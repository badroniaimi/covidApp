import 'package:anitcorona/Controllers/StreamControllers.dart';
import 'package:anitcorona/Functions/DataFileJSON.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:geolocator/geolocator.dart';

class MyNearbyUser {
  String? id;
  Map<String, double>? lastDetect;
  String? name;
  String? phoneNumber;
  String? address;
  String? email;
  UsersType? usersType;
  List<_MyNearbyScanned>? myScanned = <_MyNearbyScanned>[];

  MyNearbyUser(this.id,
      {this.name,
      this.phoneNumber,
      this.address,
      this.email,
      this.lastDetect,
      this.usersType});

  MyNearbyUser.withList(this.id, this.myScanned, this.name, this.phoneNumber,
      this.address, this.email, this.usersType);

  static List<MyNearbyUser> myUsers = <MyNearbyUser>[];

  ///this will handle adding the user
  ///and it will add it to the file
  static Future addUser(
      String id,
      String location,
      String myLocation,
      String name,
      String phoneNumber,
      String address,
      String email,
      UsersType usersType) async {
    //My location
    double startLatitude = double.parse(myLocation.split(',')[0]);
    double startLongitude = double.parse(myLocation.split(',')[1]);
    //Detected location
    double endLatitude = double.parse(location.split(',')[0]);
    double endLongitude = double.parse(location.split(',')[1]);

    var dist = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    var myScan = _MyNearbyScanned(location, dist.toString());
    int index = myUsers.indexWhere((element) => element.id == id);
    //if new user
    if (index == -1) {
      var me = MyNearbyUser(id,
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          email: email,
          usersType: usersType);
      me.myScanned!.add(myScan);
      myUsers.add(me);
    } else {
      myUsers[index].usersType = usersType;
      myUsers[index].email = email;
      myUsers[index].name = name;
      myUsers[index].address = address;
      myUsers[index].phoneNumber = phoneNumber;
      myUsers[index].myScanned!.add(myScan);
    }
    // async
    asyncData();
  }

  ///this will return a Map of the values
  Map<String, dynamic> toMap() {
    Map<String, dynamic> R = {
      "UserId": id,
      'lastDetect': this.lastDetect,
      'name': this.name,
      'phoneNumber': this.phoneNumber,
      'address': this.address,
      'email': this.email,
      'usersType': this.usersType
    };
    final myScannedMap = <Map<String, dynamic>>[];
    myScanned!.forEach((element) {
      myScannedMap.add(element.toMap());
    });
    R.addAll({"MyScanned": myScannedMap});
    return R;
  }

  ///this will create object from map data
  static MyNearbyUser fromMap(Map input) => MyNearbyUser.withList(
      input["userId"],
      input["MyScanned"],
      input['name'],
      input['phoneNumber'],
      input['address'],
      input['email'],
      input['usersType']);

  ///Note that we use this to load the data from the file
  static fromListMap(List input) {
    input.forEach((element) {
      myUsers.add(MyNearbyUser.fromMap(element));
    });
  }

  ///this will get the data as list map
  static List<Map> getListMap() {
    final R = <Map<String, dynamic>>[];
    myUsers.forEach((element) {
      R.add(element.toMap());
    });
    return R;
  }

  // detect user
  static void detectUser(String userID, String where) {
    double latitude = double.parse(where.split(',')[0]);
    double longitude = double.parse(where.split(',')[1]);
    // where
    var index =
        MyNearbyUser.myUsers.indexWhere((element) => element.id == userID);
    if (index != -1) {
      MyNearbyUser.myUsers[index].lastDetect = <String, double>{
        'latitude': latitude,
        'longitude': longitude
      };
    } else {
      MyNearbyUser.myUsers.add(MyNearbyUser(userID,
          lastDetect: <String, double>{
            'latitude': latitude,
            'longitude': longitude
          }));
    }
    // async
    asyncData();
  }

  static Future asyncData() async {
    MyDataFileJsonFunction.writeThatDocumentJSONNearby(
        MyNearbyUser.getListMap() as List<Map<String, dynamic>>);
    //Stream
    // notify to reload the data from the json file
    // MyBackgroundProcess.sendData(myUsers.last.toMap());
    MyStreamControllers.myScannedNearByUsersCont.sink.add(myUsers.last.id);
  }
}

///this the number of scanned that been done for a user
///[location] is can be spilt with (,)
class _MyNearbyScanned {
  String location;
  String distance;
  String? whenBeenScanned;
  int? forHowLong;
  _MyNearbyScanned(this.location, this.distance) {
    whenBeenScanned = DateTime.now().toString();
  }

  Map<String, dynamic> toMap() => {
        "location": location,
        "distance": distance,
        "whenBeenScanned": whenBeenScanned,
        'forHowLong': forHowLong
      };
}
