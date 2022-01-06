import 'package:anitcorona/Controllers/staticControler.dart';
import 'package:anitcorona/Widgets/MenuAppBar.dart';
import 'package:anitcorona/Widgets/TodayGraph.dart';
import 'package:anitcorona/classes/Static/WeekData.dart';
import 'package:anitcorona/elements/Connections.dart';
import 'package:anitcorona/elements/Drawer.dart';
import 'package:anitcorona/elements/Feedback.dart';
import 'package:anitcorona/elements/GetFullReport.dart';
import 'package:anitcorona/elements/Reported.dart';
import 'package:anitcorona/elements/ShareTheApp.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> myScaKey = GlobalKey<ScaffoldState>();
  late WeekData weekData;
  bool showMenu = false;
  @override
  void initState() {
    weekData = StaticController.getThisWeekReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myScaKey,
      drawer: MyDrawer(),
      appBar: AppBar(
          title: Text(
            S.of(context).AppName,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.grey[800], fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: MenuAppBar(
            showMenu: false,
            onTap: () {
              myScaKey.currentState!.openDrawer();
            },
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Stack(
                children: [
                  TodayGraph(
                      monday: weekData.monday,
                      wednesday: weekData.wednesday,
                      thursday: weekData.thursday,
                      tuesday: weekData.tuesday,
                      friday: weekData.friday,
                      sunday: weekData.sunday,
                      saturday: weekData.saturday,
                      today: weekData.today,
                      total: weekData.total),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).ContactThisWeek,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: const Color(0xff2c4260).withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // title
                    Row(
                      children: [
                        Text(
                          "${S.of(context).AppName} ${S.of(context).Radar}",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    // description
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${S.of(context).HowAppWorks1} ${S.of(context).HowAppWorks2}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    // row of the state of the user from the number of contacts and the number of reports
                    Row(
                      children: [
                        // connections
                        Expanded(child: Connections()),
                        // reported
                        Expanded(child: Reported()),
                      ],
                    ),
                    GetFullReport(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    // share the app
                    ShareTheApp(),
                    FeedbackW()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
