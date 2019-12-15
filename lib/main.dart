
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'Screens/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget { 
  Position pos;   
  @override    
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTOBILL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

