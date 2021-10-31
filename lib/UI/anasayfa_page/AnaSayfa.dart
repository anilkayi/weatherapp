import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/UI/anasayfa_page/anasayfa_vm.dart';
import 'package:weatherapp/searchcity.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(builder: (context, value, child) {
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchCity()));
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
                          width: MediaQuery.of(context).size.width * 0.009,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        )
                      ],
                    )),
                value.mods == Mod.LOADING
                    ? Center(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator()))
                    : value.mods == Mod.ERROR
                        ? Center(
                            child: Text('ERROR'),
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
                    child: value.mods == Mod.LOADING
                        ? Center(
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator()))
                        : value.mods == Mod.ERROR
                            ? Center(
                                child: Text('ERROR'),
                              )
                            : value.getFutureDailyTemp(),
                  ),
                )
              ],
            )),
      );
    });
  }
}
