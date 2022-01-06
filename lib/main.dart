import 'package:anitcorona/pages/LoadingPage.dart';
import 'package:flutter/material.dart';

import 'generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState>? myAppNavigator =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: MyLoadingPage(),
      navigatorKey: myAppNavigator,
      color: Colors.purple,
      theme: ThemeData(
        primaryColor: Colors.purple,
        fontFamily: 'RobotoMono',
        cardColor: Color(0xff7589a2),
        textTheme: TextTheme(
            headline5: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600)),
        accentColor: Color(0xff2c4260),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
        ),
      ),
      title: "AntiCovid19",
    );
  }
}
