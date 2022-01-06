import 'package:anitcorona/Controllers/Map/NodeTracking.dart';
import 'package:anitcorona/dialog/StartTrackingMessage.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class GPSTrackingButton extends StatefulWidget {
  const GPSTrackingButton({Key? key}) : super(key: key);

  @override
  _GPSTrackingButtonState createState() => _GPSTrackingButtonState();
}

class _GPSTrackingButtonState extends State<GPSTrackingButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!NodeTrackingController.isTracking)
          await showExposureReportDialog(context);
        else
          await NodeTrackingController.stopLocationTracking();
        setState(() {});
      },
      child: Card(
        elevation: 0,
        color: Color(0xff7589a2),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Row(
              key: ValueKey(NodeTrackingController.isTracking),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  !NodeTrackingController.isTracking
                      ? S.of(context).TrackingGPSStart
                      : S.of(context).TrackingGPSStop,
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
                        shape: BoxShape.circle,
                        color: !NodeTrackingController.isTracking
                            ? Colors.grey
                            : Colors.green),
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
