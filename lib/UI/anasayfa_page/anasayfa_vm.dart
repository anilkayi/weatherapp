import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weatherapp/data/locationHelper/locationHelper.dart';
import 'package:weatherapp/data/timeconvert/datetime.dart';
import 'package:weatherapp/data/weatherdailydata.dart';
import 'package:weatherapp/data/weatherdata.dart';
import 'package:weatherapp/models/weathermodels.dart';
import 'package:weatherapp/models/weathermodelsDaily.dart';

enum Mod { LOADING, ERROR, DONE }

class HomeVm extends ChangeNotifier {
  WeatherApi? weatherData;
  WeatherApiDaily? weatherDataDaily;
  LocationHelper locationData = LocationHelper();
  LocationData? lokasyon;
  Mod _mods = Mod.LOADING;

  HomeVm({
    required BuildContext context,
  }) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await getCurrentWeather();
      await getCurrentWeatherDaily();
      notifyListeners();
    });
  }

  Mod get mods => _mods;

  getCurrentWeather() async {
    weatherData = WeatherApi();
    await getLocation();
    try {
      WeatherData getData = WeatherData();
      weatherData = await getData.getCurrentTemperature(
          lokasyon!.latitude!.toString(), lokasyon!.longitude!.toString());
      _mods = Mod.DONE;
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      _mods = Mod.ERROR;
    }
  }

  getCurrentWeatherDaily() async {
    weatherDataDaily = WeatherApiDaily();
    WeatherDataDaily getDailyData = WeatherDataDaily();
    try {
      weatherDataDaily = await getDailyData.getCurrentDailyTemperature(
          lokasyon!.latitude!.toString(), lokasyon!.longitude!.toString());
      _mods = Mod.DONE;
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      _mods = Mod.ERROR;
    }
  }

  getLocation() async {
    lokasyon = await locationData.getCurrentLocation();
  }

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
                            padding: const EdgeInsets.only(left: 12.0, top: 24),
                            child: Text(
                              '${weatherData!.sys!.country},${weatherData!.name}',
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
                              readTimestamp(weatherData!.dt ?? 1),
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
                                      'assets/icons/${weatherData!.weather!.first.icon}.png'))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              '${weatherData!.weather!.first.main}',
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
                            '${weatherData!.main!.temp!.toInt()}°',
                            style: TextStyle(
                                fontSize: 60,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Max Temp: ${weatherData!.main!.tempMax!.toInt()}°',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Min Temp: ${weatherData!.main!.tempMin!.toInt()}°',
                            style: TextStyle(
                                fontSize: 20,
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

  getFutureDailyTemp() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: weatherDataDaily!.daily!.length,
      itemBuilder: (context, indeks) {
        return buildDailyTemp(indeks, context);
      },
    );
  }

  Padding buildDailyTemp(int indx, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 23),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .1,
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              readTimestamp(weatherDataDaily!.daily![indx].dt!.toInt()),
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Image.asset(
                    'assets/icons/${weatherDataDaily!.daily![indx].weather!.first.icon}.png')),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.007,
            ),
            SizedBox(
              child: Column(
                children: [
                  Text(
                    '${weatherDataDaily!.daily![indx].temp!.max!.toInt()}º',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    '${weatherDataDaily!.daily![indx].temp!.min!.toInt()}º',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    '${weatherDataDaily!.daily![indx].weather!.first.main}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
