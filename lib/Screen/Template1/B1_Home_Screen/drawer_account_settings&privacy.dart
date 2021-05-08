import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DRAWER/business_integration.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DRAWER/personal_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DRAWER/scurity_and_login.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_payments_refunds_page.dart';

class DrawerAccountSettingsAndPrivacy extends StatefulWidget {
  @override
  _DrawerAccountSettingsAndPrivacyState createState() => _DrawerAccountSettingsAndPrivacyState();
}

class _DrawerAccountSettingsAndPrivacyState extends State<DrawerAccountSettingsAndPrivacy> {

  bool showAccount,showSecurity,showPrivacy,showNotify;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      showAccount = false;
      showSecurity = false;
      showPrivacy = false;
      showNotify = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF1E2026),titleSpacing: 0, iconTheme: IconThemeData(color: Colors.white),
        title: Text("Settings & Privacy",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //account
              MaterialButton(splashColor: Color(0xFF48c0d8),
                onPressed: (){
                setState(() {
                  showAccount = ! showAccount;
                });
                },
                color: Color(0xFF23252E),
                child: Padding(
                  padding: const EdgeInsets.only(top:15,bottom: 15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/Template1/image/Foodie/icons/person.png",height: 22,),
                          SizedBox(width: 10,),
                          Text("Account Settings",style: f16wB,),
                        ],
                      ),
                      Image.asset("assets/Template1/image/Foodie/icons/down-arrow.png",color: Colors.white,height: 18,),
                    ],
                  ),
                ),
              ),
              showAccount ? Padding(
                padding: const EdgeInsets.only(bottom: 20,),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(height: 50,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PersonalInfo()
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Personal Information",style: f15wB,textAlign: TextAlign.start,)),
                      ),
                    MaterialButton(height: 50,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => FoodiPaymentsAndRefundsPage()
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                          child: Text("Payments",style: f15wB,textAlign: TextAlign.start,),
                        )),
                  ],
                ),
              ) : Container(),
              //security
              SizedBox(height: 5,),
              MaterialButton(splashColor: Color(0xFF48c0d8),
                onPressed: (){
                  setState(() {
                    showSecurity = ! showSecurity;
                  });
                },
                color: Color(0xFF23252E),
                child: Padding(
                  padding: const EdgeInsets.only(top:15,bottom: 15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/Template1/image/Foodie/icons/shield.png",height: 22,),
                          SizedBox(width: 10,),
                          Text("Security",style: f16wB,),
                        ],
                      ),
                      Image.asset("assets/Template1/image/Foodie/icons/down-arrow.png",color: Colors.white,height: 18,),
                    ],
                  ),
                ),
              ),
              showSecurity ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(height: 50,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Security()
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                          child: Text("Security & Login",style: f15wB,textAlign: TextAlign.start,),
                        )),
                    MaterialButton(height: 50,
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Apps & Website",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),
                    MaterialButton(height: 50,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => BusinessIntegration()
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Business Integration",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),
                  ],
                ),
              ) : Container(),
              SizedBox(height: 5,),
              //privacy
              MaterialButton(splashColor: Color(0xFF48c0d8),
                onPressed: (){
                  setState(() {
                    showPrivacy = ! showPrivacy;
                  });
                },
                color: Color(0xFF23252E),
                child: Padding(
                  padding: const EdgeInsets.only(top:15,bottom: 15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/Template1/image/Foodie/icons/privacy.png",color: Colors.white,height: 23,),
                          SizedBox(width: 10,),
                          Text("Privacy",style: f16wB,),
                        ],
                      ),
                      Image.asset("assets/Template1/image/Foodie/icons/down-arrow.png",color: Colors.white,height: 18,),
                    ],
                  ),
                ),
              ),
              showPrivacy ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(height: 50,
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("profile Settings",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),
                    MaterialButton(height: 50,
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Public posts",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),

                    MaterialButton(height: 50,
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Location",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),

                    MaterialButton(height: 50,
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Active Status",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),

                    MaterialButton(height: 50,
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Blocking",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),
                  ],
                ),
              ) : Container(),
              SizedBox(height: 5,),
              MaterialButton(splashColor: Color(0xFF48c0d8),
                onPressed: (){
                  setState(() {
                    showNotify = ! showNotify;
                  });
                },
                color: Color(0xFF23252E),
                child: Padding(
                  padding: const EdgeInsets.only(top:15,bottom: 15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/Template1/image/Foodie/icons/bell.png",height: 22,),
                          SizedBox(width: 10,),
                          Text("Notifications",style: f16wB,),
                        ],
                      ),
                      Image.asset("assets/Template1/image/Foodie/icons/down-arrow.png",color: Colors.white,height: 18,),
                    ],
                  ),
                ),
              ),
              showNotify ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(height: 50,
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Notification Settings",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),
                    MaterialButton(height: 50,
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0,),
                        child: Text("Text Messaging",style: f15wB,textAlign: TextAlign.start,),
                      ),
                    ),

                  ],
                ),
              ) : Container(),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
