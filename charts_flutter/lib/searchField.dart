import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providerr.dart';

class SearchField extends StatefulWidget {
  Map json;
  SearchField({@required this.json});
  @override
  State<StatefulWidget> createState() => _SearchFieldState();
}
class _SearchFieldState extends State<SearchField> {

  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
//    var provider = Provider.of<SearchLogic>(context);
    return null;
  }
  _searchThrough(String text) {

  }
}

