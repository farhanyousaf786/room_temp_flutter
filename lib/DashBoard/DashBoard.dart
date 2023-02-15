import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:roomtemppro/utils/AppAssets.dart';
import 'package:roomtemppro/utils/AppSpaces.dart';
import 'package:roomtemppro/widgets/buttons.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(children: [
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppAssets.temperature,
                      scale: 1.5,
                    ),
                  ),
                  Text(
                    "Room Temperature",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              )
            ],
          ),
          Expanded(
            child: Padding(
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
                initialValue: 10,
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
                                  fontSize: 15 +
                                      (22 * 683 / Get.mediaQuery.size.height),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))),
                  ),
                ),
              ),
            ),
          ),
          AppSpaces.vertical10,
          Text('Click to turn off'),
          AppSpaces.vertical10,
          AppSpaces.vertical30,
        ]),
      ),
    );
  }
}
