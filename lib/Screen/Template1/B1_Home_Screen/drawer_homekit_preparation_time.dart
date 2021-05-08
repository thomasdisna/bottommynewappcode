import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'Search_Screen/Search_Screen_T1.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'business_home_kitchen_timeline.dart';
import 'package:Butomy/Components/widget_style.dart';class BusinessPreparationTime extends StatefulWidget {
  @override
  _BusinessPreparationTimeState createState() => _BusinessPreparationTimeState();
}

class _BusinessPreparationTimeState extends State<BusinessPreparationTime> {

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
                              child: Text("Online",style: f12w),
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
                              child: Text("Offline",style: f12w),
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
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Average",
                    textAlign: TextAlign.center,
                    style: f15wB,
                  ),
                  Text(
                    "Know More",
                    textAlign: TextAlign.center,
                    style: f15wB,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(color: Colors.grey[850]),
              //decoration: BoxDecoration(color: Colors.grey),
              height: 97,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 10,top: 15,bottom: 15),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "Preparation time",
                            textAlign: TextAlign.center,
                            style: f14w
                        ),SizedBox(height: 6,),
                        Text(
                          "15 Mins",
                          textAlign: TextAlign.center,
                          style: f15wB,
                        ),SizedBox(height: 6,),
                        Text(
                          "All Days",
                          textAlign: TextAlign.center,
                          style: f14w,
                        ),
                      ],
                    ),
                    Text(
                      "Edit",
                      textAlign: TextAlign.center,
                      style: f14w,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 5),
              child: Text(
                "Rush Hours",
                textAlign: TextAlign.center,
                style: f15wB,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: DashPathBorder.all(
                    dashArray: CircularIntervalList<double>(<double>[5.0, 2.5]),
                  ),
                ),
                child:Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: Color(0xFF48c0d9)),
                          child: Icon(Icons.add,color: Colors.white,size: 20,)),
                      SizedBox(width: 10),
                      Text("ADD LUNCH RUSH TIME",style: f14wB),
                    ],
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: DashPathBorder.all(
                    dashArray: CircularIntervalList<double>(<double>[5.0, 2.5]),
                  ),
                ),
                child:Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: Color(0xFF48c0d9)),
                          child: Icon(Icons.add,color: Colors.white,size: 20,)),
                      SizedBox(width: 10,),
                      Text("ADD DINNER RUSH TIME",style: f14wB),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: DashPathBorder.all(
                    dashArray: CircularIntervalList<double>(<double>[5.0, 2.5]),
                  ),
                ),
                child:Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: Color(0xFF48c0d9)),
                          child: Icon(Icons.add,color: Colors.white,size: 20,)),
                      SizedBox(width: 10),
                      Text("ADD MORE RUSH  HOURS",style: f14wB),
                    ],
                  ),
                ),
              ),
            ),




          ],
        ),
      ),






    );
  }
}

//----------------------------------------------------------

class DashPathBorder extends Border {
  DashPathBorder({
    @required this.dashArray,
    BorderSide top = BorderSide.none,
    BorderSide left = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
  }) : super(
    top: top,
    left: left,
    right: right,
    bottom: bottom,
  );

  factory DashPathBorder.all({
    BorderSide borderSide = const BorderSide(color: Colors.grey),
    @required CircularIntervalList<double> dashArray,
  }) {
    return DashPathBorder(
      dashArray: dashArray,
      top: borderSide,
      right: borderSide,
      left: borderSide,
      bottom: borderSide,
    );
  }
  final CircularIntervalList<double> dashArray;

  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        TextDirection textDirection,
        BoxShape shape = BoxShape.rectangle,
        BorderRadius borderRadius,
      }) {
    if (isUniform) {
      switch (top.style) {
        case BorderStyle.none:
          return;
        case BorderStyle.solid:
          switch (shape) {
            case BoxShape.circle:
              assert(borderRadius == null,
              'A borderRadius can only be given for rectangular boxes.');
              canvas.drawPath(
                dashPath(Path()..addOval(rect), dashArray: dashArray),
                top.toPaint(),
              );
              break;
            case BoxShape.rectangle:
              if (borderRadius != null) {
                final RRect rrect =
                RRect.fromRectAndRadius(rect, borderRadius.topLeft);
                canvas.drawPath(
                  dashPath(Path()..addRRect(rrect), dashArray: dashArray),
                  top.toPaint(),
                );
                return;
              }
              canvas.drawPath(
                dashPath(Path()..addRect(rect), dashArray: dashArray),
                top.toPaint(),
              );

              break;
          }
          return;
      }
    }

    assert(borderRadius == null,
    'A borderRadius can only be given for uniform borders.');
    assert(shape == BoxShape.rectangle,
    'A border can only be drawn as a circle if it is uniform.');

    // TODO(dnfield): implement when borders are not uniform.
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