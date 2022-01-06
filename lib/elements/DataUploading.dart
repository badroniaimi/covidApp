import 'package:anitcorona/Database/Actions.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'PersonView.dart';

class DataUploadingView extends StatefulWidget {
  @override
  _DataUploadingViewState createState() => _DataUploadingViewState();
}

class _DataUploadingViewState extends State<DataUploadingView> {
  static bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/icons/doc1.png',
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).UploadingYourData,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.of(context).uploadingInformation1,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.of(context).uploadingInformation2,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.of(context).contactInformation,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontSize: 25,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyPersonView(
                              person: MyUser.me,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter.add(Alignment(0, -0.1)),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: !_isLoading
                    ? InkWell(
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.of(context).declare,
                            key: ValueKey<bool>(false),
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 30, color: Colors.white),
                            textScaleFactor: MediaQuery.of(context).size.width *
                                    0.0015 +
                                MediaQuery.of(context).textScaleFactor * 0.05,
                          ),
                        ),
                      )
                    : SpinKitThreeBounce(
                        color: Colors.white,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future showDataUploader(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (_) => DataUploadingView(),
    backgroundColor: Colors.white,
    elevation: 5,
    shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)));
