import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/covid_data.dart';
import '../models/patiant.dart';

class DB {
  static DB? _dbHelper;
  static Database? _database;

  String table = 'covid19_macA_table';
  String colId = 'id';
  String colMac = 'mac_address';
  String colSeconds = 'seconds';
  String colDate = 'date';
  String colSick = 'sick';
  String colPhone = 'phone_number';
//covid19 stats data
  String statsTable = 'covid19_stats_table';
  String colCountry = 'country';
  String colCases = 'cases';
  String colDeathes = 'deaths';
  String colRecoverd = 'recovered';
  String colCasesToday = 'cases_today';

  DB._createInstance();

  factory DB() {
    if (_dbHelper == null) {
      _dbHelper = DB._createInstance();
    }
    return _dbHelper!;
  }
  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'covid191.db';

    // Open/create the database at a given path
    var covidDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return covidDatabase;
  }

  //creatre the table
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $table($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colMac TEXT, '
        '$colSeconds INTEGER, $colDate TEXT,$colPhone TEXT,$colSick INTEGER)');

    await db.execute(
        'CREATE TABLE $statsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colCountry TEXT, $colCases INTEGER, '
        '$colDeathes INTEGER, $colRecoverd INTEGER,$colCasesToday INTEGER,$colDate TEXT)');
    print("table created");
  }
//this function is for fetching the data

  Future<List<Map<String, dynamic>>> getPatientMapList() async {
    Database db = await (this.database as FutureOr<Database>);

    var result = await db.query(table, orderBy: '$colId ');
    return result;
  }

  insertTodayStats(CovidData covidData) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'covid19.db';

    var database = await openDatabase(path, version: 1, onCreate: _createDb);
    var result = await database.rawInsert(
        "INSERT INTO covid19_stats_table (country, cases, deaths,recovered,cases_today,date)"
        " VALUES ('${covidData.country}',${covidData.stats![0]},${covidData.stats![1]},${covidData.stats![2]},${covidData.stats![3]},'${covidData.drawTime}')");
    print('data inserted');
    return result;
  }

  Future<int> insertPatient(Patient patient) async {
    Database db = await (this.database as FutureOr<Database>);
    var result = await db.insert(table, patient.toMap());
    return result;
  }

  //created just in case
  Future<int> deletePatient(int id) async {
    var db = await (this.database as FutureOr<Database>);
    int result = await db.rawDelete('DELETE FROM $table WHERE $colId = $id');
    return result;
  }

  Future<int> updatePatient(Patient patient) async {
    var db = await (this.database as FutureOr<Database>);
    var result = await db.update(table, patient.toMap(),
        where: '$colId = ?', whereArgs: [patient.id]);
    return result;
  }

//this one for calculating the number of people in the app
  Future<int> getPatientCount() async {
    Database db = await (this.database as FutureOr<Database>);
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table');
    int result = Sqflite.firstIntValue(x)!;
    return result;
  }

//thi function will get a list from the map
  Future<List<Patient>> getPatientList() async {
    var todoMapList = await getPatientMapList();

    List<Patient> covidList = <Patient>[];

    for (int i = 0; i < todoMapList.length; i++) {
      covidList.add(Patient.fromMapObject(todoMapList[i]));
      //for testing toDelete
      print(Patient.fromMapObject(todoMapList[i]).date);
    }

    return covidList;
  }

  Future<List> getStats() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'covid19.db';

    var database = await openDatabase(path, version: 1, onCreate: _createDb);
    var result = await database.query("covid19_stats_table", columns: [
      "id",
      "country",
      "cases",
      "deaths",
      "recovered",
      "cases_today",
      "date"
    ]);
// print(result.toList());
    return result.toList();
  }
} //DB
