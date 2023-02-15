import 'package:flutter/material.dart';
import 'package:roomtemppro/DashBoard/DashBoard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleek Circular Slider',
      debugShowCheckedModeBanner: false,
      home: DashBoard(),
    );
  }
}