import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:devicetemperature/devicetemperature.dart';

class RoomTemp extends StatefulWidget {
  const RoomTemp({Key? key}) : super(key: key);

  @override
  State<RoomTemp> createState() => _RoomTempState();
}

class _RoomTempState extends State<RoomTemp> {
  double? insideTemperatureC = 0.0;
  double? insideTemperatureF = 0.0;

  Future<void> initDeviceTemperature() async {
    double temp;
    try {
      temp = await Devicetemperature.DeviceTemperature;
    } catch (e) {
      temp = 0.0;
    }
    insideTemperatureC = (temp - 7);
    insideTemperatureF = (((temp * 9 / 5) + 32) - 16);
    setState(() {});
  }

  @override
  void initState() {
    initDeviceTemperature();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(15),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Room Temperature"
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
                  initialValue: insideTemperatureC!,
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
                  initialValue: insideTemperatureF!,
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
            )
          ],
        ),
      ],
    );
  }
}
