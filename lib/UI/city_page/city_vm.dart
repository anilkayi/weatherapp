import 'package:flutter/material.dart';

import 'package:weatherapp/data/timeconvert/datetime.dart';
import 'package:weatherapp/data/weathercitydata.dart';
import 'package:weatherapp/models/weathermodelscity.dart';

enum Mod { LOADING, ERROR, DONE }

class CityVm extends ChangeNotifier {
  WeatherDataCity getDataCity = WeatherDataCity();
  WeatherApiCity? getDataApi;
  final String city;

  Mod _mods = Mod.LOADING;

  CityVm(
    this.city, {
    required BuildContext context,
  }) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await getCurrentWeatherCity();
      notifyListeners();
    });
  }

  getCurrentWeatherCity() async {
    try {
      getDataApi = await getDataCity.getCurrentTemperatureCity(city.toString());
      notifyListeners();
      _mods = Mod.DONE;
    } catch (e) {
      _mods = Mod.ERROR;
    }
  }

  Mod get mods => _mods;

  buildgetCurrentFuture(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black54,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 24),
                            child: Text(
                              '${getDataApi!.sys!.country},${city.toString()}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.006,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              readTimestamp(getDataApi!.dt ?? 35),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  width: 118,
                                  height: 118,
                                  child: Image.asset(
                                      'assets/icons/${getDataApi!.weather!.first.icon}.png'))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              getDataApi!.weather!.first.main.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 35),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        children: [
                          Text(
                            '${getDataApi!.main!.temp!.toInt()}°',
                            style: TextStyle(
                                fontSize: 64,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Max Temp: ${getDataApi!.main!.tempMax!.toInt()}°',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Min Temp: ${getDataApi!.main!.tempMin!.toInt()}°',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
