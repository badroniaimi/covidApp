import 'package:anitcorona/Controllers/staticControler.dart';
import 'package:anitcorona/Widgets/TodayGraph.dart';
import 'package:anitcorona/classes/Static/WeekData.dart';
import 'package:anitcorona/elements/GPS/GettingNODEReport.dart';
import 'package:anitcorona/elements/StaticChartView.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class MainPageReport extends StatelessWidget {
  MainPageReport({Key? key}) : super(key: key);
  final WeekData weekData = StaticController.getThisWeekReport();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black87,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          S.of(context).MyFullReports,
          style: TextStyle(color: Colors.black87, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  TodayGraph(
                      monday: weekData.monday,
                      wednesday: weekData.wednesday,
                      thursday: weekData.thursday,
                      tuesday: weekData.tuesday,
                      friday: weekData.friday,
                      sunday: weekData.sunday,
                      saturday: weekData.saturday,
                      today: weekData.today,
                      total: weekData.total),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).ContactThisWeek,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Rapport for this month
            LineChartSample2(
              staticController: StaticController.getStaticForThisUserContact(),
            ),
            // node tracking explaining
            GettingNodeReportTrackingButton(),
            //  get the node tracking
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      S.of(context).TrackingGPSMessage1,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        S.of(context).TrackingGPSMessage2,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
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
