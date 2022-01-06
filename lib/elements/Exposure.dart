import 'package:anitcorona/Database/Actions.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Exposure extends StatefulWidget {
  const Exposure({Key? key}) : super(key: key);

  @override
  _ExposureState createState() => _ExposureState();
}

class _ExposureState extends State<Exposure> {
  int exposure = 0;
  bool loading = true;
  @override
  void initState() {
    MyDataBaseActions.getWhoIGotExpousedTo().then((value) {
      setState(() {
        loading = false;
        exposure = value;
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: loading
                      ? SpinKitPulse(
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        )
                      : Text(
                          "${S.of(context).Exposures} (${this.exposure})",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (exposure == 0)
                    Text(
                      S.of(context).NoExposureMessage,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                  Text(
                    S.of(context).ExposureMessage,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
