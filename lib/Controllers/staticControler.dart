import 'dart:convert';

import 'package:anitcorona/Util/MyaAPIUtil.dart';
import 'package:anitcorona/classes/MyNeabyUsers.dart';
import 'package:anitcorona/classes/Static/StaticData.dart';
import 'package:anitcorona/classes/Static/WeekData.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class StaticController {
  final StaticData value;

  StaticController(this.value);
  static Future<void> loadFromAPI() async {
    StaticData.listOfMe.clear();
    // loading
    var res = await get(Uri.parse(MyaAPIUtil.apiSRCAPData));
    List body = json.decode(res.body);
    body.forEach((element) {
      String title = element['title'];
      title = title.replaceAll(" '", '').replaceAll("'", '');
      List ax = element['xAxis'];
      List da = element['data'];
      final data = <int>[];
      final xAxis = <DateTime>[];
      da.forEach((strInt) {
        data.add(int.parse(strInt));
      });
      ax.forEach((strDate) {
        DateTime time = DateFormat('MMM d, yyyy', 'en_US').parse(strDate);
        xAxis.add(time);
      });
      StaticData.listOfMe
          .add(StaticData(data: data, title: title, xAxis: xAxis));
    });
  }

  StaticData getForThisMonth(DateTime when) {
    int month = when.month;
    int year = when.year;
    StaticData r =
        StaticData(title: value.title, xAxis: <DateTime>[], data: <int>[]);
    for (int index = 0; index < value.xAxis.length; index++) {
      final v = value.xAxis[index];
      if (v.month >= month && v.year >= year) {
        r.xAxis.add(v);
        r.data.add(value.data[index]);
      }
    }
    if (r.data.isEmpty) {
      r = getForThisMonth(when.subtract(Duration(days: 1)));
    }
    return r;
  }

  static WeekData getThisWeekReport() {
    // getting only that are in this week
    var week = DateTime.now().weekday;
    final weekData = MyNearbyUser.myUsers
        .where((element) => element.myScanned!
            .where((elementScan) =>
                DateTime.parse(elementScan.whenBeenScanned!).weekday == week)
            .isNotEmpty)
        .toList();
    final monday = weekData
            .where((element) => element.myScanned!
                .where((element) =>
                    DateTime.parse(element.whenBeenScanned!).day == week)
                .isNotEmpty)
            .length
            .toDouble() ??
        0;
    final thursday = weekData
            .where((element) => element.myScanned!
                .where((element) =>
                    DateTime.parse(element.whenBeenScanned!).day == (week + 1))
                .isNotEmpty)
            .length
            .toDouble() ??
        0;
    final wednesday = weekData
            .where((element) => element.myScanned!
                .where((element) =>
                    DateTime.parse(element.whenBeenScanned!).day == (week + 2))
                .isNotEmpty)
            .length
            .toDouble() ??
        0;
    final tuesday = weekData
            .where((element) => element.myScanned!
                .where((element) =>
                    DateTime.parse(element.whenBeenScanned!).day == (week + 3))
                .isNotEmpty)
            .length
            .toDouble() ??
        0;
    final friday = weekData
            .where((element) => element.myScanned!
                .where((element) =>
                    DateTime.parse(element.whenBeenScanned!).day == (week + 4))
                .isNotEmpty)
            .length
            .toDouble() ??
        0;
    final saturday = weekData
            .where((element) => element.myScanned!
                .where((element) =>
                    DateTime.parse(element.whenBeenScanned!).day == (week + 5))
                .isNotEmpty)
            .length
            .toDouble() ??
        0;
    final sunday = weekData
            .where((element) => element.myScanned!
                .where((element) =>
                    DateTime.parse(element.whenBeenScanned!).day == (week + 6))
                .isNotEmpty)
            .length
            .toDouble() ??
        0;
    final today = weekData
            .where((element) => element.myScanned!
                .where((element) =>
                    DateTime.parse(element.whenBeenScanned!).day ==
                    DateTime.now().day)
                .isNotEmpty)
            .length
            .toDouble() ??
        0;
    return WeekData(monday, wednesday, thursday, tuesday, friday, sunday,
        saturday, today, weekData.length.toDouble() ?? 0);
  }

  static List<DateTime> getThisMonthDays() {
    final thisMonth = DateTime.now().month;
    final days = <DateTime>[];
    var now = DateTime.now();
    var day = DateTime(now.year, thisMonth);
    while (day.month == thisMonth) {
      days.add(day);
      day = DateTime(now.year, thisMonth, (day.day + 1));
      print(day);
    }
    return days;
  }

  static List<int> getUsersContactPerMonth() {
    final r = <int>[];
    getThisMonthDays().forEach((day) {
      var usersThisMonth = MyNearbyUser.myUsers.where((element) =>
          DateTime.parse(element.myScanned!.last.whenBeenScanned!).day ==
          day.day);
      r.add(usersThisMonth.length);
    });
    if (r.isEmpty) r.add(0);
    return r;
  }

  static StaticController getStaticForThisUserContact() {
    final value = StaticData(
        data: getUsersContactPerMonth(),
        xAxis: getThisMonthDays(),
        title: S.current.MyFullContactsThisMonth);
    return StaticController(value);
  }
}
