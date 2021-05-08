/*
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutube/flutube.dart';
import 'package:Butomy/CHAT/conversation_screen.dart';
import 'package:Butomy/CHAT/database.dart';
import 'package:Butomy/Repository/UserLoginRepository/userRepository.dart'
as repo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/B1_Home_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/bi%20home%20copy.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/bottom_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekitchen_bottom_bar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/edit_post.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_add_food_market.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_add_home_kitchen.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_add_restaurant.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_homekitchen_upload_document.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_local_store_upload_document.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_restaurant_upload_document.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/notification.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_home_kitchen.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_delivery_warrior.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_food_market.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_restaurant.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_bank.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_marcket.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_home_kitchen.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_restaurant.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:Butomy/scrollview.dart';

import 'multiple_image_picker.dart';

const kGoogleApiKey = "AIzaSyABBH07rVnsmRDsmIjtpfHiBuwczmyVyLk";
double lat;
double lng;
var postImage;
var postDesc;
var homekitstatus;
var restarantstatus;
var localstatus;
var hk;
var res;
var loc;
var pic_url;
var dataUser;
var UserIdprefs;
var timedata;
DateTime _date;
bool picStatus = false;
var dp;
var d;
DateTime _date2;
var d2;
var statusflag = 0;
var s = "unlike";
var b = "unmark";
var sharePost;
var e;
bool _fullscreen;

class TimeLine extends StatefulWidget {
  TimeLine({Key key}) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

bool textSpan;

class _TimeLineState extends StateMVC<TimeLine>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserIdprefs = prefs.getString('userId');
  }

  Future<Null> _refresh() {
    _con.getTimelineWall(userid.toString());
  }

  RichText desc_lessthan_130(String text) {
    List<String> split = text.split(RegExp("@"));
    List<String> namespace = split.getRange(1, split.length).fold([], (t, e) {
      var texts = e.split(" ");
      if (texts.length > 1) {
        return List.from(t)
          ..addAll(["@${texts.first}", "${e.substring(texts.first.length)}"]);
      }
      return List.from(t)
        ..add("@${texts.first}");
    });
    return RichText(
      text: TextSpan(
        children: [TextSpan(text: split.first)]
          ..addAll(namespace
              .map((text) =>
          text.contains("@")
              ? TextSpan(text: text,
            style: TextStyle(fontSize: 14, color: Colors.blueAccent),)
              : TextSpan(text: text, style: f14w))
              .toList()),
      ),
    );
  }

  RichText desc_greaterthan_130_true(String text) {
    List<String> split = text.split(RegExp("@"));
    List<String> namespace = split.getRange(1, split.length).fold([], (t, e) {
      var texts = e.split(" ");
      if (texts.length > 1) {
        return List.from(t)
          ..addAll(["@${texts.first}", "${e.substring(texts.first.length)}"]);
      }
      return List.from(t)
        ..add("@${texts.first}");
    });
    return RichText(
      text: TextSpan(
        children: [TextSpan(text: split.first, children: [
          TextSpan(recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                textSpan = false;
              });
            },
              text: " Read less",
              style: f14b
          )
        ])
        ]
          ..addAll(namespace
              .map((text) =>
          text.contains("@")
              ? TextSpan(text: text,
            style: TextStyle(fontSize: 14, color: Colors.blueAccent),)
              : TextSpan(text: text, style: f14w))
              .toList()),
      ),
    );
  }

  RichText desc_graterthan_130_false(String text) {
    List<String> split = text.split(RegExp("@"));
    List<String> namespace = split.getRange(1, split.length).fold([], (t, e) {
      var texts = e.split(" ");
      if (texts.length > 1) {
        return List.from(t)
          ..addAll(["@${texts.first}", "${e.substring(texts.first.length)}"]);
      }
      return List.from(t)
        ..add("@${texts.first}");
    });
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: split.first.substring(0, 130,) + " ...",
              children: [TextSpan(recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    textSpan = true;
                  });
                },
                  text: " Read more",
                  style: f14b
              )
              ])
        ]
          ..addAll(namespace
              .map((text) =>
          text.contains("@")
              ? TextSpan(text: text,
              style: TextStyle(fontSize: 14, color: Colors.blueAccent))
              : TextSpan(text: text, style: f14w
          ),
          )
              .toList()),
      ),
    );
  }


  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;

      setState(() {
        lat = detail.result.geometry.location.lat;
        lng = detail.result.geometry.location.lng;
      });
    }
  }

  TextEditingController _locatn = TextEditingController();
  TextEditingController _sharee = TextEditingController();
  TabController _tabContoller;
  TimelineWallController _con;

  _TimeLineState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.getAbout(userid.toString());
    setState(() {
      textSpan = false;
      _fullscreen = true;
    });
    // TODO: implement initState
    super.initState();
    _con.getTimelineWall(userid.toString());
    getUserId();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
          scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    homekitstatus == "" ? setHomekitStatus() : null;
    restarantstatus == "" ? setRestStatus() : null;
    localstatus == "" ? setLocalStatus() : null;

    _tabContoller = TabController(length: 5, vsync: this);
    _tabContoller.addListener(_handleTabSelection);
  }

  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post', sharePost, 'text/plain');
    } catch (e) {
      //print('error: $e');
    }
  }

  createChatroomAndStartConversation(
      {String cusUserNAME, String CusImage, String cusNAME}) {
    String chatRoomId = getChatRoomId(cusUserNAME, userNAME);
    String avatars = getAvatar(CusImage, userPIC);
    String names = getNames(cusNAME, NAME);
    List<String> users = [cusUserNAME, userNAME];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "avatars": avatars,
      "chatroomId": chatRoomId,
      "names": names
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ConversationScreen(chatRoomId, CusImage, cusNAME,cusUserNAME)));
  }

  Future<String> setHomekitStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("homekit");
    prefs.setString('homekit', "1");
  }

  Future<String> removeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String> setRestStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("rest");
    prefs.setString('rest', "1");
  }

  Future<String> setLocalStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("loc");
    prefs.setString('loc', "1");
  }

  Future<String> getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    hk = prefs.getString('homekit');
    res = prefs.getString('rest');
    loc = prefs.getString('loc');

    setState(() {
      homekitstatus = hk;
      restarantstatus = res;
      localstatus = loc;
      userid = prefs.getString("userId");
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  setHomekitTimer() {
    return Timer(
      Duration(seconds: 6),
          () => setHomkitTeleStatus(),
    );
  }

  setRestTimer() {
    return Timer(
      Duration(seconds: 6),
          () => setRestTeleStatus(),
    );
  }

  setLocalTimer() {
    return Timer(
      Duration(seconds: 6),
          () => setLocalTeleStatus(),
    );
  }

  Future<String> setHomkitTeleStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("homekit");
    prefs.setString('homekit', "3");
  }

  Future<String> setRestTeleStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("rest");
    prefs.setString('rest', "3");
  }

  Future<String> setLocalTeleStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("loc");
    prefs.setString('loc', "3");
  }

  @override
  Widget build(BuildContext context) {
    // _con.getTimelineWall();
    getStatus();
    var _location = Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Padding(
        padding: const EdgeInsets.only(top: 7.0, right: 3, left: 3),
        child: InkWell(
          onTap: () {

          },
          child: Container(
            height: 47.0,
            decoration: BoxDecoration(
                color: Color(0xFF23252E),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 0.0)
                ]),
            child: Container(
              child: TextFormField(
                autofocus: false,
                readOnly: true,
                controller: _locatn,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please add receiver location';
                  }
                  return null;
                },
                onTap: () async {
                  Prediction p =
                  await PlacesAutocomplete.show(
                      context: context,
                      apiKey: kGoogleApiKey,
                      mode: Mode.overlay,
                      language: "IN",
                      components: [
                        new Component(
                            Component.country, "IN")
                      ]);
                  _locatn.text = p.description.toString();
                  displayPrediction(p);
                  var a = p.types;
                  var b = a[2];
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on, color: Colors.white),
                    border: InputBorder.none,
                    hintText: "Location",
                    suffixIcon: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
          ),
        ),
      ),
    );
    var _tabModules = Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFF23252E),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5.0,
                          spreadRadius: 0.0)
                    ]),
                child: Container(
                  height: 70,
                  child: PreferredSize(
                    child: TabBar(
                      isScrollable: true,
                      indicator: BoxDecoration(
                          color: Color((0xFFffd55e)),
                          borderRadius: BorderRadius.circular(4)),
                      controller: _tabContoller,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white,
                      indicatorColor: Colors.transparent,
                      tabs: <Widget>[
                        Tab(
                          child: Text(
                            "Foodizwall",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 0
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/wall.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/wall.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Home Kitchen",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 1
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/home-kitchen.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/home-kitchen.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Local Market",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 2
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/market.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/market.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Food Bank",
                            style: f14,
                          ),
                          icon: _tabContoller.index == 3
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/Food-Bank-1.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/Food-Bank-1.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Restaurants",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 4
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    preferredSize: Size.fromHeight(100),
                  ),
                ),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 240,
                // padding: EdgeInsets.only(bottom: 200),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TabBarView(
                    controller: _tabContoller,
                    children: <Widget>[
                      _con.timelinePostData.length != 0
                          ? RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: _refresh,
                        child: ListView.builder(
                          itemCount: _con.timelinePostData.length,
                          physics: const AlwaysScrollableScrollPhysics (),
                          itemBuilder: (BuildContext context, int index) {
                            _date = DateTime.parse(
                                _con.timelinePostData[index]['created_at']
                                ['date']);
                            _con.timelinePostData[index]["shared_post_id"] != null
                                ? _date2 = DateTime.parse(
                                _con
                                    .timelinePostData[index]["shared_post_details"]['created_at']
                                ['date'])
                                : null;
                            final List<String> playlist = <String>[
                              'https://www.youtube.com/watch?v=' +
                                  _con.timelinePostData[index]
                                  ['youtube_video_id']
                                      .toString()
                            ];
                            final List<String> playlist2 = _con
                                .timelinePostData[index]["shared_post_id"] != null
                                ? <String>[
                              'https://www.youtube.com/watch?v=' +
                                  _con
                                      .timelinePostData[index]["shared_post_details"]
                                  ['youtube_video_id']
                                      .toString()
                            ]
                                : <String>[];
                            var c =
                                DateTime
                                    .now()
                                    .difference(_date)
                                    .inHours;
                            _con.timelinePostData[index]["shared_post_id"] != null
                                ? e =
                                DateTime
                                    .now()
                                    .difference(_date2)
                                    .inHours
                                : null;
                            c > 24
                                ? d = DateTime
                                .now()
                                .difference(_date)
                                .inDays
                                .toString() +
                                " day ago"
                                : c == 0
                                ? d = DateTime
                                .now()
                                .difference(_date)
                                .inMinutes
                                .toString() +
                                " mints ago"
                                : d = DateTime
                                .now()
                                .difference(_date)
                                .inHours
                                .toString() +
                                " hrs ago";

                            _con.timelinePostData[index]["shared_post_id"] != null
                                ? e > 24
                                ? d2 = DateTime
                                .now()
                                .difference(_date2)
                                .inDays
                                .toString() +
                                " day ago"
                                : e == 0
                                ? d2 = DateTime
                                .now()
                                .difference(_date2)
                                .inMinutes
                                .toString() +
                                " mints ago"
                                : d2 = DateTime
                                .now()
                                .difference(_date2)
                                .inHours
                                .toString() +
                                " hrs ago"
                                : null;

                            return new GestureDetector(
                              child: new Column(
                                children: <Widget>[

                                  Container(
                                    // color: Colors.white.withOpacity(0.5),
                                    padding: const EdgeInsets.only(
                                        top: 5.0, bottom: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0,
                                                right: 5.0,
                                                bottom: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                        TimelineFoodWallDetailPage(
                                                                          id: _con
                                                                              .timelinePostData[index]["user_id"]
                                                                              .toString(),
                                                                        )));

                                                        showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                AlertDialog(
                                                                  backgroundColor: Color(
                                                                      0xFF1E2026),
                                                                  content: CachedNetworkImage(
                                                                    imageUrl: _con
                                                                        .timelinePostData[index]["picture"],
                                                                    height: 250,
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                  ),
                                                                ));
                                                      },
                                                      child: Container(
                                                        height: 35.0,
                                                        width: 35.0,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: _con
                                                                    .timelinePostData[index]["picture"] !=
                                                                    null
                                                                    ? CachedNetworkImageProvider(
                                                                    _con
                                                                        .timelinePostData[index]["picture"])
                                                                    : CachedNetworkImageProvider(
                                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                ),
                                                                fit: BoxFit
                                                                    .cover),
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                180.0))),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      child:
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      TimelineFoodWallDetailPage(
                                                                        id: _con
                                                                            .timelinePostData[index]['user_id']
                                                                            .toString(),
                                                                      )));
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              _con
                                                                  .timelinePostData[
                                                              index]
                                                              [
                                                              'name']
                                                                  .toString(),
                                                              style: f15wB,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                                d.toString(),
                                                                style: f10g)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    userid !=
                                                        _con.timelinePostData[
                                                        index][
                                                        "user_id"]
                                                            .toString()
                                                        ? GestureDetector(
                                                        onTap: () {
                                                          createChatroomAndStartConversation(
                                                              cusUserNAME: _con
                                                                  .timelinePostData[
                                                              index]
                                                              [
                                                              'username']
                                                                  .toString(),
                                                              CusImage: _con
                                                                  .timelinePostData[
                                                              index]
                                                              [
                                                              'picture']
                                                                  .toString(),
                                                              cusNAME: _con
                                                                  .timelinePostData[
                                                              index]
                                                              [
                                                              'name']
                                                                  .toString());
                                                        },
                                                        child: Icon(
                                                          Icons.chat,
                                                          color: Color(
                                                              (0xFFffd55e)),
                                                        ))
                                                        : Container(
                                                      height: 0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            backgroundColor:
                                                            Color(
                                                                0xFF1E2026),
                                                            context:
                                                            context,
                                                            clipBehavior: Clip
                                                                .antiAlias,
                                                            builder:
                                                                (BuildContext
                                                            context) {
                                                              return StatefulBuilder(
                                                                  builder: (
                                                                      BuildContext
                                                                      context,
                                                                      StateSetter
                                                                      state) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                          5.0,
                                                                          top:
                                                                          5,
                                                                          right:
                                                                          10,
                                                                          left:
                                                                          10),
                                                                      child:
                                                                      Wrap(
                                                                        children: <
                                                                            Widget>[
                                                                          userid
                                                                              .toString() ==
                                                                              _con
                                                                                  .timelinePostData[index]['user_id']
                                                                                  .toString()
                                                                              ? Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                Navigator
                                                                                    .push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (


                                                                                            context) =>
                                                                                            EditPost(
                                                                                              desc: _con
                                                                                                  .timelinePostData[index]['description']
                                                                                                  .toString(),
                                                                                              postid: _con
                                                                                                  .timelinePostData[index]["id"]
                                                                                                  .toString(),
                                                                                            )));
                                                                              },
                                                                              child: Container(
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Image
                                                                                        .asset(
                                                                                      "assets/Template1/image/Foodie/icons/pencil.png",
                                                                                      height: 21,
                                                                                      width: 21,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 16,
                                                                                    ),
                                                                                    Text(
                                                                                      "Edit Post",
                                                                                      style: f15wB,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : Container(
                                                                            height: 0,
                                                                          ),
                                                                          userid
                                                                              .toString() ==
                                                                              _con
                                                                                  .timelinePostData[index]['user_id']
                                                                                  .toString()
                                                                              ? Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (
                                                                                        BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        backgroundColor: Color(
                                                                                            0xFF1E2026),
                                                                                        title: new Text(
                                                                                          "Delete Post?",
                                                                                          style: f16wB,
                                                                                        ),
                                                                                        content: new Text(
                                                                                          "Do you want to delete the post",
                                                                                          style: f14w,
                                                                                        ),
                                                                                        actions: <
                                                                                            Widget>[
                                                                                          RaisedButton(
                                                                                            color: Colors
                                                                                                .white,
                                                                                            child: new Text(
                                                                                              "Cancel",
                                                                                              style: TextStyle(
                                                                                                  color: Colors
                                                                                                      .black),
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Navigator
                                                                                                  .pop(
                                                                                                  context,
                                                                                                  'Cancel');
                                                                                            },
                                                                                          ),
                                                                                          RaisedButton(
                                                                                            color: Colors
                                                                                                .white,
                                                                                            child: new Text(
                                                                                              "Delete",
                                                                                              style: TextStyle(
                                                                                                  color: Colors
                                                                                                      .black),
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              _con
                                                                                                  .deleteTimelineWall(
                                                                                                  userid
                                                                                                      .toString(),
                                                                                                  _con
                                                                                                      .timelinePostData[index]['id']
                                                                                                      .toString());

                                                                                              Navigator
                                                                                                  .pop(
                                                                                                  context);
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child: Container(

                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Icon(
                                                                                      Icons
                                                                                          .delete_outline,
                                                                                      size: 26,
                                                                                      color: Colors
                                                                                          .white,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Delete Post",
                                                                                          style: f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        Text(
                                                                                          "Delete the entire post",
                                                                                          style: f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : Container(
                                                                            height: 0,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child:
                                                                            InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  postid =
                                                                                      _con
                                                                                          .timelinePostData[index]["id"]
                                                                                          .toString();
                                                                                });
                                                                                _con
                                                                                    .saveTimelinePost(
                                                                                    postid
                                                                                        .toString(),
                                                                                    userid
                                                                                        .toString());
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Container(
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Icon(
                                                                                      Icons
                                                                                          .bookmark_border,
                                                                                      size: 26,
                                                                                      color: Colors
                                                                                          .white,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Save Post",
                                                                                          style: f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        Text(
                                                                                          "Add this to your saved post",
                                                                                          style: f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          userid
                                                                              .toString() !=
                                                                              _con
                                                                                  .timelinePostData[index]['user_id']
                                                                                  .toString()
                                                                              ? Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                _con
                                                                                    .reportTimeWall(
                                                                                    UserIdprefs,
                                                                                    _con
                                                                                        .timelinePostData[index]['id']);

                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Container(
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Icon(
                                                                                      Icons
                                                                                          .block,
                                                                                      size: 26,
                                                                                      color: Colors
                                                                                          .white,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Report & Support",
                                                                                          style: f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        Text(
                                                                                          "I'am concerned about this post",
                                                                                          style: f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : Container(
                                                                            height: 0,
                                                                          ),
                                                                          userid
                                                                              .toString() !=
                                                                              _con
                                                                                  .timelinePostData[index]['user_id']
                                                                                  .toString()
                                                                              ? Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                _con
                                                                                    .followerController(
                                                                                    userid
                                                                                        .toString(),
                                                                                    _con
                                                                                        .timelinePostData[index]['user_id']
                                                                                        .toString());
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Container(

                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Image
                                                                                        .asset(
                                                                                      "assets/Template1/image/Foodie/icons/person.png",
                                                                                      height: 21,
                                                                                      width: 21,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 16,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        _con
                                                                                            .timelinePostData[index]["follow_status"] ==
                                                                                            true
                                                                                            ? Text(
                                                                                          "Unfollow",
                                                                                          style: f15wB,
                                                                                        )
                                                                                            : Text(
                                                                                          "Follow",
                                                                                          style: f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        _con
                                                                                            .timelinePostData[index]["follow_status"] ==
                                                                                            true
                                                                                            ? Text(
                                                                                          "Unfollow  " +
                                                                                              _con
                                                                                                  .timelinePostData[index]["name"],
                                                                                          style: f13w,
                                                                                        )
                                                                                            : Text(
                                                                                          "Follow  " +
                                                                                              _con
                                                                                                  .timelinePostData[index]["name"],
                                                                                          style: f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : Container(
                                                                            height: 0,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child:
                                                                            InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  postid =
                                                                                      _con
                                                                                          .timelinePostData[index]['id']
                                                                                          .toString();
                                                                                  sharePost =
                                                                                      "https://saasinfomedia.com/foodiz/public/post/" +
                                                                                          postid
                                                                                              .toString();
                                                                                });

                                                                                Clipboard
                                                                                    .setData(
                                                                                    new ClipboardData(
                                                                                        text: sharePost
                                                                                            .toString()));
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                                Fluttertoast
                                                                                    .showToast(
                                                                                    msg: "Link Copied",
                                                                                    toastLength: Toast
                                                                                        .LENGTH_LONG,
                                                                                    gravity: ToastGravity
                                                                                        .TOP,
                                                                                    timeInSecForIosWeb: 10,
                                                                                    backgroundColor: Color(
                                                                                        0xFF48c0d8),
                                                                                    textColor: Colors
                                                                                        .white,
                                                                                    fontSize: 16.0);
                                                                              },
                                                                              child: Container(

                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Icon(
                                                                                      Icons
                                                                                          .link,
                                                                                      size: 26,
                                                                                      color: Colors
                                                                                          .white,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Copy Link",
                                                                                          style: f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        Text(
                                                                                          "Copy Post link",
                                                                                          style: f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child:
                                                                            InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  postid =
                                                                                      _con
                                                                                          .timelinePostData[index]['id']
                                                                                          .toString();
                                                                                  sharePost =
                                                                                      "https://saasinfomedia.com/foodiz/public/post/" +
                                                                                          postid
                                                                                              .toString();
                                                                                });
                                                                                _shareText();
                                                                              },
                                                                              child: Container(

                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Image
                                                                                        .asset(
                                                                                      "assets/Template1/image/Foodie/icons/share.png",
                                                                                      height: 21,
                                                                                      width: 21,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 16,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Share Post",
                                                                                          style: f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        Text(
                                                                                          "Share post externally",
                                                                                          style: f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  });
                                                            });
                                                      },
                                                      child: Icon(
                                                          Icons.more_vert,
                                                          color:
                                                          Colors.white),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        _con.timelinePostData[index]
                                        ['description'] !=
                                            "" && _con.timelinePostData[index]
                                        ['description'].length > 130 &&
                                            textSpan == false
                                            ? Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 7.0,
                                              right: 7,
                                              top: 5,
                                              bottom: 5),
                                          child: Container(
                                            child: desc_graterthan_130_false(
                                                _con.timelinePostData[index]
                                                ['description']),
                                          ),
                                        ) : _con.timelinePostData[index]
                                        ['description'] !=
                                            "" && _con.timelinePostData[index]
                                        ['description'].length > 130 &&
                                            textSpan == true
                                            ? Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 7.0,
                                              right: 7,
                                              top: 5,
                                              bottom: 5),
                                          child: Container(
                                            child: desc_greaterthan_130_true(
                                                _con.timelinePostData[index]
                                                ['description']),
                                          ),
                                        ) : _con
                                            .timelinePostData[index]['description'] !=
                                            "" && _con.timelinePostData[index]
                                        ['description'].length <= 130 ? Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 7.0,
                                              right: 7,
                                              top: 5,
                                              bottom: 5),
                                          child: Container(
                                            child: desc_lessthan_130(
                                                _con.timelinePostData[index]
                                                ['description']),
                                          ),
                                        ) :
                                        Container(
                                          height: 0,
                                        ),
                                        _con
                                            .timelinePostData[index]["shared_post_id"] !=
                                            null ? Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8, right: 8, top: 5,),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey[300],
                                                    width: .2)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          left: 5.0,
                                                          right: 5.0, top: 10,
                                                          bottom: 2),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (
                                                                          context) =>
                                                                          TimelineFoodWallDetailPage(
                                                                            id: _con
                                                                                .timelinePostData[index]["shared_post_details"]["user_id"]
                                                                                .toString(),
                                                                          )));
                                                            },
                                                            child: Container(
                                                              height: 35.0,
                                                              width: 35.0,
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: _con
                                                                          .timelinePostData[index]["shared_post_details"]["picture"] !=
                                                                          null
                                                                          ? CachedNetworkImageProvider(
                                                                          _con
                                                                              .timelinePostData[index]["shared_post_details"]["picture"])
                                                                          : CachedNetworkImageProvider(
                                                                        "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover),
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                      .circular(
                                                                      180.0))),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            child:
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            TimelineFoodWallDetailPage(
                                                                              id: _con
                                                                                  .timelinePostData[index]["shared_post_details"]['user_id']
                                                                                  .toString(),
                                                                            )));
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    _con
                                                                        .timelinePostData[index]["shared_post_details"]
                                                                    [
                                                                    'name']
                                                                        .toString(),
                                                                    style: f15wB,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Text(
                                                                      d2
                                                                          .toString(),
                                                                      style: f10g)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 25,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  _con
                                                      .timelinePostData[index]["shared_post_details"]
                                                  ['description'] !=
                                                      "" && _con
                                                      .timelinePostData[index]["shared_post_details"]
                                                  ['description'].length > 130 &&
                                                      textSpan == false
                                                      ? Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 7.0,
                                                        right: 7,
                                                        top: 5,
                                                        bottom: 5),
                                                    child: Container(
                                                      child: desc_graterthan_130_false(
                                                          _con
                                                              .timelinePostData[index]["shared_post_details"]
                                                          ['description']),
                                                    ),
                                                  ) : _con
                                                      .timelinePostData[index]["shared_post_details"]
                                                  ['description'] !=
                                                      "" && _con
                                                      .timelinePostData[index]["shared_post_details"]
                                                  ['description'].length > 130 &&
                                                      textSpan == true
                                                      ? Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 7.0,
                                                        right: 7,
                                                        top: 5,
                                                        bottom: 5),
                                                    child: Container(
                                                      child: desc_greaterthan_130_true(
                                                          _con
                                                              .timelinePostData[index]["shared_post_details"]
                                                          ['description']),
                                                    ),
                                                  ) : _con
                                                      .timelinePostData[index]["shared_post_details"]
                                                  ['description'] !=
                                                      "" && _con
                                                      .timelinePostData[index]["shared_post_details"]
                                                  ['description'].length <= 130
                                                      ? Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 7.0,
                                                        right: 7,
                                                        top: 5,
                                                        bottom: 5),
                                                    child: Container(
                                                      child: desc_lessthan_130(
                                                          _con
                                                              .timelinePostData[index]["shared_post_details"]
                                                          ['description']),
                                                    ),
                                                  )
                                                      :
                                                  Container(
                                                    height: 0,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 5,
                                                        bottom: 5,
                                                        left: 7,
                                                        right: 7),
                                                    child: _con
                                                        .timelinePostData[
                                                    index]["shared_post_details"]
                                                    ['post_images']
                                                        .length >
                                                        0
                                                        ? CachedNetworkImage(
                                                      imageUrl: _con
                                                          .timelinePostData[
                                                      index]["shared_post_details"][
                                                      "post_images_baseurl"] +
                                                          _con.timelinePostData[
                                                          index]["shared_post_details"][
                                                          "post_images"]
                                                          [0]['source'],
                                                      fit: BoxFit.cover,
                                                    )
                                                        : _con
                                                        .timelinePostData[index]["shared_post_details"]
                                                    [
                                                    "youtube_video_id"] !=
                                                        "" &&
                                                        _con.timelinePostData[
                                                        index]["shared_post_details"][
                                                        "youtube_video_id"] !=
                                                            null
                                                        ?  FluTube.playlist(
                                                      playlist2,
                                                      onVideoEnd: (){
                                                        setState(() { _fullscreen=false;});
                                                      },
                                                      autoInitialize: true,
                                                      aspectRatio: 16 / 9,allowFullScreen: _fullscreen,
                                                      allowMuting: false,
                                                      deviceOrientationAfterFullscreen: [
                                                        DeviceOrientation
                                                            .portraitUp,
                                                        DeviceOrientation
                                                            .landscapeLeft,
                                                        DeviceOrientation
                                                            .landscapeRight,
                                                      ],
                                                    )
                                                        : Container(height: 0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container(height: 0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: _con
                                              .timelinePostData[
                                          index]
                                          ['post_images']
                                              .length >
                                              0
                                              ? CachedNetworkImage(
                                            imageUrl: _con.timelinePostData[
                                            index][
                                            "post_images_baseurl"] +
                                                _con.timelinePostData[
                                                index][
                                                "post_images"]
                                                [0]['source'],
                                            fit: BoxFit.cover,
                                          )
                                              : _con.timelinePostData[index]
                                          [
                                          "youtube_video_id"] !=
                                              "" &&
                                              _con.timelinePostData[
                                              index][
                                              "youtube_video_id"] !=
                                                  null
                                              ?  FluTube.playlist(
                                            playlist,
                                            autoInitialize: true,
                                            aspectRatio: 16 / 9,
                                            onVideoEnd: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(
                                                  builder: (context)=> TimeLine()
                                              ));
                                            },
                                            allowMuting: false,
                                            looping: true,
                                            deviceOrientationAfterFullscreen: [
                                              DeviceOrientation
                                                  .portraitUp,
                                              DeviceOrientation
                                                  .landscapeLeft,
                                              DeviceOrientation
                                                  .landscapeRight,
                                            ],
                                          )
                                              : Container(
                                            height: 0,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7.0,
                                              right: 7,
                                              bottom: 5),
                                          child: Container(
                                            child: InkWell(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            postid = _con
                                                                .timelinePostData[
                                                            index]
                                                            ['id']
                                                                .toString();
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      LikeCommentSharePage(
                                                                        statusIndex:
                                                                        0,
                                                                      )));
                                                        },
                                                        child: Text(
                                                            _con.timelinePostData[
                                                            index]
                                                            [
                                                            'likes_count']
                                                                .toString() +
                                                                " Likes",
                                                            style: f14y),
                                                      ),
                                                      SizedBox(
                                                        width: 13,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            postid = _con
                                                                .timelinePostData[
                                                            index]
                                                            ['id']
                                                                .toString();
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      LikeCommentSharePage(
                                                                        statusIndex:
                                                                        1,
                                                                      )));
                                                          _con.getTimelineWall(
                                                              userid
                                                                  .toString());
                                                        },
                                                        child: Text(
                                                            _con.timelinePostData[
                                                            index]
                                                            [
                                                            'comments_count']
                                                                .toString() +
                                                                " Comments",
                                                            style: f14y),
                                                      ),
                                                      SizedBox(
                                                        width: 13,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            postid = _con
                                                                .timelinePostData[
                                                            index]
                                                            ['id']
                                                                .toString();
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      LikeCommentSharePage(
                                                                        statusIndex:
                                                                        2,
                                                                      )));
                                                        },
                                                        child: Text(
                                                            _con.timelinePostData[
                                                            index]
                                                            [
                                                            'share_count']
                                                                .toString() +
                                                                " Shares",
                                                            style: f14y),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7.0, right: 7, top: 5),
                                          child: Container(
                                            child: InkWell(
                                              child: Container(
                                                height: 20.0,
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    _con.timelinePostData[
                                                    index][
                                                    'like_status'] ==
                                                        true
                                                        ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = _con
                                                              .timelinePostData[
                                                          index]
                                                          [
                                                          'id']
                                                              .toString();
                                                        });
                                                        _con.likePostTime(
                                                            userid
                                                                .toString(),
                                                            postid
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        children: <
                                                            Widget>[
                                                          Icon(
                                                            Icons
                                                                .favorite,
                                                            color: Color(
                                                                0xFFffd55e),
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Liked",
                                                            style:
                                                            f14w,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                        : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = _con
                                                              .timelinePostData[
                                                          index]
                                                          [
                                                          'id']
                                                              .toString();
                                                        });
                                                        _con.likePostTime(
                                                            userid
                                                                .toString(),
                                                            postid
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        children: <
                                                            Widget>[
                                                          Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors
                                                                .white,
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Like",
                                                            style:
                                                            f14w,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = _con
                                                              .timelinePostData[
                                                          index]
                                                          ['id']
                                                              .toString();
                                                        });
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                    CommentPage()));
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .chat_bubble_outline,
                                                            color: Colors
                                                                .white,
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Comment",
                                                            style: f14w,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = _con
                                                              .timelinePostData[
                                                          index]
                                                          ['id']
                                                              .toString();
                                                          sharePost =
                                                              "https://saasinfomedia.com/foodiz/public/post/" +
                                                                  postid
                                                                      .toString();
                                                        });
                                                        panelController
                                                            .expand();
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          Image.asset(
                                                            "assets/Template1/image/Foodie/icons/share.png",
                                                            height: 16,
                                                            width: 16,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Share",
                                                            style: f14w,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    _con.timelinePostData[
                                                    index][
                                                    "save_status"] ==
                                                        true
                                                        ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = _con
                                                              .timelinePostData[
                                                          index]
                                                          [
                                                          "id"]
                                                              .toString();
                                                        });
                                                        _con.saveTimelinePost(
                                                            postid
                                                                .toString(),
                                                            userid
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        children: <
                                                            Widget>[
                                                          Icon(
                                                            Icons
                                                                .bookmark,
                                                            color: Color(
                                                                0xFF48c0d8),
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Saved",
                                                            style:
                                                            f14w,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                        : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = _con
                                                              .timelinePostData[
                                                          index]
                                                          [
                                                          "id"]
                                                              .toString();
                                                        });
                                                        _con.saveTimelinePost(
                                                            postid
                                                                .toString(),
                                                            userid
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        children: <
                                                            Widget>[
                                                          Icon(
                                                            Icons
                                                                .bookmark_border,
                                                            color: Colors
                                                                .white,
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Save",
                                                            style:
                                                            f14w,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                          : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xFF48c0d8),
                        ),
                      ),
                      _tabContoller.index == 1
                          ? TimelineHomeKitchen()
                          : Container(),
                      _tabContoller.index == 2
                          ? TimelineFoodMarcket()
                          : Container(),
                      _tabContoller.index == 3
                          ? TimelineFoodBank()
                          : Container(),
                      _tabContoller.index == 4
                          ? TimelineRestaurant()
                          : Container()
                    ],
                  ),
                ),
              )
            ],
          )),
    );

    var _body = Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      //  padding: const EdgeInsets.only(top: 6.0),
      child: Column(
        children: <Widget>[
          _location,
          _tabModules,
        ],
      ),
    );

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xFF1E2026),
          appBar: AppBar(
            titleSpacing: 0,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xFF1E2026),
            brightness: Brightness.dark,
            elevation: 5,
            title: Image.asset(
              "assets/Template1/image/Foodie/logo.png",
              height: 35,
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "assets/Template1/image/Foodie/icons/search.png",
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new searchAppbar()));
                    },
                  ),
                  GestureDetector(
                      onTap: () {

  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:
                                    (
                                    context) =>

                                        Feed()

                            ));


                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new QRCODE()));
                      },
                      child: Image.asset(
                        "assets/Template1/image/Foodie/QRcode.png",
                        height: 20,
                        width: 20,
                      )),
                  IconButton(
                    icon: Image.asset(
                      "assets/Template1/image/Foodie/icons/bell.png",
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new Notifications()));
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                          new HomeScreenT1()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: 28.0,
                        width: 28.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: repo.AbtInfo != null
                                    ? CachedNetworkImageProvider(repo
                                    .AbtInfo["data"][0]["picture"]
                                    .toString())
                                    : CachedNetworkImageProvider(
                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                            BorderRadius.all(Radius.circular(180.0))),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          drawer: Drawer(
            child: Container(
              color: Color(0xFF1E2026),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 70,
                    child: DrawerHeader(
                      decoration: BoxDecoration(color: Color(0xFF1E2026)),
                      child: Center(
                          child: Image.asset(
                            "assets/Template1/image/Foodie/logo_Business.png",
                            height: 35,
                          )),
                    ),
                  ),
                  homekitstatus == "1"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/home-kitchen.png",
                      'Home Kitchen',
                      "Are you passionate about cooking?\nWe are committed to deliver your\nfavourite snacks at you doorstep.",
                      "Register as Home Chef",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerHomeKitchen()))
                      },
                      Colors.lime[900],
                      10)
                      : homekitstatus == "2"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/home-kitchen.png",
                      'Home Kitchen',
                      "Your Application is\nunder process",
                      "Tele Verification  Pending",
                          () => {setHomekitTimer()},
                      Colors.green,
                      13)
                      : homekitstatus == "3"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/home-kitchen.png",
                      'Home Kitchen',
                      "Your Application is\nunder process",
                      "Proceed to Documentation",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomekitbusinessUpload()))
                      },
                      Colors.purple,
                      13)
                      : homekitstatus == "4"
                      ? CustomListTile2(
                      "Sofis Kitchen",
                      "From Kottayam,Kearala",
                      "Member Since Feb 2020",
                      "Home Kitchen", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                bottomNavBarhome()));
                  },
                      "Home Kitchen",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerHomeKitchenAdd()))
                      })
                      : CustomListTile(
                      "assets/Template1/image/Foodie/icons/home-kitchen.png",
                      'Home\nKitchen',
                      "Are you passionate about cooking?\nWe are committed to deliver your\nfavourite snacks at you doorstep.",
                      "Register as Home Chef",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerHomeKitchen()))
                      },
                      Colors.lime[900],
                      12),
                  localstatus == "1"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/market.png",
                      'Local Marcket',
                      "Register as a local supplier",
                      "Register Local Shop",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerFoodMarket()))
                      },
                      Colors.lime[900],
                      10)
                      : localstatus == "2"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/market.png",
                      'Local Marcket',
                      "Your Application is\nunder process",
                      "Tele Verification  Pending",
                          () => {setLocalTimer()},
                      Colors.green,
                      13)
                      : localstatus == "3"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/market.png",
                      'Local Marcket',
                      "Your Application is\nunder process",
                      "Proceed to Documentation",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LocalbusinessUpload()))
                      },
                      Colors.purple,
                      13)
                      : localstatus == "4"
                      ? CustomListTile2(
                      "KFC",
                      "From Kottayam,Kearala",
                      "Member Since Feb 2020",
                      "Local Store", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                bottomNavBarLocalShop()));
                  },
                      "Local Store",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerFoodMarketAdd()))
                      })
                      : CustomListTile(
                      "assets/Template1/image/Foodie/icons/market.png",
                      'Local\nMarcket',
                      "Register as a local supplier",
                      "Register Local Shop",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerFoodMarket()))
                      },
                      Colors.lime[900],
                      12),
                  restarantstatus == "1"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                      'Restaurant',
                      "We are Launching Soon",
                      "Register Restaurant",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerRestaurant()))
                      },
                      Colors.lime[900],
                      10)
                      : restarantstatus == "2"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                      'Restaurant',
                      "Your Application is\nunder process",
                      "Tele Verification  Pending",
                          () => {setRestTimer()},
                      Colors.green,
                      13)
                      : restarantstatus == "3"
                      ? CustomListTile(
                      "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                      'Restaurant',
                      "Your Application is\nunder process",
                      "Proceed to Documentation",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RestbusinessUpload()))
                      },
                      Colors.purple,
                      13)
                      : restarantstatus == "4"
                      ? CustomListTile2(
                    "Arya Bhavan",
                    "From Kottayam,Kearala",
                    "Member Since Feb 2020",
                    "Restaurant",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  bottomNavBarRestaurant()));
                    },
                    "Restaurant",
                        () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuDrawerRestaurantAdd()))
                    },
                  )
                      : CustomListTile(
                      "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                      'Restaurant',
                      "We are Launching Soon",
                      "Register Restaurant",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerRestaurant()))
                      },
                      Colors.lime[900],
                      12),
                  CustomListTile(
                      "assets/Template1/image/Foodie/icons/Delivery-Warrior.png",
                      'Delivery\nWarrior',
                      'Join our delivery warrior Team\nin Just Few Steps',
                      "Register As Delivery Warrior",
                          () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuDrawerDeliveryWarrior()))
                      },
                      Colors.lime[900],
                      12),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Stack(
              children: <Widget>[
                _body,
              ],
            ),
          ),
          bottomNavigationBar: Container(decoration: BoxDecoration(
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
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/home.png",
                        height: 23,
                        color: Color(0xFFffd55e),
                        width: 23,
                      ),
                      Text("Home", style: f15y,)
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => BottomChat()
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
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Form22()
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => purchase()
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/Template1/image/Foodie/icons/shopping-basket.png",
                          height: 23,
                          color: Colors.white54,
                          width: 23,
                        ),
                        Text("Purchase", style: f14w54,)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CartScreenT1()
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                            "assets/Template1/image/Foodie/icons/cart.png",
                            height: 23, color: Colors.white54, width: 23),
                        Text("Cart", style: f14w54,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        _con.timelinePostData.length != 0
            ? SlidingUpPanelWidget(
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xFF1E2026),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23.0),
                  topRight: Radius.circular(23.0),
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    panelController.hide();
                  },
                  child: Container(
                    height: 40,
                    decoration: ShapeDecoration(
                      color: Color(0xFF23252E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(23.0),
                          topRight: Radius.circular(23.0),
                        ),
                      ),
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Center(
                      child: Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF48c0d8),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, top: 5, right: 10, left: 10),
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        controller: scrollController,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 35.0,
                                width: 35.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: repo.AbtInfo != null
                                            ? CachedNetworkImageProvider(
                                            userPIC)
                                            : CachedNetworkImageProvider(
                                          "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(180.0))),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      NAME,
                                      style: f15wB,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF23252E),
                                      borderRadius:
                                      BorderRadius.circular(8)),
                                  child: Center(
                                    child: TextField(
                                      controller: _sharee,
                                      // controller: _loc,
                                      style:
                                      TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                          "    Write a Message....",
                                          hintStyle: f14g),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        _con.shareTimelinePost(
                                            userid.toString(), _sharee.text,
                                            postid.toString());
                                        panelController
                                            .hide();
                                      },
                                      child: Container(
                                        height: 28,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFffd55e),
                                            borderRadius:
                                            BorderRadius.circular(8)),
                                        child: Center(
                                            child: Text(
                                              "Share Now",
                                              style: f14B,
                                            )),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await postImage == "yes"
                                  ? launch("https://wa.me/?text=" +
                                  sharePost.toString())
                                  : launch("https://wa.me/?text=" +
                                  sharePost.toString());
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/Template1/image/Foodie/wtsp.png",
                                    height: 33,
                                    width: 33,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Sent in WhatsApp",
                                    style: f14w,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: InkWell(
                              onTap: () async {
                                _shareText();
                              },
                              child: Container(
                                height: 35,
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/Template1/image/Foodie/icons/share.png",
                                      height: 18,
                                      width: 18,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "More Options...",
                                      style: f14w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 43,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                  color: Color(0xFF23252E),
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextField(
                                // controller: _loc,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.white54,
                                      size: 20,
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    hintStyle: f14g),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          image: DecorationImage(
                                              image:
                                              CachedNetworkImageProvider(
                                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                errorListener: () =>
                                                new Icon(Icons.error),
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(180.0))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14w,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14g,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d9),
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        "Send",
                                        style: f14wB,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 5, bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          image: DecorationImage(
                                              image:
                                              CachedNetworkImageProvider(
                                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                errorListener: () =>
                                                new Icon(Icons.error),
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(180.0))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14w,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14g,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d9),
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        "Send",
                                        style: f14wB,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 5, bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          image: DecorationImage(
                                              image:
                                              CachedNetworkImageProvider(
                                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                errorListener: () =>
                                                new Icon(Icons.error),
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(180.0))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14w,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14g,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d9),
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        "Send",
                                        style: f14wB,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 5, bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          image: DecorationImage(
                                              image:
                                              CachedNetworkImageProvider(
                                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                errorListener: () =>
                                                new Icon(Icons.error),
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(180.0))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14w,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14g,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d9),
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        "Send",
                                        style: f14wB,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 5, bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          image: DecorationImage(
                                              image:
                                              CachedNetworkImageProvider(
                                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                errorListener: () =>
                                                new Icon(Icons.error),
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(180.0))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14w,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14g,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d9),
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        "Send",
                                        style: f14wB,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 5, bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          image: DecorationImage(
                                              image:
                                              CachedNetworkImageProvider(
                                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                errorListener: () =>
                                                new Icon(Icons.error),
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(180.0))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14w,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14g,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d9),
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        "Send",
                                        style: f14wB,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 5, bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          image: DecorationImage(
                                              image:
                                              CachedNetworkImageProvider(
                                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                errorListener: () =>
                                                new Icon(Icons.error),
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(180.0))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14w,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "aishwaraya_madhav",
                                          style: f14g,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF48c0d9),
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        "Send",
                                        style: f14wB,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          panelStatus: SlidingUpPanelStatus.hidden,
          controlHeight: 50.0,
          anchor: 0.4,
          panelController: panelController,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.expanded == panelController.status) {
              panelController.collapse();
            } else {
              panelController.expand();
            }
          },
          enableOnTap: true, //Enable the onTap callback for control bar.
        )
            : Container(
          height: 0,
        )
      ],
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

getAvatar(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

getNames(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

class CustomListTile extends StatelessWidget {
  final String img;
  final String text;
  final String botton;
  final Function onTap;
  final String Desc;
  final Color btnclr;
  final double font;

  CustomListTile(this.img, this.text, this.Desc, this.botton, this.onTap,
      this.btnclr, this.font);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        child: InkWell(
          splashColor: Colors.black45,
          child: Card(
            color: Color(0xFF1E2026),
            elevation: 0,
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white12),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF23252E)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          img,
                          height: 30,
                          width: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(text, textAlign: TextAlign.center, style: f11w)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              Desc,
                              style: TextStyle(
                                  fontSize: font, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: onTap,
                              child: Container(
                                height: 35.0,
                                width: 175.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                    color: btnclr),
                                child: Center(
                                  child: Text(
                                    botton,
                                    style: f12w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile2 extends StatelessWidget {
  final String text;
  final String botton;
  final Function onTap;
  final Function addTap;
  final String loc;
  final String Desc;
  final String cat;

  CustomListTile2(this.text, this.loc, this.Desc, this.botton, this.onTap,
      this.cat, this.addTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 15),
      child: Container(
        child: InkWell(
          splashColor: Colors.black45,
          child: Card(
            color: Color(0xFF1E2026),
            elevation: 0,
            child: Container(
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF23252E),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            cat,
                            style: f16wB,
                          ),
                          GestureDetector(
                              onTap: addTap,
                              child: Image.asset(
                                "assets/Template1/image/Foodie/icons/add-item-plus.png",
                                height: 20,
                                width: 20,
                                color: Color(0xFFffd55e),
                              ))
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    splashColor: Colors.black87,
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                            errorListener: () =>
                                            new Icon(Icons.error),
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(180.0))),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    text,
                                    style: f16wB,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    loc,
                                    style: f12g,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    Desc,
                                    style: f12g,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Image.asset(
                              "assets/Template1/image/Foodie/icons/right-arrow.png",
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
//                  Divider(thickness: 1,color: Colors.black87,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
