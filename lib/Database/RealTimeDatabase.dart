import 'package:anitcorona/Controllers/Map/NodeTracking.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:firebase_database/firebase_database.dart';

class MyRealTimeDatabaseActions {
  static final init = FirebaseDatabase.instance;
  // create a database reference from that account
  static bool isLoading = false;
  static Future<bool> uploadUserData(Map? data) async {
    if (isLoading) return false;
    isLoading = true;
    await init
        .reference()
        .child('Users')
        .child("UsersUpload")
        .child(MyUser.me.id![0])
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set({'when': DateTime.now().millisecondsSinceEpoch, 'data': data});
    isLoading = false;
    return true;
  }

  static Future<bool> uploadUserInfo(Map data) async {
    if (isLoading) return false;
    isLoading = true;
    await init
        .reference()
        .child('Users')
        .child("UsersInfo")
        .child(MyUser.me.id![0])
        .set({'when': DateTime.now().millisecondsSinceEpoch, 'data': data});
    isLoading = false;
    return true;
  }

  static Future<bool> uploadUserInfoToken(String? token) async {
    if (isLoading) return false;
    isLoading = true;
    await init
        .reference()
        .child('Users')
        .child('UsersNotifications')
        .child(MyUser.me.id![0])
        .set({'Token': token});
    isLoading = false;
    return true;
  }

  static Future<int> getNumberOfUsersInTheAppNow() async {
    var x = await init.reference().child('Users').child("UsersInfo").once();
    return (x.value as Map).keys.length;
  }

  // this will be saved in the user route
  // this will be saved in the main route
  static Future<void> setSaveLocationInTimeForNodes(
      NodeObjectSession nodeObjectSession) async {
    print(nodeObjectSession);
    await init
        .reference()
        .child('Users')
        .child('UsersMapRoad')
        .child(nodeObjectSession.locationKey)
        .child(nodeObjectSession.when.toString())
        .child(nodeObjectSession.userId)
        .set(nodeObjectSession.toMap());

    await init
        .reference()
        .child('Users')
        .child('UsersSessionsData')
        .child(nodeObjectSession.userId)
        .child(nodeObjectSession.session)
        .child(nodeObjectSession.locationKey)
        .set(nodeObjectSession.toMap());
  }

  static Future<void> saveSession(
      DatabaseReference sessionRef, String userId) async {
    final when = DateTime.now().millisecondsSinceEpoch;
    var sessionKey = sessionRef.key;
    final sessions = [];
    var qSessions = getSessions(userId);
    var snap = await qSessions.once();
    if (snap.value != null) {
      sessions.addAll(snap.value);
    }
    sessions.add({'session': sessionKey, 'when': when});
    await qSessions.set(sessions);
  }

  static DatabaseReference getSession() => getSessions(MyUser.me.id!).push();

  static DatabaseReference getSessions(String userId) =>
      init.reference().child('Users').child('UsersSessions').child(userId);

  static DatabaseReference getSessionData(String userId, String sessionKey) =>
      init
          .reference()
          .child('Users')
          .child('UsersSessionsData')
          .child(userId)
          .child(sessionKey);
}
