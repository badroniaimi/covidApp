import 'package:anitcorona/Database/Actions.dart';
import 'package:anitcorona/Global/GlobalKeys.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class HelthStatut extends StatefulWidget {
  @override
  _HelthStatutState createState() => _HelthStatutState();
}

class _HelthStatutState extends State<HelthStatut> {
  bool _isLoading = false;
  final scaKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    MyGlobalKeys.myGlobalScaKey = scaKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaKey,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(500, 200),
                          //  bottomLeft: Radius.circular(250),
                          bottomRight: Radius.circular(10)),
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                        // color: Colors.redAccent,
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 90),
                          child: Row(
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(
                                    text: "seek medical attention ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'RobotoMono',
                                    ),
                                  ),
                                  textAlign: TextAlign.center),
                              Icon(
                                Icons.local_hospital,
                                size: 50,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            //set the state of the uploading
                            setState(() {
                              _isLoading = true;
                            });
                            //upload your data
                            // await MyUser.me.uploadTheFile();
                            await MyDataBaseActions.uploadData();
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Stack(
                              children: [
                                Image.asset('assets/icons/ambulanceButton.png'),
                                Align(
                                    alignment: Alignment.centerRight
                                        .add(Alignment(-1.2, 0)),
                                    child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 500),
                                      child: !_isLoading
                                          ? Text(
                                              S.of(context).NotFeelingGood,
                                              key: ValueKey<bool>(false),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(fontSize: 20),
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.0015 +
                                                      MediaQuery.of(context)
                                                              .textScaleFactor *
                                                          0.05,
                                            )
                                          : CircleAvatar(
                                              key: ValueKey<bool>(true),
                                              backgroundColor: Colors.white,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
              ],
            ),
            Positioned(
              height: (MediaQuery.of(context).size.height) * 5 / 7,
              width: MediaQuery.of(context).size.width * 2 / 3,
              right: 60,
              top: 0,
              child: Image.asset('assets/icons/doc1.png'),
            ),
          ],
        ));
  }
}
