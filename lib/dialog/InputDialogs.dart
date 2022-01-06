import 'package:anitcorona/Functions/FXFunctions.dart';
import 'package:anitcorona/Widgets/inputWidgets.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///This will requst a Password for showing and it will hanld if there is no value
class PhoneRequst {
  static bool showAgain = true;

  TextEditingController _thisPhone = TextEditingController();
  GlobalKey<FormState> _KeyF = GlobalKey<FormState>();
  bool _click = false;
  bool _enabled = true;
  Future showThisDialog(
      BuildContext context, Function(bool onNOPASSWORD) onValid,
      {Function()? onFailing, bool showingMessageError = true}) async {
    showAgain = true;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, myState) {
            return SimpleDialog(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(5)),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      S.current.phoneNumberReq,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.5,
                    ),
                  ),
                ),
                Form(
                    key: _KeyF,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: BasicInputWidgets.formInputBox(
                          _thisPhone, S.current.phoneEnter,
                          myIcon: Icons.phone,
                          TypeOFKeyBorad: TextInputType.number,
                          Enabl: _enabled,
                          validatorFunctions: [MyFXFunctions.validateMobile]),
                    )),
                MaterialButton(
                  onPressed: _enabled
                      ? () async {
                          if (_KeyF.currentState!.validate()) {
                            MyUser.me.phoneNumber = _thisPhone.text;
                            myState(() {
                              _click = true;
                              _enabled = false;
                            });
                            // await MyUser.me.sendThePhoneNumberToValidate();
                            await Future.delayed(Duration(seconds: 3));
                            showAgain = false;
                            Navigator.of(context).pop();
                          }
                        }
                      : null,
                  elevation: 5,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  color: Colors.blue,
                  child: !_click
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.current.enter,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.2,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                )
              ],
            );
          });
        });
    if (onFailing != null) {
      onFailing();
    }
  }
}
