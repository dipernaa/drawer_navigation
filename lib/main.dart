import 'package:flutter/material.dart';
import 'package:drawer_navigation/pages/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.brown[400]
      ),
      home: Home()
    );
  }
}
