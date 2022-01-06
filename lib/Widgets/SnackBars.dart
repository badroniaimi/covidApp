import 'package:anitcorona/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySnackBars {
  static ScaffoldFeatureController? controller;
  static Future showErrorMessage(String error) {
    var x = ScaffoldMessenger.of(MyApp.myAppNavigator!.currentContext!);
    controller = x.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          children: [
            // the icon
            Icon(
              Icons.warning_amber_outlined,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                error,
                style: Theme.of(MyApp.myAppNavigator!.currentContext!)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        )));
    return controller!.closed;
  }

  static Future showDoneMessage(String doneMessage) {
    var x = ScaffoldMessenger.of(MyApp.myAppNavigator!.currentContext!);
    controller = x.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            // the icon
            Icon(
              Icons.done_outline,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                doneMessage,
                style: Theme.of(MyApp.myAppNavigator!.currentContext!)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        )));
    return controller!.closed;
  }

  static Future showMessage(String message) {
    var x = ScaffoldMessenger.of(MyApp.myAppNavigator!.currentContext!);
    controller = x.showSnackBar(SnackBar(
        backgroundColor: Colors.blue,
        content: Row(
          children: [
            // the icon
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                message,
                style: Theme.of(MyApp.myAppNavigator!.currentContext!)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        )));
    return controller!.closed;
  }
}
