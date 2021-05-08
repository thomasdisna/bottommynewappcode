import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LocationController extends ControllerMVC
{
  GlobalKey<ScaffoldState>scaffoldKey;
  LocationController(){
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
void Method() async{
  //repository.search(user).then(()value){});
}