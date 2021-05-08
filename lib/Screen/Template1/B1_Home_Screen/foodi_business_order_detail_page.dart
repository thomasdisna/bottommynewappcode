import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

class FoodiOrderDetail extends StatefulWidget {

  FoodiOrderDetail({this.order});

  String order;

  @override
  _FoodiOrderDetailState createState() => _FoodiOrderDetailState();
}

class _FoodiOrderDetailState extends StateMVC<FoodiOrderDetail> {

  HomeKitchenRegistration _con;
  _FoodiOrderDetailState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.foodiOrderDetail(widget.order);
  }

  @override
  Widget build(BuildContext context) {


    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;

    return Scaffold(backgroundColor: Color(0xFF1E2026),
      appBar:  AppBar(
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
      body: _con.orderDetailStatus==false && _con.OrderDetail!=null ?
      SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /////
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 9,bottom: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "#"+_con.OrderDetail["order_id"].toString(),
                                  style: f16B,),
                                SizedBox(height: 3,),
                                Text(DateFormat.yMMMd().format(DateTime.parse(
                                    _con.OrderDetail["order_date"]))+"  |  "+DateFormat.jm().format(DateTime.parse(
                                    _con.OrderDetail["order_date"])),style: f13,),

                              ],
                            ),
                            Column(
                              children: [
                                Container(width: MediaQuery.of(context).size.width/2.8,
                                  color: _con.OrderDetail["order_status"].toString()=="1"  ? Colors.orange[700] :_con.OrderDetail
                                  ["order_status"].toString()=="5" ?
                                  Colors.blue[700] : _con.OrderDetail["order_status"].toString()=="6" ? Colors.green[400] : Colors.transparent,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 20, top:  5,bottom: 5),
                                    child: Text(
                                      _con.OrderDetail["order_status"].toString()=="1"  ? "NEW ORDER" :
                                      _con.OrderDetail["order_status"].toString()=="5"  ?"PREPARING" :
                                      _con.OrderDetail["order_status"].toString()=="6"  ? "READY" : "",
                                      style: f14wB,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text("\u20B9"+_con.OrderDetail["amount"].toString(),style: f18B,)
                              ],
                            ),
                          ],
                        ),
                      ),
                      _con.OrderDetail["order_type"].toString()=="preorder" ? SizedBox(
                        height: 10.0,
                      ) : Container(),
                      _con.OrderDetail["order_type"].toString()=="preorder" ? Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[400],
                        child: Padding(
                          padding: const EdgeInsets.only(left:30.0,right: 30.0,top: 8.0,bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Pre Order Pickup Schedule",
                                  style:f14
                              ),
                              Text(DateFormat.yMMMd().format(DateTime.parse(
                                  _con.OrderDetail["delivery_date"]))+"  |  "+DateFormat.jm().format(DateTime.parse(
                                  _con.OrderDetail["delivery_date"])),style: f13,),
                            ],
                          ),
                        ),
                      ) : Container(),
                      _con.OrderDetail["order_type"].toString()!="preorder" ? Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          color: Colors.grey[400],
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                        ),
                      ) : Container(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 12,),
                            Container(
                              height: _con.OrderDetail["products"].length.toDouble() * 50,
                              child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                                  itemCount: _con.OrderDetail["products"].length,
                                  itemBuilder: (context, item){
                                    return Container(height: 50,
                                      alignment: Alignment.centerLeft,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(width: width/1.6,
                                            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                    border:
                                                    Border.all(color:  _con.OrderDetail
                                      ["products_type"].toString()=="0" ? Colors.green[600] : Colors.red[600]),
                                                    borderRadius: BorderRadius.circular((2)),
                                                  ),
                                                  child: Icon(Icons.brightness_1,
                                                      color:  _con.OrderDetail
                                        ["products_type"].toString()=="0" ? Colors.green[600] : Colors.red[600], size: 8),
                                                ),
                                                SizedBox(width: 7,),
                                                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(_con.OrderDetail["products"][item]["products_name"],style: f16B,overflow: TextOverflow.ellipsis,),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Text(
                                                      "Biriyani - Chiken biriyani",
                                                      style:
                                                      f10g,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),

                                          Container(width: width/8,
                                              child: Text("X "+
                                              _con.OrderDetail["products"][item]["products_quantity"].toString(),style: f14)),
                                          Container(width: width/6,
                                              child: Text("\u20B9"+_con.OrderDetail["products"][item]["final_price"].toString(),style: f14,))
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey[400],
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:18.0,right: 8.0,top: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(width: width/2.2,
                                  child: Text(
                                    "Total",
                                    style: f15B,
                                  ),
                                ),
                                Container(width: width/6.2,
                                  child: Text(
                                    _con.OrderDetail["products"].length.toString()+" items",
                                    style: f15B,
                                  ),
                                ),
                                Container(width: width/7,
                                  child: Text(
                                    "₹"+(_con.OrderDetail["amount"]-_con.OrderDetail["delivery_charge"]-_con.OrderDetail["tax"]).toString(),
                                    style: f15B,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Packing Charges",style: f14B),
                                Text("₹4,550.00",style: f14B,)
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("GST",style: f14B),
                                Text("₹"+_con.OrderDetail["tax"].toString(),style: f14B)
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Discount",style: f14B,),
                                Text("₹0.00",style: f14B,)
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Container(
                        color: Colors.grey[400],
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                      ),
                      SizedBox(height: 5.0,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 19.0,right: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Bill",style: f18B,),
                            Text("₹"+_con.OrderDetail["amount"].toString(),style: f18B)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0,bottom: 10.0),
                        child: Text("Cooking Instruction :",style: f13B),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                        child: Text("Need biriyani spicy and write happy birthday faiizan in \nCake",style: TextStyle(color: Colors.black),),
                      ),
                      SizedBox(height: 20.0,),
                      _con.OrderDetail["order_status"].toString()=="1" ||
                          _con.OrderDetail["order_status"].toString()=="5" ? Center(
                        child: MaterialButton(height: 30,
                          splashColor: Color(0xFF48c0d8),
                          onPressed: (){
                            _con.OrderDetail["order_status"].toString()=="1" ?
                            _con.updateOrderStatus(_con.OrderDetail["order_id"].toString(), "5") :
                            _con.OrderDetail["order_status"].toString()=="5" ?
                            _con.updateOrderStatus(_con.OrderDetail["order_id"].toString(), "6") : null;
                            setState(() {
                              _con.OrderDetail["order_status"].toString()=="1" ? _con.OrderDetail["order_status"]=5:
                              _con.OrderDetail["order_status"].toString()=="5" ? _con.OrderDetail["order_status"]=6 :null;
                            });
                          },
                          color: _con.OrderDetail["order_status"].toString()=="1" ? Colors.green[400] : Colors.yellow[700],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 35, right: 35),
                            child: Text(
                              _con.OrderDetail["order_status"].toString()=="1" ? "ACCEPT ORDER"
                                  :_con.OrderDetail["order_status"].toString()=="5" ? "ORDER READY":
                              "",
                              style: f14wB,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ) : _con.OrderDetail["order_status"].toString()=="6" ?
                      Center(
                        child: Padding(
                          padding:  EdgeInsets.only(left: 35, right: 35,bottom:_con.OrderDetail["order_status"].toString()=="6" ||
                              _con.OrderDetail["order_status"].toString()=="5" ?0 : 5),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("FOOD READY",style: f14GGB,),
                              _con.OrderDetail["order_status"].toString()=="6" ||
                                  _con.OrderDetail["order_status"].toString()=="5" ? FlatButton(
                                onPressed: (){},
                                splashColor: Colors.grey[400],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Image.asset("assets/Template1/image/Foodie/icons/Delivery-Warrior.png",height: 20,color:_con.OrderDetail
                                    ["order_status"].toString()=="6" ? Colors.green[400] : Colors.black,),
                                    SizedBox(width: 10,),
                                    Text("Track Driver",style:_con.OrderDetail["order_status"].toString()=="6" ? f13GGB : f13B,)
                                  ],
                                ),
                              ) :Container(),
                            ],
                          ),
                        ),
                      ) : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}

Widget _circleBlue() {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        CircleAvatar(
          backgroundColor: Color(0xFF48c0d8),
          radius: 2.3
        ),
        SizedBox(
          height: 5.0,
        ),
        CircleAvatar(
          backgroundColor:Color(0xFF48c0d8),
          radius: 2.3
        ),
        SizedBox(
          height: 5.0,
        ),
        CircleAvatar(
          backgroundColor: Color(0xFF48c0d8),
          radius: 2.3
        ),
        SizedBox(
          height: 5.0,
        ),
        CircleAvatar(
          backgroundColor: Color(0xFF48c0d8),
          radius: 2.3
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    ),
  );
}

Widget _circleGrey() {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
        ),
        SizedBox(
          height: 5.0,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
        ),
        SizedBox(
          height: 5.0,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
        ),
        SizedBox(
          height: 5.0,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    ),
  );
}
