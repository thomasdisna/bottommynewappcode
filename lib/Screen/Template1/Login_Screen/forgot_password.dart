import 'package:flutter/material.dart';
import 'package:Butomy/Controllers/UserController/userController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Components/validations.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/SignIn_Screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends StateMVC<ForgotPasswordPage> {
  bool autovalidate = false;
  Validations validations = new Validations();
  final TextEditingController _email = TextEditingController();
  UserController _con;

  _ForgotPasswordPageState() : super(UserController()){
    _con = controller;
  }
  submit(){
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();

      Navigator.of(context)
          .pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => signinTemplate1()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              padding: const EdgeInsets.only(top: 230.0),
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
                      height: 30.0,
                    ),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontFamily: "Sofia",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 28.0),
                    ),
                    SizedBox(height: 50,),
                    Form(
                      key: _con.loginFormKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 40.0),
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
                                    child: TextFormField(
                                      validator: validations.validateEmail,
                                      controller: _email,
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
                              "Reset Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Sofia",
                                  letterSpacing: 0.9),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}