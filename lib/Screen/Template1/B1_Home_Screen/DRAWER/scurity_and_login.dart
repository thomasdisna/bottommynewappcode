import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';

class Security extends StatefulWidget {




  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {

  bool switchControlAll = false;
  void toggleActivateAll(bool value) {
    if (switchControlAll == false) {

      setState(() {
        switchControlAll = true;

      });

    } else {
      setState(() {
        switchControlAll = false;

      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF1E2026),titleSpacing: 0, iconTheme: IconThemeData(color: Colors.white),
        title: Text("Security & Login",style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Login",style: f18WB,),
                  Text("Change password",style: f16wB,),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 10.0,
              ),
              child: Text("Where you're logged in",style: f18WB,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.phone_android,color: Colors.white,),
                      Text("Samsung Galaxy M21 \n - Nedumangadu india",style: f15wB,)
                    ],
                  ),
                  Row(
                    children: [
                      FlatButton(splashColor: Color(0xFF48c0d8),
                          onPressed: () {},
                          child: Text(
                            "Active",
                            style: TextStyle(color: Colors.green),
                          )),
                      FlatButton(splashColor: Color(0xFF48c0d8),
                          onPressed: () {},
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.yellow),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.phone_android,color: Colors.white,),
                      Text("Samsung Galaxy M21 \n - Nedumangadu india",style: f15wB,)
                    ],
                  ),
                  Row(
                    children: [
                      FlatButton(splashColor: Color(0xFF48c0d8),
                          onPressed: () {},
                          child: Text(
                            "Active",
                            style: TextStyle(color: Colors.green),
                          )),
                      FlatButton(splashColor: Color(0xFF48c0d8),
                          onPressed: () {},
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.yellow),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              color: Colors.grey,
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(height: 15,),
            Text(
              "Security",
              style: f18WB),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security,color: Colors.white,),
                      SizedBox(width: 5,),
                      Text("Get alerts about\nunrecognised logins",style: f15wB,)
                    ],
                  ),
                  Row(
                    children: [
                      Text("on",style: f15wB,),
                      Transform.scale(
                          scale: .8,alignment: Alignment.center,
                          child: Switch(
                            onChanged: toggleActivateAll,
                            value: switchControlAll,
                            activeColor: Colors.black,
                            activeTrackColor: Color(0xFF48c0d8),
                            inactiveThumbColor: Colors.black,
                            inactiveTrackColor: Color(0xFF48c0d8),
                          )),
                      Text("off",style: f15wB,),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}