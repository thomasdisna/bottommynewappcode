import 'package:flutter/material.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'business_home_kitchen_timeline.dart';
import 'drawer_homekit_past_orders.dart';
import 'package:Butomy/Components/widget_style.dart';class DrawerOrderStatus extends StatefulWidget {
  @override
  _DrawerOrderStatusState createState() => _DrawerOrderStatusState();
}

class _DrawerOrderStatusState extends State<DrawerOrderStatus> {
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
          height: 35,
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
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
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/Template1/image/Foodie/logo.png",
                          height: 35,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("Online",style: f13w),
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
                              child: Text("Offline",style: f13w),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),SizedBox(height: 8,),
                  Container(
                    height: 65,
                    color: Colors.grey[850],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("TODAYS SALES", style: f11w),
                              SizedBox(height: 2,),
                              Text("\u20B9 4500", style: f11w),
                              SizedBox(height: 2,),
                              Text("12 Orders", style:f11w),
                            ],
                          ),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("WEEK SO FAR", style: f11w),
                              SizedBox(height: 2,),
                              Text("\u20B9 4500", style: f11w),
                              SizedBox(height: 2,),
                              Text("12 Orders", style: f11w),
                            ],
                          ),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("MONTH SO FAR", style: f11w),
                              SizedBox(height: 2,),
                              Text("\u20B9 4500", style: f11w),
                              SizedBox(height: 2,),
                              Text("12 Orders", style: f11w),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

              CustomListTile( Icons.info_outline,'Business Info', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>BusinessInfo()
              ))}),
              CustomListTile(Icons.av_timer,'Preparation time', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>BusinessPreparationTime()
              ))}),

              CustomListTile(Icons.person,'Account Setting', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>DrawerHomekitAccountSettings()
              ))}),

              CustomListTile(Icons.content_paste,'Orders', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>BusinessHomeKitchenOrderPage()
              ))}),

              CustomListTile(Icons.assignment,'Inventory', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>DrawerHomekitInventory()
              ))}),

              CustomListTile(Icons.star_border,'Ratings', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>RatingPage()
              ))}),

              CustomListTile(Icons.note_add,'Past Orders', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>BusinessOldOrderPage()
              ))}),

              CustomListTile(Icons.settings,'Settings', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>DrawerHomekitSettings()
              ))}),

              CustomListTile(Icons.contacts,'Point of contact', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>DrawerHomekitPointOfContacts()
              ))}),

              CustomListTile(Icons.people_outline,'Partner FAQs', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>DrawerHomekitPartner_FAQs()
              ))}),

              CustomListTile(Icons.compare_arrows,'Compliances', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>DrawerHomekitCompliances()
              ))}),

              CustomListTile(Icons.library_books,'Reports', () => {Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>DrawerHomekitReports()
              ))}),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
        child: Container(height: 45,decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),color: Color(0xFF48c0d8),
        ),
          child: Center(
            child: Text("View Receipt",style: f15wB),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                decoration: BoxDecoration(
                    color: Color(0xFF23252E),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Estimated delivery around",
                        style: f15wB,),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "6:34 PM - 6:44 PM",
                          style:f15wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "to",
                        style: f14w,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "### Road St, Philadelphia, PA, 19212",
                        style: f14w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFF48c0d8)),
                        child: Icon(
                          Icons.done,
                          size: 18.0,
                        ),
                      ),
                      Text("Order Received",style: f15wB),
                      Text("6:04 PM",style: f14w),
                    ],
                  ),
                  _circleOrange(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFF48c0d8)),
                        child: Icon(
                          Icons.fastfood,
                          size: 16.0,
                        ),
                      ),
                      Text("Order Placed",style: f15wB),
                      Text("6:15 PM",style: f14w),
                    ],
                  ),
                  _circleOrange(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFF48c0d8)),
                        child: Icon(
                          Icons.directions_car,
                          size: 18.0,
                        ),
                      ),
                      Text("Out for Delivery",style: f15wB),
                      Text("6:21 PM",style: f14w),
                    ],
                  ),
                  _circleOrange(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFF48c0d8)),
                        child: Icon(
                          Icons.done_all,
                          size: 18.0,
                        ),
                      ),
                      Text("Delivered",style: f15wB),
                      Text("6:38 PM",style: f14w),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _circleOrange() {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        CircleAvatar(
          backgroundColor: Color(0xFFffd55e),
          radius: 2.0,
        ),
        SizedBox(
          height: 7.0,
        ),
        CircleAvatar(
          backgroundColor: Color(0xFFffd55e),
          radius: 2.0,
        ),
        SizedBox(
          height: 7.0,
        ),
        CircleAvatar(
          backgroundColor: Color(0xFFffd55e),
          radius: 2.0,
        ),
        SizedBox(
          height: 7.0,
        ),
        CircleAvatar(
          backgroundColor: Color(0xFFffd55e),
          radius: 2.0,
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    ),
  );
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