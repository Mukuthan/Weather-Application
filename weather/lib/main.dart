import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool wait = false;

  Future<bool> hasNetworkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No network at all
    }

    // Check actual internet access
    return await InternetConnection().hasInternetAccess;
  }

  void showNoNetworkDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Network Connection'),
          content: Text('Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                mainPage();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkLocationAndAlert(BuildContext context) async {
    bool gpsOn = await Geolocator.isLocationServiceEnabled();
    if (!gpsOn) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Location Service Off'),
              content: Text('Please turn on GPS to continue.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Geolocator.openLocationSettings();
                    Navigator.of(context).pop();
                  },
                  child: Text('Open Settings'),
                ),
              ],
            ),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission result = await Geolocator.requestPermission();
      if (result == LocationPermission.denied ||
          result == LocationPermission.deniedForever) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Permission Denied'),
                content: Text('Location permission is required.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Geolocator.openAppSettings();
                      Navigator.of(context).pop();
                    },
                    child: Text('Open App Settings'),
                  ),
                ],
              ),
        );
      }
    }
  }

  Future<Position> fetchLoction() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  Future<void> mainPage() async {
    Position position = await fetchLoction();
    if (!await hasNetworkConnection()) {
      showNoNetworkDialog(context);
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => home(data: position)),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkLocationAndAlert(context); // Safe context access
      await mainPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Sky.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(child: Image(image: AssetImage("images/ic_launcher.png"))),
    );
  }
}

/*
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CityDisplay(cityName: "Redhills",)));

class CityDisplay extends StatefulWidget {
  final String cityName;

  const CityDisplay({Key? key, required this.cityName}) : super(key: key);

  @override
  _CityDisplayState createState() => _CityDisplayState();
}

class _CityDisplayState extends State<CityDisplay> {
  @override
  Widget build(BuildContext context) {
    return Text("Selected City: ${widget.cityName}");
  }
}*/

/*class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueAccent,
              Colors.lightBlue,
              Colors.lightBlueAccent,
              Colors.white30,
            ],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 180.0),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Colors.yellowAccent, Colors.orange],
                      center: Alignment.center,
                      radius: 0.8,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 80,
              child: Icon(Icons.cloud, size: 300, color: Colors.white),
            ),

            Positioned(
              bottom: 190,
              left: 150,
              child: Icon(
                Icons.water_drop_rounded,
                size: 30,
                color: Colors.blueAccent,
              ),
            ),
            Positioned(
              bottom: 250,
              left: 200,
              child: Icon(
                Icons.water_drop_rounded,
                size: 30,
                color: Colors.blueAccent,
              ),
            ),
            Positioned(
              bottom: 210,
              left: 300,
              child: Icon(
                Icons.water_drop_rounded,
                size: 30,
                color: Colors.blueAccent,
              ),
            ),

            Positioned(
              bottom: 160,
              left: 240,
              child: Icon(
                Icons.water_drop_rounded,
                size: 30,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
