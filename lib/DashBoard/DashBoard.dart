import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomtemppro/widgets/Humidity/Humidity.dart';
import 'package:roomtemppro/widgets/LightSen/LightSen.dart';
import 'package:roomtemppro/widgets/RoomTemp/RoomTemp.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:roomtemppro/utils/AppAssets.dart';
import 'package:roomtemppro/utils/AppSpaces.dart';
import 'package:roomtemppro/widgets/buttons.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late String current = "room";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          current == "room"
              ? "Room Temperature"
              : current == "humidity"
                  ? "Humidity"
                  : "Light",
          style: TextStyle(
              fontSize: 22,
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          current = "room";
                        }),
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            color: current == "room"
                                ? Colors.lightBlue
                                : Colors.lightBlue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  AppAssets.temperature,
                                  scale: 1.8,
                                  color: current == "room"
                                      ? Colors.white
                                      : Colors.lightBlue.shade400,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 12),
                                child: Text(
                                  "Temperature",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: current == "room"
                                          ? Colors.white
                                          : Colors.lightBlue.shade400),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          current = "humidity";
                        }),
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            color: current == "humidity"
                                ? Colors.lightBlue
                                : Colors.lightBlue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  AppAssets.humidity,
                                  scale: 1.8,
                                  color: current == "humidity"
                                      ? Colors.white
                                      : Colors.lightBlue.shade400,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 12),
                                child: Text(
                                  "Humidity",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: current == "humidity"
                                        ? Colors.white
                                        : Colors.lightBlue.shade400,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          current = "light";
                        }),
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            color: current == "light"
                                ? Colors.lightBlue
                                : Colors.lightBlue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  AppAssets.light,
                                  scale: 1.8,
                                  color: current == "light"
                                      ? Colors.white
                                      : Colors.lightBlue.shade400,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 12),
                                child: Text(
                                  "Light",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: current == "light"
                                        ? Colors.white
                                        : Colors.lightBlue.shade400,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                current == "room" ?   RoomTemp() : current == "humidity" ?  Humidity() : current == "light" ? LightSen() : RoomTemp(),
              ]),
        ),
      ),
    );
  }
}
