import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class BusinessPinSetting extends StatefulWidget {

  BusinessPinSetting({this.name,this.page,this.goo,this.typ});
  String name,page,goo,typ;

  @override
  _BusinessPinSettingState createState() =>
      _BusinessPinSettingState();
}

class _BusinessPinSettingState extends StateMVC<BusinessPinSetting> {

  HomeKitchenRegistration _con;

  _BusinessPinSettingState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  TextEditingController pinController = TextEditingController();
  String currentText = "";

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
                "Set a PIN for "+widget.name,
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
                  },
                ),
              ),
            ),
            SizedBox(height: 40,),
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
                    currentText.toString().length==4 ?  _con.SetBusinessPIN(context,widget.page,currentText,widget.goo,widget.typ)
                    : Fluttertoast.showToast(
                      msg: " Please provide a valid PIN !!! ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 35,
                      backgroundColor: Color(0xFF48c0d8),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  child: Center(
                    child: Text("Set",style: f16wB,),
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
