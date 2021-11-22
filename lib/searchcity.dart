import 'package:flutter/material.dart';
import 'package:weatherapp/UI/anasayfa_page/AnaSayfa.dart';
import 'package:weatherapp/UI/city_page/city_page.dart';
import 'package:weatherapp/UI/city_page/city_vm.dart';

class SearchCity extends StatefulWidget {
  @override
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  String sehir = 'Ankara';
  TextEditingController cityName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/icons/images/a.jpg',
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(25)),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      controller: cityName,
                      onChanged: (value) {
                        sehir = value;
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                            size: 35,
                            color: Colors.white,
                          ),
                          hintText: 'Search City...',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 24),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AnaSayfa()),
                        );
                        cityName.clear();
                      },
                      child: Icon(
                        Icons.my_location,
                        size: 35,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen(sehir)));
                        cityName.clear();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.location_city,
                            size: 35,
                            color: Colors.white,
                          )
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
