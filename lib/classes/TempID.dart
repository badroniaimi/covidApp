// import 'dart:convert';
//
// import 'package:anitcorona/Global/GlobalKeys.dart';
// import 'package:anitcorona/Util/MyaAPIUtil.dart';
// import 'package:anitcorona/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class TempID {
//   String? tempId;
//   int? startTime;
//   int? endTime;
//
//   TempID(this.tempId, this.startTime, this.endTime);
//
//   static int? whenTheListWillExpier;
//   static List<TempID> allID = <TempID>[];
//
//   static void createFromListMap(List? input) {
//     TempID.allID.clear();
//     if (input == null)
//       MyGlobalKeys.myGlobalScaKey.currentState!.showSnackBar(SnackBar(
//         content: Text(S.current!.CantConnectToTheServer),
//       ));
//     if (input != null)
//       input.forEach((element) {
//         TempID.allID.add(TempID(element["tempID"], element["startTime"] * 1000,
//             element["expiryTime"] * 1000));
//       });
//   }
//
//   Map<String, dynamic> toMap() =>
//       {"tempID": tempId, "startTime": startTime, "expiryTime": endTime};
//
//   ///This will load from [MyaAPIUtil.WhereToSaveTempID]
//   ///and set if into [allID]
//   ///if [allID.isEmpty] and [MyaAPIUtil.WhereToSaveTempID] is exist
//   ///return true if it worked
//   ///false if not
//   static Future<bool> loadFromSharedPrf() async {
//     var sp = await SharedPreferences.getInstance();
//     if (allID.isEmpty && sp.containsKey(MyaAPIUtil.WhereToSaveTempID)) {
//       createFromListMap(
//           json.decode(sp.getString(MyaAPIUtil.WhereToSaveTempID)));
//
//       print(TempID.allID.length);
//
//       return true;
//     }
//     return false;
//   }
//
//   static List<Map<String, dynamic>> toListMap() {
//     List<Map<String, dynamic>> R = <Map<String, dynamic>>[];
//     allID.forEach((element) {
//       R.add(element.toMap());
//     });
//     return R;
//   }
// }
