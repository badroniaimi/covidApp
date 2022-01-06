# CovidAppFST
## [Download APK](https://mega.nz/file/WhxACIID#fTsZ6dc-pBuk7QhPlHlXo79Kzw_MLS3Wcd8FTb-P0Cc)
## Json File
The json file contains the folwoing


<div class="#6f42c1" >
   This is only an  example of how the data is been starctured
</div>


``` js
{
Profile: {UserDevice: "String",UserID: "String"},
UserPersonalInfo:{
     UserName: "String",
     UserPhone: "String",
     UserEmail: "String",
     CurrentID: "String"
     },
 ContactsNearby:
         [
         0:
          {
          UserId:"String",
          MyScanned:
                     [
                      0: {
                         location: "String",
                         distance: "String",
                         whenBeenScanned: "String"
                         }
                      1: ....
                     ]
          }
         1: ....
         ]
         Contacts:
         [
         0: 
          {
           Name: "String",
           UserID: "String",
           Scans: 
            [
               0: {
                  whenTheScanHappen: "String",
                  power: int,
                  Rssi: "String",
                  type: int,
                  secondForTheContact: int
                  }
            ]
          }
         1: ....
         ]
}
```
#### Explaining the Json File
##### Profile 
Contains the information about the device of the user, which is the android/iOS ID and the display name
```
UserDevice: is the device display name


UserID: is the Id of the device
```
##### UserPersonalInfo
Are the information about the user when he/she upload the file
```
     UserName: User name form Goolgle or Apple API,
     UserPhone: User phone number,
     UserEmail: User email,
     CurrentID: and the current ID, that the user used to upload the file !!, at that time
```
##### ContactsNearby
Its a list that contains all the users that This user made contact with, and each object as the following
###### The Objects
Each object has the ``` UserId ``` that been scanned, 
```
MyScanned
```
contains a list of scan that this user been scanned
```
   location: When this scan happen,
   distance: The distance between the users,
   whenBeenScanned: The date when this happen
```
##### Contacts
Are the contacts that user made a contact with and we will get tha mac and the phone name with other information:
```
Name: The dispaly of the device
UserID: The mac of the scanned bluetooth
```
```
Scans
```
Those are the scanned of this user, that been Identified by using and its a list of those times:
```
whenTheScanHappen: The date when the scanned happen,
power: its the power number,
Rssi: rrsi ,
type: the type of scan,
secondForTheContact: the time for this scan that happenned
```

## Understanding how it works:
The app will Laucnh and it will call the Current Functions, ```Please note that here we wont explain the UI```
we will One page that will init everything.

### MyLoadingPage:
This Function that will init all the loadings and do the check.
```dart 
  void initLoading() async {
    await MyGoogleAuth.doAutoSign();
    if (!await MyUser.getIfUserChecked() || MyUser.me.phoneNumber == null)
      phoneAuth();
    else {
      ///ToDo this need to be tested
      //reload the data
      await TempID.loadFromSharedPrf();
      MyUser.me.currentID = TempID.allID[0];

      _startLoading();
    }
  }
```
yet it handels all changes by calling other functions:
```dart
  ///This will handel phone auth
  void phoneAuth() async {
    MyUser.me.phoneNumber == null || MyUser.me.phoneNumber.isEmpty
        ? await PhoneRequst()
            .showThisDialog(context, (onNOPASSWORD) => null)
            .then((value) async {
            if (PhoneRequst.showAgain)
              phoneAuth();
            else
              createUser();
          })
        : createUser();
  }
```
Here if the user is ready to be created or not, which mean all his/her data are been validate 
```dart
  ///This will handel init the user TempID
  ///if[ MyUser.getIfUserChecked]
  ///by calling [TempID.loadFromSharedPrf]
  ///and then it will call [_startLoading]
  ///else call [CheckCode]
  void createUser() async {
    if (await MyUser.getIfUserChecked()) {
      await TempID.loadFromSharedPrf();
      MyUser.me.currentID = TempID.allID[0];

      print("ASDADS" + MyUser.me.currentID.tempId);
      _startLoading();
    } else {
      CheckCode()
          .showThisDialog(context, (onNOPASSWORD) => () {})
          .then((value) => !PhoneRequst.showAgain ? createUser() : phoneAuth());
    }
  }
```

#### Deep into startLoading Function:
After the user is clear to go and everything is fine, now we can launch the scanners 
this will not be called until all clear for the user.
```dart
  void _startLoading() async {
    await MyBluetooth.initTheAppWithJson();
    MyBluetooth.myBluetoothStartScanning();
    MyUser.me.startAdvertisingTheUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomNavBar()));
  }
```
```dart MyBluetooth.initTheAppWithJson() ```
This will do handel creating the Bluetooth and the Json file as following:
```dart 
  ///this will init all the Scaners and the services by calling [MyDataFileJsonFunction.initReadersAndWriters]
  ///and add some info [deviceInfo.androidInfo]
  static Future initTheAppWithJson() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //  IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    await MyDataFileJsonFunction.initReadersAndWriters({
      "Name": androidInfo.display,
      "UserID": androidInfo.id,
    });
  }
  ```
  
  
  The Following function will handel the setting of the file:
  
  ```dart 
  ///This file will init the process to read the file
  ///the map must contain the Name and the UserID
  ///and it will init the neaarBy users by calling [loadTheContactNearbyData]
  ///and mac @ by calling [loadTheContactsIntoTheScans]
  static Future initReadersAndWriters(Map userDeviceInformation) async {
    try {
      var Dir = await getApplicationDocumentsDirectory();
      _documentPath = Dir.path + '/' + _FileName;
      _dataFile = FilesDart.File(_documentPath);
      _fileExists = await _dataFile.exists();
      if (_fileExists) {
        print("Data are being loaded ");
        _usersData = JCDart.json.decode(await _dataFile.readAsString());
        _usersContact.addAll(_usersData["Contacts"]);
        _usersContactNearby.addAll(_usersData["ContactsNearby"]);
        //reset the user's Profile
        _usersData["UserProfile"] = userDeviceInformation["Profile"];
        //Load the contacts into the Scans (Unknown contacts)
        loadTheContactsIntoTheScans();
        loadTheContactNearbyData();
        print("Data been loaded");
      } else {
        await _dataFile.create();
        _usersData = {
          "UserDevice": userDeviceInformation["Name"],
          "UserID": userDeviceInformation["UserID"],
        };
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  ```
  
  #### The classes
  In the App each object must have from and to Map, to make it easy load and extract the data, beside saving the data
  into The Json File.
  ``` All Classes been refured to as My***=> I Prefare it like this XD ```
  ##### MyUser
  This the current user of the phone
  ##### MyScanned XXXXXX
  This is the Class that will contain the scans of the users 
  ##### MyNearby
  This is the class will handle the NearBy Function
  
  ### MyBluetooth.myBluetoothStartScanning
  This is after the file is ready now its time to start Scanning by the bluetooth
  
  ```dart 
  ///This will start scanning the bluetooth, and the data will be
  ///stored into[StreamSubscription] as [myStreamingOfScan]
  ///and [myDevicesScanned] which is a [Map]
  ///then after [whenToWrite] value it will start
  ///[MyDataFileJsonFunction.writeThatDocumentJSON]
  ///as a map with keys [Name,Power,Rssi,ID,Type]
  static StreamSubscription myBluetoothStartScanning() {
    try {
      myBluetoothInit.startScan(
          timeout: Duration(seconds: theDurationForTheScanInSecond));
      myStreamingOfScan = myBluetoothInit.scanResults.listen((event) {
        print("Starting");
        event.forEach((element) {
          MyScannedUsers.addUser(
              MyScannedUsers(element.device.name, element.device.id.id),
              thisScan: MyScans(
                  DateTime.now(),
                  element.advertisementData.txPowerLevel,
                  element.rssi.toString(),
                  element.device.type.index,
                  5));
        });
      });
      Future restartTheScan() async {
        await Future.delayed(Duration(seconds: timeBetweenEachScan), () async {
          await myBluetoothInit.stopScan();
          myStreamingOfScan.pause();
          print("restarting");
          await MyDataFileJsonFunction.addAllUsersToTheFile();
          await Future.delayed(Duration(seconds: 2));
          try {
            myBluetoothInit.startScan(
                timeout: Duration(seconds: theDurationForTheScanInSecond));
          } catch (e) {}
          myStreamingOfScan.resume();
        });
        restartTheScan();
      }

      //This to keep the process alive;
      //ToDo This create's errors
      restartTheScan();

      ///TODO add timer for the contact here in this class
      //  Future.delayed(Duration(seconds: ))
      return myStreamingOfScan;
    } catch (e) {}
    myBluetoothInit.stopScan().then((value) {
      myStreamingOfScan = MyBluetooth.myBluetoothStartScanning();
    });
  }
```
   ### MyUser.me.startAdvertisingTheUser
   after that the user is ready to call as the static object ``` me ```we will start working with the NearBy class now:
   Please note that this function need to be tested.
   ```dart 
  ///This Future will run forever
  ///if it stops, then there is an error
  ///TODO add a checker if it stopped
  Future startAdvertisingTheUser() async {
    if (this.currentID != null) {
      await MyNearByFunctions.restartWorking();
      await idHandlerWithTime().listen((event) async {
        print(event);
        if (!event) {
          //Request new TempID
          ///   await MyNearByFunctions.stopWorking();
          await handlerNewTempID();
          startAdvertisingTheUser();
        } else {
          //Here we Restart the advertising
          await MyNearByFunctions.restartWorking();
        }
      }).asFuture();
    }
    // startAdvertisingTheUser();
  }
  ```
  
  here how we will hanlde requesting new ID List
  ```dart 
  
  ///This will send a new request for the temp ID as should be as expected the last Temp Id
  ///and set it into the [SharedPreferences]
  Future handlerNewTempID() async {
    TempID.allID.clear();
    print("Request new ID");
    TempID.createFromListMap(
        await MyDataBaseActions.requestNewTempID(this.currentID.tempId));
    var sp = await SharedPreferences.getInstance();
    await sp.setString(
        MyaAPIUtil.WhereToSaveTempID, json.encode(TempID.toListMap()));
    this.currentID = TempID.allID[0];
  }
  ```
And this is the stream that we are calling 
```dart 
  ///this will keep Streaming and getting the Data from the list
  ///and assign them throw [getTheID] function
  ///it will get true when it been assign
  ///false when it couldn't assign
  static Stream<bool> idHandlerWithTime() async* {
    if (MyUser.me != null && TempID.allID.length != 0) {
      while (true) {
        if (!getTheID()) break;
        yield true;
        await Future.delayed(Duration(minutes: 15));
      }
    }
    yield false;
  }
  ```
  
  and this function will Take care of chaging the ID@:
  as we know we can get the TempID as object from the backend, so we can check if 
  the DateTime.now is between the current Time of validating the object.
  ```dart 
  ///This will get the current ID from the list, if all expired or
  ///no More IDs will return false
  static bool getTheID() {
    var currentTime = DateTime.now();
    for (var element in TempID.allID) {
      var start = DateTime.fromMillisecondsSinceEpoch(element.startTime);
      var end = DateTime.fromMillisecondsSinceEpoch(element.endTime);
      print("Testing $start <= $currentTime < $end");
      if (currentTime.isAfter(start) || currentTime.isAtSameMomentAs(start)) {
        if (currentTime.isBefore(end)) {
          print("New ID");
          print(element.tempId);
          MyUser.me.currentID = element;
          MyUser.me.currentIdIndex = TempID.allID.indexOf(element);
          return true;
        }
      }
    }
    return false;
  }
  ```
  
  like this the app now is scanning and using each class Scanners, when detect it do set them into the file
  that will be uploaded with the following algorithem:
  
  It will first add the current ID into the file, then save all work, then starting taking the token to upload to the server 
  ```dart 
    ///This will handel uploading the file
  /// it will get the token by using [MyDataBaseActions.getToken]
  /// and then prepare the file to be uploaded [MyDataFileJsonFunction.prepareTheFileToBeUploaded]
  /// and then uploading the file [MyDataBaseActions.sendFile]
  Future uploadTheFile() async {
    String token = await MyDataBaseActions.getToken();
    File theFile = await MyDataFileJsonFunction.prepareTheFileToBeUploaded();
    await MyDataBaseActions.sendFile(theFile, token);
  }
  ```
  
  
