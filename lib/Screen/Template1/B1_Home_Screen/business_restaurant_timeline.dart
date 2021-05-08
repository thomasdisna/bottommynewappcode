import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_Restaurant_Product_List_Page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/business_finance.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_about_info_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_qr_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_blog.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_menu.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_new_entry.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_orders.dart';
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
import 'Search_Screen/Search_Screen_T1.dart';
import 'business_following.dart';
import 'business_full_posts.dart';
DateTime _RSDate;
var RSMonth_year;
class BusinessRestaurantTimeline extends StatefulWidget {
  BusinessRestaurantTimeline({Key key,this.timid,this.memberdate,this.pagid,this.upld}) : super(key: key);

  String pagid,timid,memberdate;
  bool upld;

  @override
  _BusinessRestaurantTimelineState createState() =>
      _BusinessRestaurantTimelineState();
}

class _BusinessRestaurantTimelineState extends StateMVC<BusinessRestaurantTimeline> with SingleTickerProviderStateMixin {
  HomeKitchenRegistration _con;
  _BusinessRestaurantTimelineState() : super(HomeKitchenRegistration()) {
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
  getHomeKitpageTime() async{
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
      if (_fromTop > 0) _fromTop =  -300;
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

  }
  @override
  void initState() {
    FirebaseController.instanace.updateToken(widget.timid.toString(),fire_token.toString());
    FirebaseController.instanace.getUnreadMSGCountBusiness(widget.timid).then((value) {
      setState(() {
        businesschatcount=value;
      });
    });
    setState(() {
      _con.homeKitchenProfileData=BusinessProfileData;
    });
    _timControoooo = ScrollController();
    _timControoooo.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
    if(widget.upld==true){
      setState(() {
        resuplldgg=true;
      });
    }
    _con.HomekitchenGetProfile(widget.pagid);
    getHomeKitpageTime();
    _tabContoller = TabController(length: 5, vsync: this);
    _tabContoller.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(backgroundColor: Color(0xFF1E2026),
        contentPadding: EdgeInsets.only(top: 10,left: 10,right: 10),
        title: Image.asset(
          "assets/Template1/image/Foodie/logo_Business.png",
          height: 30,alignment: Alignment.topLeft,
        ),
        titlePadding: EdgeInsets.all(10),
        content: new Text("Dou you want to switch "+Bus_NAME+" to "+NAME.toString()+"?",
          style: f15w,),
        actions:
        <Widget>[
          MaterialButton(
            height: 28,
            color: Color(0xFFffd55e),
            child: new Text(
              "Cancel",
              style: TextStyle(
                  color: Colors
                      .black),
            ),
            onPressed: () => Navigator.of(context).pop(false),

          ),
          SizedBox(width: 15,),
          MaterialButton(
            height: 28,
            color: Color(0xFF48c0d8),
            child: new Text(
              "Switch",
              style: TextStyle(
                  color: Colors
                      .black),
            ),
            onPressed: () => Navigator.of(context).pop(true),

          ),
        ],

      ),
    )) ;
  }


  @override
  Widget build(BuildContext context) {
    var _kitchenDetails = _con.homeKitchenProfileData!=null? Container(
      child: Padding(
        padding:
        const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2, top: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
//                  Navigator.push(context, MaterialPageRoute(
//                      builder: (context)=> TimelineFoodWallDetailPage()
//                  ));
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              _con.homeKitchenProfileData["data"][0]["profile_image"]!=null && _con.homeKitchenProfileData["data"][0]["profile_image"]!="" ?
                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.homeKitchenProfileData["data"][0]["profile_image"]+
                                  "?alt=media": "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media" ,
                              errorListener: () => new Icon(Icons.error),
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(180.0))),
                  ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              _con.homeKitchenProfileData["data"][0]["name"],
                              style: f16wB
                          ),
                          _con.homeKitchenProfileData["data"][0]["current_location"]!=null &&  _con.homeKitchenProfileData["data"][0]["current_location"].toString().length>14 ?
                          Text("From "+_con.homeKitchenProfileData["data"][0]["current_location"].toString().substring(0,14)+"...",
                              style:
                              f13g): _con.homeKitchenProfileData["data"][0]["current_location"].toString()!="null"   || _con.homeKitchenProfileData["data"][0]["current_location"]!=null?
                          Text("From "+_con.homeKitchenProfileData["data"][0]["current_location"].toString(),style: f13g,) :
                          Text("From "+_con.homeKitchenProfileData["data"][0]["address"].toString(),style:
                          f13g),
                          Text("Member Since "+widget.memberdate.toString(),
                              style:
                              f11g),
                        ],
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
                       /* Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                    new TimelineChatPage()));
                              },
                              child: Icon(
                                Icons.chat,
                                size: 25,
                                color: Color((0xFFffd55e)),
                              )),
                        ),*/
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                      /*  GestureDetector(
                          onTap: () {
                            _con.followerController(userid,pageid_HomeKitchen);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              height: 23,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Color(0xFF48c0d9),
                                  borderRadius: BorderRadius.circular(2)),
                              child: Center(
                                  child:  _con.homeKitchenProfileData["data"][0]["follow_status"]==true?Text(
                                      "Following",
                                      style: f14B
                                  ):Text(
                                      "Follow",
                                      style: f14B
                                  )),

                            ),
                          ),
                        ),*/
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
                            _con.homeKitchenProfileData["data"][0]["rating"].toString(),
                            style: f11wB
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                            "Ratings",
                            style: f11w
                        ),
                        SizedBox(width: 3),
                        Text(
                            "28",
                            style: f11wB
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                            "Votes",
                            style: f11w
                        ),
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
    ) : Container();
    var _shareBagde = _con.homeKitchenProfileData!=null?  Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 3, right: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "Restaurant",
                      style: f14w
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                          "See Arya Bhavan",
                          style:f14w
                      ),

                      Container(height: 20,alignment: Alignment.centerLeft,
                        child: MaterialButton(
                          splashColor: Color(0xFF48c0d8),
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BusinessAboutInfo(typ: "3",pagid: widget.pagid,timid: widget.timid,
                                    )));
                          },
                          child: Text(
                              "About Info",
                              style: f14y
                          ),
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
                Image.asset("assets/Template1/image/Foodie/icons/share.png",
                  height: 20,
                  width: 20,color: Colors.white,),
                SizedBox(
                  width: 15,
                ),

              ],
            ),
          )
        ],
      ),
    ) : Container();
    var _follow =    _con.homeKitchenProfileData!=null ? Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0, top: 5, bottom: 10),
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
                          builder: (context)=>BusinessPosts(id: widget.timid,type: "3",pagid: widget.pagid,timid: widget.timid,memberdate: widget.memberdate,)
                      ));
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          _con.homeKitchenProfileData["counts"][0]["posts"].toString(),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>BusinessFollowingPage(pageId: widget.pagid.toString(),type: "3",)));
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                            _con.homeKitchenProfileData["counts"][0]["following"].toString(),
                            style: f14bB
                        ) ,
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                            "Followers",
                            style: f14wB
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )) : Container();
    var _tabModules = Container(
      child: Padding(
          padding:  EdgeInsets.only(top: _fromTop!=0 ?7 : 300),
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
                child:  _fromTop!=0 ? Container(
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
                ): Container(
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
                              style:f14,
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
                              style:f14,
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
                height: _fromTop!=0 ? MediaQuery.of(context).size.height - 193 : MediaQuery.of(context).size.height - 516,
                // padding: EdgeInsets.only(bottom: 200),
                child: TabBarView(
                  controller: _tabContoller,
                  children: <Widget>[
                    BusinessRestaurantwall(pagid: widget.pagid,timid: widget.timid,controo: _timControoooo,contheight:  _fromTop!=0 ? MediaQuery.of(context).size.height - 196 : MediaQuery.of(context).size.height - 519,),
                    BusinessRestaurantMenu(pagid: widget.pagid,timid: widget.timid,controo: _timControoooo,),
                    BusinessRestaurantVideos(controo: _timControoooo,),
                    BusinessHomeKitchenReviews(controo: _timControoooo,),
                    BusinessRestaurantBlog(contro: _timControoooo,timid: widget.timid,)
                  ],
                ),
              )
            ],
          )),
    );

    var _body = Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          _tabModules,
          Positioned(
            top: _fromTop,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                resuplldgg==true?  ImageUploadProgress() : Container(),
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

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
          actions: <Widget>[
            Row(
              children: <Widget>[

                IconButton(  splashColor: Color(0xFF48c0d8),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new BusinessQRCode(
                            memberdate: widget.memberdate,
                            name: Bus_NAME,
                            pic: Bus_Profile,
                            page_id: widget.pagid,
                            time_id: widget.timid,
                            type: "3",
                          )));
                    },
                    icon: Image.asset(
                      "assets/Template1/image/Foodie/QRcode.png",
                      height: 20,
                      width: 20,
                    )),
                Builder(
                  builder: (context) => IconButton(  splashColor: Color(0xFF48c0d8),
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip:
                    MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                )
              ],
            )
          ],
        ),
        endDrawer: Drawer(
          child: Container(
            color: Color(0xFF1E2026),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top: 20,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text("Online",
                                style: f16wB),
                          ),
                          Transform.scale(
                              scale: .8,
                              child: Switch(
                                onChanged: toggleActiveInactive,
                                value: switchControlActInact,
                                activeColor: Colors.greenAccent[700],
                                activeTrackColor: Colors.grey,
                                inactiveThumbColor: Colors.greenAccent[700],
                                inactiveTrackColor: Colors.grey,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text("Offline",
                                style: f16wB),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 65,
                      color: Colors.grey[850],
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("TODAYS SALES",
                                    style: f11w),
                                SizedBox(
                                  height: 2,
                                ),
                                Text("\u20B9 4500",
                                    style: f11wB),
                                SizedBox(
                                  height: 2,
                                ),
                                Text("12 Orders",
                                    style: f11w),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("WEEK SO FAR",
                                    style: f11w),
                                SizedBox(
                                  height: 2,
                                ),
                                Text("\u20B9 4500",
                                    style: f11wB),
                                SizedBox(
                                  height: 2,
                                ),
                                Text("12 Orders",
                                    style: f11w),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("MONTH SO FAR",
                                    style: f11w),
                                SizedBox(
                                  height: 2,
                                ),
                                Text("\u20B9 4500",
                                    style: f11wB),
                                SizedBox(
                                  height: 2,
                                ),
                                Text("12 Orders",
                                    style: f11w),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                CustomListTile(
                    Icons.info_outline,
                    'Business Info',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BusinessInfo()))
                    }),
                CustomListTile(
                    Icons.av_timer,
                    'Preparation time',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BusinessPreparationTime()))
                    }),
                CustomListTile(
                    Icons.person,
                    'Account Setting',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DrawerHomekitAccountSettings()))
                    }),
                CustomListTile2(
                    "assets/Template1/image/Foodie/icons/order-list.png",
                    'Orders',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BusinessHomeKitchenOrderPage()))
                    }),
                CustomListTile2(
                    "assets/Template1/image/Foodie/icons/inventory.png",
                    'Inventory',
                        () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BusinessRestaurantProductListPage(memberdate: widget.memberdate,pagid: widget.pagid,timid: widget.timid,)))
                    }),
                CustomListTile2(
                    "assets/Template1/image/Foodie/icons/rating.png",
                    'Ratings',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RatingPage()))
                    }),
                CustomListTile2(
                    "assets/Template1/image/Foodie/icons/past-orders.png",
                    'Past Orders',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BusinessOldOrderPage()))
                    }),
                CustomListTile2(
                    "assets/Template1/image/Foodie/icons/money.png",
                    'Finance',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BusinessFinance()))
                    }),
                CustomListTile2(
                    "assets/Template1/image/Foodie/icons/point-of-contact.png",
                    'Point of contact',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DrawerHomekitPointOfContacts()))
                    }),
                CustomListTile(
                    Icons.people_outline,
                    'Partner FAQs',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DrawerHomekitPartner_FAQs()))
                    }),
                CustomListTile2(
                    "assets/Template1/image/Foodie/icons/compliance.png",
                    'Compliances',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DrawerHomekitCompliances()))
                    }),
                CustomListTile2(
                    "assets/Template1/image/Foodie/icons/reports.png",
                    'Reports',
                        () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DrawerHomekitReports()))
                    }),
              ],
            ),
          ),
        ),
        body:Stack(
          children: <Widget>[
            _body,
          ],
        ) ,
       /* bottomNavigationBar: Container(
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
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){
                    *//*Navigator.push(context, MaterialPageRoute(
                      builder: (context) => BusinessRestaurantTimeline(memberdate: widget.memberdate,timid: widget.timid,pagid: widget.pagid,
                       )
                  ));*//*
                  },
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/home.png",
                        height: 21,
                        color: Color(0xFFffd55e),
                        width: 21,
                      ),
                      Text("Home", style: f14y,)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => BusinessRestaurantChatList(memberdate: widget.memberdate,timid: widget.timid,pagid: widget.pagid,
                          myID: userid.toString(),myName: NAME.toString(),)
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
                          builder: (context) => RestaurantNewEntryForm(timid: widget.timid,pagid: widget.pagid,memberdate: widget.memberdate,)
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
                        builder: (context) => BusinessRestaurantProductListPage(memberdate: widget.memberdate,pagid: widget.pagid,timid: widget.timid,)
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/list.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23,
                      ),
                      Text("Item list", style: f14w54,)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => BusinessRestaurantOrderPage(memberdate: widget.memberdate,pagid: widget.pagid,timid: widget.timid,)
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                          "assets/Template1/image/Foodie/icons/order-list.png",
                          height: 23, color: Colors.white54, width: 23),
                      Text("Orders", style: f14w54,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),*/
      ),
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

class ImageUploadProgress extends StatefulWidget {

  @override
  _ImageUploadProgressState createState() => _ImageUploadProgressState();
}

class _ImageUploadProgressState extends State<ImageUploadProgress> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startUpload();
  }

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startUpload() {
    for (var i = 0; i < imageList.length; i++) {
      // var nows = DateTime.now();
      // String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {

        // IMAGELISTS.add(filePath);
        _uploadTask = _storage.ref().child(IMAGELISTS[i]).putFile(imageList[i]);
      });
    }
    // _con.getTimelineWallStart(userid.toString());

  }

  _setval(){
    _uploadTask=null;
    resuplldgg=false;
    imageList=[];
    IMAGELISTS=[];
    Fluttertoast.showToast(
      msg: "Post Uploaded",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return Container();
  }




  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_uploadTask.isComplete)
                    _setval()
                  else
                    LinearProgressIndicator(
                      value: progressPercent,
                      backgroundColor: Colors.grey,
                      minHeight: 4,
                    )
                ]);
          });
    }
  }
}