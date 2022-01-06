import 'package:anitcorona/Controllers/Map/MapController.dart';
import 'package:anitcorona/Controllers/Map/NodeTracking.dart';
import 'package:anitcorona/Functions/Helpers.dart';
import 'package:anitcorona/elements/View/Session.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GPSMapPage extends StatefulWidget {
  final List<SessionObject> sessions;
  final SessionObject sessionObject;
  const GPSMapPage(
      {Key? key, required this.sessions, required this.sessionObject})
      : super(key: key);

  @override
  _GPSMapPageState createState() => _GPSMapPageState();
}

class _GPSMapPageState extends State<GPSMapPage> {
  bool loadingSession = true;
  late List<NodeObjectSession> sessionData;
  late SessionObject sessionObject;
  late GoogleMapController controller;
  bool loadingCurrentPosition = false;
  @override
  void initState() {
    sessionObject = widget.sessionObject;
    loadingSession = true;
    NodeTrackingController.getSessionObject(sessionObject).then((value) {
      setState(() {
        print(value);
        sessionData = value;
        loadingSession = false;
      });
    });
    super.initState();
  }

  void loadSession(SessionObject sessionObjectSelected) {
    sessionObject = sessionObjectSelected;
    setState(() {
      loadingSession = true;
    });
    NodeTrackingController.getSessionObject(sessionObject).then((value) {
      setState(() {
        sessionData = value;
        loadingSession = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: loadingSession
            ? SpinKitPulse(
                color: Theme.of(context).primaryColor,
              )
            : Stack(
                children: [
                  FutureBuilder<Position>(
                      future: MapController.getCurrentPosition(),
                      builder: (_, snap) {
                        if (snap.data == null)
                          return SpinKitPulse(
                            color: Theme.of(context).primaryColor,
                          );
                        Polyline polyline =
                            NodeTrackingController.getPolyLineObjectList(
                                sessionData);
                        return GoogleMap(
                          // indoorViewEnabled: false,
                          mapType: MapType.hybrid,
                          // mapType: mapType,
                          // tiltGesturesEnabled: false,
                          myLocationEnabled: true,
                          indoorViewEnabled: false,
                          initialCameraPosition:
                              MapController.getCameraPosition(LatLng(
                                  snap.data!.latitude, snap.data!.longitude)),
                          buildingsEnabled: false,
                          trafficEnabled: false,
                          mapToolbarEnabled: false,
                          compassEnabled: false,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          polylines: Set.of([polyline]),
                          // minMaxZoomPreference: MinMaxZoomPreference(5, 25),
                          onCameraMove: (va) {},
                          onMapCreated: (GoogleMapController controller) {
                            this.controller = controller;
                          },
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(() {
                                loadingCurrentPosition = true;
                              });
                              var pos =
                                  await MapController.getCurrentPosition();
                              controller.animateCamera(CameraUpdate.newLatLng(
                                  LatLng(pos.latitude, pos.longitude)));
                              setState(() {
                                loadingCurrentPosition = false;
                              });
                            },
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.blue, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: loadingCurrentPosition
                                        ? SpinKitPulse(
                                            color: Colors.white,
                                            size: 30,
                                          )
                                        : Icon(
                                            Icons.navigation,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                  ),
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              showSessionPicker(context, (t) {
                                setState(() {
                                  this.sessionObject = t;
                                });
                                loadSession(this.sessionObject);
                                Navigator.of(context).pop();
                              }, (s) {});
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.list,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(8.0).add(EdgeInsets.only(top: 20)),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${S.of(context).DateOf}: ${showTheBestTimeViewWithDateFuture(DateTime.fromMillisecondsSinceEpoch(sessionObject.when))}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
