import 'dart:convert';
import 'package:chartsflutter/HomePage.dart';
import 'package:chartsflutter/selectCountry.dart';
import 'package:provider/provider.dart';

import 'jsonData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'chartsFlutter.dart';
import 'providerr.dart';
import 'voiceSearch.dart';
import 'geolocator.dart';

void main() =>runApp(Charts());

class Charts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchLogic>.value(
      child: MaterialApp(
        home: ChartsHomePage(),
        debugShowCheckedModeBanner: false,
      ),


    );
  }
}

class ChartsHomePage extends StatefulWidget {
  @override
  _ChartsHomePageState createState() => _ChartsHomePageState();
}

class _ChartsHomePageState extends State<ChartsHomePage> {
  Map totalCases;
  Map newMap;
  bool isDoneLoading = false;
  @override
  Widget build(BuildContext context) {
    if(isDoneLoading == false) {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
//              child: FutureBuilder(
//                future: _getApiData(),
//                builder: (BuildContext context, snapshot) {
//                  if(snapshot.connectionState == ConnectionState.done) {
//                    _getApiData();
//                    print(newMap["Countries"][76]["NewConfirmed"]);
//                    var data = [
//                      Helper(cases: newMap['Countries'][76]['NewConfirmed'],color: charts.ColorUtil.fromDartColor(Colors.red),text: "NEW CASES"),
//                      Helper(cases: newMap['Countries'][76]['TotalConfirmed'],color: charts.ColorUtil.fromDartColor(Colors.blue),text: "TOTAL CASES"),
//                      Helper(cases: newMap['Countries'][76]['NewDeaths'],color: charts.ColorUtil.fromDartColor(Colors.amber),text: "NEW DEATHS"),
//                      Helper(cases: newMap['Countries'][76]['TotalDeaths'],text: "TOTAL DEATHS",color: charts.ColorUtil.fromDartColor(Colors.yellow)),
//                      Helper(cases: newMap['Countries'][76]['NewRecovered'],text: "NEW RECOVERED",color: charts.ColorUtil.fromDartColor(Colors.deepPurple)),
//                      Helper(cases: newMap['Countries'][76]['TotalRecovered'],text: "TOTAL RECOVERED",color: charts.ColorUtil.fromDartColor(Colors.cyan)),
//
//
//
//
//
//
//                    ];
//
//                    final series = [
//
//                      charts.Series(
//                        domainFn: (Helper helper,_)=> helper.cases.toString(),
//                        measureFn: (Helper helper,_)=> helper.cases,
//                        colorFn: (Helper helper,_)=> helper.color,
//                        labelAccessorFn: (Helper helper,_ )=> helper.cases.toString(),
//                        data: data
//                      )
//                    ];
//
//                    charts.BarChart chart = charts.BarChart(
//                      series,
//                      animate: true,
//
//                    );
//
//                    Widget chartWidget = Container(child: chart,height: 200);
////
//
//                    return chartWidget;
//                  }
//                  else if(snapshot.connectionState == ConnectionState.waiting){
//
//                    return Center(child: CircularProgressIndicator());
//                  }
//                  else {
//                    return Text('wtf');
//                  }
//
//
//                },
//              ),
        ),
      );
    }
    else if(isDoneLoading == true){
//      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChartPage(jsonMapData: newMap)));
    }
    else {
      return Text('i have no idea what i m doing');
    }
  }

  @override
  void initState() {
    super.initState();
    futureComplete();
  }

  Future _getApiData() async{
    while(true) {
      final response = await http.get('https://api.covid19api.com/summary');
      if(response.statusCode == 200) {
        newMap = jsonDecode(response.body);
        break;
      }

    }

  }
  void futureComplete()async {
    await _getApiData();
//    SearchLogic(json: newMap);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage(jsonData: newMap)));
//    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MicButton()));

  }





}

