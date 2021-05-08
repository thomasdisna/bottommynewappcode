import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileWallDetailController extends ControllerMVC
{
  GlobalKey<ScaffoldState>scaffoldKey;
  ProfileWallDetailController(){
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
void Method() async{
  //repository.search(user).then(()value){});
}