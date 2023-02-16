import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightSen extends StatefulWidget {
  const LightSen({Key? key}) : super(key: key);

  @override
  State<LightSen> createState() => _LightSenState();
}

class _LightSenState extends State<LightSen> {
  bool _tempAvailable = false;
  bool _humidityAvailable = false;
  bool _lightAvailable = false;
  bool _pressureAvailable = false;
  final environmentSensors = EnvironmentSensors();

  @override
  void initState() {
    super.initState();
    environmentSensors.pressure.listen((pressure) {
      print(pressure.toString());
    });
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool tempAvailable;
    bool humidityAvailable;
    bool lightAvailable;
    bool pressureAvailable;

    tempAvailable = await environmentSensors
        .getSensorAvailable(SensorType.AmbientTemperature);
    humidityAvailable =
        await environmentSensors.getSensorAvailable(SensorType.Humidity);
    lightAvailable =
        await environmentSensors.getSensorAvailable(SensorType.Light);
    pressureAvailable =
        await environmentSensors.getSensorAvailable(SensorType.Pressure);

    setState(() {
      _tempAvailable = tempAvailable;
      _humidityAvailable = humidityAvailable;
      _lightAvailable = lightAvailable;
      _pressureAvailable = pressureAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Divider(),
      (_lightAvailable)
          ? StreamBuilder<double>(
              stream: environmentSensors.light,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'The Current Light is: ${snapshot.data?.toStringAsFixed(2)},',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold),
                  ),
                );
              })
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No light sensor found',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold),
              ),
            ),

      //ElevatedButton(onPressed: initPlatformState , child: Text('Get'))
    ]);
  }
}
