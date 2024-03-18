import 'package:flutter/material.dart';
// import 'package:travel_app/src/reviews.dart';
// import 'package:travel_app/src/reviews.dart';
import 'src/register.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart' as path;

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Register(),
      debugShowCheckedModeBanner: false,
    );
  }
}
