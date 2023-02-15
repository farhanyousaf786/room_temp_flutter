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
  }

  @override
  void initState() {
    initDeviceTemperature();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SleekCircularSlider(
        appearance: CircularSliderAppearance(
          customColors: CustomSliderColors(
            trackColor: Get.theme.disabledColor,
            dotColor: Get.theme.disabledColor,
            progressBarColor: Get.theme.primaryColor,
          ),
          startAngle: 130.0,
          angleRange: 280.0,
          size: Get.mediaQuery.size.height,
          customWidths:
              CustomSliderWidths(progressBarWidth: 5, handlerSize: 10),
        ),
        min: 0,
        max: 200,
        initialValue: insideTemperatureC!,
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
                      blurRadius: 7,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Get.theme.primaryColor,
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        '${percentage.toStringAsFixed(0)}°C',
                        style: TextStyle(
                          fontSize:
                              15 + (22 * 683 / Get.mediaQuery.size.height),
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))),
          ),
        ),
      ),
    );
  }
}
