import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ChatController extends ControllerMVC
{
  GlobalKey<ScaffoldState>scaffoldKey;
  ChatController(){
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
void Method() async{
  //repository.search(user).then(()value){});
}