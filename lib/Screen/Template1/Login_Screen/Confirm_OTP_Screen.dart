import 'package:Butomy/Components/widget_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Controllers/UserController/userController.dart';
import 'package:Butomy/Library/Animation/FadeAnimation.dart';
import 'package:Butomy/Model/UserModel/userModel.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/SignIn_Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
var UserId;
class ConfirmOtpPage extends StatefulWidget {
  ConfirmOtpPage(
      {Key key,this.OTPMessage}) : super(key: key);
  String OTPMessage;

  @override
  _ConfirmOtpPageState createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends StateMVC<ConfirmOtpPage> {
  User currentUser = new User();
  TimelineWallController _con;

  _ConfirmOtpPageState() : super(TimelineWallController()){
    _con = controller;
  }
  TextEditingController otp1 = TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    showToast();
    super.initState();

  }

  void showToast(){
    Fluttertoast.showToast(
      msg:"     "+widget.OTPMessage+"     ",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }



  @override

  Widget build(BuildContext context) {

    Widget title = FadeAnimation(
      0.6,
      Text(
        'Confirm your OTP Verification',
        style: TextStyle(
            color: Colors.white,
            fontSize: 34.0,
            fontWeight: FontWeight.w600,
            fontFamily: "Sofia",
            shadows: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ]),textAlign: TextAlign.center,
      ),
    );
    Widget ResendOTP = GestureDetector(
        onTap: (){
          _con.resendOtp(context,userid.toString());

        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text("Resend OTP",style: TextStyle(color: Colors.white,fontSize: 18,decoration: TextDecoration.underline),)),
        ));
    Widget verifyButton = Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 154.0),
      child: FadeAnimation(
        0.9,
        MaterialButton(
          onPressed: () {
            if(otp1.text == widget.OTPMessage){
              _con.otp(context,otp1.text,userid.toString());
            }
            else{
              Fluttertoast.showToast(
                msg:"     Invalid OTP     ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 35,
                backgroundColor: Color(0xFF48c0d8),
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
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
                "Verify",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sofia",
                    letterSpacing: 0.9),
              )),
        ),
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/Template1/image/loginBackground.jpeg"),
                      fit: BoxFit.cover)),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black12.withOpacity(0.6)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: () => Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      signinTemplate1())),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 25.0,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 31.0,
                  ),
                  title,
                  SizedBox(
                    height: 160.0,
                  ),

                  FadeAnimation(
                    0.9,
                    Center(
                      child: Container(
                        width: 250,
                        child: PinCodeTextField(
                          controller: otp1,
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
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 55,borderWidth: 1,
                            fieldWidth: 55,
                            activeFillColor: Colors.transparent,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          textStyle: f14wB,
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if(widget.OTPMessage==otp1.text)
                            {
                              _con.otp(context,otp1.text,userid.toString());
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  ResendOTP,
                  verifyButton,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}