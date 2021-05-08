import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Controllers/UserController/userController.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onBoarding_Screen.dart';

var EmailPref,PasswordPref;
class SplashScreenTemplate1 extends StatefulWidget {
  @override
  _SplashScreenTemplate1State createState() => _SplashScreenTemplate1State();
}

class _SplashScreenTemplate1State extends State<SplashScreenTemplate1> {

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      EmailPref = prefs.getString('Email');
      PasswordPref = prefs.getString('Password');
      userid=prefs.getString("userId");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserId();
  }
  @override
  Widget build(BuildContext context) {
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: SplashScreenTemplate1Screen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.white),
    );
  }
}

class SplashScreenTemplate1Screen extends StatefulWidget {
  @override
  _SplashScreenTemplate1ScreenState createState() =>
      _SplashScreenTemplate1ScreenState();
}

class _SplashScreenTemplate1ScreenState
    extends StateMVC<SplashScreenTemplate1Screen> {
  TimelineWallController _con;

  _SplashScreenTemplate1ScreenState() : super(TimelineWallController()){
    _con = controller;
  }
  @override
  void _Navigator() {
    if(EmailPref!= null && PasswordPref!=null && (userid!=null || userid!="" ))
    {
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => TimeLine(false)));
    }
    else{
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => OnboardingScreen(),
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    }
  }

  /// Set timer SplashScreenTemplate1
  _timer() async {
    return Timer(Duration(milliseconds: 3100), _Navigator);
  }
  _timer1() async {
    return Timer(Duration(milliseconds: 3100), _checking);
  }

  void _checking1() {
    if(userid.toString().isNotEmpty && userid.toString()!=null && userid!=null)
    {
      _con.getAbout(userid.toString());
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => TimeLine(false)));
    }
    else{
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => OnboardingScreen(),
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    }
  }

  void _checking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var iddd= prefs.getString("userId");
    if(iddd!=null && iddd.isNotEmpty && iddd!=""){
      setState(() {
        userid=iddd;
        starttim=0;
      });
      _con.splashgetTimelineWall(context,userid.toString());
    /*  Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => TimeLine()));*/
    }
    else{
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => OnboardingScreen(),
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    }
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(backgroundColor: Color(0xFF1E2026),
        contentPadding: EdgeInsets.only(top: 10, left: 10),
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 18, alignment: Alignment.topLeft,
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
  void initState() {
    super.initState();
    /*setState(() {
      chatmsgcount = 0;
    });*/
    _timer1();
  }

  Widget build(BuildContext context) {
  userid!=null && userid!="" ?  _con.getAbout(userid.toString()) : null;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        color: Color(0xFF1E2026),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/welcome tile.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
