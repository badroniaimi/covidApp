import 'package:anitcorona/Controllers/Map/NodeTracking.dart';
import 'package:anitcorona/Functions/Helpers.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GettingSessions extends StatefulWidget {
  final Function(List<SessionObject>) onSession;
  final Function(SessionObject) onTap;
  const GettingSessions(
      {Key? key, required this.onSession, required this.onTap})
      : super(key: key);

  @override
  _GettingSessionsState createState() => _GettingSessionsState();
}

class _GettingSessionsState extends State<GettingSessions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<SessionObject>>(
          future: NodeTrackingController.getSessions(),
          initialData: [],
          builder: (_, snap) {
            widget.onSession(snap.data ?? []);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: snap.data!.isEmpty
                  ? SpinKitPulse(
                      color: Theme.of(context).primaryColor,
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8)
                                .add(EdgeInsets.only(top: 8)),
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).MySessions,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                          for (final sessionObject in snap.data ?? [])
                            InkWell(
                                onTap: () => widget.onTap(sessionObject),
                                child:
                                    SessionView(sessionObject: sessionObject))
                        ],
                      ),
                    ),
            );
          }),
    );
  }
}

class SessionView extends StatelessWidget {
  final SessionObject sessionObject;
  const SessionView({Key? key, required this.sessionObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                showTheBestTimeViewWithDateFuture(
                    DateTime.fromMillisecondsSinceEpoch(sessionObject.when)),
                textScaleFactor: MyTextFunctions.getTheTextFactor(context),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future showSessionPicker(BuildContext context, Function(SessionObject) onTap,
        Function(List<SessionObject>) onSession) =>
    showModalBottomSheet(
        context: context,
        builder: (_) => GettingSessions(
              onTap: onTap,
              onSession: onSession,
            ));
