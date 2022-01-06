import 'package:anitcorona/Controllers/AuthControllers.dart';
import 'package:anitcorona/Controllers/UserControllers.dart';
import 'package:anitcorona/Widgets/SnackBars.dart';
import 'package:anitcorona/Widgets/TitledListView.dart';
import 'package:anitcorona/Widgets/ValidatedText.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool loadingPhone = false;
  bool loadingCIN = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2), color: Colors.white),
      child: Column(
        children: [
          // the logo
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Image.asset(
              'assets/images.png',
              scale: 2.1,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.supervised_user_circle_outlined),
                    label: Text("${MyUser.me.name}")),
              ),
            ],
          ),
          // the phone
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: loadingPhone
                ? SizedBox(
                    height: 50,
                    child: SpinKitThreeBounce(
                      color: Colors.grey,
                    ),
                  )
                : InkWell(
                    key: ValueKey(loadingPhone),
                    onTap: () async {
                      if (MyUser.me.phoneNumber == null ||
                          MyUser.me.phoneNumber!.isEmpty) {
                        setState(() {
                          loadingPhone = true;
                        });
                        await MyAuthControllers.smsPhoneHandler(context,
                            onSent: () {
                          setState(() {
                            loadingPhone = false;
                          });
                        }, onError: () {
                          MySnackBars.showErrorMessage(
                              "Please check your phone number");
                          setState(() {
                            loadingPhone = false;
                          });
                        });
                        setState(() {
                          loadingPhone = false;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValidateTextCard(
                        title: "Phone number",
                        validate: () => (MyUser.me.phoneNumber != null &&
                            MyUser.me.phoneNumber!.isNotEmpty),
                      ),
                    ),
                  ),
          ),
          InkWell(
            onTap: () async {
              if (MyUserController.cin.isEmpty) {
                await showUserCINUI(context);
                setState(() {});
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValidateTextCard(
                title: "CIN",
                validate: () => MyUserController.cin.isNotEmpty,
              ),
            ),
          ),
          // the logout
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TitledListView(title: "Credit", child: Column()),
          ),
          TextButton.icon(
              onPressed: () {}, icon: Icon(Icons.logout), label: Text("Logout"))
          // logs
        ],
      ),
    );
  }
}
