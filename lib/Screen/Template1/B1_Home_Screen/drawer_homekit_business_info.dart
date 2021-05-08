import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'Search_Screen/Search_Screen_T1.dart';
import 'business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Components/widget_style.dart';
class BusinessInfo extends StatefulWidget {
  @override
  _BusinessInfoState createState() => _BusinessInfoState();
}

bool acc = false;
bool fin = false;
bool usr = false;

class _BusinessInfoState extends State<BusinessInfo> {

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
                              Text("\u20B9 4500", style:f11w),
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
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              //  decoration: BoxDecoration(color: Color(0xFF23252E)),
              decoration: BoxDecoration(color: Colors.grey[850]),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Business Information",
                      textAlign: TextAlign.center,
                      style: f15wB,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Sofis Kitchen, Poojapura",
                      textAlign: TextAlign.center,
                      style: f14w,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    acc = !acc;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Account",
                      textAlign: TextAlign.center,
                      style: f16wB,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black87,thickness: 1,
            ),
            acc == true
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Sofis Kitchen",
                            textAlign: TextAlign.center,
                            style: f15wB,
                          ),SizedBox(height: 3,),
                          Text(
                            "Poojapura (282971)",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "Thiruvananthapuram",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Active",
                              textAlign: TextAlign.center,
                              style: f14wB,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.brightness_1,
                              color: Colors.greenAccent[700],
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sofis Kitchen",
                        textAlign: TextAlign.center,
                        style: f14wB,
                      ),SizedBox(height: 3,),
                      Text(
                        "The V Building TC17/712",
                        textAlign: TextAlign.center,
                        style: f14w,
                      ),SizedBox(height: 3,),
                      Text(
                        "Poojapura P.O. Poojapura",
                        textAlign: TextAlign.center,
                        style: f14w,
                      ),SizedBox(height: 3,),
                      Text(
                        "Thiruvananthapuram, State - Kerala",
                        textAlign: TextAlign.center,
                        style: f14w,
                      ),SizedBox(height: 3,),
                      Text(
                        "695012",
                        textAlign: TextAlign.center,
                        style: f14w,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 10, top: 20,bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "Foodizwall BID",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "Onboarding Date",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "Phone Number",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "Email ID",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "SOFIS KITCHEN",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "282971",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "21/05/2020",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "8086595642",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),SizedBox(height: 3,),
                          Text(
                            "mammupeeyes@gmail.com",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    fin = !fin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Finance",
                      textAlign: TextAlign.center,
                      style: f16wB,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black87,thickness: 1,
            ),
            fin == true
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.only(left: 30, right: 10,bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Bank",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Account Number",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "IFSC Code",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "STATE BANK OF INDIA",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "34361606188",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "SBINoo13313",
                            textAlign: TextAlign.center,
                            style: f14w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    usr = !usr;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "User Roles",
                      textAlign: TextAlign.center,
                      style: f16wB,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black87,thickness: 1,
            ),
            usr == true
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, right: 10, left: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 45.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ]),
                        child: Container(
                          child: TextField(
                            //controller: _loc,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search,
                                    color: Colors.white),
                                border: InputBorder.none,
                                hintText: "Search Foodi",
                                hintStyle: f14g),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                  errorListener: () =>
                                  new Icon(Icons.error),
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                            BorderRadius.all(Radius.circular(180.0))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Tojo Thomas",
                              style: f15wB,
                            ),SizedBox(height: 3,),
                            Text("Lives in Kottayam,Kerala",
                                style: f14g),SizedBox(height: 3,),
                            Text("Member since Feb 2020",
                                style: f14g),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                  ),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            " Page Role",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Admin",
                        textAlign: TextAlign.center,
                        style: f14w,
                      ),
                      Icon(Icons.brightness_1,
                          color: Colors.green, size: 18),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: Colors.black87,thickness: 1,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 20),
                  child: Text(
                    "Order Manager",
                    textAlign: TextAlign.center,
                    style: f14w,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: Colors.black87,thickness: 1,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 20),
                  child: Text(
                    "Advertiser",
                    textAlign: TextAlign.center,
                    style: f14w,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: Colors.black87,thickness: 1,
                  ),
                ),
                Container(
                  height: 100,
                ),
              ],
            )
                : Container(),
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