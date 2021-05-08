import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/video_firebase.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';

class WelcomeFoodizWallBusiness extends StatefulWidget {
  @override
  _WelcomeFoodizWallBusinessState createState() =>
      _WelcomeFoodizWallBusinessState();
}

class _WelcomeFoodizWallBusinessState extends State<WelcomeFoodizWallBusiness> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>TimeLine(false)
              ));
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        elevation: 5,
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),
      ),
      backgroundColor: Color(0xFF1E2026),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to",
              style: TextStyle(color: Colors.white70, fontSize: 35),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/Template1/image/Foodie/logo_Business.png",
              height: 50,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Your Registration is under process.\nOur support team will contact you\nin 3 working days",
              style: TextStyle(color: Colors.white70, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 60,
            ),
            InkWell(
              splashColor: Color(0xFFffd55e),
                borderRadius: BorderRadius.circular(6),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>TimeLine(false)
                ));
              },
              child: Container(height: 50,width: 50,
              child: Center(
                child: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(6)
              ),),
            )
          ],
        ),
      ),
    );
  }
}
