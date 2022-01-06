import 'package:anitcorona/Controllers/Map/NodeTracking.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StartTrackingReport extends StatefulWidget {
  const StartTrackingReport({Key? key}) : super(key: key);

  @override
  _StartTrackingReportState createState() => _StartTrackingReportState();
}

class _StartTrackingReportState extends State<StartTrackingReport> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
        color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500);
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: size.height * 0.32, horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 200,
          width: size.width * 0.8,
          child: Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).AsyncGPSTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black87),
                        ),
                        IconButton(
                            padding: EdgeInsets.only(bottom: 20),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        S.of(context).TrackingGPSMessage1,
                        style: bodyStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        S.of(context).TrackingGPSMessage1,
                        style: bodyStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          await NodeTrackingController.startTracking();
                          setState(() {
                            loading = false;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Color(0xff7589a2).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            key: ValueKey(loading),
                            padding: const EdgeInsets.all(8.0)
                                .add(EdgeInsets.symmetric(vertical: 5)),
                            child: loading
                                ? Center(
                                    child: SpinKitPulse(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text(
                                          S.of(context).TrackingGPSStart,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.grey[800]),
                                        ),
                                        Icon(Icons.gps_fixed,
                                            color: Colors.grey[700]),
                                      ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future showExposureReport(BuildContext context) => showModalBottomSheet(
    context: context, enableDrag: true, builder: (_) => StartTrackingReport());

Future showExposureReportDialog(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => StartTrackingReport());
