import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

class FoodiMarketDetailPage extends StatefulWidget {

  FoodiMarketDetailPage({this.product_id,this.itemname,this.price});
  String product_id,itemname,price;

  @override
  _FoodiMarketDetailPageState createState() => _FoodiMarketDetailPageState();
}
DateTime _date;
var d;
class _FoodiMarketDetailPageState extends StateMVC<FoodiMarketDetailPage> {
  Completer<GoogleMapController> _controller = Completer();

  String createDate;
  bool textSpan;

  HomeKitchenRegistration _con;

  _FoodiMarketDetailPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  @override
  void initState() {
    setState(() {
      textSpan=false;
    });
    print("prod :"+widget.product_id);
    _con.BusinessEveryItemDetailPage(widget.product_id.toString());
    _con.FoodiMarketTimelineWalls1();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post', "https://saasinfomedia.com/foodiz/public/sharepost/"+_con.ProductDetail["post_id"].toString(), 'text/plain');
    } catch (e) {
      //print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if(_con.ProductDetail!=null) {
      setState(() {
        widget.itemname = _con.ProductDetail["kitchen_item_name"].toString();
        widget.price = _con.ProductDetail["kitchen_item_amount"].toString();
      });
      _date = DateTime.parse(
          _con.ProductDetail['created_at']);
      createDate = DateFormat.yMMMd().format(_date);
      var c =
          DateTime
              .now()
              .difference(_date)
              .inHours;
      setState(() {
        c > 24 && c <= 48
            ? d = "Yesterday" : c < 25 && c>0  ?
        d = DateTime
            .now()
            .difference(_date)
            .inHours
            .toString() +
            " hrs ago"
            : c == 0
            ? d = DateTime
            .now()
            .difference(_date)
            .inMinutes
            .toString() +
            " mints ago"
            :  d = DateTime
            .now()
            .difference(_date)
            .inDays.toString()+" days ago";
      });
    }
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        elevation: 5,
        title: widget.itemname!= null && widget.itemname != "" ?
        Text(widget.itemname.toUpperCase()+" @ Rs."+widget.price,style: TextStyle(color: Colors.white),) : Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),
      ),

      body: _con.ProductDetail!=null ? SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _con
                .ProductDetail
            ['kitchen_item_image']
                .length >
                0 && _con
                .ProductDetail
            ['kitchen_item_image']
                .length == 1
                ? Container(
              height: 250,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: CachedNetworkImage(
                  imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                      _con.ProductDetail[
                      "kitchen_item_image"]
                      [0]['source']
                          .toString()
                          .replaceAll(
                          " ", "%20") +
                      "?alt=media",
                  fit: BoxFit.cover,
                  placeholder: (context,
                      ind) => Image.asset(
                    "assets/Template1/image/Foodie/post_dummy.jpeg",
                    fit: BoxFit.cover,)
              ),
            ) : _con
                .ProductDetail
            ['kitchen_item_image']
                .length >
                0 && _con
                .ProductDetail
            ['kitchen_item_image']
                .length > 1 ?
            Container(
                height: 250.0,
                child: new Carousel(
                  boxFit: BoxFit.fill,
                  dotColor: Colors.black,
                  dotSize: 5.5,
                  autoplay: false,
                  dotSpacing: 16.0,
                  dotIncreasedColor: Color(
                      0xFF48c0d8),
                  dotBgColor: Colors
                      .transparent,
                  showIndicator: true,
                  overlayShadow: true,
                  overlayShadowColors: Colors
                      .white
                      .withOpacity(0.2),
                  overlayShadowSize: 0.9,
                  images: _con
                      .ProductDetail
                  ['kitchen_item_image'].map((
                      item) {
                    return new CachedNetworkImage(
                      placeholder: (context,
                          ind) =>
                          Image.asset(
                            "assets/Template1/image/Foodie/post_dummy.jpeg",
                            fit: BoxFit
                                .cover,),
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                          item['source']
                              .toString()
                              .replaceAll(
                              " ", "%20") +
                          "?alt=media",
                      imageBuilder: (
                          context,
                          imageProvider) =>
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit
                                    .cover,
                              ),
                            ),
                          ),
                    );
                  }).toList(),
                ))
                : Container(height: 0,),
            Container(height: 43,
              // color: Color(0xFF23252E),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 28,
                        width: 90,alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Color(0xFFffd55e),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:12.0),
                          child: Text("\u20B9 "+_con
                              .ProductDetail
                          ['kitchen_item_amount'].toString(),style: f14B,),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              _con.likePostTime(
                                  userid
                                      .toString(),
                                  _con
                                      .ProductDetail
                                  ["post_id"].toString());
                              if(_con
                                  .ProductDetail
                              ["is_liked"]==true){
                                setState(() {
                                  _con
                                      .ProductDetail
                                  ["is_liked"]=false;
                                });
                              }
                              else
                                setState(() {
                                  _con
                                      .ProductDetail
                                  ["is_liked"]=true;
                                });
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  _con
                                      .ProductDetail
                                  ["is_liked"]==true ? Icons.favorite :  Icons.favorite_border,
                                  color: _con
                                      .ProductDetail
                                  ["is_liked"]==true ? Color(0xFFffd55e) : Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                    _con
                                        .ProductDetail
                                    ["is_liked"]==true ? "Liked" :  "Like",
                                    style: f14w
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () async {
                              _shareText();
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/Template1/image/Foodie/icons/share.png",
                                  height: 16,
                                  width: 16,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Share",
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on,color: Colors.white,size: 16,),
                      SizedBox(width: 3,),
                      Text(_con.ProductDetail["location"].toString().length>30 ?
                      _con.ProductDetail["location"].toString().substring(0,30)+"..." :
                      _con.ProductDetail["location"].toString(),style: f13w,)
                    ],
                  ),
                  Text(createDate,style: f13w,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 15),
              child: Container(
                // color: Color(0xFF23252E),
                child: RichText(
                  text: TextSpan(
                      text:textSpan==true && _con
                          .ProductDetail
                      ['products_description'].toString().length>130 ?  _con
                          .ProductDetail
                      ['products_description'].toString() : textSpan==false && _con
                          .ProductDetail
                      ['products_description'].toString().length>130 ? _con
                          .ProductDetail
                      ['products_description'].toString().substring(0,130) :  _con
                          .ProductDetail
                      ['products_description'].toString(),
                      style: f14w,
                      children: [
                        _con
                            .ProductDetail
                        ['products_description'].toString().length>130 ?  TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=(){
                              setState(() {
                                textSpan==true ? textSpan=false : textSpan=true;
                              });
                            },
                            text:textSpan==true ? " Read less..." : " Read more...",
                            style: f14GB
                        ) : TextSpan(text: "")
                      ]
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 10,top: 0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Category :  ",style: f15wB,),
                      Text("Cooked Food",style: f15w,),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Qty :  ",style: f15wB,),
                      Text(_con
                          .ProductDetail
                      ['products_quantity'].toString(),style: f15w,),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 5),
              child: Container(color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          Container(clipBehavior: Clip.antiAlias,
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: CachedNetworkImage(
                              imageUrl: _con
                                  .ProductDetail
                              ['kitchen_user_image']+"?alt=media",
                            ),
                          ),
                          SizedBox(width: 7,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_con
                                  .ProductDetail
                              ['kitchen_page_name']+" is Listed",style: f15w),
                              SizedBox(height: 3,),
                              Text("Added "+d.toString(),style: f14g,),
                              SizedBox(height: 3,),
                              GestureDetector(
                                  onTap: (){
                                    Navigator
                                        .push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                TimelineFoodWallDetailPage(
                                                  id:_con
                                                      .ProductDetail["kitchen_user_id"]
                                                      .toString(),
                                                )));
                                  },
                                  child: Text("View Foodie Profile",style: f14yB,))
                            ],
                          )
                        ],
                      ),
                      userid.toString()!= _con
                          .ProductDetail["kitchen_user_id"].toString() ? GestureDetector(
                          onTap: () {
                            try {
                              String chatID = makeChatId(
                                  timelineIdFoodi
                                      .toString(),
                                  _con
                                      .ProductDetail["timeline_parent_id"].toString());
                              Navigator
                                  .push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (
                                          context) =>
                                          ChatRoom(
                                              timelineIdFoodi.toString(),
                                              NAME,
                                              _con
                                                  .ProductDetail["kitchen_user_device_token"],
                                              _con
                                                  .ProductDetail["timeline_parent_id"].toString(),
                                              chatID,
                                              _con
                                                  .ProductDetail["kitchen_user_username"].toString(),
                                              _con
                                                  .ProductDetail["kitchen_user_name"].toString(),
                                              _con
                                                  .ProductDetail["kitchen_user_image"].toString()
                                                  .replaceAll(
                                                  " ",
                                                  "%20") +
                                                  "?alt=media",
                                              "")));
                            } catch (e) {
                              print(e
                                  .message);
                            }
                          },
                          child: Icon(
                            Icons.chat,
                            size: 22,
                            color: Color((0xFFffd55e)),
                          )) : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 15,bottom: 5),
              child: Text("Approx Location",style: f14wB),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[800],
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(_con.ProductDetail["location_lat"]), double.parse(_con.ProductDetail["location_long"])),
                      zoom: 12.4746,
                    ),zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: null,
                    // circles: Set.from([Circle(
                    //     circleId: CircleId("1"),
                    //     center:/*currentLocation!=null ?  LatLng(currentLocation.latitude  ,  currentLocation.longitude) :*/
                    //     LatLng(double.parse(_con.ProductDetail["location_lat"]), double.parse(_con.ProductDetail["location_long"])),
                    //     radius: 90,strokeColor: Color(0xFF48c0d8),
                    //     strokeWidth: 3
                    // )]),
                  )),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8,right: 8,bottom: 10),
                  child: Text("Get Direction",style: f14wB,),
                ),
              ],
            ),

            Container(color: Colors.white,
              height: 250,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Admob",style: f16B,)),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left:8,right: 8,bottom: 0),
              child: Text("Related Items",style: f15wB,),
            ),
            Container(height: 262,
              alignment: Alignment.center,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: _con.TimFoodMarket.length,
                  itemBuilder:(context,indexxx){
                return widget.product_id!=_con.TimFoodMarket[indexxx]["kitchen_item_id"].toString() ?
                Padding(
                  padding:  EdgeInsets.only(top: 0,left: 5,right: 5),
                  child: Center(
                    child: Container(
                      height: 240,
                      width: 170,
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context)=>FoodiMarketDetailPage(
                                price: _con.TimFoodMarket[indexxx]["kitchen_item_amount"].toString(),
                                itemname: _con.TimFoodMarket[indexxx]["kitchen_item_name"].toString(),
                                product_id: _con.TimFoodMarket[indexxx]["kitchen_item_id"].toString(),)
                          ));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             FoodBankDetailPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF1E2026),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(4.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.8),
                                    blurRadius: 8.0,
                                    spreadRadius: 0.0)
                              ]),
                          child: Container(
                            // color: Colors.white.withOpacity(0.5),
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 6, left: 3, right: 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: <Widget>[
                                    CachedNetworkImage(
                                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                          _con
                                              .TimFoodMarket[indexxx]["kitchen_item_image"][0]["source"] +
                                          "?alt=media",
                                      imageBuilder: (context,
                                          imageProvider) =>
                                          Container(
                                            height: 110,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                color: Colors.black12,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(2.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 5.0,
                                                      color: Colors
                                                          .black12
                                                          .withOpacity(
                                                          0.1),
                                                      spreadRadius: 2.0)
                                                ]
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          Container(
                                            height: 110,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                color: Colors.black12,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(2.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 5.0,
                                                      color: Colors
                                                          .black12
                                                          .withOpacity(
                                                          0.1),
                                                      spreadRadius: 2.0)
                                                ]
                                            ),
                                          ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, top: 3, right: 0.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(_con
                                                .TimFoodMarket[indexxx]["kitchen_item_name"].toString().length>19 ? _con
                                                .TimFoodMarket[indexxx]["kitchen_item_name"].toString().substring(0,19)+" ..."
                                                : _con.TimFoodMarket[indexxx]["kitchen_item_name"].toString()
                                                /*"Food Box for neddy 15 Boxes"
                                                              .substring(0, 22) +
                                                              "..."*/,
                                                style: f14wB),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/Template1/image/Foodie/icons/eye.png",
                                                  height: 18,
                                                  width: 18,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text("1585 Views",
                                                    style: f12w)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (
                                                            context) =>
                                                            TimelineFoodWallDetailPage(
                                                              id: _con
                                                                  .TimFoodMarket[indexxx]['user_id']
                                                                  .toString(),
                                                            )));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height: 30.0,
                                                    width: 30.0,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image:
                                                            CachedNetworkImageProvider(
                                                                _con
                                                                    .TimFoodMarket[indexxx]["busprofileimage"]+"?alt=media"
                                                            ),
                                                            fit: BoxFit
                                                                .cover),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                180.0))),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        Text(
                                                          _con
                                                              .TimFoodMarket[indexxx]["busname"],
                                                          style: f14w,
                                                        ),
                                                        SizedBox(height: 2,),
                                                        Text(_con
                                                            .TimFoodMarket[indexxx]["busaddress"]
                                                            .toString()
                                                            .substring(
                                                            0, 11) + "...",
                                                            style: f11g),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.grey,
                                                  size: 14,
                                                ),
                                                Text(
                                                  _con
                                                      .TimFoodMarket[indexxx]["item_distance"].toString()+" km",
                                                  style: f12g,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, right: 3),
                                      child: Divider(
                                        color: Colors.black87,
                                        thickness: 1,
                                      ),
                                    ),
                                    Container(alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: Text("Price : "+_con
                                            .TimFoodMarket[indexxx]["kitchen_item_amount"].toString(),style: f14bB,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ) : Container(height: 0,);
              } ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          child: _con
              .ProductDetail!=null &&  userid.toString()!= _con
              .ProductDetail["kitchen_user_id"].toString() ?
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  try {
                    String chatID = makeChatId(
                        timelineIdFoodi
                            .toString(),
                        _con
                            .ProductDetail["kitchen_user_id"].toString());
                    Navigator
                        .push(
                        context,
                        MaterialPageRoute(
                            builder: (
                                context) =>
                                ChatRoom(
                                    timelineIdFoodi.toString(),
                                    NAME,
                                    _con
                                        .ProductDetail["kitchen_user_device_token"],
                                    _con
                                        .ProductDetail["timeline_parent_id"].toString(),
                                    chatID,
                                    _con
                                        .ProductDetail["kitchen_user_username"].toString(),
                                    _con
                                        .ProductDetail["kitchen_user_name"].toString(),
                                    _con
                                        .ProductDetail["kitchen_user_image"].toString()
                                        .replaceAll(
                                        " ",
                                        "%20") +
                                        "?alt=media",
                                    "Hai "+_con.ProductDetail["kitchen_user_name"].toString()+" . I'am interested this item https://saasinfomedia.com/butomy/foodimarket/product/"+
                                        _con.ProductDetail["kitchen_item_id"].toString())));
                  } catch (e) {
                    print(e
                        .message);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFffd55e),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      )
                  ),
                  height: 42,
                  width: width/2.4,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 3,),
                      Text("Chat",style: f14B,),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFffd55e),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )
                ),
                height: 42,
                width: width/2.4,
                child: Center(child: Text("Request Call back",style: f14B,)),
              )
            ],
          ) : Container(height: 0,),
        ),
      ),
    );
  }
}
