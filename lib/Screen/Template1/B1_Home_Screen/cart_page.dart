import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Data_Model/cartModel.dart';
import 'package:Butomy/FIREBASE/chatlist.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/New_Entry_Form.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/Payout_Screen/Delivery_Screen_T1.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends StateMVC<CartPage> {

  HomeKitchenRegistration _con;
  _CartPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  final List<cartModel> items = new List();

  @override
  void initState() {
    super.initState();
    _con.getCARTListControo(userid.toString());
    setState(() {
      items.add(
        cartModel(
          img: "assets/image/image_recipe/recipe1.jpg",
          id: 1,
          title: "Spaghetti Wok Carbonara",
          desc: "Chicken World Restaurant",
          price: 20,
        ),
      );
    });
  }

  /// Declare price and value for chart
  int value = 1;
  int pay = 20;
  int delivery = 4;
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
    elevation: 0.0,
  );
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
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
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>TimeLine(false)
                    ));
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
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/chat.png",
                        height: 21,
                        color: Colors.white54,
                        width: 21,
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
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/shopping-basket.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23,
                      ),
                      Text("Purchase",style: f14w54,)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>CartPage()
                    ));
                  },
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/Template1/image/Foodie/icons/cart.png",
                          height: 23, color: Color(0xFFffd55e), width: 23),
                      Text("Cart",style: f15y,)
                    ],
                  ),
                )
              ],
            ),
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
                      margin: EdgeInsets.only(top: 250, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            _con.CartList.length>0  && _con.statusCart==false ?  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //  _wallet,
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Container(
                    height: _con.CartList.length.toDouble()*84,
                    color: Color(0xFF23252E),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Item to Order",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                        Container(
                          height: _con.CartList.length.toDouble()*72,
                          child: ListView.builder(
                            itemCount: items.length,
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
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10.0),

                                              /// Image item
                                              child: Container(
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
                                                  child: Image.asset(
                                                    '${items[index].img}',
                                                    height: 90.0,
                                                    width: 90.0,
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
                                                  Container(
                                                    width: 200.0,
                                                    child: Text(
                                                      '${items[index].title}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,

                                                          color: Colors.white,
                                                          fontSize: 16.0),
                                                      overflow: TextOverflow.clip,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Text(
                                                    '${items[index].desc}',
                                                    style: TextStyle(
                                                      fontSize: 13,

                                                      color: Colors.grey,
                                                    ),
                                                    overflow:
                                                    TextOverflow.ellipsis,
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
                                                          "\u20B9" +
                                                              '${items[index].price}',
                                                          style: TextStyle(
                                                              color: Colors.white,

                                                              fontSize: 16.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                      ),
                                                      Padding(
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
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    value =
                                                                        value - 1;
                                                                    value =
                                                                    (value > 0
                                                                        ? value
                                                                        : 0);
                                                                    pay = items[index]
                                                                        .price *
                                                                        value;
                                                                    total = pay +
                                                                        delivery;
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
                                                                  value
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
                                                                    value =
                                                                        value + 1;
                                                                    pay = items[index]
                                                                        .price *
                                                                        value;
                                                                    total = pay +
                                                                        delivery;
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
                                                      ),
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
                            scrollDirection: Axis.vertical,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 5.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Order ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        " \u20B9 " + pay.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 5.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Delivery ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        " \u20B9 " + delivery.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(color: Colors.black87,thickness: 1,),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Total ",
                        style: TextStyle(
                            color: Colors.white,

                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        " \u20B9 " + total.toString(),
                        style: TextStyle(
                            color: Colors.white,

                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                DeliveryScreenT1()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 15.0,
                        top: 20.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 38.0,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            color: _colorsButton1),
                        child: Center(
                          child: Text(
                            _payButton,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ) :
            _con.statusCart == false ? Center(child: Padding(
              padding: const EdgeInsets.only(top:250.0),
              child: Text("No Items Added",style: f16wB,),
            )) : Container(height: 0,),
          ],
        ));
  }
}