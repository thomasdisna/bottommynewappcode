import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_business_order_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_order_detail_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

class FoodiOrdersPage extends StatefulWidget {
  @override
  _FoodiOrdersPageState createState() => _FoodiOrdersPageState();
}

class _FoodiOrdersPageState extends StateMVC<FoodiOrdersPage> {

  HomeKitchenRegistration _con;
  _FoodiOrdersPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getFoodiOrderList();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
          _con.FoodiOrderList.length>0 && _con.orderStatus==false  ? Expanded(
            child: ListView.builder(
              // scrollDirection: Axis.vertical,
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _con.FoodiOrderList.length,
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
                          _con.FoodiOrderList[index]["order_type"].toString()=="preorder" ? Padding(
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
                                  Text("Order Id: #"+_con.FoodiOrderList[index]["order_id"].toString(),style: f17RB,),
                                  SizedBox(height: 3,),
                                  Text(DateFormat.yMMMd().format(DateTime.parse(
                                      _con.FoodiOrderList[index]["order_date"]))+"  |  "+DateFormat.jm().format(DateTime.parse(
                                      _con.FoodiOrderList[index]["order_date"])),style: f13g,),
                                ],
                              ),
                              Container(
                                  height: 23,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d8),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Center(child: Text(_con.FoodiOrderList[index]["order_status"].toString(),style: f13B,)))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_con.FoodiOrderList[index]["business_name"].toString(),style: f15wB,),
                                  SizedBox(height: 3,),
                                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on,size: 14,color: Colors.grey,),
                                      SizedBox(width: 1,),
                                      Text(_con.FoodiOrderList[index]["business_location"].toString(),style: f13g,),
                                    ],
                                  ),
                                ],
                              ),
                              Text("\u20B9 "+_con.FoodiOrderList[index]["amount"].toString(),style: f15yB,)
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
                            height:_con.FoodiOrderList[index]["products"].length.toDouble()* 20,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                itemCount: _con.FoodiOrderList[index]["products"].length,
                                itemBuilder: (context,item){
                                print("prrrooo index "+index.toString()+" proo lengthh "+_con.FoodiOrderList[index]["products"].length.toString());
                              return Container(
                                child: Text(_con.FoodiOrderList[index]["products"][item]["products_name"]+"  x  "
                                    +_con.FoodiOrderList[index]["products"][item]["products_quantity"].toString(),style: f14w,)
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
                                builder: (context) => FoodiUserOrderDetail(order: _con.FoodiOrderList[index]["order_id"].toString(),)
                              ));
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 23,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFffd55e),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Center(child: Text("Cancel Order",style: f14B,))),
                                Row(
                                  children: [
                                    Text("View Details",style: f14wB,),
                                    SizedBox(width: 2,),
                                    Icon(Icons.keyboard_arrow_right,color: Colors.white,size: 22,)
                                  ],
                                ),
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
    );
  }
}
