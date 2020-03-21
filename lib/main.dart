import 'package:flutter/material.dart';
import 'package:tournamentviewer/screens/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('rebuild MyApp');
    return MaterialApp(
      title: 'Tournament viewer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: MyHomeView(),
    );
  }
}
