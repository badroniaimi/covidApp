import 'package:anitcorona/generated/l10n.dart';
import 'package:anitcorona/main.dart';
import 'package:anitcorona/pages/Report/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetFullReport extends StatelessWidget {
  const GetFullReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // navigate to the full report page
        MyApp.myAppNavigator!.currentState!
            .push(CupertinoPageRoute(builder: (_) => MainPageReport()));
      },
      child: Card(
        elevation: 0,
        color: Color(0xff7589a2),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).GetMyFullReport,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
