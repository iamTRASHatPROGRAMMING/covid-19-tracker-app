import 'package:chartsflutter/main.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'jsonData.dart';
import 'searchField.dart';

class ChartPage extends StatefulWidget {
  var data;
  double height;
  bool showPieChart = false;
  ChartPage({@required this.data,this.height,@required this.showPieChart});
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {


  @override
  Widget build(BuildContext context) {


    var series = [
      charts.Series(
          domainFn: (Helper help,_)=> help.text,
          measureFn: (Helper helper,_)=>helper.cases,
          data: widget.data,
          colorFn: (Helper help,_)=> help.color
      )
    ];
    var chart;
    if(widget.showPieChart) {
      chart = new charts.PieChart(series,animate: true,defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [new charts.ArcLabelDecorator()]),);
      return Container(
        width: double.maxFinite,
        color: Colors.white,
        height: widget.height,
        child: Center(
          child: chart,
        ),
      );

    }
    else {
       chart = new charts.BarChart(series,animate: true);
      return Container(
        width: double.maxFinite,
        color: Colors.white,
        height: widget.height,
        child: Center(
          child: chart,
        ),
      );

    }


  }
}



