import 'dart:convert' as JCDart;
import 'dart:io' as FilesDart;
import 'dart:io';

import 'package:anitcorona/classes/MyNeabyUsers.dart';
import 'package:anitcorona/classes/MyScannedUsers.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:anitcorona/classes/Scans.dart';
import 'package:path_provider/path_provider.dart';

class MyDataFileJsonFunction {
  static FilesDart.File? _dataFile;
  JCDart.JsonDecoder X = JCDart.JsonDecoder();
  static late String _documentPath;
  static bool _fileExists = false;
  static const String _FileName = "MyFileData.json";
  static Map<String, dynamic>? _usersData = Map<String, dynamic>();
  static List _usersContact = [];
  static List _usersContactNearby = [];

  ///This file will init the process to read the file
  ///the map must contain the Name and the UserID
  ///and it will init the neaarBy users by calling [loadTheContactNearbyData]
  ///and mac @ by calling [loadTheContactsIntoTheScans]
  static Future initReadersAndWriters(Map userDeviceInformation) async {
    var Dir = await getApplicationDocumentsDirectory();
    _documentPath = Dir.path + '/' + _FileName;
    _dataFile = FilesDart.File(_documentPath);
    _fileExists = await _dataFile!.exists();
    if (_fileExists) {
      try {
        print("Data are being loaded ");
        _usersData = JCDart.json.decode(await _dataFile!.readAsString());
        if (_usersData != null) {
          if (_usersData!.containsKey("Contacts"))
            _usersContact.addAll(_usersData!["Contacts"]);
          if (_usersData!.containsKey("ContactsNearby"))
            _usersContactNearby.addAll(_usersData!["ContactsNearby"]);
          //reset the user's Profile
          _usersData!["UserProfile"] = userDeviceInformation["Profile"];
          //Load the contacts into the Scans (Unknown contacts)
          loadTheContactsIntoTheScans();
          loadTheContactNearbyData();
          print("Data been loaded");
        } else {
          _usersData = Map<String, dynamic>();
          _usersData!["UserProfile"] = userDeviceInformation["Profile"];
        }
      } catch (e) {
        // error
      }
    } else {
      await _dataFile!.create();
      _usersData = {
        "UserDevice": userDeviceInformation["Name"],
        "UserID": userDeviceInformation["UserID"],
      };
    }

    return true;
  }

  ///This will write into the file of the json
  static Future<bool> writeThatDocumentJSON(
      List<Map<String, dynamic>> newData) async {
    try {
      _usersContact = newData;
      _usersData!["Contacts"] = _usersContact;
      await _dataFile!.writeAsString(JCDart.json.encode(_usersData));
      return true;
    } catch (e) {
      print("error in fetching the data " + e.toString());
      return false;
    }
  }

  ///This will load all the contacts and add them to the  object in the Program
  static void loadTheContactsIntoTheScans() {
    _usersContact.forEach((element) {
      MyScannedUsers.fromMap(element["Name"], element["UserID"],
          [for (final x in element["Scans"]) MyScans.fromMap(x)]);
    });
  }

  ///This will load the data from the object to the file
  static Future addAllUsersToTheFile() async {
    await writeThatDocumentJSON(MyScannedUsers.toListMap());
  }

  ///Nearby loading data
  static loadTheContactNearbyData() {
    MyNearbyUser.fromListMap(_usersContactNearby);
  }

  ///This will write into the file of the json
  static Future<bool> writeThatDocumentJSONNearby(
      List<Map<String, dynamic>> newData) async {
    try {
      _usersContactNearby.clear();
      _usersContactNearby.addAll(newData);
      _usersData!["ContactsNearby"] = _usersContactNearby;
      await _dataFile!.writeAsString(JCDart.json.encode(_usersData));
      return true;
    } catch (e) {
      print("error in fetching the data " + e.toString());
      return false;
    }
  }

  ///This will prepare the document to be uploaded and return it
  ///it will add the current  [MyUser.me] data by creating the data as map
  /// in key UserPersonalInfo
  static Future<File?> prepareTheFileToBeUploaded() async {
    _usersData!.addAll({"UserPersonalInfo": MyUser.me.toMap()});
    await _dataFile!.writeAsString(JCDart.json.encode(_usersData));
    return _dataFile;
  }

  static Future<bool> saveErrorsReading(Map errors) async {
    return true;
  }
}
