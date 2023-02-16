import 'dart:convert';

import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:http/http.dart' as http;

class Humidity extends StatefulWidget {
  const Humidity({Key? key}) : super(key: key);

  @override
  State<Humidity> createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  double? latitude;
  double? longitude;
  int? humidity = 0;
  String? cityName = "";
  String apiKey = 'dd6359b8920c1a71d2561dc152d6ad3f';
  bool? isLoading = true;
  bool _lightAvailable = false;
  final environmentSensors = EnvironmentSensors();


  getLocationWeather() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    getData(
        'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$apiKey');
  }

  getData(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      humidity = decodeData['main']['humidity'];
      cityName = decodeData['name'];
      setState(() {});
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    getLocationWeather();
    environmentSensors.pressure.listen((pressure) {
      print(pressure.toString());
    });
    Future.delayed(const Duration(seconds: 1), () {
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading!
        ? const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Loading Data...",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        )
        : Column(
            children: [
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Material(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(15),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "  Humidity  "
                      ,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  cityName!,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    size: MediaQuery.of(context).size.height/3.5,
                    customColors: CustomSliderColors(
                      trackColor: Colors.lightBlue,
                      dotColor: Get.theme.disabledColor,
                      progressBarColor: Colors.lightBlue,
                    ),
                    startAngle: 130.0,
                    angleRange: 280.0,
                    customWidths: CustomSliderWidths(
                        progressBarWidth: 10, handlerSize: 10),
                  ),
                  min: 0,
                  max: 150,
                  initialValue: humidity!.toDouble(),
                  // onChangeEnd: (_value) => controller.tempature.value = _value,
                  innerWidget: (percentage) => Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 15,
                            ),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 10,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              '${percentage.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
