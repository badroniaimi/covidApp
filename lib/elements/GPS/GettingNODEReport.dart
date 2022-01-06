import 'package:anitcorona/Controllers/Map/NodeTracking.dart';
import 'package:anitcorona/elements/View/Session.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:anitcorona/main.dart';
import 'package:anitcorona/pages/Report/MapPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GettingNodeReportTrackingButton extends StatelessWidget {
  const GettingNodeReportTrackingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // show model sheet for choosing the nodes session
        // and navigate to it
        late List<SessionObject> mySessions;
        showSessionPicker(context, (sessionObject) {
          MyApp.myAppNavigator!.currentState!.push(CupertinoPageRoute(
              builder: (_) => GPSMapPage(
                  sessions: mySessions, sessionObject: sessionObject)));
        }, (sessions) {
          mySessions = sessions;
        });
      },
      child: Card(
        elevation: 0,
        color: Color(0xff7589a2),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Row(
              // key: ValueKey(NodeTrackingController.isTracking),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).GPSReport,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
