import 'package:flutter/material.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final String apiKey = "fe9a4b85dc60bb9843e6647b29cf06b8";
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location locale = Location();
    await locale.getCurrentLocation();
    NetworkMethods networks = NetworkMethods(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=${locale.latitude}&lon=${locale.longitude}&appid=$apiKey&units=metric");
    var weatherData = jsonDecode(await networks.getWeatherData());
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
