import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/res_walll.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_about_info_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_blog.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_menu.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_restaurantwall.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_videos.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekitchen_reviews.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../business_following.dart';
import 'package:intl/intl.dart';

import '../business_full_posts.dart';

DateTime _RSDate;
var RSMonth_year;

class RestProf extends StatefulWidget {
  RestProf({Key key, this.timid, this.memberdate, this.pagid,this.currentindex})
      : super(key: key);

  String pagid, timid, memberdate;
  int currentindex;


  @override
  _RestProfState createState() => _RestProfState();
}

class _RestProfState extends StateMVC<RestProf>
    with SingleTickerProviderStateMixin {
  HomeKitchenRegistration _con;

  _RestProfState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  TextEditingController _loc = TextEditingController();
  TabController _tabContoller;
  bool switchControlActInact = false;
  var textHolder = 'Switch is OFF';

  void toggleActiveInactive(bool value) {
    if (switchControlActInact == false) {
      setState(() {
        switchControlActInact = true;
        textHolder = 'Switch is ON';
      });
    } else {
      setState(() {
        switchControlActInact = false;
        textHolder = 'Switch is OFF';
      });
    }
  }

  getHomeKitpageTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pageid_Restaurant = prefs.getString('R_page_id');
  }

  ScrollController _timControoooo;
  static final _containerHeight = 300.0;
  var _fromTop = 0.toDouble();
  var _allowReverse = true, _allowForward = true;
  var _prevOffset = 0.0;
  var _prevForwardOffset = -_containerHeight;
  var _prevReverseOffset = 0.0;

  _scrollListener() {
    double offset12 = _timControoooo.offset;
    var direction = _timControoooo.position.userScrollDirection;

    if (direction == ScrollDirection.reverse) {
      _allowForward = true;
      if (_allowReverse) {
        _allowReverse = false;
        _prevOffset = offset12;
        _prevForwardOffset = _fromTop;
      }

      var difference = offset12 - _prevOffset;
      _fromTop = _prevForwardOffset + difference;
      if (_fromTop > 0) _fromTop = -300;
    } else if (direction == ScrollDirection.forward) {
      _allowReverse = true;
      if (_allowForward) {
        _allowForward = false;
        _prevOffset = offset12;
        _prevReverseOffset = _fromTop;
      }
      var difference = offset12 - _prevOffset;
      _fromTop = _prevReverseOffset + difference;
      if (_fromTop < -_containerHeight) _fromTop = 0;
    }
    setState(() {});
  }

  @override
  void initState() {
    _timControoooo = ScrollController();
    _timControoooo.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
    _con.RestaurantGetProfile(widget.pagid);
    getHomeKitpageTime();
    _tabContoller = TabController(length: 5, vsync: this, initialIndex: widget.currentindex);
    _tabContoller.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var _kitchenDetails = _con.homeKitchenProfileData != null
        ? Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, bottom: 2, top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 43,
                            width: 43,
                            child: Center(
                              child: GestureDetector(
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(_con
                                              .homeKitchenProfileData[
                                          "data"][0]["profile_image"] !=
                                              null
                                              ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                              _con.homeKitchenProfileData["data"][0]
                                              ["profile_image"] +
                                              "?alt=media"
                                              : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                              "icu.png" +
                                              "?alt=media"),
                                          fit: BoxFit.cover),
                                      border: Border.all(color: _con
                                          .homeKitchenProfileData[
                                      "data"][0]["profile_image"] ==
                                          null ? Color(0xFF48c0d8) : Colors.transparent),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(180.0))),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:18,top: 10),
                            child: Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150),
                                  color: Color(0xFF1E2026)
                              ),
                              child: Center(
                                child: Container(height: 17,
                                  width: 17,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(150),
                                      color: Color(0xFF48c0d8)
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/tray.png",
                                      height: 12,
                                      width: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          child: GestureDetector(
                            onTap: () {
//                        Navigator.push(context, MaterialPageRoute(
//                            builder: (context)=> TimelineFoodWallDetailPage()
//                        ));
                            },
                            child: Container(width: MediaQuery.of(context).size.width-170,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      _con.homeKitchenProfileData["data"][0]
                                          ["name"],maxLines: 1,overflow: TextOverflow.ellipsis,
                                      style: f16wB),
                                  Text("From " + _con.homeKitchenProfileData["data"]
                                  [0]["address"],
                                    style: f13g,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  Text(
                                      "Member Since " +
                                          DateFormat.yMMMd()
                                              .format(DateTime.parse(
                                                  _con.homeKitchenProfileData[
                                                          "data"][0]["created_at"]
                                                      ["date"]))
                                              .toString(),maxLines: 1,overflow: TextOverflow.ellipsis,
                                      style: f11g),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: userid.toString() !=
                                        _con.homeKitchenProfileData["data"][0]
                                                ["account_id"]
                                            .toString()
                                    ? GestureDetector(
                                        onTap: () {
                                          try {
                                            String chatID = makeChatId(
                                                timelineIdFoodi.toString(),
                                                widget.timid
                                                    .toString());
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ChatRoom(
                                                        timelineIdFoodi,
                                                        NAME,
                                                        _con.homeKitchenProfileData["data"][0]
                                                                ["device_token"]
                                                            .toString(),
                                                        widget.timid
                                                            .toString(),
                                                        chatID,
                                                        _con.homeKitchenProfileData["data"][0]["username"]
                                                            .toString(),
                                                        _con.homeKitchenProfileData["data"]
                                                        [0][
                                                        "name"]
                                                            .toString(),
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.homeKitchenProfileData["data"]
                                                        [0]
                                                        ["profile_image"]
                                                            .toString()
                                                            .replaceAll(" ", "%20") +
                                                            "?alt=media",
                                                        "")));
                                          } catch (e) {
                                            print(e.message);
                                          }
                                        },
                                        child: Icon(
                                          Icons.chat,
                                          size: 25,
                                          color: Color((0xFFffd55e)),
                                        ))
                                    : Container(),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              userid.toString() !=
                                      _con.homeKitchenProfileData["data"][0]
                                              ["account_id"]
                                          .toString()
                                  ? GestureDetector(
                                      onTap: () {
                                        if (_con.homeKitchenProfileData["data"]
                                                [0]["following_status"] ==
                                            true) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      Color(0xFF1E2026),
                                                  content: new Text(
                                                    "Do you want to Unfollow " +
                                                        _con.homeKitchenProfileData[
                                                                "data"][0]
                                                                ["name"]
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
                                                            widget.pagid
                                                                .toString(),
                                                            userid.toString(),
                                                            "1");
                                                        setState(() {
                                                          _con.homeKitchenProfileData[
                                                                      "data"][0]
                                                                  [
                                                                  "following_status"] =
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
                                            _con.homeKitchenProfileData["data"]
                                                [0]["following_status"] = true;
                                          });
                                          _con.BusinessFollowunFollow(
                                              widget.pagid.toString(),
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
                                              child: _con.homeKitchenProfileData[
                                                              "data"][0][
                                                          "following_status"] ==
                                                      true
                                                  ? Text("Unfollow",
                                                      style: f14B)
                                                  : Text("Follow",
                                                      style: f14B)),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                  _con.homeKitchenProfileData["data"][0]
                                          ["rating"]
                                      .toString(),
                                  style: f11wB),
                              SizedBox(
                                width: 2,
                              ),
                              Text("Ratings", style: f11w),
                            ],
                          ),
                          //
                          // Text("5 Ratings  28 Votes",style: TextStyle(color: Colors.white,fontSize: 10),),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : Container();
    var _shareBagde = _con.homeKitchenProfileData != null
        ? Padding(
            padding:
                const EdgeInsets.only(top: 4.0, bottom: 3, right: 8, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Restaurant", style: f14w),
                        Row(
                          children: <Widget>[
                            Text("See Arya Bhavan", style: f14w),
                            Container(height: 20,alignment: Alignment.centerLeft,
                              child: MaterialButton(
                                splashColor: Color(0xFF48c0d8),
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BusinessAboutInfo(
                                                typ: "3",
                                                pagid: widget.pagid,
                                                timid: widget.timid,
                                              )));
                                },
                                child: Text("About Info", style: f14y),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/share.png",
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),

                    ],
                  ),
                )
              ],
            ),
          )
        : Container();
    var _follow = _con.homeKitchenProfileData != null
        ? Padding(
            padding:
                EdgeInsets.only(left: 3.0, right: 3.0, top: 2, bottom: 10),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 38.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF23252E),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5.0,
                          spreadRadius: 0.0)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>BusinessPosts(id: widget.timid,type: "3",
                              pagid: widget.pagid,timid: widget.timid,memberdate: widget.memberdate,)
                          ));
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              _con.homeKitchenProfileData["counts"][0]["posts"]
                                  .toString(),
                              style: f14bB,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Posts",
                              style: f14wB,
                            ),
                          ],
                        ),
                      ),
                      //Color(0xFF48c0d9),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BusinessFollowingPage(
                                        pageId: widget.pagid.toString(),
                                        type: "3",
                                      )));
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                                _con.homeKitchenProfileData["counts"][0]
                                        ["following"]
                                    .toString(),
                                style: f14bB),
                            SizedBox(
                              width: 3,
                            ),
                            Text("Followers", style: f14wB),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        : Container();
    var _tabModules = Container(
      child: Padding(
          padding: EdgeInsets.only(top: _fromTop != 0 ? 7 : 300),
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
                child: _fromTop != 0
                    ? Container(
                        height: 40,
                        child: TabBar(
                          indicator: BoxDecoration(
                              color: Color((0xFFffd55e)),
                              borderRadius: BorderRadius.circular(4)),
                          controller: _tabContoller,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.white,
                          indicatorColor: Colors.transparent,
                          tabs: <Widget>[
                            Tab(
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
                                      )),
                            Tab(
                                icon: _tabContoller.index == 1
                                    ? Image.asset(
                                        "assets/Template1/image/Foodie/icons/Menu.png",
                                        height: 24,
                                        width: 24,
                                        color: Colors.black,
                                      )
                                    : Image.asset(
                                        "assets/Template1/image/Foodie/icons/Menu.png",
                                        height: 24,
                                        width: 24,
                                        color: Colors.white,
                                      )),
                            Tab(
                                icon: _tabContoller.index == 2
                                    ? Image.asset(
                                        "assets/Template1/image/Foodie/icons/Videos.png",
                                        height: 24,
                                        width: 24,
                                        color: Colors.black,
                                      )
                                    : Image.asset(
                                        "assets/Template1/image/Foodie/icons/Videos.png",
                                        height: 24,
                                        width: 24,
                                        color: Colors.white,
                                      )),
                            Tab(
                                icon: _tabContoller.index == 3
                                    ? Image.asset(
                                        "assets/Template1/image/Foodie/icons/rating.png",
                                        height: 24,
                                        width: 24,
                                        color: Colors.black,
                                      )
                                    : Image.asset(
                                        "assets/Template1/image/Foodie/icons/rating.png",
                                        height: 24,
                                        width: 24,
                                        color: Colors.white,
                                      )),
                            Tab(
                                icon: _tabContoller.index == 4
                                    ? Image.asset(
                                        "assets/Template1/image/Foodie/icons/blog.png",
                                        height: 24,
                                        width: 24,
                                        color: Colors.black,
                                      )
                                    : Image.asset(
                                        "assets/Template1/image/Foodie/icons/blog.png",
                                        height: 24,
                                        width: 24,
                                        color: Colors.white,
                                      )),
                          ],
                        ),
                      )
                    : Container(
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
                                    "Restaurantwall",
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
                                        )),
                              Tab(
                                  child: Text(
                                    "Menu",
                                    style: f14,
                                    textAlign: TextAlign.center,
                                  ),
                                  icon: _tabContoller.index == 1
                                      ? Image.asset(
                                          "assets/Template1/image/Foodie/icons/Menu.png",
                                          height: 24,
                                          width: 24,
                                          color: Colors.black,
                                        )
                                      : Image.asset(
                                          "assets/Template1/image/Foodie/icons/Menu.png",
                                          height: 24,
                                          width: 24,
                                          color: Colors.white,
                                        )),
                              Tab(
                                  child: Text(
                                    "Videos",
                                    style: f14,
                                    textAlign: TextAlign.center,
                                  ),
                                  icon: _tabContoller.index == 2
                                      ? Image.asset(
                                          "assets/Template1/image/Foodie/icons/Videos.png",
                                          height: 24,
                                          width: 24,
                                          color: Colors.black,
                                        )
                                      : Image.asset(
                                          "assets/Template1/image/Foodie/icons/Videos.png",
                                          height: 24,
                                          width: 24,
                                          color: Colors.white,
                                        )),
                              Tab(
                                  child: Text(
                                    "Reviews",
                                    style: f14,
                                    textAlign: TextAlign.center,
                                  ),
                                  icon: _tabContoller.index == 3
                                      ? Image.asset(
                                          "assets/Template1/image/Foodie/icons/rating.png",
                                          height: 24,
                                          width: 24,
                                          color: Colors.black,
                                        )
                                      : Image.asset(
                                          "assets/Template1/image/Foodie/icons/rating.png",
                                          height: 24,
                                          width: 24,
                                          color: Colors.white,
                                        )),
                              Tab(
                                  child: Text(
                                    "Blog",
                                    style: f14,
                                    textAlign: TextAlign.center,
                                  ),
                                  icon: _tabContoller.index == 4
                                      ? Image.asset(
                                          "assets/Template1/image/Foodie/icons/blog.png",
                                          height: 24,
                                          width: 24,
                                          color: Colors.black,
                                        )
                                      : Image.asset(
                                          "assets/Template1/image/Foodie/icons/blog.png",
                                          height: 24,
                                          width: 24,
                                          color: Colors.white,
                                        )),
                            ],
                          ),
                          preferredSize: Size.fromHeight(100),
                        ),
                      ),
              ),
              Container(
                height: _fromTop != 0
                    ? MediaQuery.of(context).size.height - 137
                    : MediaQuery.of(context).size.height - 460,
                // padding: EdgeInsets.only(bottom: 200),
                child: TabBarView(
                  controller: _tabContoller,
                  children: <Widget>[
                    OtherRestaurantwall(
                      pagid: widget.pagid,
                      timid: widget.timid,
                      controo: _timControoooo,
                      contheight: _fromTop != 0
                          ? MediaQuery.of(context).size.height - 133
                          : MediaQuery.of(context).size.height - 453,
                    ),
                    BusinessRestaurantMenu(
                      pagid: widget.pagid,
                      timid: widget.timid,
                      controo: _timControoooo,
                    ),
                    BusinessRestaurantVideos(
                      controo: _timControoooo,
                    ),
                    BusinessHomeKitchenReviews(
                      controo: _timControoooo,
                    ),
                    BusinessRestaurantBlog(
                      contro: _timControoooo,timid: widget.timid,
                    )
                  ],
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
      child: Stack(
        children: [
          _tabModules,
          Positioned(
            top: _fromTop,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/Template1/image/Foodie/rest_back.jpeg",fit: BoxFit.cover,),
                ),
                _kitchenDetails,
                _shareBagde,
                _follow,
              ],
            ),
          ),
        ],
      ),
    );

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
      body: _con.homeKitchenProfileData != null
          ? Stack(
              children: <Widget>[
                _body,
              ],
            )
          : Center(
              child: CircularProgressIndicator(
              backgroundColor: Color(0xFF48c0d8),
            )),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black87))),
        child: InkWell(
          splashColor: Colors.black45,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                //Icon(Icons.arrow_right, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
