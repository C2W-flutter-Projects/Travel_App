import 'requiredClasses.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'dart:io';

dynamic database;

// create database
Future<dynamic> createMyDatabase() async {
  return openDatabase(
    path.join(await getDatabasesPath(), "UsersDatabase.db"),
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

  return List.generate(mapEntry.length, (i) {
    return SingleChildModalUsersData(
        id: mapEntry[i]["id"],
        name: mapEntry[i]["name"],
        phone: mapEntry[i]["phone"],
        username: mapEntry[i]["username"],
        password: mapEntry[i]["password"]);
  });
}
