

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:devicetemperature/devicetemperature.dart';

class OutSideTemp extends StatefulWidget {
  const OutSideTemp({Key? key}) : super(key: key);

  @override
  State<OutSideTemp> createState() => _OutSideTempState();
}

class _OutSideTempState extends State<OutSideTemp> {
  double? latitude;
  double? longitude;
  int? humidity = 0;
  String? cityName = "";
  bool? isLoading = true;
  bool _lightAvailable = false;
  String? address = "";
  double? temperatureC = 0.0;
  double? temperatureF = 0.0;
  double? temperatureK = 0.0;
  double? feelsLikeC = 0.0;
  double? feelsLikeF = 0.0;



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
      double temp = decodeData['main']['temp'];
      double feels = decodeData['main']['feels_like'];
      cityName = decodeData['name'];
      temperatureC = temp - 273;
      temperatureF = temperatureC! * 9 / 5 + 32;
      feelsLikeC = feels - 273;
      feelsLikeF = feelsLikeC! * 9 / 5 + 32;

      print("outC: $temperatureC");
      print("outF: $temperatureF");
      print("feelsLikeC: $feelsLikeC");
      print("feelsLikeF: $feelsLikeF");
      setState(() {});
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    getLocationWeather();

    Future.delayed(const Duration(seconds: 1), () {
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
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
                "Outside Temperature"
                ,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Celsius ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    size: 120,
                    customColors: CustomSliderColors(
                      trackColor: Colors.lightBlue,
                      dotColor: Get.theme.disabledColor,
                      progressBarColor: Colors.lightBlue,
                    ),
                    startAngle: 130.0,
                    angleRange: 280.0,
                    customWidths: CustomSliderWidths(
                        progressBarWidth: 8, handlerSize: 10),
                  ),
                  min: 0,
                  max: 100,
                  initialValue: temperatureC!,
                  // onChangeEnd: (_value) => controller.tempature.value = _value,
                  innerWidget: (percentage) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(

                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              '${percentage.toStringAsFixed(0)}°C',
                              style: TextStyle(
                                fontSize: 16,
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
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Fahrenheit",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    size: 120,
                    customColors: CustomSliderColors(
                      trackColor: Colors.lightBlue,
                      dotColor: Get.theme.disabledColor,
                      progressBarColor: Colors.lightBlue,
                    ),
                    startAngle: 130.0,
                    angleRange: 280.0,
                    customWidths: CustomSliderWidths(
                        progressBarWidth: 8, handlerSize: 10),
                  ),
                  min: 0,
                  max: 100,
                  initialValue: temperatureF!,
                  // onChangeEnd: (_value) => controller.tempature.value = _value,
                  innerWidget: (percentage) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(

                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              '${percentage.toStringAsFixed(0)}°F',
                              style: TextStyle(
                                fontSize: 16,
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
              ],
            )
          ],
        ),

      cityName! == "" ? SizedBox():  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "  Location  ",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    ),
              ),
            ),
          ),
        ),
      cityName! == "" ? Center(
        child: Text(
          "Loading...",
          style: TextStyle(
              fontSize: 22,
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold),
        ),
      )  :Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            cityName!,
            style: TextStyle(
                fontSize: 22,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold),
          ),
        ),
        Divider(),
      ],
    );
  }
}
