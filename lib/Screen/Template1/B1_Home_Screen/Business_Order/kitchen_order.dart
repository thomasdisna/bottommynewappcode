import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_HomeKitchen_Product_List_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_home_kitchen_new_entry.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekitchen_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_order_order_detail.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';

import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Components/widget_style.dart';
class BusinessHomeKitchenOrderPage extends StatefulWidget {
  BusinessHomeKitchenOrderPage({Key key,this.pagid,this.timid,this.memberdate})   : super(key: key);
  String pagid,timid,memberdate;

  @override
  _BusinessHomeKitchenOrderPageState createState() => _BusinessHomeKitchenOrderPageState();
}

class _BusinessHomeKitchenOrderPageState extends State<BusinessHomeKitchenOrderPage> {

  bool switchControlActInact = false;
  var textHolder = 'Switch is OFF';


  void toggleActiveInactive(bool value) {
    if (switchControlActInact == false) {
      setState(() {
        switchControlActInact = true;
        textHolder = 'Switch is ON';
      });
    } else {
      setState(() {
        switchControlActInact = false;
        textHolder = 'Switch is OFF';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
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
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Image.asset(
                  "assets/Template1/image/Foodie/icons/search.png",
                  height: 20,
                  width: 20,
                ),
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new searchAppbar()));
                },
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new QRCODE()));
                  },
                  child: Image.asset(
                    "assets/Template1/image/Foodie/QRcode.png",
                    height: 20,
                    width: 20,
                  )),
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                  MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              )
            ],
          )
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          color: Color(0xFF1E2026),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/Template1/image/Foodie/logo_Business.png",
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("Online",
                                  style: f14w),
                            ),
                            Transform.scale(
                                scale: .7,
                                child: Switch(
                                  onChanged: toggleActiveInactive,
                                  value: switchControlActInact,
                                  activeColor: Colors.greenAccent[700],
                                  activeTrackColor: Colors.grey,
                                  inactiveThumbColor: Colors.greenAccent[700],
                                  inactiveTrackColor: Colors.grey,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Text("Offline",
                                  style: f14w),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 65,
                    color: Colors.grey[850],
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("TODAYS SALES",
                                  style:f11w),
                              SizedBox(
                                height: 2,
                              ),
                              Text("\u20B9 4500",
                                  style: f11w),
                              SizedBox(
                                height: 2,
                              ),
                              Text("12 Orders",
                                  style: f11w),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("WEEK SO FAR",
                                  style: f11w),
                              SizedBox(
                                height: 2,
                              ),
                              Text("\u20B9 4500",
                                  style: f11w),
                              SizedBox(
                                height: 2,
                              ),
                              Text("12 Orders",
                                  style: f11w),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("MONTH SO FAR",
                                  style: f11w),
                              SizedBox(
                                height: 2,
                              ),
                              Text("\u20B9 4500",
                                  style: f11w),
                              SizedBox(
                                height: 2,
                              ),
                              Text("12 Orders",
                                  style: f11w),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              CustomListTile(
                  Icons.info_outline,
                  'Business Info',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusinessInfo()))
                  }),
              CustomListTile(
                  Icons.av_timer,
                  'Preparation time',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BusinessPreparationTime()))
                  }),
              CustomListTile(
                  Icons.person,
                  'Account Setting',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrawerHomekitAccountSettings()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/order-list.png",
                  'Orders',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusinessHomeKitchenOrderPage()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/inventory.png",
                  'Inventory',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawerHomekitInventory()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/rating.png",
                  'Ratings',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RatingPage()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/past-orders.png",
                  'Past Orders',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusinessOldOrderPage()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/settings.png",
                  'Settings',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawerHomekitSettings()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/point-of-contact.png",
                  'Point of contact',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrawerHomekitPointOfContacts()))
                  }),
              CustomListTile(
                  Icons.people_outline,
                  'Partner FAQs',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrawerHomekitPartner_FAQs()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/compliance.png",
                  'Compliances',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrawerHomekitCompliances()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/reports.png",
                  'Reports',
                      () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawerHomekitReports()))
                  }),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text("Orders",
                  style: f15wB),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              //  decoration: BoxDecoration(color: Color(0xFF23252E)),
              decoration: BoxDecoration(color: Colors.grey[850],borderRadius: BorderRadius.circular(5)),
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("#TVM/1060",
                                  style: f14w),
                              SizedBox(height: 5),
                              Text("\u20B9  1,515.00",
                                  style: f14wB),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(

                                    decoration: BoxDecoration(color: Color(0xFF48c0d8),borderRadius: BorderRadius.circular(4)),
                                    height: 20,
                                    width: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Center(
                                        child: Text("Pending Order",
                                            style: f14wB),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("04-07-2020 07:19pm | Sofis Kitchen",
                                  style: f14w),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>BusinessOrderpageOrderDetails()
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.green,),

                            height: 30,

                            child: Center(child: Text("Order Details",style: f14B),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              //  decoration: BoxDecoration(color: Color(0xFF23252E)),
              decoration: BoxDecoration(color: Colors.grey[850],borderRadius: BorderRadius.circular(5)),
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("#TVM/1060",
                                  style: f14w),
                              SizedBox(height: 5),
                              Text("\u20B9  1,515.00",
                                  style: f14w),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(

                                    decoration: BoxDecoration(color: Color(0xFF48c0d8),borderRadius: BorderRadius.circular(4)),
                                    height: 20,
                                    width: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Center(
                                        child: Text("Pending Order",
                                            style: f14wB),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("04-07-2020 07:19pm | Sofis Kitchen",
                                  style: f14w),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>BusinessOrderpageOrderDetails()
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.green,),

                            height: 30,

                            child: Center(child: Text("Order Details",style: f15B),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E2026),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 2,
            ),
          ],
        ),
        height: 56,
        child: Padding(
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                      BusinessHomeKitchenTimeline(memberdate: widget.memberdate,pagid: widget.pagid,
                        timid: widget.timid,upld: false,)),
                  );
                },
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/home.png",
                      height: 21,
                      color: Colors.white54,
                      width: 21,
                    ),
                    Text("Home", style: f14w54,)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => BusinessHomeKitchenChatList(memberdate: widget.memberdate,timid: widget.timid,pagid: widget.pagid,
                        myID: widget.timid.toString(),myName: Bus_NAME.toString(),)
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/chat.png",
                      height: 21,
                      color: Colors.white54,
                      width: 21,
                    ),
                    Text("Chat", style: f14w54,)
                  ],
                ),
              ),
              Container(
                height: 42,
                width: 42,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => HomeKitNewEntryForm(timid: widget.timid,pagid: widget.pagid,memberdate: widget.memberdate,)
                    ));
                  },
                  elevation: 5,
                  backgroundColor: Color(0xFF48c0d9),
                  child: Icon(
                    Icons.add,
                    size: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => BusinessHomeKitchenProductListPage(memberdate: widget.memberdate,pageid: widget.pagid,timeid: widget.timid,)
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/list.png",
                      height: 23,
                      color: Colors.white54,
                      width: 23,
                    ),
                    Text("Item list", style: f14w54,)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        "assets/Template1/image/Foodie/icons/order-list.png",
                        height: 23, color: Color(0xFFffd55e), width: 23),
                    Text("Orders", style: f14y,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black87))),
        child: InkWell(
          splashColor: Colors.black45,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: f14w,
                      ),
                    ),
                  ],
                ),
                //Icon(Icons.arrow_right, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}