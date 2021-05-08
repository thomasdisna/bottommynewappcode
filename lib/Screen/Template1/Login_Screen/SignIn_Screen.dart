import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Controllers/UserController/userController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Signup_Screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Components/validations.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/forgot_password.dart';

File jsonFile;
Directory dir;
String fileName = "myJSONFile.json";
bool fileExists = false;
Map<dynamic, dynamic> fileContent;
class signinTemplate1 extends StatefulWidget {
  signinTemplate1({Key key}) : super(key: key);

  @override
  _signinTemplate1State createState() => _signinTemplate1State();
}

class _signinTemplate1State extends StateMVC<signinTemplate1> {
  bool autovalidate = false;
  Validations validations = new Validations();
  TimelineWallController _con;

  _signinTemplate1State() : super(TimelineWallController()){
    _con = controller;
  }

  Future<String> setStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Email', _email.text);
    prefs.setString('Password', _password.text);
  }

  bool _isPassHidden = true;
  void _togglePassVisibility(){
    setState(() {
      _isPassHidden = !_isPassHidden;
    });
  }

  submit(){
    setStatus();
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();

      _con.login(context,_email.text,_password.text);
    }
  }

  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(backgroundColor: Color(0xFF1E2026),
        contentPadding: EdgeInsets.only(top: 10, left: 10),
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23, alignment: Alignment.topLeft,
        ),
        titlePadding: EdgeInsets.all(10),
        content: new Text("Are you sure you want to exit?",
            style: f15w),
        actions:
        <Widget>[
          MaterialButton(
            height: 28,
            color: Color(0xFFffd55e),
            child: new Text(
              "Cancel",
              style: TextStyle(
                  color: Colors
                      .black),
            ),
            onPressed: () => Navigator.of(context).pop(false),

          ),
          SizedBox(width: 15,),
          MaterialButton(
            height: 28,
            color: Color(0xFF48c0d8),
            child: new Text(
              "Ok",
              style: TextStyle(
                  color: Colors
                      .black),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],

      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: _height,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/Template1/image/loginBackground.jpeg"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: _height,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black12.withOpacity(0.2)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 130.0),
                child: Container(
                  height: _height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: Color(0xFF1E2026)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontFamily: "Sofia",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 28.0),
                      ),
                      Form(
                        key: _con.loginFormKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 30.0),
                              child: Container(
                                height: 53.5,
                                decoration: BoxDecoration(
                                  color: Color(0xFF23252E),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(
                                    color: Colors.grey[800],
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0, top: 5.0),
                                  child: Theme(
                                    data: ThemeData(hintColor: Colors.transparent),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: TextFormField(controller: _email,
                                        validator: validations.validateEmail,
                                        style: new TextStyle(color: Colors.white),
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.emailAddress,
                                        autocorrect: false,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(0.0),
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            labelText: 'Email',
                                            hintStyle: TextStyle(color: Colors.white),
                                            labelStyle: TextStyle(
                                              color: Colors.white70,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 15.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 53.5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF23252E),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                      border: Border.all(
                                        color: Colors.grey[800],
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 5),
                                      child: Row(
                                        children: [
                                          Container(width:MediaQuery.of(context).size.width-112,
                                            child: Theme(
                                              data:
                                              ThemeData(hintColor: Colors.transparent),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: TextFormField(
                                                  controller: _password,
                                                  obscureText: _isPassHidden,
                                                  validator: validations.validatePassword,
                                                  style: new TextStyle(color: Colors.white),
                                                  textAlign: TextAlign.start,
                                                  keyboardType: TextInputType.text,
                                                  autofocus: false,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      filled: true,  contentPadding: EdgeInsets.symmetric(vertical: 0),
                                                      fillColor: Colors.transparent,
                                                      labelText: 'Password',
                                                      hintStyle:
                                                      TextStyle(color: Colors.white),
                                                      labelStyle: TextStyle(
                                                        color: Colors.white70,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              _togglePassVisibility();
                                            },
                                            icon: _isPassHidden
                                                ? Icon(
                                              Icons.visibility_off,
                                              size: 21,
                                              color: Colors.white70,
                                            )
                                                : Icon(Icons.visibility,
                                                size: 21,
                                                color: Colors.white70),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:8,left: 2,right: 2),
                                    child: Container(
                                      child: Text("Password need with minimum 8 characters and include"
                                          " letters, numbers and special characters...",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey,fontSize: 12.5),),
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 64.0),
                        child: MaterialButton(
                          onPressed: () {
                            submit();
                          },
                          splashColor: Color(0xFF48c0d8),
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          height: 52,
                          color: Color(0xFFffd55e),
                          child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Sofia",
                                    letterSpacing: 0.9),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                              new ForgotPasswordPage()));
                        },
                        child: Text("Forgot Password ?",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                fontSize: 15.0)),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                              new signupTemplate1()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 15.0),
                            ),
                            Text(" Signup",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Color(0xFFffd55e),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15.0))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}