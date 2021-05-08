import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/welcome_foodizwall_business.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDrawerRestaurantAdd extends StatefulWidget {
  @override
  _MenuDrawerRestaurantAddState createState() => _MenuDrawerRestaurantAddState();
}

class _MenuDrawerRestaurantAddState extends State<MenuDrawerRestaurantAdd> {
  int selectedRadio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio=0;
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
    });
  }
  Future<String> setStatus() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('rest');
    prefs.setString('rest', "2");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF1E2026),iconTheme: IconThemeData(color: Colors.white),
        elevation: 4,titleSpacing: 0,
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),
      ),
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Color(0xFF23252E)),
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Register as Restaurant",
                  textAlign: TextAlign.center,
                  style: f15wB,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/28,
            ),
            Text(
              "Partner with Foodizwall\nand do more",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Get Started",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height/42,
            ),
            Text(
              "Foodizwall is a technology platform helping\nworldwide expand their reach, delight customers and\nboost their button line. Partner with us today.",
              style: f14gB,
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height:MediaQuery.of(context).size.height/42
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 9, right: 9, bottom: 2, top: 2),
              child: Container(
                color: Color(0xFF23252E),
                height: MediaQuery.of(context).size.height/15.5,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFffd55e),
                        ),
                      ),
                      hintText: "Restaurant Name",
                      hintStyle:
                      f14g),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 9, right: 9, bottom: 2, top: 2),
              child: Container(
                color: Color(0xFF23252E),
                height: MediaQuery.of(context).size.height/15.5,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFffd55e),
                        ),
                      ),
                      hintText: "Full Address",
                      hintStyle:
                      f14g),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 9, right: 4, bottom: 2, top: 2),
                  child: Container(
                    color: Color(0xFF23252E),
                    height: MediaQuery.of(context).size.height/15.5,
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFffd55e),
                            ),
                          ),
                          hintText: "Name",
                          hintStyle:f14g),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 9, bottom: 2, top: 2),
                  child: Container(
                    color: Color(0xFF23252E),
                    height:MediaQuery.of(context).size.height/15.5,
                    width: MediaQuery.of(context).size.width / 2.87,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFffd55e),
                            ),
                          ),
                          hintText: "Surname",
                          hintStyle:f14g),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 9, right: 9, bottom: 2, top: 2),
              child: Container(
                color: Color(0xFF23252E),
                height: MediaQuery.of(context).size.height/15.5,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFffd55e),
                        ),
                      ),
                      hintText: "Mobile Number (xxxxxxxxxx)",
                      hintStyle:f14g),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 9, right: 9, bottom: 2, top: 2),
              child: Container(
                color: Color(0xFF23252E),
                height: MediaQuery.of(context).size.height/15.5,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFffd55e),
                        ),
                      ),
                      hintText: "Email Address",
                      hintStyle:f14g),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Text("Category",style: f14gB),
                    Radio(
                      value: 0,
                      groupValue: selectedRadio,
                      activeColor: Color(0xFFffd55e),
                      onChanged: (val){

                        setSelectedRadio(val);
                      },
                    ),
                    Text("Snacks",style: f14g),
                    Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      activeColor: Color(0xFFffd55e),
                      onChanged: (val){
                      setSelectedRadio(val);},
                    ),
                    Text("Cakes",style: f14g),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      activeColor: Color(0xFFffd55e),
                      onChanged: (val) {

                        setSelectedRadio(val);
                      },
                    ),
                    Text("Meals",style: f14g),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height/34
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    "By clicking 'Submit', you agree to ",
                    style: f13g
                ),
                Text(
                    "Foodizwall General Terms and",
                    style: f13y
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Conditions ",
                    style: f13y
                ),
                Text(
                    "and acknowledge you have read the ",
                    style: f13g
                ),
                Text(
                    "Privacy Policy.",
                    style: f13y
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){/*setStatus();*/
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WelcomeFoodizWallBusiness()));},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Color(0xFF48c0d8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
                  "SUBMIT",
                  style: f15wB,
                )),
          ),
        ),
      ),
    );
  }
}
