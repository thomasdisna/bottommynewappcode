import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_business_forgot_user_confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekitchen_bottom_bar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_timeline.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class BusinessPinAfterEntry extends StatefulWidget {

  BusinessPinAfterEntry({this.name,this.timid,this.pagid,this.upld,this.memberdate,this.pin,this.typ,this.phone});
  String name,pin,typ,phone;
  String pagid,timid,memberdate;
  bool upld;

  @override
  _BusinessPinAfterEntryState createState() =>
      _BusinessPinAfterEntryState();
}

class _BusinessPinAfterEntryState extends StateMVC<BusinessPinAfterEntry> {

  HomeKitchenRegistration _con;

  _BusinessPinAfterEntryState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  TextEditingController pinController = TextEditingController();
  String currentText = "";

  @override
  void initState() {
    _con.HomekitchenGetProfile(widget.pagid);
    widget.typ=="1" ? _con.getAccountWallImage(widget.timid) :
    widget.typ=="2" ?  _con.LocalStoregetAccountWallImage(widget.timid) :
    widget.typ=="3" ? _con.RestaurantgetAccountWallImage(widget.timid) :
    null;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
              child: Image.asset(
                "assets/Template1/image/Foodie/logo_Business.png",
                height: 60,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Center(
              child: Text(
                widget.name+" PIN",
                style: TextStyle(color: Colors.white70, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: 200,
                child: PinCodeTextField(
                  autoFocus: true,
                  // controller: pinController,
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: false,
                  obscuringCharacter: "*",
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    selectedColor: Color(0xFF48c0d8),
                    selectedFillColor: Colors.transparent,
                    inactiveColor: Colors.white,disabledColor: Colors.white,
                    activeColor: Colors.white,
                    inactiveFillColor: Colors.transparent,
                    shape: PinCodeFieldShape.circle,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 35,borderWidth: 1,
                    fieldWidth: 35,
                    activeFillColor: Colors.transparent,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  textStyle: f14wB,
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      currentText = value;
                    });
                    if(widget.pin==currentText)
                    {
                      widget.typ=="1" ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  bottomNavBarHomeKitchen(pagid:widget.pagid,
                                    timid: widget.timid,memberdate: widget.memberdate,currentIndex: 0,upld: false,))): widget.typ=="2" ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  bottomNavBarLocalShop(pagid:widget.pagid,
                                    timid: widget.timid,memberdate: widget.memberdate,currentIndex: 0,upld: false,))) : widget.typ=="3" ?
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  bottomNavBarRestaurant(pagid:widget.pagid,
                                    timid: widget.timid,memberdate: widget.memberdate,currentIndex: 0,upld: false,))) : null;
                    }

                  },
                ),
              ),
            ),
            FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ForgotBusinessConfirmScreen(
                      memberdate: widget.memberdate,
                      phone: widget.phone,
                      typ: widget.typ,
                      pagid: widget.pagid,
                      timid: widget.timid,
                      name: widget.name,
                      upld: widget.upld,
                      pin: widget.pin,
                    )
                  ));
                },
                child: Text("Forgot PIN?",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey),)),
            SizedBox(height: 60,),
            Center(
              child: Container(height: 40,width: 110,
                child: MaterialButton(
                  splashColor: Color(0xFF48c0d8),
                  height: 40,minWidth: 90,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                        color: Colors.white
                    )
                  ),
                  onPressed: (){
                    if(widget.pin==currentText)
                      {
                        widget.typ=="1" ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    bottomNavBarHomeKitchen(pagid:widget.pagid,
                                      timid: widget.timid,memberdate: widget.memberdate,currentIndex: 0,upld: false,))): widget.typ=="2" ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    bottomNavBarLocalShop(pagid:widget.pagid,
                                      timid: widget.timid,memberdate: widget.memberdate,currentIndex: 0,upld: false,))) : widget.typ=="3" ?
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    bottomNavBarRestaurant(pagid:widget.pagid,
                                      timid: widget.timid,memberdate: widget.memberdate,currentIndex: 0,upld: false,))) : null;
                      }
                    else
                      Fluttertoast.showToast(
                        msg: "Incorrect PIN !!!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 35,
                        backgroundColor: Color(0xFF48c0d8),
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    // _con.SetBusinessPIN(widget.page,currentText);
                  },
                  child: Center(
                    child: Text("Submit",style: f16wB,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
