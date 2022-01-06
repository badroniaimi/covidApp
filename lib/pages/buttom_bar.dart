import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:anitcorona/Controllers/UserControllers.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:anitcorona/elements/DataUploading.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:anitcorona/pages/GPS/MapNodesPage.dart';
import 'package:anitcorona/pages/MyStatePage.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import './MyHomePage.dart';
import '../Functions/page_choice.dart';
import 'DataChartsPage.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 0;

//pagePicker
  PageChoice pgChoice = new PageChoice();

  Widget _showPage = new HomePage();
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _pageIndex,
          key: _bottomNavigationKey,
          // index: 0,
          // backgroundColor: Color.fromRGBO(16, 132, 146, .99),
          // animationCurve: Curves.decelerate,
          // height: 50,
          items: [
            SalomonBottomBarItem(
                icon: Icon(Icons.home, size: 30, color: Colors.grey),
                title: Text(
                  S.of(context).home,
                )),
            SalomonBottomBarItem(
                icon:
                    Icon(Icons.stacked_bar_chart, size: 30, color: Colors.grey),
                title: Text(S.of(context).CurrentSituation)),
            SalomonBottomBarItem(
                icon: Icon(Icons.health_and_safety_rounded,
                    size: 30, color: Colors.grey),
                title: Text(S.of(context).MyCovidState)),
            SalomonBottomBarItem(
                icon: Icon(Icons.favorite, size: 30, color: Colors.red),
                title: Text(S.of(context).declare)),
            SalomonBottomBarItem(
                icon: Icon(Icons.map, size: 30, color: Colors.grey),
                title: Text(S.of(context).GPSReport)),
            // Icon(Icons.home, size: 30),
            // Icon(Icons.favorite, color: Colors.red, size: 30),
//            Icon(Icons.compare_arrows, size: 30),
          ],
          onTap: (index) async {
            setState(() {
              _pageIndex = index;
            });
            if (_pageIndex == 3) {
              // check user Data first
              if (MyUserController.cin.isEmpty ||
                  MyUser.me.phoneNumber == null ||
                  MyUser.me.phoneNumber!.isEmpty) {
                // show error message
                await showOkAlertDialog(
                    context: context, message: S.of(context).UploadingError);
                await Future.delayed(Duration(seconds: 2));
                setState(() {
                  _pageIndex = 0;
                });
                return null;
              }
              await showDataUploader(context);
              setState(() {
                _pageIndex = 0;
              });
            }
          },
        ),
        body: Container(
          child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500), child: getPage()),
        ));
  }

  Widget getPage() {
    switch (_pageIndex) {
      case 0:
        return HomePage();
      case 1:
        return DataChartPage();
      case 2:
        return MyStatePage();
      case 4:
        return GPSNodePage();
      default:
        return HomePage();
    }
  }
}
