import 'package:anitcorona/Auth/MyGoogleAuth.dart';
import 'package:anitcorona/Database/RealTimeDatabase.dart';
import 'package:anitcorona/Functions/TextFunction.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MyAuthControllers {
  static bool cinVerified = false;

  // login
  /// this will handle the login, if there is an error, the dialog will be appear in the screen
  static Future<bool> loginHandler() async {
    try {
      return await MyFirebaseAuth.doAutoSign();
    } catch (e) {
      print(e);
      return false;
    }
  }

  // verified
  // email, and phone
  /// this will give a map if is the email is validate or not, same for the phone
  static Future<Map<String, bool>> getIfValidate() async {
    final r = <String, bool>{'email': false, 'phone': false};

    r['email'] = MyFirebaseAuth.auth.currentUser!.emailVerified;
    r['phone'] = (MyFirebaseAuth.auth.currentUser!.phoneNumber != null ||
        MyFirebaseAuth.auth.currentUser!.phoneNumber!.isEmpty);
    return r;
  }

  // allow for operations

// send validate email
  static Future<bool> checkEmail() async {
    await MyFirebaseAuth.auth.currentUser!.sendEmailVerification();
    return true;
  }

// check phone
  static Future<bool> checkPhone(String phoneNumber, BuildContext context,
      {required Function() onSent, required Function() onError}) async {
    await MyFirebaseAuth.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneCredential) async {
          await MyFirebaseAuth.auth.currentUser!
              .updatePhoneNumber(phoneCredential)
              .catchError(() {
            onError();
          });
          onSent();
          // MyFirebaseAuth.auth
          //     .signInWithCredential(authCredential)
          //     .then((result) {
          //   Navigator.pop(context);
          // }).catchError((e) {
          //   onError();
          // });
        },
        verificationFailed: (authException) {
          onError();
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          onSent();
          final _codeController = TextEditingController();
          String smsCode = "";
          final RoundedLoadingButtonController _btnController =
              RoundedLoadingButtonController();
          //show dialog to take input from the user
          showCupertinoDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: Text("Enter SMS Code"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLength: 6,
                          validator: (str) {
                            try {
                              int.parse(str ?? '');
                              return null;
                            } catch (e) {
                              return "Wrong code number";
                            }
                          },
                          controller: _codeController,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      RoundedLoadingButton(
                        controller: _btnController,
                        child: Text("Done"),
                        color: Colors.redAccent,
                        onPressed: () async {
                          _btnController.start();
                          FirebaseAuth auth = MyFirebaseAuth.auth;
                          print(auth.currentUser!.email);

                          String currentName = auth.currentUser!.displayName!;
                          String currentID = auth.currentUser!.uid;
                          // String currentEmail = auth.currentUser!.email!;
                          String currentPhoto = auth.currentUser!.photoURL!;
                          smsCode = _codeController.text.trim();

                          final _credential = PhoneAuthProvider.credential(
                              verificationId: verificationId, smsCode: smsCode);

                          auth.currentUser!
                              .linkWithCredential(_credential)
                              .then((result) async {
                            await auth.currentUser!.updateProfile(
                                displayName: currentName,
                                photoURL: currentPhoto);
                            MyUser.me.phoneNumber =
                                auth.currentUser!.phoneNumber;
                            MyRealTimeDatabaseActions.uploadUserInfo(
                                MyUser.me.toMap());
                            _btnController.success();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }).catchError((e) async {
                            print(e);
                            _btnController.error();
                            onError();
                            await Future.delayed(Duration(seconds: 2));
                            _btnController.reset();
                          });
                        },
                      )
                    ],
                  ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // onError();
        });
    return true;
  }

  static smsPhoneHandler(BuildContext context,
      {required Function() onSent, required Function() onError}) {
    final _codeController = TextEditingController();
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();

    //show dialog to take input from the user
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Enter you phone number"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        prefixIcon: SizedBox(
                      width: 80,
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          Text(
                            "+212",
                            textScaleFactor:
                                MyTextFunctions.getTheTextFactorFix(context),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    )),
                    validator: (str) {
                      try {
                        int.parse(str ?? '');
                        return null;
                      } catch (e) {
                        return "Wrong phone number";
                      }
                    },
                    controller: _codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                RoundedLoadingButton(
                  controller: _btnController,
                  child: Text("send"),
                  color: Colors.redAccent,
                  onPressed: () async {
                    _btnController.start();

                    await checkPhone("+212${_codeController.text}", context,
                        onSent: () {
                      _btnController.success();
                      onSent();
                    }, onError: () async {
                      onError();

                      _btnController.error();
                      await Future.delayed(Duration(seconds: 2));
                      _btnController.reset();
                    });
                  },
                )
              ],
            ));
  }
}
