import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:anitcorona/Database/RealTimeDatabase.dart';
import 'package:anitcorona/Functions/DataFileJSON.dart';
import 'package:anitcorona/classes/MyNeabyUsers.dart';
import 'package:anitcorona/classes/MyScannedUsers.dart';

class MyDataBaseActions {
  static const MyHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
  };
  static var myEncode = Encoding.getByName("utf-8");

  static Future uploadData() async {
    File theFile =
        (await (MyDataFileJsonFunction.prepareTheFileToBeUploaded()))!;
    // read the file
    var data = await theFile.readAsString();
    var jsonBody = json.decode(data);

    await MyRealTimeDatabaseActions.uploadUserData(jsonBody);
    // remove file
    await theFile.delete();
    MyNearbyUser.myUsers.clear();
    MyScannedUsers.listOfMe.clear();
  }

  /// this will connect to the server via firebase functions to get the number of users that reported in positive state
  static Future<int> getWhoReportedMe() async {
    await Future.delayed(Duration(milliseconds: 2000));
    return 0;
  }

  static Future<int> getWhoIGotExpousedTo() async {
    await Future.delayed(Duration(milliseconds: 2000));
    return 0;
  }

  static Future<bool> getMyStatus() async {
    await Future.delayed(Duration(milliseconds: 2000));
    return false;
  }
//  ///this will upload the file and get the url of the file
//  static Future<String> uploadFileToStorage(File theFile) async {
//    var x = MyDatabaseUtil.myStorage
//        .ref()
//        .child("UsersUpload")
//        .child(MyUser.me.phoneNumber)
//        .child("UserProfile")
//        .putFile(theFile);
//    AndroidDeviceInfo androidInfo = await MyBluetooth.deviceInfo.androidInfo;
//    var dataThatWillBeSent = {
//      "userDeviceID": androidInfo.id,
//      "userPhoneNumber": MyUser.me.phoneNumber
//    };

//    var data = await x.onComplete;
//    return await data.ref.getDownloadURL();
//  }

//   ///this will send the phone number and send a Sms from the back end
//   ///note that it will return string that is the code been sent to the user
//   static Future<String> sendPhoneNumber(String phoneNumber) async {
//     Map<String, String> inputData = {"phoneNumber": phoneNumber};
//     var res = await http.post(MyaAPIUtil.SMSAPI,
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/x-www-form-urlencoded"
//         },
//         body: inputData,
//         encoding: Encoding.getByName("utf-8"));
//     var data = json.decode(res.body);
//     if (data["status"]) return data["message"];
//     return null;
//   }
//
//   static Future<List> verifyUserPhoneNumber(
//       String phoneNumber, String reqID, String code) async {
// //    Map<String, String> inputData = {
// //      "phoneNumber": phoneNumber,
// //      "request_id": reqID,
// //      "code": code
// //    };
//     ///TODO Change this to sms later
// //    var res = await http.post(MyaAPIUtil.getTempIDFree,
// //        headers: MyHeaders, body: inputData, encoding: myEncode);
//     var res = await http.post(
//       MyaAPIUtil.getTempIDFree,
//     );
//     var data = json.decode(res.body);
//     if (data["status"]) return data["message"];
//     print(data["message"]);
//     return null;
//   }
//
//   static bool showError = true;
//
//   ///This will request a new list of temp IDs
//   ///from the last temp ID
//   static Future<List<Map>> requestNewTempID(String lastID) async {
//     var inputData = {"tempId": lastID};
//     try {
//       var res = await http.post(MyaAPIUtil.SMSValidate,
//           headers: MyHeaders, body: inputData, encoding: myEncode);
//       var data = json.decode(res.body);
//       if (data["status"]) {
//         showError = true;
//         return data["message"];
//       }
//       return null;
//     } catch (e) {
//       //Error
//       if (showError)
//         MyGlobalKeys.myGlobalScaKey.currentState.showSnackBar(SnackBar(
//           content: Text(S.current.CantConnectToTheServer),
//           duration: Duration(seconds: 4),
//         ));
//       showError = false;
//       return null;
//     }
//   }
//
//   static Future<String> getPinToken() async {
//     var res = await http.get(MyaAPIUtil.GetToken, headers: MyHeaders);
//     var data = json.decode(res.body);
//     if (data["status"]) return data["pin"];
//     return null;
//   }
//
//   ///This will get the token to upload the file
//   static Future<String> getToken() async {
//     var inputData = {
//       "tempId": MyUser.me.currentID.tempId,
//       "pin": await getPinToken()
//     };
//     var res = await http.post(MyaAPIUtil.SendToken,
//         headers: MyHeaders, body: inputData, encoding: myEncode);
//     var data = json.decode(res.body);
//     if (data["status"]) return data["token"];
//     return null;
//   }

  ///This will upload the file to the server by giving the token and the file
  ///it return the results of the api status
//   static Future<bool> sendFile(File myFile, String myToken) async {
//     final req = http.MultipartRequest('POST', Uri.parse(MyaAPIUtil.UploadFile));
//     req.fields.addAll({"token": myToken});
// //    req.headers.addAll({
// //      "Content-Type": "application/json",
// //    });
//     req.files.add(await http.MultipartFile.fromPath("File", myFile.path,
//         contentType: MediaType("application", "json")));
//     http.StreamedResponse res = await req.send();
//     var r = await res.stream.bytesToString();
//     return json.decode(r)["status"];
//   }
}
