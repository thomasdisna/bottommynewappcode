import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchController extends ControllerMVC
{
  GlobalKey<ScaffoldState>scaffoldKey;
  SearchController(){
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
void searchMethod() async{
  //repository.search(user).then(()value){});
}