import 'package:anitcorona/Controllers/staticControler.dart';
import 'package:anitcorona/Widgets/MenuAppBar.dart';
import 'package:anitcorona/classes/Static/StaticData.dart';
import 'package:anitcorona/elements/Drawer.dart';
import 'package:anitcorona/elements/NumberTotalOfUsersView.dart';
import 'package:anitcorona/elements/StaticChartView.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class DataChartPage extends StatelessWidget {
  const DataChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> myScaKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: MyDrawer(),
      key: myScaKey,
      appBar: AppBar(
        leading: MenuAppBar(
          showMenu: false,
          onTap: () {
            myScaKey.currentState!.openDrawer();
          },
        ),
        title: Text(
          S.of(context).ThisMonthReport,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.grey[800], fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // the total users in the app now
              Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: NumberViewTotalUsersView(),
              ),
              LineChartSample2(
                staticController: StaticController(
                    StaticController(StaticData.listOfMe[0])
                        .getForThisMonth(DateTime.now())),
              ),
              LineChartSample2(
                staticController: StaticController(
                    StaticController(StaticData.listOfMe[3])
                        .getForThisMonth(DateTime.now())),
              ),
              LineChartSample2(
                staticController: StaticController(
                    StaticController(StaticData.listOfMe[2])
                        .getForThisMonth(DateTime.now())),
              ),
              LineChartSample2(
                staticController: StaticController(
                    StaticController(StaticData.listOfMe[1])
                        .getForThisMonth(DateTime.now())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
