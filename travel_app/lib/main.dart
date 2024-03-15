import 'package:flutter/material.dart';
import 'package:travel_app/src/reviews.dart';
import 'src/register.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    path.join(await getDatabasesPath(), 'TodoList10.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE AddTask(taskId INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, stars REAL)");
    },
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Register(),
      debugShowCheckedModeBanner: false,
    );
  }
}
