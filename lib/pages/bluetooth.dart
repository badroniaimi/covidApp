import 'package:anitcorona/Functions/MyNearByFunctions.dart';
import 'package:flutter/material.dart';

class Bluetooth extends StatefulWidget {
  @override
  _BluetoothState createState() => new _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
//  final String userName = Random().nextInt(10000).toString();
//  final Strategy strategy = Strategy.P2P_STAR;
//
//  String _data = '';
//  String _isConnected = '';
  bool _scanning = true;
//  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
//  DB dbhelper = new DB();
  @override
  void initState() {
    super.initState();
//    _bluetooth.devices.listen((device) {
//      setState(() async {
//        _data += device.name + ' (${device.address})\n';
//        //inserting data into sql
//        Patient patient = Patient('${device.address}', '', 0, '', '', 0);
//        patient.date = DateFormat.yMd().format(DateTime.now());
//        int result;
//        if (patient.id != null) {
//          //  result =await dbhelper.update(patient);
//          print('nothing');
//        } else {
//          result = await dbhelper.insertPatient(patient);
//          print('inserted');
//        }
//        //  connect(device.address);
//      });
//    });
//    _bluetooth.scanStopped.listen((device) {
//      setState(() {
//        _scanning = false;
//        _data += 'scan stopped\n';
//      });
//    });
  }

//  BluetoothConnection connection;
//
// void connect(String address) async {
//    try {
//      connection = await BluetoothConnection.toAddress(address);
//      print('Connected to the device');
//      _isConnected="is connected";
//
//      connection.input.listen((Uint8List data) {
//        //Data entry point
//        print(ascii.decode(data));
//      });
//
//    } catch (exception) {
//      print('Cannot connect, exception occured');
//      _isConnected="not connected";
//    }
//  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('BluetoothCheck'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    _scanning
                        ? RaisedButton(
                            child: Text("Stop "),
                            onPressed: () async {
                              await MyNearByFunctions.stopWorking();
                              setState(() {
                                _scanning = false;
                              });
                            },
                          )
                        : RaisedButton(
                            child: Text("Start "),
                            onPressed: () async {
                              await MyNearByFunctions.startWorking();
                              setState(() {
                                _scanning = true;
                              });
                            },
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
