import 'package:anitcorona/Widgets/MenuAppBar.dart';
import 'package:anitcorona/elements/CurrentState.dart';
import 'package:anitcorona/elements/Drawer.dart';
import 'package:anitcorona/elements/Exposure.dart';
import 'package:anitcorona/elements/ReportExposure.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class MyStatePage extends StatefulWidget {
  const MyStatePage({Key? key}) : super(key: key);

  @override
  _MyStatePageState createState() => _MyStatePageState();
}

class _MyStatePageState extends State<MyStatePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> myScaKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: MyDrawer(),
      key: myScaKey,
      appBar: AppBar(
        leading: MenuAppBar(
          showMenu: false,
          onTap: () {
            myScaKey.currentState!.openDrawer();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // the total users in the app now
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  children: [
                    Text(
                      S.of(context).CurrentStatus,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              CurrentState(),
              ReportExposure(),
              Exposure(),
              Image.asset("assets/ExPage.png")
            ],
          ),
        ),
      ),
    );
  }
}
