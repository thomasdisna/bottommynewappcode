import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_confirm_order_status.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homkit_order_detail_details.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'Search_Screen/Search_Screen_T1.dart';
import 'business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Components/widget_style.dart';
class BusinessOrderpageOrderDetails extends StatefulWidget {
  @override
  _BusinessOrderpageOrderDetailsState createState() =>
      _BusinessOrderpageOrderDetailsState();
}

class _BusinessOrderpageOrderDetailsState
    extends State<BusinessOrderpageOrderDetails> {

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
                              child: Text("Online",style:f13w),
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
                              Text("12 Orders", style: f11w),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Orders # TVM/76945796760",
                              textAlign: TextAlign.center,
                              style: f15wB,
                            ),
                            Text(
                              "04-07-2020 07:10 pm | 3 Items",
                              textAlign: TextAlign.center,
                              style: f14w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrawerOrderStatus()));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFF48c0d8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                        "Confirm Order ",
                        style: f15wB,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Text(
                              "Order Details",
                              style: f15wB,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.green[600]),
                                  borderRadius: BorderRadius.circular((2)),
                                ),
                                child: Icon(
                                  Icons.brightness_1,
                                  color: Colors.green[600],
                                  size: 10,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text("Vegetable Cutlet",
                                  style: f14w),
                            ],
                          ),
                          Text("x 3",
                              style: f14w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("\u20B9",
                                  style: f14w),
                              SizedBox(width: 3),
                              Text("136.00",
                                  style: f14w),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.green[600]),
                                  borderRadius: BorderRadius.circular((2)),
                                ),
                                child: Icon(
                                  Icons.brightness_1,
                                  color: Colors.green[600],
                                  size: 10,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text("Vegetable Cutlet",
                                  style: f14w),
                            ],
                          ),
                          Text("x 3",
                              style:f14w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("\u20B9",
                                  style: f14w),
                              SizedBox(width: 3),
                              Text("136.00",
                                  style: f14w),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.green[600]),
                                  borderRadius: BorderRadius.circular((2)),
                                ),
                                child: Icon(
                                  Icons.brightness_1,
                                  color: Colors.green[600],
                                  size: 10,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text("Vegetable Cutlet",
                                  style: f14w),
                            ],
                          ),
                          Text("x 3",
                              style: f14w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("\u20B9",
                                  style: f14w),
                              SizedBox(width: 3),
                              Text("136.00",
                                  style: f14w),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Amount to be Collected",
                          style: f14w),
                      Row(
                        children: <Widget>[
                          Text("Item Total",
                              style: f14w),
                          SizedBox(width: 10),
                          Row(
                            children: <Widget>[
                              Text("\u20B9",
                                  style: f14w),
                              SizedBox(width: 3),
                              Text("136.00",
                                  style: f14w),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.only(left: 23, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("\u20B9",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16)),
                            SizedBox(width: 3),
                            Text("185.00",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderItemDetail()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23, right: 20,top: 5),
                      child: Text("Details",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ),
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