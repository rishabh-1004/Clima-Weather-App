import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:convert';
import '../services/networking.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.weatherDataTransfer});

  final weatherDataTransfer;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  int condition;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherDataTransfer);
  }

  void updateUI(dynamic weatherinfo) {
    setState(() {
      if (weatherinfo == null) {
        temperature = 0;
        condition = 0;
        cityName = "Error";
        return;
      }
      print("It did reach here");
      print(weatherinfo);
      print(weatherinfo["main"]["temp"]);
      double temperature_temp = weatherinfo["main"]["temp"];
      temperature = temperature_temp.toInt();

      condition = weatherinfo['weather'][0]['id'];
      print(condition);
      cityName = weatherinfo['name'];
      print(cityName);
    });
  }

  NetworkMethods networks = NetworkMethods();
  //var temperature= weatherinfo["main"]["temp"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var cityDetails = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (cityDetails != null) {
                        var newWeatherData =
                            await networks.getWeatherByCity(cityDetails);
                        print(newWeatherData);
                        updateUI(json.decode(newWeatherData));
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
