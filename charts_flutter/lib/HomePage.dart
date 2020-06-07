import 'package:chartsflutter/geolocator.dart';
import 'package:chartsflutter/chartsFlutter.dart';
import 'package:chartsflutter/jsonData.dart';
import 'package:chartsflutter/searchField.dart';
import 'package:chartsflutter/selectCountry.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'providerr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'voiceSearch.dart';


class HomePage extends StatefulWidget {
  Map jsonData;
  bool showPieChart = false;
  HomePage({@required this.jsonData});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController textEditingController = new TextEditingController();
  var controller = new ScrollController();
  bool clicked  = false;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    var  provider = Provider.of<SearchLogic>(context);


    var height =300.0;

     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
          decoration: BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(22.0))
          ),
          child: Row(
            children: <Widget>[
              Container(
                child: IconButton(icon: Icon(Icons.search), onPressed: () {
                  for(var i=0;i<=widget.jsonData['Countries'].length -1;i++) {
                    if(textEditingController.text == widget.jsonData['Countries'][i]['Country']) {
                      print(textEditingController.text == widget.jsonData["Countries"][i]["Country"]);
//                      controller.jumpTo(height * i);
                      controller.animateTo(height * i, duration: Duration(seconds: 5), curve: Curves.ease);
                      var a = height * i;
                      print('height = $height');
                      print("i = $i");
                      print(a);
                      break;
//                      controller.jumpTo(value)
                    }

                    else {
                      print("${textEditingController.text} did not match ");
                    }
                  }
                }),
              ),
              VerticalDivider(
                width: 3,
                thickness: 1,
                color: Colors.white,

              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              MicButton(voiceSearchResult: (val) {
                for(var i=0; i<= widget.jsonData['Countries'].length -1;i++) {
                  if(val == widget.jsonData['Countries'][i]['Country'].toString()) {
                    controller.animateTo(height * i, duration: Duration(seconds: 2), curve: Curves.ease);
                  }

                }
              },)

            ],
          ),
        )
      ),
      body: Container(
        child: GestureDetector(
          onTap: ()=>setState((){if(clicked ==true)clicked=false;}),
          child: Container(
              child: FutureBuilder(builder: (context, snap) {
                return ListView.builder(
                  controller: controller,
                  itemCount: widget.jsonData['Countries'].length -1 ,
                  itemBuilder: (BuildContext context , i) {
                    return Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 300,
                            width: double.maxFinite,
                            color: Colors.black,
                            child: Container(
                              child: ChartPage(data: [
                                Helper(cases: widget.jsonData['Countries'][i]['NewConfirmed'], color: charts.ColorUtil.fromDartColor(Colors.blue), text: "NEW CASES"),
                                Helper(cases: widget.jsonData['Countries'][i]['NewDeaths'], color: charts.ColorUtil.fromDartColor(Colors.red), text: "NEW DEATHS"),
                                Helper(cases: widget.jsonData['Countries'][i]['NewRecovered'], color: charts.ColorUtil.fromDartColor(Colors.green), text: "NEW RECOVERED")
                              ],height: 300,showPieChart: widget.showPieChart,),
                            ),
                          ),
                          SizedBox(height: 10,child: Container(color: Colors.black,),),
                          Container(
                            height: 300,
                            width: double.maxFinite,
                            child: Center(child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(30.0),
                                  child: Text(widget.jsonData['Countries'][i]['Country'].toString(),style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.black
                                  ),),
                                ),
                                Text(widget.jsonData['Countries'][i]['NewConfirmed'].toString(),style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.black
                                ),),
                              ],
                            ),),
                          ),
                        ],
                      ),
                    );
                  },
                );

              })
            ),
        ),

      ),
      floatingActionButton: Builder(
        builder: (context) {
          if(clicked ==false ) {
            return FloatingActionButton(
              child: Icon(Icons.settings),
              onPressed: (){
                setState(() {
                  clicked = !clicked;
                });
              },
            );
          }
          else if(clicked == true) {
            return Container(
              height: 200,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: <Widget>[
                  FloatingActionButton(heroTag: 'btn1',onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Location(json: widget.jsonData)));
                  }
                  ,backgroundColor: Colors.purple,
                  child: Icon(Icons.view_array),
                  tooltip: 'SPECIFIC COUNTRY',),
                  Padding(padding: EdgeInsets.all(10)),
                  FloatingActionButton(heroTag: 'btn2',onPressed: (){
                    setState(()=>widget.showPieChart = !widget.showPieChart)  ;
                    },backgroundColor: Colors.purple,
                  child: Icon(Icons.pie_chart_outlined),
                  tooltip: "SHOW PIE CHART",)
                ],
              ),
            );
          }
          else {
            return null;
          }
        },
      )







    );

  }


//  FloatingActionButton(
//  child: Icon(Icons.clear),
//  onPressed: (){
//  setState(() {
//  widget.showPieChart = !widget.showPieChart;
//  });
//  },
//  ),


  @override
  void dispose() {
    controller.dispose();
  }


}

