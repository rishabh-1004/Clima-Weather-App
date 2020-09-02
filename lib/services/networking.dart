import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkMethods {
  NetworkMethods({@required this.url});

  final url;

  getWeatherData() async {
    try {
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
}
