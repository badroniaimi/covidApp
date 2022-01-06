import 'package:anitcorona/Database/Actions.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CurrentState extends StatefulWidget {
  const CurrentState({
    Key? key,
  }) : super(key: key);

  @override
  _CurrentStateState createState() => _CurrentStateState();
}

class _CurrentStateState extends State<CurrentState> {
  late final bool positive;
  bool loading = true;
  @override
  void initState() {
    MyDataBaseActions.getMyStatus().then((value) {
      setState(() {
        loading = false;
        positive = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(0xff7589a2),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: loading
                      ? SpinKitPulse(
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        )
                      : Row(
                          children: [
                            Text(
                              positive
                                  ? S.of(context).Positive
                                  : S.of(context).NoPositive,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: positive
                                        ? Colors.red
                                        : Colors.lightBlueAccent),
                              ),
                            )
                          ],
                        ),
                ),
                Text(
                  S.of(context).ReportYourselfAsPositive,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white, fontSize: 15),
                )
              ],
            ),
            Icon(
              Icons.navigate_next,
              size: 40,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
