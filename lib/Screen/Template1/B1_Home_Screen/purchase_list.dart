import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/FIREBASE/chatlist.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'New_Entry_Form.dart';

class purchase extends StatefulWidget {
  @override
  _purchaseState createState() => _purchaseState();
}

var s= "unlike";
var value1 = 1;
var price1 = 210;
var pay1=210;
int value2 = 1;
double price2 = 180;
double pay2=180;
int value3 = 1;
double price3 = 110;
double pay3=110;

class _purchaseState extends StateMVC<purchase> {

  HomeKitchenRegistration _con;
  _purchaseState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  @override
  void initState() {
    // setState(() {
    //   _con.PurchaseList= PURCHASELIST;
    // });
    _con.getPurchaseList(userid.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
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
                          chatmsgcount>0 ?   Container(
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
                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(alignment: Alignment.topRight,
                      children: [
                        Container(width: 40,
                          child: Image.asset(
                            "assets/Template1/image/Foodie/icons/shopping-basket.png",
                            height: 23,
                            color: Color(0xFFffd55e),
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
                    Text("Bucket list",style: f14y,)
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>CartScreenT1(null,null,false)
                    ));
                  },
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(alignment: Alignment.topRight,
                        children: [
                          Container(width: 38,
                            child: Image.asset(
                              "assets/Template1/image/Foodie/icons/cart.png",
                              height: 23,
                              color: Colors.white54,
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
                      Text("Cart",style: f14w54,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFF1E2026),
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          title: Text("Purchase List",style:TextStyle(color:Colors.white),),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Visibility(
                  visible: _con.statusPurchase,
                  child: Container(
                      margin: EdgeInsets.only(top: 250, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            _con.PurchaseList.length>0  ?
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: _con.PurchaseList.length,
                      itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color:Color(0xFF1E2026),  boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors
                                  .black
                                  .withOpacity(
                                  0.4),
                              spreadRadius: 2.0)
                        ],
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))
                              ),
                              //color: Colors.amber,
                              child:   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Container(clipBehavior: Clip.antiAlias,
                                          height: 37,width: 37,
                                          decoration: BoxDecoration(
                                            // color: Color(0xFF0dc89e),
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:_con.PurchaseList[index]["business_profile_image"]!=null ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.PurchaseList[index]["business_profile_image"]+"?alt=media" : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                          ),
                                        ),
                                        SizedBox(width: 7,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              _con.PurchaseList[index]["business_name"].toString(),
                                              style: f16wB,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                _con.PurchaseList[index]["business_address"].toString(),
                                              style: f14w,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  userid.toString() != _con.PurchaseList[index]["user_id"].toString()?  GestureDetector(
                                        onTap: (){
                                          try {
                                            String chatID = makeChatId(
                                                timelineIdFoodi
                                                    .toString(),
                                                _con.PurchaseList[index]["business_timeline_id"].toString());
                                            Navigator
                                                .push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) =>
                                                        ChatRoom(
                                                            timelineIdFoodi.toString(),
                                                            NAME,
                                                            _con.PurchaseList[index]["business_device_token"].toString(),
                                                            _con.PurchaseList[index]["business_timeline_id"].toString(),
                                                            chatID,
                                                            _con.PurchaseList[index]["business_username"].toString(),
                                                            _con.PurchaseList[index]["business_name"].toString(),
                                                            _con.PurchaseList[index]["business_profile_image"]!=null ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                 _con.PurchaseList[index]["business_profile_image"].toString() +
                                                                "?alt=media" : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media" ,
                                                            "")));
                                          } catch (e) {
                                            print(e
                                                .message);
                                          }
                                        },
                                        child: Icon(Icons.chat,color: Color(0xFFffd55e),size: 25,)) : Container()
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                           Container(
                             height: _con.PurchaseList[index]["products"].length.toDouble() *45,
                             child: ListView.builder(
                                 itemCount: _con.PurchaseList[index]["products"].length,
                                 itemBuilder: (context,ind){
                               return  Container(
                                   height: 40,
                                   width: MediaQuery.of(context).size.width,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       Padding(
                                         padding: const EdgeInsets.only(left: 13,right: 13),
                                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             Container(width: MediaQuery.of(context).size.width/2.3,
                                               child: Text(_con.PurchaseList[index]["products"][ind]["products_name"].toString(),
                                                 style: f14w,overflow: TextOverflow.ellipsis,maxLines: 1,
                                               ),
                                             ),
                                             Text("\u20B9"+ (_con.PurchaseList[index]["products"][ind]["base_price"]*
                                                 _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"]).toString(), style: f14y),
                                             Container(
                                               width: 70.0,
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
                                                         _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"] =
                                                             _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"] - 1;
                                                         _con.PurchaseList[index]["products"][ind]["final_price"]= _con.PurchaseList[index]["products"][ind]["base_price"]*
                                                             _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"];
                                                         _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"] =
                                                         ( _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"] > 0
                                                             ?  _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"]
                                                             : 0);

                                                       });
                                                       _con.EditPurchaseListItem( _con.PurchaseList[index]["products"][ind]["customers_basket_id"].toString(),
                                                           _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"].toString());
                                                     },
                                                     child: Container(
                                                       height: 24.0,
                                                       width: 30.0,
                                                       decoration:
                                                       BoxDecoration(
                                                         color: Color(
                                                             0xFF1E2026),
                                                       ),
                                                       child: Center(
                                                           child: Text(
                                                             "-",
                                                             style: f15wB,
                                                           )),
                                                     ),
                                                   ),
                                                   Text(
                                                     _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"]
                                                         .toString(),
                                                     style: TextStyle(
                                                         color: Colors
                                                             .white,
                                                         fontWeight:
                                                         FontWeight
                                                             .w800,
                                                         fontFamily:
                                                         "Sofia",
                                                         fontSize:
                                                         14.0),
                                                   ),

                                                   /// Increasing value of item
                                                   InkWell(
                                                     onTap: () {
                                                       setState(() {
                                                         _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"] =
                                                             _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"] + 1;
                                                         _con.PurchaseList[index]["products"][ind]["final_price"]= _con.PurchaseList[index]["products"][ind]["base_price"]*
                                                             _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"];
                                                       });
                                                       _con.EditPurchaseListItem( _con.PurchaseList[index]["products"][ind]["customers_basket_id"].toString(), _con.PurchaseList[index]["products"][ind]["customers_basket_quantity"].toString());
                                                     },
                                                     child: Container(
                                                       height: 24.0,
                                                       width: 28.0,
                                                       decoration: BoxDecoration(
                                                           color: Color(
                                                               0xFF1E2026)),
                                                       child: Center(
                                                           child: Text(
                                                             "+",
                                                             style: f15wB,
                                                           )),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),

                                           ],
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 16.0,right: 16),
                                         child: Divider(color: Colors.black87,thickness: 1,),
                                       ),
                                     ],
                                   ));
                             }),
                           ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0,bottom: 15,top: 10),
                                  child: Container(
                                    height: 25.0,
                                    child: MaterialButton(
                                      splashColor: Color(0xFFffd55e),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      height: 25.0,
                                      minWidth: 80.0,
                                      color: Colors.red,
                                      onPressed:(){
                                        _con.removePurchase(_con.PurchaseList[index]["business_page_id"].toString());
                                      },
                                      child: Center(
                                        child: Text(
                                          "Delete",
                                          style: f14B,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0,bottom: 15,top: 10),
                                  child: Container(
                                    height: 25.0,
                                    child: MaterialButton(
                                      splashColor: Color(0xFFffd55e),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      height: 25.0,
                                      minWidth: 80.0,
                                      color: Color(0xFF48c0d8),
                                      onPressed:(){
                                        _con.AddToCartControo(context,_con.PurchaseList[index]["business_page_id"].toString(),userid.toString(), _con.PurchaseList[index]["business_name"], _con.PurchaseList[index]["business_address"],_con.PurchaseList[index]["products"][0]["products_name"].toString(),_con.PurchaseList[index]["products"].length);
                                      },
                                      child: Center(
                                        child: Text(
                                          "Check Out",
                                          style: f14wB,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                )
                : _con.PurchaseList.length==0 &&   _con.statusPurchase == false ?
            Center(child:
            Padding(
    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/2.5),
    child: Text("No Items Added",style: f16wB,),
    )) :
            Container(height: 0,),
          ],
        ));
  }
}