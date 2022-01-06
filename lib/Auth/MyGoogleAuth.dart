import 'package:anitcorona/classes/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFirebaseAuth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  ///this will handle the login via google
  ///[Returns] true if it done correctly or false if not
  static Future<bool> singIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          (await googleSignIn.signIn())!;
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // ignore: deprecated_member_use
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authR = await auth.signInWithCredential(credential);
      // assert(!authR.user.isAnonymous);
      // assert(await authR.user.getIdToken() != null);
      // var currentUser = authR.user;
      // assert(authR.user.uid == currentUser.uid);
      MyUser.me = MyUser(
          name: authR.user!.displayName,
          email: authR.user!.email,
          id: authR.user!.uid,
          phoneNumber: authR.user!.phoneNumber,
          token: authR.user!.refreshToken);
      MyUser.me.id = authR.user!.uid;
      auth.userChanges().forEach((element) {
        MyUser.me = MyUser(
            id: element!.uid,
            name: element.displayName,
            email: element.email,
            phoneNumber: element.phoneNumber);
      });
      //Save the user
      var prf = await SharedPreferences.getInstance();
      MyUser.me.toMap().forEach((key, value) async {
        await prf.setString(key, value);
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///this will handle the methods
  static Future<bool> doAutoSign() async {
    if (auth.currentUser != null) {
      MyUser.me = MyUser(
          id: auth.currentUser!.uid,
          name: auth.currentUser!.displayName,
          email: auth.currentUser!.email,
          phoneNumber: auth.currentUser!.phoneNumber);
      auth.userChanges().forEach((element) {
        MyUser.me = MyUser(
            id: element!.uid,
            name: element.displayName,
            email: element.email,
            phoneNumber: element.phoneNumber);
      });
      return true;
    } else {
      return await singIn();
    }
  }

  ///this will load the user
  // static Future<bool> loadUser() async {
  //   try {
  //     await SharedPreferences.getInstance().then((value) {});
  //     return true;
  //   } catch (e) {
  //     print("while loding the user " + e.toString());
  //     return false;
  //   }
  // }
}
