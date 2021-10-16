import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/data/weatherdata.dart';
import 'package:weatherapp/models/weathermodels.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  WeatherData getData = WeatherData();
  WeatherApi weatherData = WeatherApi();

  Future<void> getCurrentWeather() async {
    weatherData = await getData.getCurrentTemperature();
  }

  @override
  void initState() {
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/images/a.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 45,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
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
                                      left: 16.0, top: 24),
                                  child: Text(
                                    'Ankara,Turkey',
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
                                    'Pzrts,11 Ekim',
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
                                    'Sunny',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 35),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 22,
                            ),
                            Text(
                              '13º C',
                              style: TextStyle(
                                  fontSize: 64,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.black45),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildDailyTemp(),
                              buildDailyTemp(),
                              buildDailyTemp(),
                              buildDailyTemp(),
                              buildDailyTemp(),
                              buildDailyTemp(),
                              buildDailyTemp(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Padding buildDailyTemp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
      child: Column(
        children: [
          Text(
            'Pzrts,11',
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
              width: 40,
              height: 40,
              child: Image.asset('assets/icons/01n.png')),
          SizedBox(
            height: 4,
          ),
          Column(
            children: [
              Text(
                '18º',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '10º',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Sunny',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
