import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roomtemppro/DashBoard/DashBoard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Room Temp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff867cef),
        backgroundColor: Color(0xfff0f0f0),
        disabledColor: Color(0xffededed),
        colorScheme: ColorScheme.fromSwatch(accentColor: Color(0xffaf92ea)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DashBoard(),
    );
  }
}