import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/UI/anasayfa_page/AnaSayfa.dart';
import 'package:weatherapp/UI/anasayfa_page/anasayfa_vm.dart';

import 'package:weatherapp/UI/city_page/city_vm.dart';

void main() {
  String city;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeVm(context: context)),
    ChangeNotifierProvider(
        create: (context) => CityVm('Ankara', context: context))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnaSayfa();
  }
}
