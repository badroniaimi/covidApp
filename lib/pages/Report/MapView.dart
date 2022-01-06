import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportMapView extends StatefulWidget {
  final GoogleMap googleMap;
  const ReportMapView({Key? key, required this.googleMap}) : super(key: key);

  @override
  _ReportMapViewState createState() => _ReportMapViewState();
}

class _ReportMapViewState extends State<ReportMapView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: widget.googleMap,
        ),
        // the Controllers
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: GPSTrackingButton(),
        //   ),
        // )
      ],
    );
  }
}
