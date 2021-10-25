import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weatherapp/data/locationHelper/locationHelper.dart';
import 'package:weatherapp/data/timeconvert/datetime.dart';
import 'package:weatherapp/data/weatherdailydata.dart';
import 'package:weatherapp/data/weatherdata.dart';
import 'package:weatherapp/models/weathermodels.dart';
import 'package:weatherapp/models/weathermodelsDaily.dart';
import 'package:weatherapp/searchcity.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  WeatherApi weatherData = WeatherApi();
  WeatherApiDaily weatherDataDaily = WeatherApiDaily();
  LocationHelper locationData = LocationHelper();
  LocationData? lokasyon;
  Future<void> getCurrentWeather() async {
    getLocation();
    print(lokasyon!.latitude);
    print(lokasyon!.longitude);
    try {
      WeatherData getData = WeatherData();
      weatherData = await getData.getCurrentTemperature(
          lokasyon!.latitude!.toString(), lokasyon!.longitude!.toString());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  Future<void> getCurrentWeatherDaily() async {
    WeatherDataDaily getDailyData = WeatherDataDaily();
    getLocation();
    print(lokasyon!.latitude);
    print(lokasyon!.longitude);
    try {
      weatherDataDaily = await getDailyData.getCurrentDailyTemperature(
          lokasyon!.latitude!.toString(), lokasyon!.longitude!.toString());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  Future<void> getLocation() async {
    lokasyon = await locationData.getCurrentLocation();
  }

  @override
  void initState() {
    getCurrentWeather();
    getCurrentWeatherDaily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/icons/images/a.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchCity()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Search City...',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      )
                    ],
                  )),
              buildgetCurrentFuture(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.black45),
                  child: getFutureDailyTemp(),
                ),
              )
            ],
          )),
    );
  }

  FutureBuilder<void> buildgetCurrentFuture() {
    return FutureBuilder(
      future: getCurrentWeather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 24),
                                  child: Text(
                                    '${weatherData.sys!.country},${weatherData.name}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    readTimestamp(weatherData.dt ?? 1),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                        width: 118,
                                        height: 118,
                                        child: Image.asset(
                                            'assets/icons/${weatherData.weather!.first.icon}.png'))),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    '${weatherData.weather!.first.main}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 35),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${weatherData.main!.temp!.toInt()}°',
                                  style: TextStyle(
                                      fontSize: 60,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Max Temp: ${weatherData.main!.tempMax!.toInt()}°',
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Min Temp: ${weatherData.main!.tempMin!.toInt()}°',
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
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  FutureBuilder<void> getFutureDailyTemp() {
    return FutureBuilder(
      future: getCurrentWeatherDaily(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: weatherDataDaily.daily!.length,
            itemBuilder: (context, indeks) {
              return buildDailyTemp(indeks);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Padding buildDailyTemp(int indx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 23),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .1,
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              readTimestamp(weatherDataDaily.daily![indx].dt!.toInt()),
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Container(
                width: 60,
                height: 60,
                child: Image.asset(
                    'assets/icons/${weatherDataDaily.daily![indx].weather!.first.icon}.png')),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              child: Column(
                children: [
                  Text(
                    '${weatherDataDaily.daily![indx].temp!.max!.toInt()}º',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    '${weatherDataDaily.daily![indx].temp!.min!.toInt()}º',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${weatherDataDaily.daily![indx].weather!.first.main}',
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
