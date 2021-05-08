import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/Payout_Screen/Payment_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ConfirmOrderScreen extends StatefulWidget {
  ConfirmOrderScreen({this.time,this.date,this.email,this.lastname,
    this.address,this.pincode,this.phone,this.city,this.firstname,
    this.street,this.itemList,this.type,this.kitaddress,this.loc_name});
  
  String firstname,lastname,email,phone,street,address,city,pincode,type,kitaddress,loc_name;
  List itemList;
  String date;
  String time;


@override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends StateMVC<ConfirmOrderScreen> {

  HomeKitchenRegistration _con;
  _ConfirmOrderScreenState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "Confirm Order",
          style: TextStyle(
              fontFamily: "Sofia",
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFF1E2026),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Color(0xFFffd55e),
                  size: 22.0,
                ),
                _circleOrange(),
                Icon(
                  Icons.credit_card,
                  color: Color(0xFFffd55e),
                  size: 21.0,
                ),
                _circleOrange(),
                Icon(
                  Icons.check_circle,
                  color: Color(0xFFffd55e),
                  size: 21.0,
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Row(
                children: [ // Navigator.pop(context);
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width:30,
                        child: widget.loc_name=="Home" ?
                        Image.asset("assets/Template1/image/Foodie/icons/home.png",height: 16,width: 16,color: Colors.grey,) :
                        widget.loc_name=="Work" ?  Icon(Icons.work,color: Colors.grey,size: 18,) :
                        Icon(Icons.location_on,color: Colors.grey,size: 18,),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width-70,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Deliver to "+widget.loc_name,style: f15wB,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text(widget.address,style: f14g,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: Container(
                color: Color(0xFF23252E),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,),
                      child: Text(
                        "Order from "+widget.itemList[0]["business_name"].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Container(
                      height: widget.itemList[0]["products"].length.toDouble()*130,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.itemList[0]["products"].length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  left: 13.0,
                                  right: 13.0,
                                  bottom: 10.0),
                              /// Background Constructor for card
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(10.0),

                                          /// Image item
                                          child: Container(
                                              height: 80,width: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black12
                                                            .withOpacity(0.1),
                                                        blurRadius: 0.5,
                                                        spreadRadius: 0.1)
                                                  ]),
                                              child: CachedNetworkImage(
                                                imageUrl:  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                    widget.itemList[0]["products"][index]["products_image"][0]["source"].toString()+"?alt=media",
                                                fit: BoxFit.cover,
                                              ))),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0,
                                              left: 10.0,
                                              right: 5.0),
                                          child: Column(
                                            /// Text Information Item
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(top:5.0),
                                                child: Text(
                                                  widget.itemList[0]["products"][index]["products_name"].toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.white,
                                                      fontSize: 16.0),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 15.0),
                                                    child: Text(
                                                      widget.itemList[0]["products"][index]["customers_basket_quantity"].toString()+"  x  " +"\u20B9" +
                                                          widget.itemList[0]["products"][index]["final_price"].toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,

                                                          fontSize: 16.0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                  /*Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 18.0,
                                                        left: 0.0),
                                                    child: Container(
                                                      width: 112.0,
                                                      decoration:
                                                      BoxDecoration(
                                                          color: Color(
                                                              0xFF1E2026)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: <Widget>[
                                                          /// Decrease of value item
                                                          *//*InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                widget.itemList[0]["products"][index]["customers_basket_quantity"] =
                                                                    widget.itemList[0]["products"][index]["customers_basket_quantity"] - 1;
                                                                widget.itemList[0]["products"][index]["customers_basket_quantity"] =
                                                                (widget.itemList[0]["products"][index]["customers_basket_quantity"] > 0
                                                                    ? widget.itemList[0]["products"][index]["customers_basket_quantity"]
                                                                    : 0);
                                                                _con.EditPurchaseListItem( widget.itemList[0]["products"][index]["customers_basket_id"] .toString(),
                                                                    widget.itemList[0]["products"][index]["customers_basket_quantity"] .toString());
                                                                widget.itemList[0]["products"][index]["final_price"]=widget.itemList[0]["products"][index]["customers_basket_quantity"]*
                                                                    widget.itemList[0]["products"][index]["base_price"];

                                                                cartTotal=cartTotal-widget.itemList[0]["products"][index]["base_price"];
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 30.0,
                                                              width: 30.0,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                    0xFF1E2026),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                    "-",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                        fontSize:
                                                                        16.0),
                                                                  )),
                                                            ),
                                                          ),*//*
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                18.0),
                                                            child: Text(
                                                              widget.itemList[0]["products"][index]["customers_basket_quantity"]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,

                                                                  fontSize:
                                                                  16.0),
                                                            ),
                                                          ),

                                                          /// Increasing value of item
                                                          *//*InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                widget.itemList[0]["products"][index]["customers_basket_quantity"] =
                                                                    widget.itemList[0]["products"][index]["customers_basket_quantity"] + 1;
                                                                _con.EditPurchaseListItem( widget.itemList[0]["products"][index]["customers_basket_id"] .toString(),
                                                                    widget.itemList[0]["products"][index]["customers_basket_quantity"] .toString());
                                                                cartTotal=cartTotal+widget.itemList[0]["products"][index]["base_price"];
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 30.0,
                                                              width: 28.0,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xFF1E2026)),
                                                              child: Center(
                                                                  child: Text(
                                                                    "+",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontSize:
                                                                        16.0),
                                                                  )),
                                                            ),
                                                          ),*/
                                                  /*
                                                        ],
                                                      ),
                                                    ),
                                                  ),*/
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Tax (2.0%):",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            " \u20B9 " + ((cartTotal/100)*2).toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Delivery: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            " \u20B9 " + "4".toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:15,right: 15,bottom: 15),
                      child: Text("Total Amount: "+ (cartTotal+4+((cartTotal/100)*2)).toString(),style: f16bB,),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            if(widget.date==null && widget.time==null)
           {
             if(widget.type=="0") {
               _con.placeOrder(context,widget.itemList[0]["business_page_id"].toString(),widget.email,widget.address,widget.firstname,widget.lastname,
                widget.street,widget.city,widget.pincode,widget.phone);}
           else{
               _con.placeOrder2(context,widget.itemList[0]["business_page_id"].toString(),widget.email,widget.address,widget.firstname,widget.lastname,
                   widget.street,widget.city,widget.pincode,widget.phone,"Order from "+widget.itemList[0]["business_name"].toString());
             }
           }
            if(widget.date!=null && widget.time!=null){
              if(widget.type=="0")
             {
               _con.PreOrderplaceOrder(context,widget.itemList[0]["business_page_id"].toString(),widget.email,widget.address,widget.firstname,widget.lastname,
                  widget.street,widget.city,widget.pincode,widget.phone,widget.date,widget.time);
             }
              else{
                _con.PreOrderplaceOrder2(context,widget.itemList[0]["business_page_id"].toString(),widget.email,widget.address,widget.firstname,widget.lastname,
                    widget.street,widget.city,widget.pincode,widget.phone,widget.date,widget.time,"Order from "+widget.itemList[0]["business_name"].toString());
              }
            }
          },
          child: Container(
            height: 45.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Color(0xFF48c0d8)
            ),
            child: Center(
                child: Text(
                  "Check Out",
                  style: f16B,
                )),
          ),
        ),
      ),
    );
  }
}

Widget _circleWhite() {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 18.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 18.0,
      ),
    ],
  );
}

Widget _circleOrange() {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 18.0,
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFffd55e),
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFffd55e),
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFffd55e),
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFffd55e),
        radius: 2.0,
      ),
      SizedBox(
        width: 18.0,
      ),
    ],
  );
}
