import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_pin_setting.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotBusinessConfirmScreen extends StatefulWidget {

ForgotBusinessConfirmScreen({this.name,this.timid,this.pagid,this.upld,this.memberdate,this.pin,this.typ,this.phone});
String name,pin,typ,phone;
String pagid,timid,memberdate;
bool upld;


  @override
  _ForgotBusinessConfirmScreenState createState() => _ForgotBusinessConfirmScreenState();
}

class _ForgotBusinessConfirmScreenState extends State<ForgotBusinessConfirmScreen> {

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
        Text("Enter your "+widget.name+" Phone Number?",style: f15w,),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 40.0),
              child: Container(
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
                      left: 12.0, right: 12.0, top: 3.0),
                  child: Theme(
                    data:
                    ThemeData(hintColor: Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: _mob,
                        style: new TextStyle(color: Colors.white),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.phone,
                        autocorrect: false,
                        autofocus: false,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(0.0),
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: 'Mobile Number',
                            hintStyle:
                            TextStyle(color: Colors.white),
                            labelStyle: TextStyle(
                              color: Colors.white70,
                            )
                        ),
                      ),
                    ),
                  ),
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
                    if(widget.phone==_mob.text)
                    {
                     Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BusinessPinSetting(name: widget.name,page: widget.pagid,goo: "1",typ: widget.typ,)));
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
