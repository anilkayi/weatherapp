import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/UI/city_page/city_vm.dart';

class CityScreen extends StatefulWidget {
  String city;

  CityScreen(this.city);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CityVm(widget.city, context: context),
      child: Consumer<CityVm>(builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icons/images/a.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 35,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  value.mods == Mod.LOADING
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : value.mods == Mod.ERROR
                          ? Center(
                              child: Text(
                                  'Yanlış veya geçersiz bir şehir girdiniz.'),
                            )
                          : value.buildgetCurrentFuture(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.black45),
                      child: Padding(
                        padding: const EdgeInsets.all(45.0),
                        child: SingleChildScrollView(
                          child: value.mods == Mod.LOADING
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : value.mods == Mod.ERROR
                                  ? Center(
                                      child: Text(
                                          'Yanlış veya geçersiz bir şehir girdiniz.'),
                                    )
                                  : Text(
                                      value.getDataCity.getMessage(value
                                          .getDataApi!.main!.temp!
                                          .toInt()),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                      textAlign: TextAlign.center,
                                    ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }
}
