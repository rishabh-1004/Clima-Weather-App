import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../services/location.dart';

final String apiKey = "fe9a4b85dc60bb9843e6647b29cf06b8";
final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

class NetworkMethods {
  getWeatherData(String url) async {
    try {
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return (response.statusCode);
      }
    } catch (e) {
      return (e);
    }
  }

  Future getWeatherLocation() async {
    Location locale = Location();
    await locale.getCurrentLocation();
    return getWeatherData(
        "${baseUrl}?lat=${locale.latitude}&lon=${locale.longitude}&appid=$apiKey&units=metric");
  }

  Future<dynamic> getWeatherByCity(String city) async {
    return getWeatherData("${baseUrl}?q=${city}&appid=$apiKey&units=metric");
  }
}
