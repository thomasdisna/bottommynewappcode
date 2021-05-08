import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_Restaurant_Product_List_Page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_new_entry.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_timeline.dart';
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
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_business_order_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'Business_HomeKitchen_Product_List_page.dart';
import 'Search_Screen/Search_Screen_T1.dart';
import 'business_homekitchen_chat.dart';
import 'business_home_kitchen_new_entry.dart';
import 'business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:intl/intl.dart';
class BusinessRestaurantOrderPage extends StatefulWidget {
  BusinessRestaurantOrderPage({Key key,this.pagid,this.timid,this.memberdate})   : super(key: key);
  String pagid,timid,memberdate;

  @override
  _BusinessRestaurantOrderPageState createState() => _BusinessRestaurantOrderPageState();
}

class _BusinessRestaurantOrderPageState extends StateMVC<BusinessRestaurantOrderPage> {

  HomeKitchenRegistration _con;
  _BusinessRestaurantOrderPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getBusinessOrderList(widget.pagid);
  }

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

      ),

      body: Column(
        children: [
          Center(
            child: Visibility(
                visible: _con.orderStatus,
                child: Container(
                    margin: EdgeInsets.only(top: 250, ),
                    child: CircularProgressIndicator()
                )
            ),
          ),
          _con.BusinessOrderList.length>0 && _con.orderStatus==false  ? Expanded(
            child: ListView.builder(
              // scrollDirection: Axis.vertical,
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _con.BusinessOrderList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 6.0,
                              color: Colors.black12.withOpacity(0.1),
                              spreadRadius: 2.0)
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _con.BusinessOrderList[index]["order_type"].toString()=="preorder" ? Padding(
                            padding: const EdgeInsets.only(top:8.0,bottom: 15),
                            child: Container(
                                height: 23,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Color(0xFF0dc89e),
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Center(child: Text("Pre Order",style: f14B,))),
                          ) : Container(),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order Id: #"+_con.BusinessOrderList[index]["order_id"].toString(),style: f15wB,),
                                  SizedBox(height: 3,),
                                  Text(DateFormat.yMMMd().format(DateTime.parse(
                                      _con.BusinessOrderList[index]["order_date"]))+"  |  "+DateFormat.jm().format(DateTime.parse(
                                      _con.BusinessOrderList[index]["order_date"])),style: f13g,),
                                ],
                              ),
                              Container(
                                  height: 23,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d8),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Center(child: Text(/*_con.BusinessOrderList[index]["order_status"].toString()*/"Pending",style: f13B,)))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_con.BusinessOrderList[index]["business_name"].toString(),style: f15wB,),
                                  SizedBox(height: 3,),
                                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on,size: 14,color: Colors.grey,),
                                      SizedBox(width: 1,),
                                      Text(_con.BusinessOrderList[index]["business_location"].toString(),style: f13g,),
                                    ],
                                  ),
                                ],
                              ),
                              Text("\u20B9 "+_con.BusinessOrderList[index]["amount"].toString(),style: f15yB,)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(color: Colors.grey[600],),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height:_con.BusinessOrderList[index]["products"].length.toDouble()* 20,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _con.BusinessOrderList[index]["products"].length,
                                itemBuilder: (context,item){
                                  return Container(
                                      child: Text(_con.BusinessOrderList[index]["products"][item]["products_name"]+"  x  "
                                          +_con.BusinessOrderList[index]["products"][item]["products_quantity"].toString(),style: f14w,)
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(color: Colors.grey[600],),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => FoodiOrderDetail(order: _con.BusinessOrderList[index]["order_id"].toString(),)
                              ));
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("View Details",style: f14wB,),
                                SizedBox(width: 2,),
                                Icon(Icons.keyboard_arrow_right,color: Colors.white,size: 22,)
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ) : _con.orderStatus == false ? Center(child: Padding(
            padding: const EdgeInsets.only(top:100.0),
            child: Text("No Orders Yet...",style: f15bB,),
          )):Container(height: 0,),
        ],
      ),
    /*  bottomNavigationBar: Container(
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
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      BusinessRestaurantTimeline(memberdate: widget.memberdate,pagid: widget.pagid,
                        timid: widget.timid,upld: false,)),);
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
                      builder: (context) => BusinessRestaurantChatList(memberdate: widget.memberdate,timid: widget.timid,pagid: widget.pagid,
                        myID: userid.toString(),myName: NAME.toString(),)
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
                        builder: (context) => RestaurantNewEntryForm(timid: widget.timid,pagid: widget.pagid,memberdate: widget.memberdate,)
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
                      builder: (context) => BusinessRestaurantProductListPage(memberdate: widget.memberdate,pagid: widget.pagid,timid: widget.timid,)
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
      ),*/
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