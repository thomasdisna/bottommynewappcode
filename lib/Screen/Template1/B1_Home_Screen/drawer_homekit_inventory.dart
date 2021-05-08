import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodiz_business_item_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'business_home_kitchen_timeline.dart';

class DrawerHomekitInventory extends StatefulWidget {
  @override
  _DrawerHomekitInventoryState createState() => _DrawerHomekitInventoryState();
}

class _DrawerHomekitInventoryState extends State<DrawerHomekitInventory> {
  bool switchControlAll = false;
  bool switchControlActInact = false;
  bool switchControlBuyPre = false;
  var textHolder = 'Switch is OFF';

  void toggleActivateAll(bool value) {
    if (switchControlAll == false) {
      setState(() {
        switchControlAll = true;
        textHolder = 'Switch is ON';
      });

    } else {
      setState(() {
        switchControlAll = false;
        textHolder = 'Switch is OFF';
      });

    }
  }

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

  void toggleBuyPre(bool value) {
    if (switchControlBuyPre == false) {
      setState(() {
        switchControlBuyPre = true;
        textHolder = 'Switch is ON';
      });

    } else {
      setState(() {
        switchControlBuyPre = false;
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
          height: 35,
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
                    height: 22,
                    width: 22,
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11)),
                              SizedBox(
                                height: 2,
                              ),
                              Text("\u20B9 4500",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11)),
                              SizedBox(
                                height: 2,
                              ),
                              Text("12 Orders",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("WEEK SO FAR",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              SizedBox(
                                height: 2,
                              ),
                              Text("\u20B9 4500",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              SizedBox(
                                height: 2,
                              ),
                              Text("12 Orders",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("MONTH SO FAR",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              SizedBox(
                                height: 2,
                              ),
                              Text("\u20B9 4500",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              SizedBox(
                                height: 2,
                              ),
                              Text("12 Orders",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
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
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Card(
                      color: Colors.grey[700],
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 3.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Total Items",
                              style: f14w,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "10",
                              style: f14wB,
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.grey[700],
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 3.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Active Items", style: f14w),
                            SizedBox(
                              height: 12,
                            ),
                            Text("5", style: f14wB)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 3.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/add-item.png",
                            height: 30,
                            width: 25,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Add Item", style: f14w)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(60)),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      hintText: "Search Item",
                      hintStyle: f14g),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Sort/Filter", style: f14wB),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Activate All", style: f14w),
                      Transform.scale(
                          scale: .7,
                          child: Switch(
                            onChanged: toggleActivateAll,
                            value: switchControlAll,
                            activeColor: Color((0xFFffd55e)),
                            activeTrackColor: Colors.grey,
                            inactiveThumbColor: Color((0xFFffd55e)),
                            inactiveTrackColor: Colors.grey,
                          )),
                    ],
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height + 300,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemDetailPage()));
                        },
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text("Vegetable Cutlet",
                                                style: f15wB),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 14,
                                              width: 14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .greenAccent[700]),
                                                  borderRadius:
                                                  BorderRadius.circular(2)),
                                              child: Icon(
                                                Icons.brightness_1,
                                                color: Colors.greenAccent[700],
                                                size: 8,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 72,
                                                  width: 68,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/Template1/image/Foodie/snack.jpg"),
                                                          fit: BoxFit.cover),
                                                      color: Colors.black12,
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.0)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 5.0,
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                0.1),
                                                            spreadRadius: 2.0)
                                                      ]),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "In Snacks",
                                                      style: f14w,
                                                    ),
                                                    SizedBox(height: 3),
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 14,
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text("4.1",
                                                            style: f14gB),
                                                        Text(" Ratings",
                                                            style: f14g)
                                                      ],
                                                    ),
                                                    SizedBox(height: 3),
                                                    Text(
                                                      "In Snacks",
                                                      style: f14w,
                                                    ),
                                                    SizedBox(height: 3),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                            "Price: ",
                                                            style: f14w
                                                        ),
                                                        Text(
                                                            "\u20B9" + " 15.00",
                                                            style: f14wB
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height: 32,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text("Active",
                                                style: f135w),
                                          ),
                                          Transform.scale(
                                              scale: .7,
                                              child: Switch(
                                                onChanged: toggleActiveInactive,
                                                value: switchControlActInact,
                                                activeColor:
                                                Colors.greenAccent[700],
                                                activeTrackColor: Colors.grey,
                                                inactiveThumbColor:
                                                Colors.greenAccent[700],
                                                inactiveTrackColor: Colors.grey,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text("Inactive",
                                                style: f135w),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 32,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text("Buy Now",
                                                style: f135w),
                                          ),
                                          Transform.scale(
                                              scale: .7,
                                              child: Switch(
                                                onChanged: toggleBuyPre,
                                                value: switchControlBuyPre,
                                                activeColor: Color(0xFFffd55e),
                                                activeTrackColor: Colors.grey,
                                                inactiveThumbColor:
                                                Color(0xFF48c0d8),
                                                inactiveTrackColor: Colors.grey,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text("Pre Order",
                                                style: f135w),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, bottom: 10),
                              child: Divider(
                                color: Colors.black87,
                                thickness: 1,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
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
