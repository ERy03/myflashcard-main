import 'package:flutter/material.dart';
import 'package:myflashcard/db/database.dart';

import 'screens/home_screen.dart';

late MyDatabase database;
void main() {
  database = MyDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My flashcard",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Lanobe",
      ),
      home: HomeScreen(),
    );
  }
}
