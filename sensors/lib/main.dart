import 'package:enviro_sensors/enviro_sensors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<BarometerEvent> _pressureStream;
  Stream<LightmeterEvent> _lightmeterStream;
  Stream<AmbientTempEvent> _ambientTempStream;
  Stream<HumidityEvent> _humidityStream;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Stream<BarometerEvent> pressureStream;
    Stream<LightmeterEvent> lightmeterStream;
    Stream<AmbientTempEvent> ambientTempStream;
    Stream<HumidityEvent> humidityStream;

    try {
      pressureStream = pressureStream.asBroadcastStream();
      lightmeterStream = lightmeterStream.asBroadcastStream();
      ambientTempStream = ambientTempStream.asBroadcastStream();
      humidityStream = humidityStream.asBroadcastStream();
    } on PlatformException {
      // todo
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    _pressureStream = pressureStream;
    _lightmeterStream = lightmeterStream;
    _ambientTempStream = ambientTempStream;
    _humidityStream = humidityStream;
  }

  String _addUnitOfMeasurementSuffix(double prefix, String suffix) {
    return prefix.toStringAsFixed(1) + ' ' + suffix;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sensor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('Flutter Sensor')),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 35,
            ),
            Text('Barometer:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                StreamBuilder(
                    stream: _pressureStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return Text((snapshot.data.reading == null)
                            ? 'null'
                            : '${snapshot.data.reading.toFixedString(1)} hPa');
                      }
                      return Text('Barometer stream value');
                    }),
                FlatButton(
                  onPressed: null,
                  child: Text('disabled'),
                  color: Colors.purpleAccent,
                )
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 35,
            ),
            Text('Light sensor:'),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StreamBuilder(
                      stream: _lightmeterStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return Text((snapshot.data.reading == null)
                              ? 'null'
                              : '${snapshot.data.reading.toFixedString(1)} lx');
                        }
                        return Text('Light sensor stream value');
                      }),
                  FlatButton(
                    onPressed: null,
                    child: Text('disabled'),
                    color: Colors.purpleAccent,
                  )
                ]),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 35,
            ),
            Text('Ambient temperature sensor:'),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StreamBuilder(
                      stream: _ambientTempStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return Text((snapshot.data.reading == null)
                              ? 'null'
                              : '${snapshot.data.reading.toFixedString(1)} °C');
                        }
                        return Text('Ambient temperature sensor stream value');
                      }),
                  FlatButton(
                    onPressed: null,
                    child: Text('disabled'),
                    color: Colors.purpleAccent,
                  )
                ]),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 35,
            ),
            Text('Humidity sensor:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                StreamBuilder(
                    stream: _humidityStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return Text((snapshot.data.reading == null)
                            ? 'null'
                            : '${snapshot.data.reading.toFixedString(1)} %');
                      }
                      return Text('Humidity sensor stream value');
                    }),
                FlatButton(
                  onPressed: null,
                  child: Text('disabled'),
                  color: Colors.purpleAccent,
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 35,
            )
          ],
        ),
      ),
    );
  }
}
