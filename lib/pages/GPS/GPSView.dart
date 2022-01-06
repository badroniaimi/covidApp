import 'package:anitcorona/elements/GPS/GPSTracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GPSView extends StatefulWidget {
  final GoogleMap googleMap;
  const GPSView({Key? key, required this.googleMap}) : super(key: key);

  @override
  _GPSViewState createState() => _GPSViewState();
}

class _GPSViewState extends State<GPSView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: widget.googleMap,
        ),
        // the Controllers
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GPSTrackingButton(),
          ),
        )
      ],
    );
  }
}
