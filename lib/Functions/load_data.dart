import 'package:anitcorona/Database/DB.dart';
import 'package:anitcorona/models/covid_data.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/covid_data.dart';

const url = "https://www.worldometers.info/coronavirus/country/morocco/";

class LoadData {
//static List<int> listH = List<int>();

  Future<CovidData> getData() async {
    //this variable are going to be used to compare date in the database and today to show the newest data
    int year = DateTime.now().year;
    int mounth = DateTime.now().month;
    int day = DateTime.now().day;

    List<int?> caseList = <int?>[];
    List<String> lastDateList = <String>[];
    DB dbhelper = new DB();
    CovidData covidData = CovidData(
        "Morocco", [], DateFormat.yMd().format(DateTime.now()).toString());

    var elements = await dbhelper.getStats();
    if (elements.length > 0) {
      Map stats = elements[elements.length - 1];
      lastDateList = stats['date'].toString().split('/');
      if (year > int.tryParse(lastDateList[2])! ||
          mounth > int.tryParse(lastDateList[0])! ||
          day > int.tryParse(lastDateList[1])!) {
        var result = await http.get(Uri.parse(url));
        caseList = dataScrapping(result) as List<int?>;
        if (elements[elements.length - 1] != null) {
          caseList.add(caseList[0]! - stats['cases'] as int?);
        } else {
          caseList.add(0);
        }
        covidData.stats = caseList;
        dbhelper.insertTodayStats(covidData);
      } else {
        Map mapStats = elements[elements.length - 1];
        caseList.add(mapStats['cases']);
        caseList.add(mapStats['deaths']);
        caseList.add(mapStats['recovered']);
        caseList.add(mapStats['cases_today']);

        covidData.stats = caseList;

        // print(mapStats['deaths'].toString());

      }

//      await dbhelper.getStats().then((elements){
//
//
//       });
//
//
//
//      return covidData;
    } else {
      print("case2 where database is empty");
      var result = await http.get(Uri.parse(url));
      caseList = dataScrapping(result) as List<int?>;
      caseList.add(0);
      covidData.stats = caseList;
      await dbhelper.insertTodayStats(covidData);
      await getData();
    }

    // print(covidData.stats);
    return covidData;

//  print('');
//  for (int stat in covidData.toMap()['stats'] ){
//    print(stat);
//  }
  }

  List dataScrapping(var result) {
    var dataToInt;

    var doc = parse(result.body);
    List<int> caseList = <int>[];
    var _data = doc.getElementsByClassName("maincounter-number");
    for (Element data in _data) {
      dataToInt = int.tryParse(data.text.toString().replaceAll(',', ''));
      // print(dataToInt);
      if (dataToInt != null) {
        try {
          caseList.add(dataToInt);
        } catch (e) {
          dataToInt = 0;
          print(e);
        }
      }
    }
    //new cases is a calculated var
    //caseList.add(caseList[2]-caseList[2]);
    return caseList;
  }

  getStatList() async {
    var covidData = await getData();
    return covidData.stats;
  }
}
