import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_pin_setting.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class resetBusinessConfirmScreen extends StatefulWidget {

  resetBusinessConfirmScreen({this.name,this.timid,this.pagid,this.upld,this.memberdate,this.pin,this.typ,});
  String name,pin,typ;
  String pagid,timid,memberdate;
  bool upld;


  @override
  _resetBusinessConfirmScreenState createState() => _resetBusinessConfirmScreenState();
}

class _resetBusinessConfirmScreenState extends State<resetBusinessConfirmScreen> {

  TextEditingController _mob = TextEditingController();

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
            Text("Enter your "+widget.name+" Pin?",style: f15w,),
            SizedBox(height: 40,),
            Center(
              child: Container(
                width: 200,
                child: PinCodeTextField(
                  controller: _mob,
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

                    if(widget.pin==_mob.text)
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BusinessPinSetting(name: widget.name,page: widget.pagid,goo: "0",typ: widget.typ,)));
                    }

                  },
                ),
              ),
            ),
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
                    if(widget.pin==_mob.text)
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BusinessPinSetting(name: widget.name,page: widget.pagid,goo: "0",typ: widget.typ,)));
                    }
                    else
                      Fluttertoast.showToast(
                        msg: "Invalid Mobile number !!!",
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
                    child: Text("Next",style: f16wB,),
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
