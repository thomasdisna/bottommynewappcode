import 'package:flutter/material.dart';
import 'package:Butomy/Model/UserModel/userModel.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

var UserIdPref;

class UserController extends ControllerMVC {
  User user = new User();
  var saveUUUUUUUUUUserInfo;

  GlobalKey<ScaffoldState> scaffoldKey;

  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

}