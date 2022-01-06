import 'package:anitcorona/pages/GPS/GPSView.dart';
import 'package:anitcorona/pages/Report/MapView.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController {
  static late GoogleMapController _controller;
  static bool move = true;
  static CameraPosition _currentCameraPosition = CameraPosition(
    target: LatLng(31.50783, -9.76849),
    zoom: 16.4746,
  );
  static Future<Widget> initMap(
      {Set<Polyline>? polyline, Key? key, bool report = false}) async {
    late LatLng latLng;
    var currentPos = await Geolocator.getCurrentPosition();
    if (polyline != null)
      latLng = LatLng(polyline.elementAt(0).points[0].latitude,
          polyline.elementAt(0).points[0].longitude);
    else
      latLng = LatLng(currentPos.latitude, currentPos.longitude);
    _currentCameraPosition = CameraPosition(
        target: LatLng(latLng.latitude, latLng.longitude), zoom: 18);

    if (!report)
      return GPSView(
        googleMap: GoogleMap(
          key: key,
          // indoorViewEnabled: false,
          mapType: MapType.hybrid,
          // mapType: mapType,
          // tiltGesturesEnabled: false,
          myLocationEnabled: true,
          indoorViewEnabled: false,
          initialCameraPosition: _currentCameraPosition,
          buildingsEnabled: false,
          trafficEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polyline != null ? polyline : Set<Polyline>(),
          // minMaxZoomPreference: MinMaxZoomPreference(5, 25),
          onCameraMove: (va) {},
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
      );
    return ReportMapView(
      googleMap: GoogleMap(
        key: key,
        // indoorViewEnabled: false,
        mapType: MapType.hybrid,
        // mapType: mapType,
        // tiltGesturesEnabled: false,
        myLocationEnabled: true,
        indoorViewEnabled: false,
        initialCameraPosition: _currentCameraPosition,
        buildingsEnabled: false,
        trafficEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        polylines: polyline != null ? polyline : Set<Polyline>(),
        // minMaxZoomPreference: MinMaxZoomPreference(5, 25),
        onCameraMove: (va) {},
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }

  Future<void> animateTo(CameraPosition cameraPosition) async {
    if (move) {
      move = false;

      await _controller
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      Future.delayed(Duration(seconds: 1), () {
        move = true;
      });
    }
  }

  static Future<Position> getCurrentPosition() =>
      Geolocator.getCurrentPosition();
  static CameraPosition getCameraPosition(LatLng latLng) => CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude), zoom: 18);
}
