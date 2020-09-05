import 'package:flutter/material.dart';

import '../services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    NetworkMethods networks = NetworkMethods();
    var weatherData = jsonDecode(await networks.getWeatherLocation());
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LocationScreen(weatherDataTransfer: weatherData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingPlain(
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
