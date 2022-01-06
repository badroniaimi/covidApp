import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///this class is for showing information in the screen
class MyShowInfoDialogs {
  static bool ok = false;
  static bool cancel = true;

  ///this will show a Dialog about some info
  static Future showNormalInfo(String info, BuildContext context,
      {String title = "info"}) async {
    ok = false;
    cancel = true;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 18),
              ),
              content: Center(
                child: Text(
                  info,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    ok = true;
                    cancel = false;
                    Navigator.of(context).pop();
                  },
                  color: Colors.blue,
                )
              ],
            ));
  }
}
