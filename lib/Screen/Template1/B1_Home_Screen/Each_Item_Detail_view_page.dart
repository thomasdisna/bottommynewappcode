import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/photos_view_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'ANOTHERPERSON/wall_web_view_page.dart';

class EachItemDetailPage extends StatefulWidget {
  String product_id,typ,page_id;
  EachItemDetailPage({this.product_id,this.typ,this.page_id});

  @override
  _EachItemDetailPageState createState() => _EachItemDetailPageState();
}

class _EachItemDetailPageState extends StateMVC<EachItemDetailPage> {

  HomeKitchenRegistration _con;
  _EachItemDetailPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  bool splashcolor;
  @override
  void initState() {
    setState(() {
      splashcolor=false;
    });
    print("PRROODD IIDDD "+widget.product_id.toString());
    print("PRROODD pageee "+widget.page_id.toString());
    _con.BusinessEveryItemDetailPage(widget.product_id.toString());
    _con.BusinessRelatedItem(widget.page_id,widget.typ);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: _con.ProductDetail!=null ? SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverAppBar(
              titleSpacing: 0,pinned: true,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Color(0xFF1E2026),
              brightness: Brightness.dark,
              elevation: 5,
              title: Image.asset(
                "assets/Template1/image/Foodie/logo.png",
                height: 23,
              ),
            ),
              SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10,right: 20,bottom: 15),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                            _con.ProductDetail["kitchen_item_name"].toString().length>26 ?
                                  _con.ProductDetail["kitchen_item_name"].toString().substring(0,26)+"..." : _con.ProductDetail["kitchen_item_name"].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                _con.ProductDetail["item_sub_titile"]!=null ?  SizedBox(height: 5,) : Container(),
                                _con.ProductDetail["item_sub_titile"]!=null ?  Text(_con.ProductDetail["item_sub_titile"],style:f14w) : Container()
                              ],
                            ),
                            Image.asset("assets/Template1/image/Foodie/icons/share.png",height: 22,width: 22)
                          ],
                        ),
                      ),
                     _con.ProductDetail["kitchen_item_image"].length>1 ?  Container(
                        height: 320.0,
                        child: new Carousel(
                          boxFit: BoxFit.cover,
                          dotColor: Colors.black26,
                          dotSize: 5.5,
                          autoplay: false,
                          dotSpacing: 16.0,
                          dotIncreasedColor: Color(0xFF48c0d8),
                          dotBgColor: Colors.transparent,
                          showIndicator: true,
                          overlayShadow: true,
                          overlayShadowColors: Colors.white.withOpacity(0.2),
                          overlayShadowSize: 0.9,
                          images: _con
                              .ProductDetail["kitchen_item_image"].map((item) {
                            return new CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                    item['source']
                                        .toString()
                                        .replaceAll(
                                        " ", "%20") +
                                    "?alt=media",
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error));
                          }).toList(),
                        ),
                      ) : Container(
                       height: 320,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           image: DecorationImage(
                               image: CachedNetworkImageProvider( "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                   _con
                                       .ProductDetail["kitchen_item_image"][0]["source"]
                                       .toString()
                                       .replaceAll(
                                       " ",
                                       "%20") +
                                       "?alt=media")
                                   /*: CachedNetworkImageProvider(
                                 "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                               ),*/,
                               fit: BoxFit
                                   .cover),
                          ),
                     ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 12),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\u20B9 "+ _con
                                  .ProductDetail["kitchen_item_amount"].toString(),
                              style: f15yB,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 25,
                                  width: 85,
                                  decoration: BoxDecoration(
                                      color:  _con.ProductDetail
                                      ["placeorder_type"].toString()=="0" ?  Color(0xFFffd55e) : Color(0xFF0dc89e),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                    child: Text( _con.ProductDetail
                                    ["placeorder_type"].toString()=="0" ? "Buy Now" : "Pre Order", style: f14B),
                                  ),
                                )  ,
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap:(){
                                    _con.AddtoPurchaseList(userid.toString(),_con.ProductDetail
                                    ["kitchen_item_id"].toString(),widget.typ,"1",_con.ProductDetail
                                    ["kitchen_item_amount"].toString(),_con.ProductDetail["page_id"].toString());
                                    setState(() {
                                      splashcolor=true;
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/shopping-basket.png",
                                    height: 24,
                                    width: 24,
                                    color:splashcolor? Color(0xFF48c0d8) : Color(0xFFffd55e),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 12),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 14.0,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 3,),
                            Container(width: MediaQuery.of(context).size.width-57,
                              child: Text(
                                _con
                                    .ProductDetail["kitchen_user_address"],
                                style: f14gB,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 70.0,
                        width: double.infinity,
                        color: Colors.black12.withOpacity(0.01),
                        child: Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                      height: 38.0,
                                      width: 38.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0)),
                                          color: Color(0xFFF7D142)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/Template2/icon/ratting.png",
                                          height: 18.0,
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(_con
                                            .ProductDetail["kitchen_item_rating"].toString(),
                                          style: f14wB,
                                        ),
                                        Text(
                                            "Ratings",
                                            style: f14w
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                      height: 38.0,
                                      width: 38.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(50.0)),
                                          color: Color(0xFFF32956)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/Template2/icon/bookmark.png",
                                          height: 18.0,
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            _con
                                                .ProductDetail["save_count"].toString(),
                                            style: f14wB
                                        ),
                                        Text(
                                            "Bookmark",
                                            style: f14w
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => GalleryScreen(ImageList: _con.ProductDetail["kitchen_item_image"],)
                                  ));
                                },
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        height: 38.0,
                                        width: 38.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0)),
                                            color: Color(0xFF5658D1)),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/Template2/icon/photos.png",
                                            height: 18.0,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              _con.ProductDetail["kitchen_item_image"].length.toString(),
                                              style: f14wB
                                          ),
                                          Text(
                                              "Photos",
                                              style: f14w
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        //kitchen_user_image
                                          image: CachedNetworkImageProvider(_con.ProductDetail["kitchen_page_image"]!=null? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.ProductDetail["kitchen_page_image"]+"?alt=media"
                                          :  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",

                                          ),
                                          fit: BoxFit.cover),
                                      border: Border.all(color: _con.ProductDetail["kitchen_page_image"]==null ? Color(0xFF48c0d8) : Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(180.0))),
                                ),
                                SizedBox(width: 8,),
                                Text(
                                    _con.ProductDetail["kitchen_page_name"].toString(),
                                    style: f15wB
                                ),
                                SizedBox(width: 20),
                               userid.toString()!= _con
                                   .ProductDetail["kitchen_user_id"].toString() ? GestureDetector(
                                    onTap: () {
                                      try {
                                        String chatID = makeChatId(
                                            timelineIdFoodi
                                                .toString(),
                                            _con
                                                .ProductDetail["kitchen_timeline_id"]);
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
                                                            .ProductDetail["kitchen_timeline_id"].toString(),
                                                        chatID,
                                                        _con
                                                            .ProductDetail["kitchen_user_username"].toString(),
                                                        _con
                                                            .ProductDetail["kitchen_page_name"].toString(),
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                            .ProductDetail["kitchen_page_image"].toString()
                                                            .replaceAll(
                                                            " ",
                                                            "%20") +
                                                            "?alt=media",
                                                        "")));
                                      } catch (e) {
                                        print(e.message);
                                      }
                                    },
                                    child: Icon(
                                      Icons.chat,
                                      size: 22,
                                      color: Color((0xFFffd55e)),
                                    )) : Container(),
                              ],
                            ),
                            // kitchen_follow_status
                           userid.toString()!=_con.ProductDetail["kitchen_user_id"].toString() ? GestureDetector(
                              onTap: () {
                                if (_con
                                    .ProductDetail["kitchen_follow_status"] ==
                                    true) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                          Color(0xFF1E2026),
                                          content: new Text(
                                            "Do you want to Unfollow " +
                                                _con.ProductDetail
                                                ["kitchen_page_name"]
                                                    .toString() +
                                                " ?",
                                            style: f14w,
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              height: 28,
                                              color: Color(0xFFffd55e),
                                              child: new Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color:
                                                    Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                            ),
                                            MaterialButton(
                                              height: 28,
                                              color: Color(0xFF48c0d8),
                                              child: new Text(
                                                "Unfollow",
                                                style: TextStyle(
                                                    color:
                                                    Colors.black),
                                              ),
                                              onPressed: () {
                                                _con.BusinessFollowunFollow(
                                                    _con
                                                        .ProductDetail["kitchen_page_id"].toString(),
                                                    userid.toString(),
                                                    "1");
                                                setState(() {
                                                  _con
                                                      .ProductDetail["kitchen_follow_status"] =
                                                  false;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  setState(() {
                                    _con
                                        .ProductDetail["kitchen_follow_status"] = true;
                                  });
                                  _con.BusinessFollowunFollow(
                                      _con
                                          .ProductDetail["kitchen_page_id"].toString(),
                                      userid.toString(),
                                      "1");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 23,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d9),
                                      borderRadius:
                                      BorderRadius.circular(2)),
                                  child: Center(
                                      child: _con
                                          .ProductDetail["kitchen_follow_status"] ==
                                          true
                                          ? Text("Unfollow",
                                          style: f14B)
                                          : Text("Follow",
                                          style: f14B)),
                                ),
                              ),
                            ) : Container(height: 0,)
                          ],
                        ),
                      ),

                      _con.ProductDetail["products_description"].toString().length>0 ?  Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                        child: Text(
                          _con.ProductDetail["products_description"].toString(),
                          style:f14w,
                          textAlign: TextAlign.justify,
                        ),
                      ) : Container(),
                      _con.ProductDetail["product_video_id"].toString().length>5 ?  Padding(
                        padding: const EdgeInsets.only(top : 15,bottom: 5),
                        child: GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>WebViewContainer(
                                  url: _con.ProductDetail["product_video_url"].toString(),)
                            ));
                          },
                          child: Stack(alignment: Alignment.center,
                            children: [
                              CachedNetworkImage(
                                  imageUrl: "https://img.youtube.com/vi/" +
                                      _con.ProductDetail["product_video_id"].toString()+
                                      "/0.jpg",height: 200,width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                              ),
                              Image.asset(
                                "assets/Template1/image/Foodie/icons/youtube.png",
                                height: 32,
                                width: 32,
                              )
                            ],
                          ),
                        ),
                      ) : Container(),
                      _con.ProductDetail["product_video_id"].toString().length>5 ? Padding(
                        padding: const EdgeInsets.only(left:20,right: 20,bottom: 20),
                        child: Text(_con.ProductDetail["product_video_title"].toString(),style: f14w,),
                      ) : Container(),
                    _con.RelatedItem.length > 0 && _con.RelatedItem.length!=1 ?  Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0,top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Related Post",
                                style: f16wB,
                              ),
                              Text(
                                "See all",
                                style: f14wB,
                              ),
                            ]),
                      ) : Container(),
                      SizedBox(
                        height: 10.0,
                      ),
                     _con.RelatedItem.length>0  ? Container(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: _con.RelatedItem.length,
                          scrollDirection: Axis.horizontal,
                         itemBuilder: (context,rel){
                            return _con.RelatedItem[rel]["kitchen_item_id"].toString()!=widget.product_id ? GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) =>EachItemDetailPage(page_id: widget.page_id,product_id: _con.RelatedItem[rel]["kitchen_item_id"].toString(),
                                  typ: widget.typ,)
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: 110.0,
                                      width: 150.0,
                                      child: CachedNetworkImage(
                                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"
                                            +_con.RelatedItem[rel]["kitchen_item_image"][0]["source"]+"?alt=media",fit: BoxFit.cover,

                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 5.0,
                                                color: Colors.black12.withOpacity(0.1),
                                                spreadRadius: 2.0)
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(width: 150,
                                      child: Text(
                                        _con.RelatedItem[rel]["kitchen_item_name"],
                                        style:f15wB,overflow: TextOverflow.ellipsis,maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      "\u20B9"+ _con
                                          .RelatedItem[rel]["kitchen_item_amount"].toString(),
                                      style: f15yB,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          size: 15.0,
                                          color: Colors.yellow,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Text("  "+
                                              _con.RelatedItem[rel]["kitchen_item_rating"],
                                            style: f14w,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 35.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ) : Container();
                         },
                        ),
                      ) : Container(),
                      SizedBox(
                        height: 20.0,
                      ),
                    ]))
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Widget _relatedPost(String image, title, location, ratting) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 110.0,
          width: 150.0,
          decoration: BoxDecoration(
              image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 2.0)
              ]),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          title,
          style:f15wB,
        ),
        SizedBox(
          height: 2.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 14.0,
              color: Colors.white70,
            ),
            Text(
              location,
              style: f14g,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.star,
              size: 15.0,
              color: Colors.yellow,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text("  "+
                  ratting,
                style: f14w,
              ),
            ),
            SizedBox(
              width: 35.0,
            ),
          ],
        ),
      ],
    ),
  );
}
