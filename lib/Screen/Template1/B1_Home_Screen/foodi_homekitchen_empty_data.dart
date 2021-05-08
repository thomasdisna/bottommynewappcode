
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_home_kitchen.dart';
import 'package:flutter/material.dart';

class KitchenEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(backgroundColor: Color(0xFF1E2026),iconTheme: IconThemeData(color: Colors.white),
        elevation: 4,titleSpacing: 0,
        brightness: Brightness.dark,
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/chef.png',height: 75,color: Colors.white,),
              SizedBox(height: 25,),
              Center(
                child: Text(
                  "NO current Home kitchen Available \n at your location",
                  textAlign: TextAlign.center,
                  style: f16wB,
                ),
              ),
              SizedBox(height: 30.0,),
              FlatButton(
                splashColor: Color(0xFF48c0d8),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MenuDrawerHomeKitchen()));
                },
                child: Text(
                  "Register as Home Kitchen Now",
                  style: f15B,

                ),
                color: Color(0xFFffd55e),
              ),
              SizedBox(height: 30.0,),
              Center(
                child: Text(
                  "For Franchise Contact us",
                  textAlign: TextAlign.center,
                  style: f15w,
                ),
              ),
              Center(
                child: Text(
                  "marketing@butomy.com",
                  textAlign: TextAlign.center,
                  style: f15wB,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}