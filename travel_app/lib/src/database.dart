import 'requiredClasses.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// import 'dart:io';

dynamic database;

// create database
Future<dynamic> createMyDatabase() async {
  return openDatabase(
    path.join(await getDatabasesPath(), "UsersDatabase2.db"),
    version: 1,
    onCreate: (db, version) {
      db.execute(''' CREATE TABLE UserData (
    id INTEGER PRIMARY KEY,
    name TEXT,
    phone TEXT,
    username TEXT,
    password TEXT
  )
''');
      db.execute(''' CREATE TABLE ReviewData (
    reviewId INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    stars REAL
  )
''');
      db.execute(''' CREATE TABLE AppData (
    reviewId INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    stars REAL
  )
''');
      print("Database Created Sucessfully");
    },
  );
}

//insert data into database

Future<void> insertUserData(SingleChildModalUsersData obj) async {
  final localDB = await database;

  localDB.insert(
    "UserData",
    obj.getUserMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// get data from database

Future<List<SingleChildModalUsersData>> fetchUserData() async {
  final localDB = await database;

  List<Map<String, dynamic>> mapEntry = await localDB.query(
    "UserData",
  );
  print("INSIDE MAPENTRY DATA: $mapEntry");
  return List.generate(mapEntry.length, (i) {
    return SingleChildModalUsersData(
        id: mapEntry[i]["id"],
        name: mapEntry[i]["name"],
        phone: mapEntry[i]["phone"],
        username: mapEntry[i]["username"],
        password: mapEntry[i]["password"]);
  });
}

class AppDataModel {
  final int? reviewId;
  String? title;
  String? description;
  double? stars;

  AppDataModel({this.reviewId, this.title, this.description, this.stars});

  Map<String, dynamic> todoMap() {
    return {
      "reviewId": reviewId,
      "title": title,
      "description": description,
      "stars": stars,
    };
  }

  @override
  String toString() {
    return """{reviewId : $reviewId, title : $title, description : $description, stars : $stars}""";
  }
}

List<AppDataModel> dataList = [];
double starsRating = 0.0;

// insert
Future<void> insertAppData(AppDataModel obj) async {
  final localDB = await database;

  await localDB.insert("AppData", obj.todoMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

// fetch data
Future<List<AppDataModel>> getAppData() async {
  final localDB = await database;

  List<Map<String, dynamic>> reviewMap = await localDB.query("AppData");
  print("INSIDE MAP: $reviewMap");
  return List.generate(reviewMap.length, (i) {
    return AppDataModel(
      reviewId: reviewMap[i]['reviewId'],
      title: reviewMap[i]['title'],
      description: reviewMap[i]['description'],
      stars: reviewMap[i]['stars'],
      // date: reviewMap[i]['date'],
    );
  });
}
