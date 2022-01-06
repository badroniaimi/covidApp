import 'dart:math';

import 'package:anitcorona/Database/RealTimeDatabase.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NodeTrackingController {
  static bool _tracking = true;
  static bool _isTracking = false;
  static late Stream<Position> _stream;
  static Future<void> startTracking() async {
    _stream =
        Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best);
    var session = MyRealTimeDatabaseActions.getSession();
    await MyRealTimeDatabaseActions.saveSession(session, MyUser.me.id!);
    _isTracking = true;
    _tracking = true;
    _stream.forEach((element) async {
      if (_tracking) {
        var when = DateTime.now().millisecondsSinceEpoch;
        // the location
        var locationData = element.toJson();
        var locationKey =
            '${element.longitude.toString().replaceAll('.', '-')}_${element.latitude.toString().replaceAll('.', '-')}';
        var userData = MyUser.me.toMap();
        final object = NodeObjectSession(
            locationData: locationData,
            locationKey: locationKey,
            userData: userData,
            when: when,
            session: session.key,
            userId: MyUser.me.id!);
        // save
        await MyRealTimeDatabaseActions.setSaveLocationInTimeForNodes(object);
      }
    });
  }

  static Future<void> stopLocationTracking() async {
    _tracking = false;
    _isTracking = false;
  }

  static bool get tracking => _tracking;

  static bool get isTracking => _isTracking;

  static Future<List<SessionObject>> getSessions() async {
    final r = <SessionObject>[];
    var snap =
        await MyRealTimeDatabaseActions.getSessions(MyUser.me.id!).once();
    (snap.value as List).forEach((element) {
      r.add(SessionObject.fromMap(Map.from(element)));
    });
    return r;
  }

  static Future<List<NodeObjectSession>> getSessionObject(
      SessionObject sessionObject) async {
    final r = <NodeObjectSession>[];
    var snap = await MyRealTimeDatabaseActions.getSessionData(
            MyUser.me.id!, sessionObject.session)
        .once();
    (snap.value as Map).forEach((key, value) {
      r.add(NodeObjectSession.fromMap(Map<String, dynamic>.from(value)));
    });
    return r;
  }

  static Polyline getPolyLineObjectList(List<NodeObjectSession> list) {
    late Polyline r;
    r = Polyline(
        polylineId: PolylineId(list.first.session),
        width: 5,
        points: <LatLng>[
          for (final x in list)
            LatLng(
                MyPosition.fromMap(Map<String, dynamic>.from(x.locationData))
                    .latitude,
                MyPosition.fromMap(Map<String, dynamic>.from(x.locationData))
                    .longitude)
        ],
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    return r;
  }
}

class MyPosition extends Position {
  /// The latitude of this position in degrees normalized to the interval -90.0
  /// to +90.0 (both inclusive).
  final double latitude;

  /// The longitude of the position in degrees normalized to the interval -180
  /// (exclusive) to +180 (inclusive).
  final double longitude;

  /// The time at which this position was determined.
  final DateTime? timestamp;

  /// The altitude of the device in meters.
  ///
  /// The altitude is not available on all devices. In these cases the returned
  /// value is 0.0.
  final double altitude;

  /// The estimated horizontal accuracy of the position in meters.
  ///
  /// The accuracy is not available on all devices. In these cases the value is
  /// 0.0.
  final double accuracy;

  /// The heading in which the device is traveling in degrees.
  ///
  /// The heading is not available on all devices. In these cases the value is
  /// 0.0.
  final double heading;

  /// The floor specifies the floor of the building on which the device is
  /// located.
  ///
  /// The floor property is only available on iOS and only when the information
  /// is available. In all other cases this value will be null.
  final int? floor;

  /// The speed at which the devices is traveling in meters per second over
  /// ground.
  ///
  /// The speed is not available on all devices. In these cases the value is
  /// 0.0.
  final double speed;

  /// The estimated speed accuracy of this position, in meters per second.
  ///
  /// The speedAccuracy is not available on all devices. In these cases the
  /// value is 0.0.
  final double speedAccuracy;

  /// Will be true on Android (starting from API lvl 18) when the location came
  /// from the mocked provider.
  ///
  /// On iOS this value will always be false.
  final bool isMocked;
  MyPosition({
    required this.longitude,
    required this.latitude,
    required this.timestamp,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.speedAccuracy,
    this.floor,
    this.isMocked = false,
  }) : super(
            accuracy: accuracy,
            altitude: altitude,
            heading: heading,
            latitude: latitude,
            longitude: longitude,
            speed: speed,
            speedAccuracy: speedAccuracy,
            timestamp: timestamp,
            floor: floor,
            isMocked: isMocked);

  factory MyPosition.fromMap(Map<String, dynamic> map) {
    return new MyPosition(
      latitude: double.parse(map['latitude'].toString()),
      longitude: double.parse(map['longitude'].toString()),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      altitude: double.parse(map['altitude'].toString()),
      accuracy: double.parse(map['accuracy'].toString()),
      heading: double.parse(map['heading'].toString()),
      floor: map['floor'] as int?,
      speed: double.parse(map['speed'].toString()),
      speedAccuracy:
          double.parse(map['speedAccuracy']?.toString() ?? 0.toString()),
      isMocked: map['isMocked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
      'timestamp': this.timestamp,
      'altitude': this.altitude,
      'accuracy': this.accuracy,
      'heading': this.heading,
      'floor': this.floor,
      'speed': this.speed,
      'speedAccuracy': this.speedAccuracy,
      'isMocked': this.isMocked,
    } as Map<String, dynamic>;
  }
}

class SessionObject {
  String session;
  int when;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  SessionObject({
    required this.session,
    required this.when,
  });

  @override
  String toString() {
    return 'SessionObject{session: $session, when: $when}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionObject &&
          runtimeType == other.runtimeType &&
          session == other.session &&
          when == other.when);

  @override
  int get hashCode => session.hashCode ^ when.hashCode;

  factory SessionObject.fromMap(Map<String, dynamic> map) {
    return new SessionObject(
      session: map['session'] as String,
      when: map['when'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'session': this.session,
      'when': this.when,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

class NodeObject {
  int when;
  String locationKey;
  Map userData;
  Map locationData;
  String userId;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  NodeObject({
    required this.when,
    required this.locationKey,
    required this.userData,
    required this.locationData,
    required this.userId,
  });

  @override
  String toString() {
    return 'NodeObject{when: $when, locationKey: $locationKey, userData: $userData, locationData: $locationData, userId: $userId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NodeObject &&
          runtimeType == other.runtimeType &&
          when == other.when &&
          locationKey == other.locationKey &&
          userData == other.userData &&
          locationData == other.locationData &&
          userId == other.userId);

  @override
  int get hashCode =>
      when.hashCode ^
      locationKey.hashCode ^
      userData.hashCode ^
      locationData.hashCode ^
      userId.hashCode;

  factory NodeObject.fromMap(Map<String, dynamic> map) {
    return new NodeObject(
      when: map['when'] as int,
      locationKey: map['locationKey'] as String,
      userData: map['userData'] as Map,
      locationData: map['locationData'] as Map,
      userId: map['userId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'when': this.when,
      'locationKey': this.locationKey,
      'userData': this.userData,
      'locationData': this.locationData,
      'userId': this.userId,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

class NodeObjectSession implements NodeObject {
  @override
  Map locationData;

  @override
  String locationKey;

  @override
  Map userData;

  @override
  int when;

  String session;

  @override
  String userId;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  NodeObjectSession({
    required this.locationData,
    required this.locationKey,
    required this.userData,
    required this.when,
    required this.session,
    required this.userId,
  });

  @override
  String toString() {
    return 'NodeObjectSession{locationData: $locationData, locationKey: $locationKey, userData: $userData, when: $when, session: $session, userId: $userId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NodeObjectSession &&
          runtimeType == other.runtimeType &&
          locationData == other.locationData &&
          locationKey == other.locationKey &&
          userData == other.userData &&
          when == other.when &&
          session == other.session &&
          userId == other.userId);

  @override
  int get hashCode =>
      locationData.hashCode ^
      locationKey.hashCode ^
      userData.hashCode ^
      when.hashCode ^
      session.hashCode ^
      userId.hashCode;

  factory NodeObjectSession.fromMap(Map<String, dynamic> map) {
    return new NodeObjectSession(
      locationData: map['locationData'] as Map,
      locationKey: map['locationKey'] as String,
      userData: map['userData'] as Map,
      when: map['when'] as int,
      session: map['session'] as String,
      userId: map['userId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'locationData': this.locationData,
      'locationKey': this.locationKey,
      'userData': this.userData,
      'when': this.when,
      'session': this.session,
      'userId': this.userId,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
