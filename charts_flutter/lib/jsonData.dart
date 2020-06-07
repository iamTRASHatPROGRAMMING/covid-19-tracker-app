import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
class Helper {
   int cases;
   String text;
   charts.Color color;



   Helper({this.cases,this.color,this.text});

//factory Helper.fromMap(Map jsonData) {
//  return Helper(jsonData['NewConfirmed'],jsonData['TotalConfirmed']);
//}

//Map toMap(Map map ) {
//   map['cases'] = this.cases;
//   map['text'] = this.text;
//   map['color'] = this.color;
//}


}