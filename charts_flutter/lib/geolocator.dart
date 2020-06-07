import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Location extends StatefulWidget {
  Map json;
  Location({@required this.json});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String address;
  double longitude;
  double latitude;
  Position _currentPosition;
  String country;
  bool gettingLocation =false;
  int countryLocationInJson;
  Map<String, dynamic> mapDataFromJson = {'LOADING': 'data'};
  DateTime date;


  @override
  void initState() {
    super.initState();
    gettingLocation = true;print(gettingLocation);
    getCurrentLocation();
    debugPrint("$_currentPosition");
    date = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("INFORMATION BASED ON YOUR LOCATION"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child:!gettingLocation?Center(child: CircularProgressIndicator(),):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
//            if(_currentPosition != null) Text("latitude ${_currentPosition.latitude} , longitude ${_currentPosition.longitude} , country = ${country}")
            Center(child: Container(child: Text("  ${country}",textAlign: TextAlign.center,style: TextStyle(
              color: Colors.red,
              fontSize: 60,
              fontWeight: FontWeight.bold
            ),))),
            Padding(padding: EdgeInsets.all(10)),


          Flexible(flex: 2,
          child: ListView(
            children: [
              for(MapEntry e in mapDataFromJson.entries) buildData(e)
            ]
          ),)
          ],
        ),
      ),
    );
  }

  getCurrentLocation() {
   geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
     setState(() {
       _currentPosition = position;

     });
     getAddress();
   }).catchError((e)=>print(e));
    
  }

  getAddress() async {
    try{
      List<Placemark> list = await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
    Placemark placemark = list[0];

    setState(() {
      address =   "${placemark.locality} , ${placemark.postalCode} , ${[placemark.country]}";
      country = placemark.country;
    });
      for(var i =0;i<=widget.json['Countries'].length-1;i++) {
        if(country == widget.json['Countries'][i]['Country']) {
          setState(() {
            countryLocationInJson = i;
            mapDataFromJson =   widget.json["Countries"][countryLocationInJson];
            print(mapDataFromJson);

          });
          print("map from json data $mapDataFromJson");


        }}

    }
    catch(e) {print(e);}
  }
  Widget buildData(MapEntry e) {

   TextStyle style = new TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30
    );

     return Container(

     decoration: BoxDecoration(
       borderRadius: BorderRadius.all(Radius.circular(32)),
       border: Border.all(width: 3),
       color: Colors.white

     ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: <Widget>[
         SizedBox(height: 10,child: Container(color: Colors.white,),),
         Text(e.key,textAlign: TextAlign.center,style: style,),
         Padding(padding: EdgeInsets.all(10),),
         Text(e.value.toString(),style: style,textAlign: TextAlign.center,)
       ],
     ),
   );


  }





}
