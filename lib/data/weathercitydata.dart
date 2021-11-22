import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weathermodelscity.dart';

const apikey = '2d0347892dd1b8fe4d68b8930270e613';

class WeatherDataCity {
  Future<WeatherApiCity> getCurrentTemperatureCity(String city) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey&units=metric');

    var response = await http.get(url);
    var body = jsonDecode(response.body);
    print('${response.body}');
    return WeatherApiCity.fromMap(body);
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Hava 25° üstündedir,şort ve tişört giyebilir,serinlemek için havuza gidebilirsiniz.';
    } else if (temp <= 24 || temp >= 11) {
      return 'Hava sıcaklığı 11-24° arasındadır. Bu havada tişört ve pantolon giyip, piknik yapmaya gidebilirsiniz.';
    } else if (temp <= 10) {
      return 'Hava sıcaklığı 10° altindadir. Bu havada hirka,mont tarzı şeyler üstünüze alabilirsiniz. Arkadaşlarınızla kapalı ortamda sıcak bir şeyler içebilirsiniz.';
    } else {
      return 'Hava sicakliği 10° altındadır. Bu havada hırka,mont tarzı şeyler üstünüze alabilirsiniz. Arkadaşlarınızla kapalı ortamda sıcak bir şeyler içebilirsiniz.';
    }
  }
}
