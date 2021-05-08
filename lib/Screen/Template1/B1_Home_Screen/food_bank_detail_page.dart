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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

class FoodBankDetailPage extends StatefulWidget {

  FoodBankDetailPage({this.product_id,this.req_show});
  String product_id;
  bool req_show;


  @override
  _FoodBankDetailPageState createState() => _FoodBankDetailPageState();
}
DateTime _date;
var d;
class _FoodBankDetailPageState extends StateMVC<FoodBankDetailPage> {
  Completer<GoogleMapController> _controller = Completer();


  bool textSpan;

  HomeKitchenRegistration _con;

  _FoodBankDetailPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  @override
  void initState() {
    setState(() {
      textSpan=false;
    });
    print("prod :"+widget.product_id);
    _con.BusinessEveryItemDetailPage(widget.product_id.toString());
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
if(_con.ProductDetail!=null) {
  _date = DateTime.parse(
      _con.ProductDetail['created_at']);
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
        title: Image.asset(
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
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_on,color: Colors.white,size: 18,),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            _con
                                .ProductDetail
                            ['item_distance'].toString()+" km away",
                            style: f14w,
                          ),
                        ],
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
              child: Row(
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
                  Container(width: MediaQuery.of(context).size.width-78,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_con
                            .ProductDetail
                        ['kitchen_page_name']+" is giving away",style: f14w),
                        SizedBox(height: 3,),
                        Text(_con
                            .ProductDetail
                        ['kitchen_item_name'],style: f15wB,), SizedBox(height: 3,),
                        Text("Added "+d.toString(),style: f13y,),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 20,bottom: 20),
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
              padding: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
              child: Text("Pick Up Timing",style:f16bB),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 20,top: 0),
              child: Text(_con
                  .ProductDetail
              ['pickup_time'].toString(),style: f13w,),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8,right: 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: RichText(textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Everything in this section is given away for \n",
                        style: f14w,
                        children: [
                          TextSpan(
                              text: "Free. ",
                              style: f14yB
                          ),
                          TextSpan(
                            text: "Strictly no selling, no swaps, no donations.",
                            style: f14w),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 15,bottom: 0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Approx Pickup Location",style: f14wB),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on,color: Colors.grey,size: 15,),
                      SizedBox(width: 2,),
                      Text(_con.ProductDetail["item_distance"].toString()+" km",style: f14g)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:8, left: 8,bottom: 10,top: 3),
              child: Text("("+_con.ProductDetail["location"]+")",style: f13g),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8,right: 8),
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
            SizedBox(height: 10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left:8,right: 8,bottom: 20),
                child: Text("This item is listed only for charitable organizations.",style: f14bB,),
              ),
            ),
          userid.toString()!=  _con.ProductDetail["kitchen_user_id"].toString() && widget.req_show==true ?  Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: (){
                  try {
                    String chatID = makeChatId(
                        timelineIdFoodi
                            .toString(),
                        _con.ProductDetail["timeline_parent_id"].toString());
                    Navigator
                        .push(
                        context,
                        MaterialPageRoute(
                            builder: (
                                context) =>
                                ChatRoom(
                                    timelineIdFoodi.toString(),
                                    NAME,
                                    _con.ProductDetail["kitchen_user_device_token"].toString(),
                                    _con.ProductDetail["timeline_parent_id"].toString(),
                                    chatID,
                                    _con.ProductDetail["kitchen_user_username"].toString(),
                                    _con.ProductDetail["kitchen_user_name"].toString(),
                                    _con.ProductDetail["kitchen_user_image"].toString()
                                        .replaceAll(
                                        " ",
                                        "%20") +
                                        "?alt=media",
                                   "Hai "+_con.ProductDetail["kitchen_user_name"].toString()+" . I need this item https://saasinfomedia.com/butomy/foodbank/product/"+_con.ProductDetail["kitchen_item_id"].toString())));
                  } catch (e) {
                    print(e
                        .message);
                  }
                },
                child: Container(height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFffd55e),
                  borderRadius: BorderRadius.circular(10)
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left:12,right: 12),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Request This",style: f16B,),
                      Row(
                        children: [
                          Icon(Icons.location_on,color: Colors.black,size: 18,),
                          SizedBox(width: 3,),
                          Text(_con.ProductDetail["item_distance"].toString()+" km away",style: f14,)
                        ],
                      )
                    ],
                  ),
                ),),
              ),
            ) : Container(),
            SizedBox(height: 15,)
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
