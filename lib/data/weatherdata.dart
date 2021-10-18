import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weatherapp/models/weathermodels.dart';

const apikey = '2d0347892dd1b8fe4d68b8930270e613';

class WeatherData {
  Future<WeatherApi> getCurrentTemperature() async {
    var url = await Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=40.0006&lon=32.5283&appid=${apikey}&units=metric');
    var response = await get(url);
    var body = jsonDecode(response.body);
    //print('${response.body}');
    return WeatherApi.fromMap(body);
  }
}
