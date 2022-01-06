import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './load_data.dart';
import '../style/global.dart';
import 'chart.dart';

class InfoCard extends StatelessWidget {
  final String? title;
  final int? effectedNum;
  final int? id;
  final Color? iconColor;
  final Function? press;

  const InfoCard({
    Key? key,
    this.id,
    this.title,
    this.effectedNum,
    this.iconColor,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: (new LoadData()).getStatList(),
        // ignore: missing_return
        builder: (BuildContext coontext, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Input a URL to start');
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.active:
              return new Text('');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return new Text(
                  'no connection to the internet',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                int? a = snapshot.data[id];
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onTap: press as void Function()?,
                      child: Container(
                        width: constraints.maxWidth,
                        // Here constraints.maxWidth provide us the available width for the widget
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: iconColor!.withOpacity(0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    // child: SvgPicture.asset(
                                    //   "assets/icons/running.svg",
                                    //   height: 12,
                                    //   width: 12,
                                    //   color: iconColor,
                                    // ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: Colors.black87),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(color: kTextColor),
                                        children: [
                                          TextSpan(
                                            text: '$a \n',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                          ),
                                          TextSpan(
                                            text: "People",
                                            style: TextStyle(
                                              fontSize: 15,
                                              height: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: LineReportChart(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
          }
        });
  }
}

class SymptomsCard extends StatelessWidget {
  final String? imgSrc;
  final String? title;
  const SymptomsCard({
    Key? key,
    this.imgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(imgSrc!),
        Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.blueAccent),
        )
      ],
    );
  }
}

class AlertCard extends StatelessWidget {
  final String? imgSrc;
  final String? title;
  final Function? press;
  const AlertCard({
    Key? key,
    this.imgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press as void Function()?,
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(16, 132, 146, .99),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Wrap(
              children: <Widget>[
                Image.asset(imgSrc!, width: 450, height: 125),
              ],
            ),
          ),
          FlatButton(
            color: Colors.white.withOpacity(0.00),
            child: Container(
              height: 125,
              width: 450,
              color: Colors.white.withOpacity(0.00),
            ),
            onPressed: () {
              _launchURL();
            },
          ),
        ]));
  }

  _launchURL() async {
    const url = 'tel:+1234567';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
