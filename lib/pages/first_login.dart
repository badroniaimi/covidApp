// import 'package:fancy_on_boarding/fancy_on_boarding.dart';
// import 'package:flutter/material.dart';
//
// import '../Functions/first_log_check.dart';
// import '../style/global.dart';
// import 'LoadingPage.dart';
//
// class FirstLogin extends StatelessWidget {
//   final pageList = [
//     PageModel(
//       heroImagePath: ,
//         color: white,
//         // heroAssetPath: 'assets/icons/how.png',
//         title: Text('How it works?',
//             style: TextStyle(
//               fontWeight: FontWeight.w800,
//               color: GbackgroundStatutColor,
//               fontSize: 34.0,
//             )),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//               'the app will register everyone that you meet on your phone, and notify you if one them tested positive for covid19',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w300,
//                 color: Colors.grey,
//                 fontSize: 18.0,
//               )),
//         ),
//         iconAssetPath: 'assets/icons/circle.png'),
//     PageModel(
//         color: white,
//         heroAssetPath: 'assets/icons/people.png',
//         title: Text('Stay safe',
//             style: TextStyle(
//               fontWeight: FontWeight.w800,
//               color: GbackgroundStatutColor,
//               fontSize: 34.0,
//             )),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//               'A lot of positive cases don\'t even know they are carrying the virus, so they continue spreading the virus Unintentionally, so by using this app you will be not only protecting your self but others as well   ',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w300,
//                 color: grey,
//                 fontSize: 18.0,
//               )),
//         ),
//         iconAssetPath: 'assets/icons/circle.png'),
//     PageModel(
//         color: white,
//         heroAssetPath: 'assets/icons/privacy.png',
//         title: Text('Privacy',
//             style: TextStyle(
//               fontWeight: FontWeight.w800,
//               color: GbackgroundStatutColor,
//               fontSize: 34.0,
//             )),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//               'Your phone number is the only detail needed for you to use the Corona out app',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w300,
//                 color: grey,
//                 fontSize: 18.0,
//               )),
//         ),
//         iconAssetPath: 'assets/icons/circle.png'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           FancyOnBoarding(
//             doneButtonBackgroundColor: GbackgroundStatutColor,
//             doneButtonText: "Done",
//             pageList: pageList,
//             onDoneButtonPressed: () {
//               FirstLog.setLoginFlag();
//
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => MyLoadingPage()));
//             },
//             onSkipButtonPressed: () => print('skip'),
//           ),
//           Positioned.fill(
//             bottom: 10,
//             child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Text(
//                   "< swipe left",
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }
