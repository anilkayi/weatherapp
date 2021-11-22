import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weatherapp/models/weathermodelsDaily.dart';

const apikey = '2d0347892dd1b8fe4d68b8930270e613';

class WeatherDataDaily {
  Future<WeatherApiDaily> getCurrentDailyTemperature(
      String lat, String long) async {
    var url = await Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely&appid=${apikey}&units=metric');
    var response = await get(url);
    var body = json.decode(response.body);
    //print('RIGHT HEREEE -------->>>>>  ${response.body}');
    return WeatherApiDaily.fromMap(body);
  }
}
