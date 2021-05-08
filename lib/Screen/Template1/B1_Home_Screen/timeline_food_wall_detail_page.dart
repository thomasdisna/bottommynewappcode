import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/rendering.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/CHAT/conversation_screen.dart';
import 'package:Butomy/CHAT/database.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/ANOTHERPERSON/othervideos.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/ANOTHERPERSON/otherwall.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_blog.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_food_bank.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_food_marcket.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_food_reviews.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Controllers/TimelineController/timelineWallController.dart';
import 'ANOTHERPERSON/follwers&followings.dart';
import 'ANOTHERPERSON/other_about_info.dart';
import 'ANOTHERPERSON/otherblog.dart';
import 'ANOTHERPERSON/posts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

var UserIdprefs;
var userInformation;
DateTime _date;
var f;
class TimelineFoodWallDetailPage extends StatefulWidget {
  TimelineFoodWallDetailPage({Key key, this.id}) : super(key: key);
  String id;

  @override
  _TimelineFoodWallDetailPageState createState() =>
      _TimelineFoodWallDetailPageState();
}

bool settingsFlag = false;
bool helpFlag = false;
var sharePost;
var postImage;
var postDesc;
class _TimelineFoodWallDetailPageState
    extends StateMVC<TimelineFoodWallDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _tabContoller;
  int currentIndex = 0;
  TimelineWallController _con;

  _TimelineFoodWallDetailPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  Future<String> removerPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  ScrollController _timdetControoooo;
  static final _containerHeight = 156.0;
  var _fromTop = 0.toDouble();
  var _allowReverse = true, _allowForward = true;
  var _prevOffset = 0.0;
  var _prevForwardOffset = -_containerHeight;
  var _prevReverseOffset = 0.0;

  _scrollListener() {
    double offset12 = _timdetControoooo.offset;
    var direction = _timdetControoooo.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {

      _allowForward = true;
      if (_allowReverse) {
        _allowReverse = false;
        _prevOffset = offset12;
        _prevForwardOffset = _fromTop;
      }

      var difference = offset12 - _prevOffset;
      _fromTop = _prevForwardOffset + difference;
      if (_fromTop > 0) _fromTop =  -156;
    } else if (direction == ScrollDirection.forward) {
      _allowReverse = true;
      if (_allowForward) {
        _allowForward = false;
        _prevOffset = offset12;
        _prevReverseOffset = _fromTop;
      }
      var difference = offset12 - _prevOffset;
      _fromTop = _prevReverseOffset + difference;
      if (_fromTop < -_containerHeight) _fromTop =0;

    }
    setState(() {});
    if (_timdetControoooo.offset >= _timdetControoooo.position.maxScrollExtent &&
        !_timdetControoooo.position.outOfRange) {
      setState(() {
        starttim=_con.timelinePostData.length;
        _con.getTimelineWall(userid.toString());
      });
    }
    if (_timdetControoooo.offset <= _timdetControoooo.position.minScrollExtent &&
        !_timdetControoooo.position.outOfRange) {
      setState(() {

      });

    }
  }

  @override
  void initState() {
    _timdetControoooo = ScrollController();
    _timdetControoooo.addListener(_scrollListener);
    // TODO: implement initState
    _con.getOtherAbout(widget.id,userid.toString());
    super.initState();
    _tabContoller = TabController(length: 6, vsync: this);
    _tabContoller.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  void onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<void> _shareText() async {
    try {
          Share.text('Share Foodiz Post',
          sharePost, 'text/plain');
    } catch (e) {
     // print('error: $e');
    }
  }



  createChatroomAndStartConversation({String cusUserNAME, String CusImage,String cusNAME}) {
    String chatRoomId = getChatRoomId(cusUserNAME, userNAME);
    String avatars = getAvatar(CusImage, userPIC);
    String names = getNames(cusNAME, NAME);
    List<String> users = [cusUserNAME, userNAME];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "avatars": avatars,
      "chatroomId": chatRoomId,
      "names":names
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ConversationScreen(chatRoomId, CusImage, cusNAME,cusUserNAME)));
  }

  @override
  Widget build(BuildContext context) {
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
      body: _con.saveOtherUserInfo != null
          ? Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: _fromTop,
              left: 0,
              right: 0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Container(
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
                                GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                backgroundColor: Color(
                                                    0xFF1E2026),
                                                content: CachedNetworkImage(
                                                  imageUrl: _con
                                                      .saveOtherUserInfo["data"][0]
                                                  ["picture"]
                                                      .toString().replaceAll(" ", "%20")+"?alt=media",
                                                  height: 250,
                                                  fit: BoxFit
                                                      .fitWidth,
                                                ),
                                              ));
                                    },
                                    child: Stack(alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          child: Center(
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundImage:
                                              CachedNetworkImageProvider(_con
                                                  .saveOtherUserInfo["data"][0]
                                              ["picture"]
                                                  .toString().replaceAll(" ", "%20")+"?alt=media"),
                                            ),
                                          ),
                                        ),
                                        _con.saveOtherUserInfo["data"][0]["req_verified_user"].toString() == "1" ? Padding(
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
                                                    color: Colors.blue[700]
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/star.png",
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ) : Container(height: 0,)
                                      ],
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    child: GestureDetector(
                                      onTap: () {

                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
//                                         Text("Alexander", style: f16wB),
                                          Text(
                                              _con.saveOtherUserInfo["data"]
                                              [0]["name"]
                                                  .toString(),
                                              style: f16wB),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text("Member Since "+DateFormat.yMMMd().format(DateTime.parse(
                                              _con.saveOtherUserInfo["data"]
                                              [0]
                                              ["created_at"]["date"])).toString(),
                                              style: f11g),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            userid.toString() !=
                                _con.saveOtherUserInfo["data"][0]["id"]
                                    .toString()
                                ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 5),
                                  child: GestureDetector(
                                      onTap: () {

                                        try {
                                          String chatID = makeChatId(timelineIdFoodi.toString(), _con.saveOtherUserInfo["data"][0]['timeline_id'].toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ChatRoom(
                                                    timelineIdFoodi, NAME, _con.saveOtherUserInfo["data"][0]
                                                  ['device_token'].toString(),
                                                    _con.saveOtherUserInfo["data"][0]
                                                    ['timeline_id'].toString(), chatID,
                                                    _con.saveOtherUserInfo["data"][0]['username'].toString(), _con.saveOtherUserInfo["data"][0]['name'].toString(),
                                                    _con.saveOtherUserInfo["data"][0]['picture'].toString().replaceAll(" ", "%20") + "?alt=media","")));
                                        } catch (e) {print(e.message);}

                                      },
                                      child: Icon(
                                        Icons.chat,
                                        size: 25,
                                        color: Color((0xFFffd55e)),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 5),
                                  child:
                                  _con
                                      .saveOtherUserInfo["data"][0]
                                  ["follow_status"]==true ? GestureDetector(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (
                                              BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Color(
                                                  0xFF1E2026),
                                              content: new Text(
                                                "Do you want to Unfollow "+_con.saveOtherUserInfo["data"][0]['name'].toString()+" ?",
                                                style: f14w,
                                              ),
                                              actions: <
                                                  Widget>[
                                                MaterialButton(
                                                  height: 28,
                                                  color: Color(0xFFffd55e),
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
                                                MaterialButton(
                                                  height: 28,
                                                  color: Color(0xFF48c0d8),
                                                  child: new Text(
                                                    "Unfollow",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black),
                                                  ),
                                                  onPressed: () {
                                                    _con.followerController(userid,widget.id);
                                                   setState(() {  _con
                                                       .saveOtherUserInfo["data"][0]
                                                   ["follow_status"]=false;});
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
                                      height: 23,
                                      width:   80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                          color: Color(0xFF48c0d8)),
                                      child: Center(
                                          child: Text(
                                            "Unfollow",
                                            style: f14B,
                                          ))
                                    ),
                                  ) :
                                  GestureDetector(
                                    onTap: (){
                                      _con.followerController(userid,widget.id);
                                      setState(() {
                                        _con.saveOtherUserInfo["data"][0]
                                      ["follow_status"]=true;});
                                    },
                                    child: Container(
                                      height: 23,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                          color: Color(0xFF48c0d8)),
                                      child: Center(
                                          child: Text(
                                            "Follow",
                                            style: f14B,
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            )
                                : Container(
                              height: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0, bottom: 3, right: 8, left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Business", style: f14w),
                              Row(
                                children: <Widget>[
                                  Text("See "+ _con.saveOtherUserInfo["data"]
                                  [0]["name"]
                                      .toString(), style: f14w),
                                  Container(height: 20,alignment: Alignment.centerLeft,
                                    child: MaterialButton(
                                      splashColor: Color(0xFF48c0d8),
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OtherAboutInfo(id: widget.id.toString(),)));
                                      },
                                      child: Text("About Info", style: f14y),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/foodbank member badge.png",
                            height: 45,
                            width: 45,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 3.0, right: 3.0, top: 5, bottom: 10),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 38.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xFF23252E),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AnotherPersonalPosts(
                                                    id: _con
                                                        .saveOtherUserInfo[
                                                    "data"][0]["timeline_id"]
                                                        .toString(),
                                                  )));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          //"129",
                                          _con.saveOtherUserInfo["counts"][0]
                                          ["posts"]
                                              .toString(),
                                          style: f14bB,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          //  _con.saveUserInfo["counts"][0]["following"].toString(),
                                          "Posts ",
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
                                              builder: (context) =>
                                                  OtherFollowers(
                                                    statusIndex: 0,
                                                    id: _con
                                                        .saveOtherUserInfo[
                                                    "data"][0]["id"]
                                                        .toString(),
                                                    followers: _con
                                                        .saveOtherUserInfo[
                                                    "counts"][0]
                                                    ["followers"]
                                                        .toString(),following:  _con.saveOtherUserInfo["counts"][0]
                                                  ["following"]
                                                      .toString(),
                                                  )));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          //"1.7K",
                                          _con.saveOtherUserInfo["counts"][0]
                                          ["followers"]
                                              .toString(),
                                          style: f14bB,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "Followers",
                                          style: f14wB,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OtherFollowers(
                                                    statusIndex: 1,
                                                    id: _con
                                                        .saveOtherUserInfo[
                                                    "data"][0]["id"]
                                                        .toString(),
                                                    followers: _con
                                                        .saveOtherUserInfo[
                                                    "counts"][0]
                                                    ["followers"]
                                                        .toString(),following:  _con.saveOtherUserInfo["counts"][0]
                                                  ["following"]
                                                      .toString(),
                                                  )));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          //"71",
                                          _con.saveOtherUserInfo["counts"][0]
                                          ["following"]
                                              .toString(),
                                          style: f14bB,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("Following", style: f14wB),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top:_fromTop!=0 ?7 : 150),
              child: Column(
                children: <Widget>[

                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 2, right: 4, left: 4),
                        child: Column(
                          children: <Widget>[
                            _fromTop!=0 ?  Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFF23252E),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                        Colors.black.withOpacity(0.1),
                                        blurRadius: 5.0,
                                        spreadRadius: 0.0)
                                  ]),
                              child: TabBar(
                                indicator: BoxDecoration(
                                    color: Color((0xFFffd55e)),
                                    borderRadius:
                                    BorderRadius.circular(4)),
                                labelColor: Colors.black,
                                controller: _tabContoller,
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
                                    ),
                                  ),
                                  Tab(
                                    icon: _tabContoller.index == 1
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
                                    ),
                                  ),
                                  Tab(
                                    icon: _tabContoller.index == 2
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
                                    ),
                                  ),
                                  Tab(
                                    icon: _tabContoller.index == 3
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
                                    icon: _tabContoller.index == 4
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
                                      icon: _tabContoller.index == 5
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
                            ) :
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF23252E),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                        Colors.black.withOpacity(0.1),
                                        blurRadius: 5.0,
                                        spreadRadius: 0.0)
                                  ]),
                              child: PreferredSize(
                                child: TabBar(
                                  isScrollable: true,
                                  indicator: BoxDecoration(
                                      color: Color((0xFFffd55e)),
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  labelColor: Colors.black,
                                  controller: _tabContoller,
                                  unselectedLabelColor: Colors.white,
                                  indicatorColor: Colors.transparent,
                                  tabs: <Widget>[
                                    Tab(
                                      child: Text(
                                        "Foodie Wall",
                                        style: f14,
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
                                      child: Text("Videos", style: f14),
                                      icon: _tabContoller.index == 1
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
                                      ),
                                    ),
                                    Tab(
                                      child:
                                      Text("Foodie Review", style: f14),
                                      icon: _tabContoller.index == 2
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
                                      ),
                                    ),
                                    Tab(
                                      child:
                                      Text("Foodie Market", style: f14),
                                      icon: _tabContoller.index == 3
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
                                      child: Text("Food Bank", style: f14),
                                      icon: _tabContoller.index == 4
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
                                          "Blog",
                                          style: f14,
                                          textAlign: TextAlign.center,
                                        ),
                                        icon: _tabContoller.index == 5
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
                            Container(
                              height: _fromTop!=0 ?  MediaQuery.of(context).size.height - 139 :
                              MediaQuery.of(context).size.height - 316,
                              child: TabBarView(
                                controller: _tabContoller,
                                children: <Widget>[
                                  _tabContoller.index == 0? OtherAccountFoodWall(id: widget.id
                                      .toString(),wallContro: _timdetControoooo,timid:_con
                                      .saveOtherUserInfo["data"][0]
                                  ["timeline_id"].toString() ,) : Container(),
                                  _tabContoller.index == 1 ?   OtherAccountVideos(id: widget.id
                                      .toString(), timid: _con
                                      .saveOtherUserInfo["data"][0]
                                  ["timeline_id"].toString(),followstatus: _con
                                      .saveOtherUserInfo["data"][0]
                                  ["follow_status"],memerdate: DateFormat.yMMMd().format(DateTime.parse(
                                      _con.saveOtherUserInfo["data"]
                                      [0]
                                      ["created_at"]["date"])).toString(),videoContro: _timdetControoooo,) : Container(),
                                  _tabContoller.index == 2 ? AccountFoodReviews(reviwcontro: _timdetControoooo,) : Container(),
                                  _tabContoller.index == 3 ?  AccountFoodMarcket(marketcontro: _timdetControoooo,pageid: Market_pageid.toString(),) : Container(),
                                  _tabContoller.index == 4 ? AccountFoodBank(bankControo: _timdetControoooo,pageid: _con
                                      .saveOtherUserInfo["data"][0]
                                  ["foodbank_pageid"].toString(),): Container(),
                                  _tabContoller.index == 5 ? AnotherAccountBlog(blogContro: _timdetControoooo,timlineid: _con
                                      .saveOtherUserInfo["data"][0]
                                  ["timeline_id"].toString(),) : Container()
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                  //nearYou,
                  // _popular,
                ],
              ),
            ),
          ],
        ),
      )
          : Center(
          child: CircularProgressIndicator(
            backgroundColor: Color(0xFF48c0d8),
          )),
    );
  }
}


getChatRoomId(String a, String b) {
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

getAvatar(String a, String b) {
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)) {
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

