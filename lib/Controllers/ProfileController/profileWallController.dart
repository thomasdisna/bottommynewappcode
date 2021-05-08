import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileWallController extends ControllerMVC
{
  GlobalKey<ScaffoldState>scaffoldKey;
  ProfileWallController(){
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
void Method() async{
  //repository.search(user).then(()value){});
}