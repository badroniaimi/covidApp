import 'package:anitcorona/Database/Actions.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Reported extends StatefulWidget {
  const Reported({Key? key}) : super(key: key);

  @override
  _ReportedState createState() => _ReportedState();
}

class _ReportedState extends State<Reported> {
  bool loading = true;
  late int value;
  @override
  void initState() {
    MyDataBaseActions.getWhoReportedMe().then((value) {
      setState(() {
        this.value = value;
        loading = false;
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  S.of(context).Reported,
                  style: Theme.of(context).textTheme.caption!.copyWith(
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
                        shape: BoxShape.circle, color: Colors.red),
                  ),
                )
              ],
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: loading
                  ? SpinKitPulse(
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    )
                  : Text(
                      "$value",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
