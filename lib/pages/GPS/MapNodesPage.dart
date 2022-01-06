import 'package:anitcorona/Controllers/Map/MapController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GPSNodePage extends StatefulWidget {
  const GPSNodePage({Key? key}) : super(key: key);

  @override
  _GPSNodePageState createState() => _GPSNodePageState();
}

class _GPSNodePageState extends State<GPSNodePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: MapController.initMap(),
        initialData: SpinKitPulse(
          color: Theme.of(context).primaryColor,
        ),
        builder: (_, snap) => snap.data!);
  }
}
