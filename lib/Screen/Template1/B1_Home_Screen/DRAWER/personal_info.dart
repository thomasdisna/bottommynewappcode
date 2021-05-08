import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_about_info_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_edit_profile.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(titleSpacing: 0,
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF1E2026), iconTheme: IconThemeData(color: Colors.white),
        title: Text("Personal information",style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MaterialButton(height: 50,
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AboutInfo()
              ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("About Info",style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.w400,color: Colors.white),),
                    Image.asset('assets/Template1/image/Foodie/icons/right_arrow.png',height: 20,color: Colors.white,),
                  ],
                ),
              ),
            ),
            MaterialButton(height: 50,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AccountEditPage()
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Account",style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.w400,color: Colors.white),),
                    Image.asset('assets/Template1/image/Foodie/icons/right_arrow.png',height: 20,color: Colors.white,),
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
