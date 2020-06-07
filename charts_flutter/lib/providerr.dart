import 'package:flutter/material.dart';

class SearchLogic extends ChangeNotifier {
  Map json;
  int index = 76;
  SearchLogic({@required this.json});





  int search(String searchVal) {
    print(json);
    for(int i=0;i<=json["Countries"].length -1;i++) {
      if(json["Countries"][i]['Country'] == searchVal) {
        index  =i;print(index);
        notifyListeners();

      }
      else {
        print("Country not found");
      }
      notifyListeners();
    }
  }



}