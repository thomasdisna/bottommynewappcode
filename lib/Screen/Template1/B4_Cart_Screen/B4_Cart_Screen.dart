import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_cart_location_chooding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Data_Model/cartModel.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/FIREBASE/chatlist.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/CART-PAYMENTS-SCREENS/payment-detail-enter-screen.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/New_Entry_Form.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/bottom_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'Payout_Screen/Delivery_Screen_T1.dart';

class CartScreenT1 extends StatefulWidget {

  CartScreenT1(this.date,this.time,this.preoder);

  bool preoder;
  String date;
  String time;

  @override
  _CartScreenT1State createState() => _CartScreenT1State();
}

class _CartScreenT1State extends StateMVC<CartScreenT1> {

  HomeKitchenRegistration _con;
  _CartScreenT1State() : super(HomeKitchenRegistration()) {
    _con = controller;
  }


  @override
  void initState() {
    super.initState();
    _con.getCARTListControo(userid.toString());
    setState(() {

    });
  }

  TextEditingController _promoCodeController = TextEditingController();

  /// Declare price and value for chart
  int value = 1;
  int pay = 20;
  int delivery = 10;
  int total = 24;
  String _payButton = "Pay";
  Color _colorsButton1 = Color(0xFF48c0d8);
  Color _colorsButton2 = Color(0xFF48c0d8);
  @override
  var _appBar = AppBar(
    automaticallyImplyLeading: false,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    backgroundColor: Color(0xFF1E2026),
    title: Text(
      "My Order",
      style: TextStyle(
          fontFamily: "Sofia",
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.white),
    ),
    elevation: 5.0,
  );
/*
  var _wallet = Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 35.0,
          width: 80.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2.0,
                    spreadRadius: 3.0,
                    color: Color(0xFFFEE140).withOpacity(0.2))
              ],
             color: Color(0xFF48c0d8)),
          child: Center(
            child: Text(
              "Wallet",
              style: TextStyle(color: Colors.white, fontFamily: "Sofia"),
            ),
          ),
        ),
        Text(
          "\u20B9 62.00",
          style: TextStyle(
              color: Colors.white, fontFamily: "Sofia", fontSize: 17.0),
        )
      ],
    ),
  );
*/
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: Container(alignment: Alignment.bottomCenter,
          height: _con.CartList.length>0  && _con.statusCart==false  ? 110 : 56,
          child: Column(
            children: [
              _con.CartList.length>0  && _con.statusCart==false ?    Container(height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3,
                    left: 20.0,
                    right: 20.0,),
                  child: MaterialButton(
                    height: 38.0,
                    splashColor: Color(0xFF48c0d8),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                    ),
                    color: Color(0xFFffd55e),
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context) => PaymentRequestScreen(cartList: _con.CartList,date: widget.date!=null ?
                      //     widget.date : null,time:widget.time!=null ? widget.time : null,)
                      // ));
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) => FoodiCartAddressBookPage(cartList: _con.CartList,date: widget.date!=null ?
                              widget.date : null,time:widget.time!=null ? widget.time : null,)
                          ));
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u20B9"+cartTotal.toString(),
                          style: f16B,
                        ),
                        Row(
                          children: [
                            Text(
                              "Place Order",
                              style: f16B,
                            ),
                            Icon(Icons.arrow_right,size: 33)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ) : Container(),
              _con.CartList.length>0  && _con.statusCart==false ?  SizedBox(height: 12,) : Container(),
              Container(
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
                  padding: const EdgeInsets.only(top: 7,bottom: 7),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeLine(false)), (route) => false);
                        },
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/Template1/image/Foodie/icons/home.png",
                              height: 23,
                              color: Colors.white54,
                              width: 23,
                            ),
                            Text("Home",style: f14w54,)
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ChatList(timelineIdFoodi.toString(),NAME)
                          ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(alignment: Alignment.topRight,
                              children: [
                                Container(width: 38,
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/chat.png",
                                    height: 21,
                                    color: Colors.white54,
                                    width: 21,
                                  ),
                                ),
                                chatmsgcount>0 ?    Container(
                                  height: 14,width: 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0dc89e),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(child: Text(chatmsgcount.toString(),style: f10B,textAlign: TextAlign.center,)),
                                ) : Container()
                              ],
                            ),
                            Text("Chat",style: f14w54,)
                          ],
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 42,
                        child: FloatingActionButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>AddNewEntries(videooo: "",vid_show: false,typpp: "",)
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
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>purchase()
                          ));
                        },
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(alignment: Alignment.topRight,
                              children: [
                                Container(width: 40,
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/shopping-basket.png",
                                    height: 23,
                                    color: Colors.white54,
                                    width: 23,
                                  ),
                                ),
                                purchasecount>0 ? Container(
                                  height: 14,width: 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0dc89e),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(child: Text(purchasecount.toString(),style: f10B,textAlign: TextAlign.center,)),
                                ) : Container()
                              ],
                            ),
                            Text("Bucket list",style: f14w54,)
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(alignment: Alignment.topRight,
                              children: [
                                Container(width: 38,
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/cart.png",
                                    height: 23,
                                    color: Color(0xFFffd55e),
                                    width: 23,
                                  ),
                                ),
                                cartCount > 0 ? Container(
                                  height: 14, width: 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0dc89e),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(child: Text(
                                    cartCount.toString(), style: f10B,
                                    textAlign: TextAlign.center,)),
                                ) : Container()
                              ],
                            ),
                            Text("Cart",style: f14y,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFF1E2026),
        appBar: _appBar,
        body:  Column(
          children: [
            Center(
              child: Visibility(
                  visible: _con.statusCart,
                  child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
          _con.CartList.length>0  && _con.statusCart==false ?  Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,top: 20,right: 20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(clipBehavior: Clip.antiAlias,
                                height: 37,width: 37,
                                decoration: BoxDecoration(
                                  // color: Color(0xFF0dc89e),
                                  borderRadius: BorderRadius.circular(100)
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:_con.CartList[0]["business_profile_image"]!=null ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.CartList[0]["business_profile_image"]+"?alt=media" : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                ),
                              ),
                              SizedBox(width: 7,),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_con.CartList[0]["business_name"].toString(),
                                    style: f16wB,),
                                  SizedBox(height: 2,),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,size: 13,color: Colors.grey,),
                                      Text(_con.CartList[0]["business_address"].toString(),
                                        style: f13g,),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          MaterialButton(
                            onPressed: (){
                              _con.removeCartList();
                            },
                            height: 30,
                            color: Color(0xFFffd55e),
                            splashColor: Color(0xFF48c0d8),
                            child: Text("Clear Cart",style: f14B,),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                      child: Container(
                        color: Color(0xFF23252E),
                        child: Container(
                          height: _con.CartList[0]["products"].length.toDouble()*63,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _con.CartList[0]["products"].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                    left: 13.0,
                                    right: 16.0,),
                                /// Background Constructor for card
                                child: Row( mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: /* _con.OrderDetail
                                              ["products_type"].toString()=="0" ? Colors.green[600] : */Colors.red[600]),
                                              borderRadius: BorderRadius.circular((2)),
                                            ),
                                            child: Icon(Icons.brightness_1,
                                                color:  /*_con.OrderDetail
                                                ["products_type"].toString()=="0" ? Colors.green[600] : */Colors.red[600], size: 8),
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              _con.CartList[0]["products"][index]["products_name"].toString(),
                                              style:f16wB,
                                              overflow: TextOverflow.clip,
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              "\u20B9" +
                                                  _con.CartList[0]["products"][index]["final_price"].toString(),
                                              style: f15wB,
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    Container(
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
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _con.CartList[0]["products"][index]["customers_basket_quantity"] =
                                                    _con.CartList[0]["products"][index]["customers_basket_quantity"] - 1;
                                                _con.CartList[0]["products"][index]["customers_basket_quantity"] =
                                                (_con.CartList[0]["products"][index]["customers_basket_quantity"] > 0
                                                    ? _con.CartList[0]["products"][index]["customers_basket_quantity"]
                                                    : 0);
                                                _con.EditPurchaseListItem( _con.CartList[0]["products"][index]["customers_basket_id"] .toString(),
                                                    _con.CartList[0]["products"][index]["customers_basket_quantity"] .toString());
                                                _con.CartList[0]["products"][index]["final_price"]=_con.CartList[0]["products"][index]["customers_basket_quantity"]*
                                                    _con.CartList[0]["products"][index]["base_price"];

                                                cartTotal=cartTotal-_con.CartList[0]["products"][index]["base_price"];
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
                                          ),
                                          Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal:
                                                18.0),
                                            child: Text(
                                              _con.CartList[0]["products"][index]["customers_basket_quantity"]
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
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _con.CartList[0]["products"][index]["customers_basket_quantity"] =
                                                    _con.CartList[0]["products"][index]["customers_basket_quantity"] + 1;
                                                _con.EditPurchaseListItem( _con.CartList[0]["products"][index]["customers_basket_id"] .toString(),
                                                    _con.CartList[0]["products"][index]["customers_basket_quantity"] .toString());
                                                cartTotal=cartTotal+_con.CartList[0]["products"][index]["base_price"];
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF22252e),
                      ),

                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(  width: MediaQuery.of(context).size.width/2,
                            height: 30,
                            child: TextField(style: f13w,
                              decoration: InputDecoration(
                                hintStyle: f13b,
                                hintText: "Add cooking instructions (Optional)",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF48c0d8))
                                ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF48c0d8))
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                           left: 20.0, right: 5.0,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("PROMOCODE",style: f15wB,),
                          MaterialButton(
                            onPressed: (){},
                            splashColor: Color(0xFF48c0d8),
                            height: 25,minWidth: 30,
                            child: Text(
                              "View Promocode",
                              style: f13y,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: 42,
                            width: MediaQuery.of(context).size.width - 150,
                            child: TextField(
                              style: f14w,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
                                hintText: "Enter promo code",
                                hintStyle: f13g,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF0bc9e6),
                                    width: 1.0,
                                  ),
                                ),
                                //for focusing the border in blue color with thickness
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF0bc9e6),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              controller: _promoCodeController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: MaterialButton(
                              splashColor: Color(0xFFffd55e),
                                height: 30.0,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                            ),
                                onPressed: () {},
                                color: Color(0xFF0bc9e6),
                                child: Text(
                                  "APPLY",
                                  style: f13bb,
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      color: Color(0xFF22252e),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 20),
                        child: Center(child: Text("You have saved ₹50 on the bill",style: f14w,)),
                      ),
                    ),
                         Padding(
                      padding: EdgeInsets.only(top: 15,left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Item Total",
                            style: f15w,
                          ),
                          Text(
                            "\u20B9"+cartTotal.toString(),
                            style: f15wB,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0,top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Delivery partner fee",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              decoration: TextDecoration.underline
                               ),
                          ),
                          Text(
                            "\u20B9" + delivery.toString(),
                            style: f15wB,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only( left: 20.0, right: 20,top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Taxes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.underline
                            ),
                          ),
                          Text(
                            "\u20B9" +((cartTotal/100)*2).toString(),
                            style: f15wB,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only( left: 20.0, right: 20,top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Applied Discount",
                            style: f15w,
                          ),
                          Text(
                            "- \u20B950",
                            style: TextStyle(
                              color: Colors.green[500],
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Divider(color: Colors.grey[600],thickness: .3,),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only( left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "To Pay",
                            style: f16wB,
                          ),
                          Text(
                            "\u20B9" + (cartTotal+delivery+((cartTotal/100)*2)).toString(),
                            style: f16wB,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Divider(color: Colors.grey[600],thickness: .3,),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only( left: 20.0, right: 20.0),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset("assets/Template1/image/Foodie/icons/file.png",height: 25,color: Colors.white,),
                          SizedBox(width: 5,),
                          RichText(
                            text: TextSpan(
                              text: "Review your order and address details to avoid\ncancellation",
                              style: f14w,
                              children: [
                                TextSpan(text: " Read Policy",style: f14b)
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    )

                  ],
                ),
            ),
          ) :
          _con.statusCart == false ? Center(child: Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/2.5),
            child: Text("No Items Added",style: f16wB,),
          )) : Container(height: 0,),
          ],
        ));
  }
}