import 'package:anitcorona/Controllers/StreamControllers.dart';
import 'package:anitcorona/Functions/FXFunctions.dart';
import 'package:anitcorona/classes/Scans.dart';

//Contacts
//Unknown users
class MyScannedUsers {
  String? name;
  String? id;
  List<MyScans?> myScans = <MyScans?>[];
  static List<MyScannedUsers> listOfMe = <MyScannedUsers>[];
  MyScannedUsers(this.name, this.id);

  MyScannedUsers.fromMap(this.name, this.id, this.myScans) {
    listOfMe.add(this);
  }

  ///This if for adding the detecting user
  ///[thisScan] is the scan that been happen now
  ///if its during the day, it will add it to the second as 5 second
  ///for each scan
  static void addUser(MyScannedUsers user,
      {int second = 5, MyScans? thisScan}) {
    var index = listOfMe.indexWhere((element) => element.id == user.id);
    try {
      if (index != -1) {
        // MyNotifications.displayNotif(
        //     title: "New person added ", body: "All Data been saved");
        //this means the scan is old, means on the same day
        if (listOfMe[index].myScans.length == 0) {
          // user scanned never been saved
          listOfMe[index].myScans.add(thisScan);
        } else if (MyFXFunctions.compair2DateTimeAsTheMonthAndTheYearAndTheDay(
            listOfMe[index].getTheLastScanTime()!.whenTheScanHappen,
            thisScan!.whenTheScanHappen)) {
          int? index2 = listOfMe[index].myScans.indexWhere((element) =>
              element!.whenTheScanHappen ==
              listOfMe[index].getTheLastScanTime()!.whenTheScanHappen);
          // if (index2 != -1) {
          //   listOfMe[index].myScans[index2]!.secondForTheContact += second;
          // }
        } else {
          //if its not on the same day !?
          listOfMe[index].myScans.add(thisScan);
        }
      } else {
        //if this is a new user
        user.myScans.add(thisScan);
        listOfMe.add(user);
      }
    } catch (e) {
      var er =
          "Error in reading the User: ${user.id}, ${user.name}, Scanned: ${user.myScans}";
      Map error = {
        'error': e.toString(),
        'message': er,
        'userID': user.id,
        'userName': user.name,
        'scanned': [for (final x in user.myScans) x!.toMap()]
      };
      print(error);
    }
    MyStreamControllers.myScannedUnKnownUsersCont.sink.add(listOfMe.last.id);
  }

  @override
  String toString() {
    return 'MyScannedUsers{name: $name, id: $id, myScans: $myScans}';
  }

  ///This will get the last scanned for this user
  MyScans? getTheLastScanTime() {
    MyScans? R;
    myScans.forEach((element) {
      myScans.forEach((element2) {
        if (!MyFXFunctions.compair2DateTimeAsTheMonthAndTheYearAndTheDay(
            element!.whenTheScanHappen, element2!.whenTheScanHappen))
          R = element2;
        else
          R = element;
      });
    });
    return R;
  }

  ///This will return a list with map data from the this class
  ///[listOfMe]
  static List<Map<String, dynamic>> toListMap() {
    List<Map<String, dynamic>> R = <Map<String, dynamic>>[];
    listOfMe.forEach((element) {
      R.add(element.toMap());
    });
    return R;
  }

  List<Map<String, dynamic>> scannedListMap() {
    List<Map<String, dynamic>> R = <Map<String, dynamic>>[];
    myScans.forEach((element) {
      R.add(element!.toMap());
    });
    return R;
  }

  Map<String, dynamic> toMap() =>
      {"Name": this.name, "UserID": this.id, "Scans": scannedListMap()};
}
