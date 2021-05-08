import 'dart:async';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_homekitchen_empty_data.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_video_list.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatlist.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_edit_profile.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_address_book_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_favourite_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_orders_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_payments_refunds_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/share_post_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/video_list_detail_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_about_info_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_blog.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_food_bank.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_food_marcket.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_food_reviews.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_referfriend.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_saveditem.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_settings&privacy.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_shareprofile.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_help_community.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_report_problem.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_terms&policies.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_language.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/followers.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/profile_posts_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_requestverification.dart';
import 'package:Butomy/Screen/Template1/OnBoarding_Screen/Choose_Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Controllers/TimelineController/timelineWallController.dart';
import 'ANOTHERPERSON/wall_web_view_page.dart';
import 'New_Entry_Form.dart';
import 'Search_Screen/Search_Screen_T1.dart';
import 'Search_Screen/thumb_vide0_widget.dart';
import 'Search_Screen/video_widget.dart';
import 'account_food_wall.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
as repo;
import 'comments.dart';
import 'edit_post.dart';
import 'hashtag_search_page.dart';
import 'like_comment_share_count_page.dart';

var textSpan;
var UserIdprefs;
var userInformation;
var httpsObj = "https://img.youtube.com/vi/";
var thirdHttp = "/0.jpg";
var imgHtp;
var s = "unlike";
var b = "unmark";
bool video;
DateTime _date;
var f;
var d;
var sharePost;
var postImage;
DateTime _join;
var postDesc;
List<String> playlist;
var namePass, youtubeIdPass, titlePass, DescPass, LikePass, CommentPass,
    SharePass;

class HomeScreenT1 extends StatefulWidget {
  HomeScreenT1({Key key, this.QRData}) : super(key: key);
  String QRData;

  @override
  _HomeScreenT1State createState() => _HomeScreenT1State();
}

bool settingsFlag = false;
bool helpFlag = false;

class _HomeScreenT1State extends StateMVC<HomeScreenT1>
    with SingleTickerProviderStateMixin {

  List<bool> _showutube = List.filled(1000, false);
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  List<bool> _likes = List.filled(100, false);
  List<bool> _save = List.filled(100, false);

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  TabController _tabContoller;
  int currentIndex = 0;
  TimelineWallController _con;

  ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

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

  _HomeScreenT1State() : super(TimelineWallController()) {
    _con = controller;
  }

  TextEditingController _sharee = TextEditingController();

  Future<String> removerPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  ScrollController _accountControo;
  static final _containerHeight = 156.0;
  var _fromTop = 0.toDouble();
  var _allowReverse = true, _allowForward = true;
  var _prevOffset = 0.0;
  var _prevForwardOffset = -_containerHeight;
  var _prevReverseOffset = 0.0;

  _scrollListener() {
    double offset12 = _accountControo.offset;
    var direction = _accountControo.position.userScrollDirection;

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

    if (_accountControo.offset >= _accountControo.position.maxScrollExtent &&
        !_accountControo.position.outOfRange) {
      setState(() {
        starttim=_con.timelinePostData.length;
        _con.getTimelineWall(userid.toString());
      });
    }
    if (_accountControo.offset <= _accountControo.position.minScrollExtent &&
        !_accountControo.position.outOfRange) {
    }
  }

  _postUpdate() async{
    Timer(Duration(seconds: 2),(){
      _con.getAccountWallVideos(timelineIdFoodi.toString(), "video", userid.toString());
    });
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {
      });
    _refreshController.loadComplete();
  }

  Future<void> _getData() async {
    setState(() {
      _con.getAccountWallVideos(timelineIdFoodi.toString(), "video", userid.toString());
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    _con.getOtherAbout1(userid.toString());
    _accountControo = ScrollController();
    _accountControo.addListener(_scrollListener);
    // _con.getAccountWallImage(userid.toString());
    // TODO: implement initState
    setState(() {
      textSpan = false;
    });

    super.initState();
    _con.getAccountWallVideos(timelineIdFoodi.toString(), "video", userid.toString());
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
    _tabContoller = TabController(length: 6, vsync: this);
    _tabContoller.addListener(_handleTabSelection);
    if (_con.AccountWallVideos.length > 0) {
      _con.AccountWallVideos[0]['like_status'] == true
          ? _likes[0] = true
          : _likes[0] = false;
      _con.AccountWallVideos[0]['save_status'] == true
          ? _save[0] = true
          : _save[0] = false;
    }
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post',
          sharePost, 'text/plain');
    } catch (e) {
      // print('error: $e');
    }
  }

  void onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(repo.AbtInfo!=null)

    _con.getFollowing(userid.toString());
    if (_con.AccountWallVideos.length > 0) {
      playlist = <String>[
        "https://www.youtube.com/watch?v=" +
            _con.AccountWallVideos[0]["youtube_video_id"].toString()
      ];
    }
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
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeLine(false)), (route) => false);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/home.png",
                      height: 23,
                      color: Colors.white54,
                      width: 23,
                    ),
                    Text("Home", style: f14w54,)
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
                         chatmsgcount>0 ? Container(
                          height: 14,width: 14,
                          decoration: BoxDecoration(
                              color: Color(0xFF0dc89e),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(child: Text(chatmsgcount.toString(),style: f10B,textAlign: TextAlign.center,)),
                        ) : Container()
                      ],
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
                        builder: (context) => AddNewEntries(videooo: "",vid_show: false,typpp: "",)
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
                    Text("Bucket list", style: f14w54,)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CartScreenT1(null,null,false)
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text("Cart", style: f14w54,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
              IconButton(
                splashColor: Color(0xFF48c0d8),
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
              IconButton(  splashColor: Color(0xFF48c0d8),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new QRCODE()));
                  },
                  icon: Image.asset(
                    "assets/Template1/image/Foodie/QRcode.png",
                    height: 20,
                    width: 20,
                  )),
              Builder(
                builder: (context) =>
                    IconButton(  splashColor: Color(0xFF48c0d8),
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      tooltip:
                      MaterialLocalizations
                          .of(context)
                          .openAppDrawerTooltip,
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
              Container(
                height: 55,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                    //     colors: <Color>[
                    //   Color(0xFF1E2026),
                    //   Colors.black87,
                    // ]
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/Template1/image/Foodie/logo.png",
                      height: 25,
                    ),
                  ),
                ),
              ),
              CustomListTile(Icons.insert_drive_file, 'Recent Orders',() => {Navigator.push(context, MaterialPageRoute(builder: (context) => FoodiOrdersPage()))}),
              CustomListTile(Icons.hourglass_empty, 'Business Kitchen',() => {Navigator.push(context, MaterialPageRoute(builder: (context) => KitchenEmptyList()))}),
              CustomListTile(
                  Icons.insert_drive_file,
                  'Past Orders',
                      () =>
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodiOrdersPage()))
                  }),
              CustomListTile(
                  Icons.bookmark_border,
                  'Saved Items',
                      () =>
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawerAccountSavedItem()))
                  }),
              CustomListTile(
                  Icons.favorite_border,
                  'Favourite Items',
                      () =>
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodiFavouritesPage()))
                  }),
              CustomListTile(
                  Icons.add_location,
                  'Address Book',
                      () =>
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodiAddressBookPage()))
                  }),
              CustomListTile(
                  Icons.payment,
                  'Payments & Refunds',
                      () =>
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodiPaymentsAndRefundsPage()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/share.png",
                  'Share Profile',
                      () =>
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrawerAccountShareProfile()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/refer-a-friend.png",
                  'Refer a Friend',
                      () =>
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrawerAccountReferFriend()))
                  }),
              CustomListTile2(
                  "assets/Template1/image/Foodie/icons/shield.png",
                  'Request Verification',
                      () =>
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrawerAccountRequestVerification(stat: repo.AbtInfo["data"][0]
                                ["req_verified_user"].toString(),showw: repo.AbtInfo["data"][0]["id_proof"]!=null ? "1" : "0",
                                )))
                  }),
              Padding(
                padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      helpFlag = !helpFlag;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/help and support.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 7),
                          Text("Help & Support",
                              textAlign: TextAlign.center, style: f14w),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
              ),
              helpFlag == true
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DrawerAccountHelpCommunity()));
                      },
                      child: Container(
                        height: 60,
                        width: 300,
                        child: Card(
                          color: Color(0xFF23252E),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/Template1/image/Foodie/icons/help and support.png",
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text("Help Community",
                                    textAlign: TextAlign.center,
                                    style: f14w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DrawerAccountReportProblem()));
                      },
                      child: Container(
                        height: 60,
                        width: 300,
                        child: Card(
                          color: Color(0xFF23252E),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/Template1/image/Foodie/icons/report-a-problem.png",
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text("Report a Problem",
                                    textAlign: TextAlign.center,
                                    style: f14w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DrawerAccountTermsPolicies()));
                      },
                      child: Container(
                        height: 60,
                        width: 300,
                        child: Card(
                          color: Color(0xFF23252E),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/Template1/image/Foodie/icons/TERMS-AND-POLICY.png",
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text("Terms & Policies",
                                    textAlign: TextAlign.center,
                                    style: f14w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Container(
                height: 0,
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      settingsFlag = !settingsFlag;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/settings.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 7),
                          Text("Settings & Privacy",
                              textAlign: TextAlign.center, style: f14w),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
              ),
              settingsFlag == true
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DrawerAccountSettingsAndPrivacy()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 60,
                        width: 300,
                        child: Card(
                          color: Color(0xFF23252E),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/Template1/image/Foodie/icons/settings.png",
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text("Settings",
                                    textAlign: TextAlign.center,
                                    style: f14w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DrawerAccountLanguage()));
                      },
                      child: Container(
                        height: 60,
                        width: 300,
                        child: Card(
                          color: Color(0xFF23252E),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.language,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(width: 5),
                                Text("Language",
                                    textAlign: TextAlign.center,
                                    style: f14w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Container(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Colors.black87))),
                  child: InkWell(
                    splashColor: Colors.black45,
                    onTap: ()  {
                      setState(()  {
                        userNAME = "";
                        fire_name = "";
                        fire_id = "";
                        fire_username = "";
                        fire_token = "";
                        NAME = "";
                        userPIC = "";
                        userid = "";
                        postid = "";
                        removerPref();
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                        // the new route
                        MaterialPageRoute(
                          builder: (BuildContext context) => chooseLogin(),
                        ),

                        // this function should return true when we're done removing routes
                        // but because we want to remove all other screens, we make it
                        // always return false
                            (Route route) => false,
                      );
                     /* Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => chooseLogin()));*/
                    },
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Log Out',
                                  style: f14w,
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
              ),
            ],
          ),
        ),
      ),
      body: repo.AbtInfo != null
          ? Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: _fromTop,
              left: 0,
              right: 0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                height:48,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 5.0, bottom: 2, top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                        alignment: Alignment.bottomRight,
                              children: [
                                Container(height: 50,
                            width:50,
                                  
                                  child: Center(
                                    child: GestureDetector(
                                        onTap: () {
//                  Navigator.push(context, MaterialPageRoute(
//                      builder: (context)=> TimelineFoodWallDetailPage()
//                  ));
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                    backgroundColor: Color(
                                                        0xFF1E2026),
                                                    content: CachedNetworkImage(
                                                      imageUrl: userPIC,
                                                      height: 250,
                                                      fit: BoxFit
                                                          .fitWidth,
                                                    ),
                                                  ));
                                        },
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundImage:
                                          CachedNetworkImageProvider(userPIC),
                                        )),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AccountEditPage()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Container(
                                          height: 22,
                                        width: 22,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(150),
                                            color: Color(0xFF1E2026)
                                        ),
                                        child: Center(
                                          child: Container(height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(150),
                                                color: Color(0xFF48c0d8)
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/Template1/image/Foodie/icons/pencil.png",
                                                height: 10,
                                                width: 10,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              width: 10,
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
//                                         Text("Alexander", style: f16wB),
                                      Text(
                                          NAME,
                                          style: f16wB),
                                      SizedBox(height: 3,),
                                      repo.AbtInfo["data"].length>0 ?   Text("Member Since " +
                                         DateFormat.yMMMd().format(DateTime.parse(
                                          repo.AbtInfo["data"][0]
                                          ["created_at"]["date"])).toString(),
                                          style: f11g) : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height:47,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, bottom: 3, right: 8, left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Business", style: f14w),
                                Row(
                                  children: <Widget>[
                                    Text("See " + repo.AbtInfo["data"][0]
                                    ["name"]
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
                                                      AboutInfo()));
                                        },

                                        child: Text("About Info", style: f14y,textAlign: TextAlign.left),
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
                                                  PersonalPosts(tim: timelineIdFoodi.toString(),)));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          //"129",
                                          repo.AbtInfo["counts"][0]["posts"]
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
                                                  Followers(user_id: userid.toString(),
                                                    statusIndex: 0,
                                                    followers: repo
                                                        .AbtInfo["counts"][0]
                                                    ["followers"]
                                                        .toString(),
                                                    following: repo
                                                        .AbtInfo["counts"][0]
                                                    ["following"]
                                                        .toString(),
                                                  )));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          //"1.7K",
                                          repo.AbtInfo["counts"][0]
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
                                                  Followers(user_id: userid.toString(),
                                                    statusIndex: 1,
                                                    followers: repo
                                                        .AbtInfo["counts"][0]
                                                    ["followers"]
                                                        .toString(),
                                                    following: repo
                                                        .AbtInfo["counts"][0]
                                                    ["following"]
                                                        .toString(),
                                                  )));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          //"71",
                                          repo.AbtInfo["counts"][0]
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
              padding:  EdgeInsets.only(top:_fromTop!=0 ?5 : 143),
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
                            ) : Container(
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
                              height:  _fromTop!=0 ?  MediaQuery
                                  .of(context)
                                  .size
                                  .height - 193
                                  :
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height - 365,
                              child: TabBarView(
                                controller: _tabContoller,
                                children: <Widget>[
                                  _tabContoller.index == 0
                                      ? AccountFoodWall(accwallcontro: _accountControo,)
                                      : Container(),
                                  _tabContoller.index == 1
                                      ? SmartRefresher(
                                    enablePullDown: true,
                                    enablePullUp: false,
                                    header: WaterDropMaterialHeader(color: Colors.black,backgroundColor: Color(0xFF0dc89e),),
                                    onRefresh: _getData,
                                    controller: _refreshController,
                                    onLoading: _onLoading,
                                        child: SingleChildScrollView(controller: _accountControo,
                                    child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Visibility(
                                                visible: _con.statusVideo,
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                      top: 100,),
                                                    child: CircularProgressIndicator()
                                                )
                                            ),
                                          ),
                                          _con.AccountWallVideos.length > 0 &&
                                              _con.statusVideo == false
                                              ? Column(
                                            children: <Widget>[
                        //                     _con
                        //                         .AccountWallVideos[
                        //                     0][
                        //                     "youtube_video_id"]
                        //                         .toString()
                        //                         .length == 11 &&
                        //                         _con
                        //                             .AccountWallVideos[
                        //                         0][
                        //                         "youtube_video_id"] !=
                        //                             null
                        //                         ? Column(
                        //                       children: [
                        //                         GestureDetector(
                        //                           onTap:(){
                        //                             Navigator.push(context, MaterialPageRoute(
                        //                                 builder: (context)=>WebViewContainer(
                        //                                   url: 'https://www.youtube.com/watch?v=' +
                        //                                       _con
                        //                                           .AccountWallVideos[
                        //                                       0]
                        //                                       ['youtube_video_id']
                        //                                           .toString(),)
                        //                             ));
                        //                           },
                        //                           child: Padding(
                        //                             padding: const EdgeInsets.only(top:6.0),
                        //                             child: Stack(alignment: Alignment.center,
                        //                               children: [
                        //                                 CachedNetworkImage(
                        //                                     imageUrl: "https://img.youtube.com/vi/" +
                        //                                         _con
                        //                                             .AccountWallVideos[
                        //                                         0][
                        //                                         "youtube_video_id"]
                        //                                             .toString() +
                        //                                         "/0.jpg",
                        //                                     height: 200,width: MediaQuery.of(context).size.width,
                        //                                     fit: BoxFit.cover,
                        //                                     placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover, height: 200,width: MediaQuery.of(context).size.width,)
                        //                                 ),
                        //                                 Image.asset(
                        //                                   "assets/Template1/image/Foodie/icons/youtube.png",
                        //                                   height: 32,
                        //                                   width: 32,
                        //                                 )
                        //                               ],
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         Row(crossAxisAlignment: CrossAxisAlignment.start,
                        //                           children: [
                        //                             Container(
                        //                               width: MediaQuery.of(context).size.width-25,
                        //                               child: _con
                        //                                   .AccountWallVideos[
                        //                               0]
                        //                               ['youtube_title'].length > 130 && /*textSpan==false &&*/ _showutube[0]==false ?
                        //                               Padding(
                        //                                 padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                        //                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //                                   children: [
                        //                                     SmartText(
                        //                                       text:
                        //                                       _con
                        //                                           .AccountWallVideos[
                        //                                       0]['youtube_title'].substring(0, 130,) + " ...",
                        //                                       style: TextStyle(
                        //                                         color: Colors.white,
                        //                                       ),
                        //                                       onOpen:(link){
                        //                                         Navigator.push(context, MaterialPageRoute(
                        //                                             builder: (context)=>WebViewContainer(url: link,)
                        //                                         ));
                        //                                       },
                        //
                        //                                       onTagClick: (tag) {
                        //                                         Navigator.push(
                        //                                             context,
                        //                                             MaterialPageRoute(
                        //                                                 builder: (context) =>
                        //                                                     HashSearchAppbar(
                        //                                                       hashTag: tag,
                        //                                                     )));
                        //                                       },
                        //                                       onUserTagClick: (tag) {
                        //                                         _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                        //                                       },
                        //                                     ),
                        //                                     SizedBox(height: 3,),
                        //                                     GestureDetector(
                        //                                         onTap: (){
                        //                                           setState(() {textSpan=true;
                        //                                           _showutube[0]=true;});
                        //                                         },
                        //                                         child: Text("Show more...",style: f14p,)),
                        //                                     SizedBox(height: 2,),
                        //                                   ],
                        //                                 ),
                        //                               ) : _con
                        //                                   .AccountWallVideos[
                        //                               0]
                        //                               ['youtube_title'].length > 130/* &&
                        // textSpan == true*/ && _showutube[0]==true?
                        //                               Padding(
                        //                                 padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                        //                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //                                   children: [
                        //                                     SmartText(
                        //                                       text:
                        //                                       _con
                        //                                           .AccountWallVideos[
                        //                                       0]['youtube_title'],
                        //                                       style: TextStyle(
                        //                                         color: Colors.white,
                        //                                       ),
                        //                                       onOpen:(link){
                        //                                         Navigator.push(context, MaterialPageRoute(
                        //                                             builder: (context)=>WebViewContainer(url: link,)
                        //                                         ));
                        //                                       },
                        //                                       onTagClick: (tag) {
                        //                                         Navigator.push(
                        //                                             context,
                        //                                             MaterialPageRoute(
                        //                                                 builder: (context) =>
                        //                                                     HashSearchAppbar(
                        //                                                       hashTag: tag,
                        //                                                     )));
                        //                                       },
                        //                                       onUserTagClick: (tag) {
                        //                                         _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                        //                                       },
                        //                                     ),
                        //                                     SizedBox(height:3,),
                        //                                     GestureDetector(
                        //                                         onTap: (){
                        //                                           setState(() {textSpan=false;
                        //                                           _showutube[0]=false;});
                        //                                         },
                        //                                         child: Text("Show less...",style: f14p,)),
                        //                                     SizedBox(height: 2,),
                        //                                   ],
                        //                                 ),
                        //                               ) : _con
                        //                                   .AccountWallVideos[
                        //                               0]
                        //                               ['youtube_title'].length <= 130 ?  Padding(
                        //                                 padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                        //                                 child: SmartText(
                        //                                   text:
                        //                                   _con
                        //                                       .AccountWallVideos[
                        //                                   0]['youtube_title'],
                        //                                   style: TextStyle(
                        //                                     color: Colors.white,
                        //                                   ),
                        //                                   onOpen:(link){
                        //                                     Navigator.push(context, MaterialPageRoute(
                        //                                         builder: (context)=>WebViewContainer(url: link,)
                        //                                     ));
                        //                                   },
                        //                                   onTagClick: (tag) {
                        //                                     Navigator.push(
                        //                                         context,
                        //                                         MaterialPageRoute(
                        //                                             builder: (context) =>
                        //                                                 HashSearchAppbar(
                        //                                                   hashTag: tag,
                        //                                                 )));
                        //                                   },
                        //                                   onUserTagClick: (tag) {
                        //                                     _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                        //                                   },
                        //                                 ),
                        //                               ) : Container(),
                        //                             ),
                        //                             GestureDetector(
                        //                                 onTap: () {
                        //                                   showModalBottomSheet(
                        //                                       backgroundColor:
                        //                                       Color(
                        //                                           0xFF1E2026),
                        //                                       context:
                        //                                       context,
                        //                                       clipBehavior: Clip
                        //                                           .antiAlias,
                        //                                       builder:
                        //                                           (BuildContext
                        //                                       context) {
                        //                                         return StatefulBuilder(
                        //                                             builder: (
                        //                                                 BuildContext
                        //                                                 context,
                        //                                                 sss.StateSetter
                        //                                                 state) {
                        //                                               return Padding(
                        //                                                 padding: const EdgeInsets
                        //                                                     .only(
                        //                                                     bottom:
                        //                                                     5.0,
                        //                                                     top:
                        //                                                     5,
                        //                                                     right:
                        //                                                     10,
                        //                                                     left:
                        //                                                     10),
                        //                                                 child:
                        //                                                 Wrap(
                        //                                                   children: <
                        //                                                       Widget>[
                        //                                                     userid
                        //                                                         .toString() ==
                        //                                                         _con
                        //                                                             .AccountWallVideos[0]['user_id']
                        //                                                             .toString()
                        //                                                         ? Padding(
                        //                                                       padding: const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child: InkWell(
                        //                                                         onTap: () {
                        //                                                           Navigator
                        //                                                               .push(
                        //                                                               context,
                        //                                                               MaterialPageRoute(
                        //                                                                   builder: (
                        //                                                                       context) =>
                        //                                                                       EditPost(
                        //                                                                         desc: _con
                        //                                                                             .AccountWallVideos[0]['description']
                        //                                                                             .toString(),
                        //                                                                         postid: _con
                        //                                                                             .AccountWallVideos[0]["id"]
                        //                                                                             .toString(),
                        //                                                                       )));
                        //                                                         },
                        //                                                         child: Container(
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Image
                        //                                                                   .asset(
                        //                                                                 "assets/Template1/image/Foodie/icons/pencil.png",
                        //                                                                 height: 21,
                        //                                                                 width: 21,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 16,
                        //                                                               ),
                        //                                                               Text(
                        //                                                                 "Edit Post",
                        //                                                                 style: f15wB,
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     )
                        //                                                         : Container(
                        //                                                       height: 0,
                        //                                                     ),
                        //                                                     userid
                        //                                                         .toString() ==
                        //                                                         _con
                        //                                                             .AccountWallVideos[0]['user_id']
                        //                                                             .toString()
                        //                                                         ? Padding(
                        //                                                       padding: const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child: InkWell(
                        //                                                         onTap: () {
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                           showDialog(
                        //                                                               context: context,
                        //                                                               builder: (
                        //                                                                   BuildContext context) {
                        //                                                                 return AlertDialog(
                        //                                                                   backgroundColor: Color(
                        //                                                                       0xFF1E2026),
                        //                                                                   title: new Text(
                        //                                                                     "Delete Post?",
                        //                                                                     style: f16wB,
                        //                                                                   ),
                        //                                                                   content: new Text(
                        //                                                                     "Do you want to delete the post",
                        //                                                                     style: f14w,
                        //                                                                   ),
                        //                                                                   actions: <
                        //                                                                       Widget>[
                        //                                                                     MaterialButton(
                        //                                                                       height: 28,
                        //                                                                       color: Color(0xFFffd55e),
                        //                                                                       child: new Text(
                        //                                                                         "Cancel",
                        //                                                                         style: TextStyle(
                        //                                                                             color: Colors
                        //                                                                                 .black),
                        //                                                                       ),
                        //                                                                       onPressed: () {
                        //                                                                         Navigator
                        //                                                                             .pop(
                        //                                                                             context,
                        //                                                                             'Cancel');
                        //                                                                       },
                        //                                                                     ),
                        //                                                                     MaterialButton(
                        //                                                                       height: 28,
                        //                                                                       color: Color(0xFF48c0d8),
                        //                                                                       child: new Text(
                        //                                                                         "Delete",
                        //                                                                         style: TextStyle(
                        //                                                                             color: Colors
                        //                                                                                 .black),
                        //                                                                       ),
                        //                                                                       onPressed: () {
                        //                                                                         _con
                        //                                                                             .deleteTimelineWall(
                        //                                                                             userid
                        //                                                                                 .toString(),
                        //                                                                             _con
                        //                                                                                 .AccountWallVideos[0]['id']
                        //                                                                                 .toString());
                        //
                        //                                                                         Navigator
                        //                                                                             .pop(
                        //                                                                             context);
                        //                                                                       },
                        //                                                                     ),
                        //                                                                   ],
                        //                                                                 );
                        //                                                               });
                        //                                                         },
                        //                                                         child: Container(
                        //
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Icon(
                        //                                                                 Icons
                        //                                                                     .delete_outline,
                        //                                                                 size: 26,
                        //                                                                 color: Colors
                        //                                                                     .white,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 10,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Delete Post",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "Delete the entire post",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     )
                        //                                                         : Container(
                        //                                                       height: 0,
                        //                                                     ),
                        //                                                     Padding(
                        //                                                       padding:
                        //                                                       const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child:
                        //                                                       InkWell(
                        //                                                         onTap: () {
                        //                                                           setState(() {
                        //                                                             postid =
                        //                                                                 _con
                        //                                                                     .AccountWallVideos[0]["id"]
                        //                                                                     .toString();
                        //                                                           });
                        //                                                           _con
                        //                                                               .saveTimelinePost(
                        //                                                               postid
                        //                                                                   .toString(),
                        //                                                               userid
                        //                                                                   .toString());
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                         },
                        //                                                         child: Container(
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Icon(
                        //                                                                 Icons
                        //                                                                     .bookmark_border,
                        //                                                                 size: 26,
                        //                                                                 color: Colors
                        //                                                                     .white,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 10,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Save Post",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "Add this to your saved post",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     ),
                        //                                                     userid
                        //                                                         .toString() !=
                        //                                                         _con
                        //                                                             .AccountWallVideos[0]['user_id']
                        //                                                             .toString()
                        //                                                         ? Padding(
                        //                                                       padding: const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child: InkWell(
                        //                                                         onTap: () {
                        //                                                           _con
                        //                                                               .reportTimeWall(
                        //                                                               userid,
                        //                                                               _con
                        //                                                                   .AccountWallVideos[0]['id']);
                        //
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                         },
                        //                                                         child: Container(
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Icon(
                        //                                                                 Icons
                        //                                                                     .block,
                        //                                                                 size: 26,
                        //                                                                 color: Colors
                        //                                                                     .white,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 10,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Report & Support",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "I'am concerned about this post",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     )
                        //                                                         : Container(
                        //                                                       height: 0,
                        //                                                     ),
                        //                                                     userid
                        //                                                         .toString() !=
                        //                                                         _con
                        //                                                             .AccountWallVideos[0]['user_id']
                        //                                                             .toString()
                        //                                                         ? Padding(
                        //                                                       padding: const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child: InkWell(
                        //                                                         onTap: () {
                        //                                                           _con
                        //                                                               .followerController(
                        //                                                               userid
                        //                                                                   .toString(),
                        //                                                               _con
                        //                                                                   .AccountWallVideos[0]['user_id']
                        //                                                                   .toString());
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                         },
                        //                                                         child: Container(
                        //
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Image
                        //                                                                   .asset(
                        //                                                                 "assets/Template1/image/Foodie/icons/person.png",
                        //                                                                 height: 21,
                        //                                                                 width: 21,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 16,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   _con
                        //                                                                       .AccountWallVideos[0]["follow_status"] ==
                        //                                                                       true
                        //                                                                       ? Text(
                        //                                                                     "Unfollow",
                        //                                                                     style: f15wB,
                        //                                                                   )
                        //                                                                       : Text(
                        //                                                                     "Follow",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   _con
                        //                                                                       .AccountWallVideos[0]["follow_status"] ==
                        //                                                                       true
                        //                                                                       ? Text(
                        //                                                                     "Unfollow  " +
                        //                                                                         _con
                        //                                                                             .AccountWallVideos[0]["name"],
                        //                                                                     style: f13w,
                        //                                                                   )
                        //                                                                       : Text(
                        //                                                                     "Follow  " +
                        //                                                                         _con
                        //                                                                             .AccountWallVideos[0]["name"],
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     )
                        //                                                         : Container(
                        //                                                       height: 0,
                        //                                                     ),
                        //                                                     Padding(
                        //                                                       padding:
                        //                                                       const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child:
                        //                                                       InkWell(
                        //                                                         onTap: () {
                        //                                                           setState(() {
                        //                                                             postid =
                        //                                                                 _con
                        //                                                                     .AccountWallVideos[0]['id']
                        //                                                                     .toString();
                        //                                                             sharePost =
                        //                                                                 "https://saasinfomedia.com/foodiz/public/sharepost/" +
                        //                                                                     postid
                        //                                                                         .toString();
                        //                                                           });
                        //
                        //                                                           Clipboard
                        //                                                               .setData(
                        //                                                               new ClipboardData(
                        //                                                                   text: sharePost
                        //                                                                       .toString()));
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                           Fluttertoast
                        //                                                               .showToast(
                        //                                                               msg: "Link Copied",
                        //                                                               toastLength: Toast
                        //                                                                   .LENGTH_LONG,
                        //                                                               gravity: ToastGravity
                        //                                                                   .TOP,
                        //                                                               timeInSecForIosWeb: 10,
                        //                                                               backgroundColor: Color(
                        //                                                                   0xFF48c0d8),
                        //                                                               textColor: Colors
                        //                                                                   .white,
                        //                                                               fontSize: 16.0);
                        //                                                         },
                        //                                                         child: Container(
                        //
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Icon(
                        //                                                                 Icons
                        //                                                                     .link,
                        //                                                                 size: 26,
                        //                                                                 color: Colors
                        //                                                                     .white,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 10,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Copy Link",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "Copy Post link",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     ),
                        //                                                     Padding(
                        //                                                       padding:
                        //                                                       const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child:
                        //                                                       InkWell(
                        //                                                         onTap: () {
                        //                                                           setState(() {
                        //                                                             postid =
                        //                                                                 _con
                        //                                                                     .AccountWallVideos[0]['id']
                        //                                                                     .toString();
                        //                                                             sharePost =
                        //                                                                 "https://saasinfomedia.com/foodiz/public/sharepost/" +
                        //                                                                     postid
                        //                                                                         .toString();
                        //                                                           });
                        //                                                           _shareText();
                        //                                                         },
                        //                                                         child: Container(
                        //
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Image
                        //                                                                   .asset(
                        //                                                                 "assets/Template1/image/Foodie/icons/share.png",
                        //                                                                 height: 21,
                        //                                                                 width: 21,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 16,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Share Post",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "Share post externally",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     ),
                        //                                                   ],
                        //                                                 ),
                        //                                               );
                        //                                             });
                        //                                       });
                        //                                 },
                        //                                 child: Padding(
                        //                                   padding: const EdgeInsets.only(top:5.0),
                        //                                   child: Icon(
                        //                                       Icons.more_vert,
                        //                                       size: 17,
                        //                                       color: Colors
                        //                                           .white),
                        //                                 )),
                        //                           ],
                        //                         ),
                        //                       ],
                        //                     ) : _con
                        //                         .AccountWallVideos[0]
                        //                     [
                        //                     "youtube_video_id"]
                        //                         .toString()
                        //                         .length != 11 &&
                        //                         _con
                        //                             .AccountWallVideos[
                        //                         0][
                        //                         "youtube_video_id"] !=
                        //                             null ?
                        //                     Column(
                        //                       children: [
                        //                         VideoWidget(
                        //                               url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                        //                                   _con
                        //                                       .AccountWallVideos[0]['youtube_video_id']
                        //                                       .toString()
                        //                                       .replaceAll(
                        //                                       " ", "%20") +
                        //                                   "?alt=media",
                        //                               play: true,),
                        //                         Row(crossAxisAlignment: CrossAxisAlignment.start,
                        //                           children: [
                        //                             Container(
                        //                               width: MediaQuery.of(context).size.width-25,
                        //                               child: _con
                        //                                   .AccountWallVideos[
                        //                               0]
                        //                               ['description'].length > 130 && /*textSpan==false &&*/ _showutube[0]==false ?
                        //                               Padding(
                        //                                 padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                        //                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //                                   children: [
                        //                                     SmartText(
                        //                                       text:
                        //                                       _con
                        //                                           .AccountWallVideos[
                        //                                       0]['description'].substring(0, 130,) + " ...",
                        //                                       style: TextStyle(
                        //                                         color: Colors.white,
                        //                                       ),
                        //                                       onOpen:(link){
                        //                                         Navigator.push(context, MaterialPageRoute(
                        //                                             builder: (context)=>WebViewContainer(url: link,)
                        //                                         ));
                        //                                       },
                        //
                        //                                       onTagClick: (tag) {
                        //                                         Navigator.push(
                        //                                             context,
                        //                                             MaterialPageRoute(
                        //                                                 builder: (context) =>
                        //                                                     HashSearchAppbar(
                        //                                                       hashTag: tag,
                        //                                                     )));
                        //                                       },
                        //                                       onUserTagClick: (tag) {
                        //                                         _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                        //                                       },
                        //                                     ),
                        //                                     SizedBox(height: 3,),
                        //                                     GestureDetector(
                        //                                         onTap: (){
                        //                                           setState(() {textSpan=true;
                        //                                           _showutube[0]=true;});
                        //                                         },
                        //                                         child: Text("Show more...",style: f14p,)),
                        //                                     SizedBox(height: 2,),
                        //                                   ],
                        //                                 ),
                        //                               ) : _con
                        //                                   .AccountWallVideos[
                        //                               0]
                        //                               ['description'].length > 130/* &&
                        // textSpan == true*/ && _showutube[0]==true?
                        //                               Padding(
                        //                                 padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                        //                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //                                   children: [
                        //                                     SmartText(
                        //                                       text:
                        //                                       _con
                        //                                           .AccountWallVideos[
                        //                                       0]['description'],
                        //                                       style: TextStyle(
                        //                                         color: Colors.white,
                        //                                       ),
                        //                                       onOpen:(link){
                        //                                         Navigator.push(context, MaterialPageRoute(
                        //                                             builder: (context)=>WebViewContainer(url: link,)
                        //                                         ));
                        //                                       },
                        //                                       onTagClick: (tag) {
                        //                                         Navigator.push(
                        //                                             context,
                        //                                             MaterialPageRoute(
                        //                                                 builder: (context) =>
                        //                                                     HashSearchAppbar(
                        //                                                       hashTag: tag,
                        //                                                     )));
                        //                                       },
                        //                                       onUserTagClick: (tag) {
                        //                                         _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                        //                                       },
                        //                                     ),
                        //                                     SizedBox(height:3,),
                        //                                     GestureDetector(
                        //                                         onTap: (){
                        //                                           setState(() {textSpan=false;
                        //                                           _showutube[0]=false;});
                        //                                         },
                        //                                         child: Text("Show less...",style: f14p,)),
                        //                                     SizedBox(height: 2,),
                        //                                   ],
                        //                                 ),
                        //                               ) : _con
                        //                                   .AccountWallVideos[
                        //                               0]
                        //                               ['description'].length <= 130 ?  Padding(
                        //                                 padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                        //                                 child: SmartText(
                        //                                   text:
                        //                                   _con
                        //                                       .AccountWallVideos[
                        //                                   0]['description'],
                        //                                   style: TextStyle(
                        //                                     color: Colors.white,
                        //                                   ),
                        //                                   onOpen:(link){
                        //                                     Navigator.push(context, MaterialPageRoute(
                        //                                         builder: (context)=>WebViewContainer(url: link,)
                        //                                     ));
                        //                                   },
                        //                                   onTagClick: (tag) {
                        //                                     Navigator.push(
                        //                                         context,
                        //                                         MaterialPageRoute(
                        //                                             builder: (context) =>
                        //                                                 HashSearchAppbar(
                        //                                                   hashTag: tag,
                        //                                                 )));
                        //                                   },
                        //                                   onUserTagClick: (tag) {
                        //                                     _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                        //                                   },
                        //                                 ),
                        //                               ) : Container(),
                        //                             ),
                        //                             GestureDetector(
                        //                                 onTap: () {
                        //                                   showModalBottomSheet(
                        //                                       backgroundColor:
                        //                                       Color(
                        //                                           0xFF1E2026),
                        //                                       context:
                        //                                       context,
                        //                                       clipBehavior: Clip
                        //                                           .antiAlias,
                        //                                       builder:
                        //                                           (BuildContext
                        //                                       context) {
                        //                                         return StatefulBuilder(
                        //                                             builder: (
                        //                                                 BuildContext
                        //                                                 context,
                        //                                                 sss.StateSetter
                        //                                                 state) {
                        //                                               return Padding(
                        //                                                 padding: const EdgeInsets
                        //                                                     .only(
                        //                                                     bottom:
                        //                                                     5.0,
                        //                                                     top:
                        //                                                     5,
                        //                                                     right:
                        //                                                     10,
                        //                                                     left:
                        //                                                     10),
                        //                                                 child:
                        //                                                 Wrap(
                        //                                                   children: <
                        //                                                       Widget>[
                        //                                                     userid
                        //                                                         .toString() ==
                        //                                                         _con
                        //                                                             .AccountWallVideos[0]['user_id']
                        //                                                             .toString()
                        //                                                         ? Padding(
                        //                                                       padding: const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child: InkWell(
                        //                                                         onTap: () {
                        //                                                           Navigator
                        //                                                               .push(
                        //                                                               context,
                        //                                                               MaterialPageRoute(
                        //                                                                   builder: (
                        //                                                                       context) =>
                        //                                                                       EditPost(
                        //                                                                         desc: _con
                        //                                                                             .AccountWallVideos[0]['description']
                        //                                                                             .toString(),
                        //                                                                         postid: _con
                        //                                                                             .AccountWallVideos[0]["id"]
                        //                                                                             .toString(),
                        //                                                                       )));
                        //                                                         },
                        //                                                         child: Container(
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Image
                        //                                                                   .asset(
                        //                                                                 "assets/Template1/image/Foodie/icons/pencil.png",
                        //                                                                 height: 21,
                        //                                                                 width: 21,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 16,
                        //                                                               ),
                        //                                                               Text(
                        //                                                                 "Edit Post",
                        //                                                                 style: f15wB,
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     )
                        //                                                         : Container(
                        //                                                       height: 0,
                        //                                                     ),
                        //                                                     userid
                        //                                                         .toString() ==
                        //                                                         _con
                        //                                                             .AccountWallVideos[0]['user_id']
                        //                                                             .toString()
                        //                                                         ? Padding(
                        //                                                       padding: const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child: InkWell(
                        //                                                         onTap: () {
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                           showDialog(
                        //                                                               context: context,
                        //                                                               builder: (
                        //                                                                   BuildContext context) {
                        //                                                                 return AlertDialog(
                        //                                                                   backgroundColor: Color(
                        //                                                                       0xFF1E2026),
                        //                                                                   title: new Text(
                        //                                                                     "Delete Post?",
                        //                                                                     style: f16wB,
                        //                                                                   ),
                        //                                                                   content: new Text(
                        //                                                                     "Do you want to delete the post",
                        //                                                                     style: f14w,
                        //                                                                   ),
                        //                                                                   actions: <
                        //                                                                       Widget>[
                        //                                                                     MaterialButton(
                        //                                                                       height: 28,
                        //                                                                       color: Color(0xFFffd55e),
                        //                                                                       child: new Text(
                        //                                                                         "Cancel",
                        //                                                                         style: TextStyle(
                        //                                                                             color: Colors
                        //                                                                                 .black),
                        //                                                                       ),
                        //                                                                       onPressed: () {
                        //                                                                         Navigator
                        //                                                                             .pop(
                        //                                                                             context,
                        //                                                                             'Cancel');
                        //                                                                       },
                        //                                                                     ),
                        //                                                                     MaterialButton(
                        //                                                                       height: 28,
                        //                                                                       color: Color(0xFF48c0d8),
                        //                                                                       child: new Text(
                        //                                                                         "Delete",
                        //                                                                         style: TextStyle(
                        //                                                                             color: Colors
                        //                                                                                 .black),
                        //                                                                       ),
                        //                                                                       onPressed: () {
                        //                                                                         _con
                        //                                                                             .deleteTimelineWall(
                        //                                                                             userid
                        //                                                                                 .toString(),
                        //                                                                             _con
                        //                                                                                 .AccountWallVideos[0]['id']
                        //                                                                                 .toString());
                        //
                        //                                                                         Navigator
                        //                                                                             .pop(
                        //                                                                             context);
                        //                                                                       },
                        //                                                                     ),
                        //                                                                   ],
                        //                                                                 );
                        //                                                               });
                        //                                                         },
                        //                                                         child: Container(
                        //
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Icon(
                        //                                                                 Icons
                        //                                                                     .delete_outline,
                        //                                                                 size: 26,
                        //                                                                 color: Colors
                        //                                                                     .white,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 10,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Delete Post",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "Delete the entire post",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     )
                        //                                                         : Container(
                        //                                                       height: 0,
                        //                                                     ),
                        //                                                     Padding(
                        //                                                       padding:
                        //                                                       const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child:
                        //                                                       InkWell(
                        //                                                         onTap: () {
                        //                                                           setState(() {
                        //                                                             postid =
                        //                                                                 _con
                        //                                                                     .AccountWallVideos[0]["id"]
                        //                                                                     .toString();
                        //                                                           });
                        //                                                           _con
                        //                                                               .saveTimelinePost(
                        //                                                               postid
                        //                                                                   .toString(),
                        //                                                               userid
                        //                                                                   .toString());
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                         },
                        //                                                         child: Container(
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Icon(
                        //                                                                 Icons
                        //                                                                     .bookmark_border,
                        //                                                                 size: 26,
                        //                                                                 color: Colors
                        //                                                                     .white,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 10,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Save Post",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "Add this to your saved post",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     ),
                        //                                                     userid
                        //                                                         .toString() !=
                        //                                                         _con
                        //                                                             .AccountWallVideos[0]['user_id']
                        //                                                             .toString()
                        //                                                         ? Padding(
                        //                                                       padding: const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child: InkWell(
                        //                                                         onTap: () {
                        //                                                           _con
                        //                                                               .reportTimeWall(
                        //                                                               userid,
                        //                                                               _con
                        //                                                                   .AccountWallVideos[0]['id']);
                        //
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                         },
                        //                                                         child: Container(
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Icon(
                        //                                                                 Icons
                        //                                                                     .block,
                        //                                                                 size: 26,
                        //                                                                 color: Colors
                        //                                                                     .white,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 10,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Report & Support",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "I'am concerned about this post",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     )
                        //                                                         : Container(
                        //                                                       height: 0,
                        //                                                     ),
                        //                                                     userid
                        //                                                         .toString() !=
                        //                                                         _con
                        //                                                             .AccountWallVideos[0]['user_id']
                        //                                                             .toString()
                        //                                                         ? Padding(
                        //                                                       padding: const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child: InkWell(
                        //                                                         onTap: () {
                        //                                                           _con
                        //                                                               .followerController(
                        //                                                               userid
                        //                                                                   .toString(),
                        //                                                               _con
                        //                                                                   .AccountWallVideos[0]['user_id']
                        //                                                                   .toString());
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                         },
                        //                                                         child: Container(
                        //
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Image
                        //                                                                   .asset(
                        //                                                                 "assets/Template1/image/Foodie/icons/person.png",
                        //                                                                 height: 21,
                        //                                                                 width: 21,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 16,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   _con
                        //                                                                       .AccountWallVideos[0]["follow_status"] ==
                        //                                                                       true
                        //                                                                       ? Text(
                        //                                                                     "Unfollow",
                        //                                                                     style: f15wB,
                        //                                                                   )
                        //                                                                       : Text(
                        //                                                                     "Follow",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   _con
                        //                                                                       .AccountWallVideos[0]["follow_status"] ==
                        //                                                                       true
                        //                                                                       ? Text(
                        //                                                                     "Unfollow  " +
                        //                                                                         _con
                        //                                                                             .AccountWallVideos[0]["name"],
                        //                                                                     style: f13w,
                        //                                                                   )
                        //                                                                       : Text(
                        //                                                                     "Follow  " +
                        //                                                                         _con
                        //                                                                             .AccountWallVideos[0]["name"],
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     )
                        //                                                         : Container(
                        //                                                       height: 0,
                        //                                                     ),
                        //                                                     Padding(
                        //                                                       padding:
                        //                                                       const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child:
                        //                                                       InkWell(
                        //                                                         onTap: () {
                        //                                                           setState(() {
                        //                                                             postid =
                        //                                                                 _con
                        //                                                                     .AccountWallVideos[0]['id']
                        //                                                                     .toString();
                        //                                                             sharePost =
                        //                                                                 "https://saasinfomedia.com/foodiz/public/sharepost/" +
                        //                                                                     postid
                        //                                                                         .toString();
                        //                                                           });
                        //
                        //                                                           Clipboard
                        //                                                               .setData(
                        //                                                               new ClipboardData(
                        //                                                                   text: sharePost
                        //                                                                       .toString()));
                        //                                                           Navigator
                        //                                                               .pop(
                        //                                                               context);
                        //                                                           Fluttertoast
                        //                                                               .showToast(
                        //                                                               msg: "Link Copied",
                        //                                                               toastLength: Toast
                        //                                                                   .LENGTH_LONG,
                        //                                                               gravity: ToastGravity
                        //                                                                   .TOP,
                        //                                                               timeInSecForIosWeb: 10,
                        //                                                               backgroundColor: Color(
                        //                                                                   0xFF48c0d8),
                        //                                                               textColor: Colors
                        //                                                                   .white,
                        //                                                               fontSize: 16.0);
                        //                                                         },
                        //                                                         child: Container(
                        //
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Icon(
                        //                                                                 Icons
                        //                                                                     .link,
                        //                                                                 size: 26,
                        //                                                                 color: Colors
                        //                                                                     .white,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 10,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Copy Link",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "Copy Post link",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     ),
                        //                                                     Padding(
                        //                                                       padding:
                        //                                                       const EdgeInsets
                        //                                                           .all(
                        //                                                           6.0),
                        //                                                       child:
                        //                                                       InkWell(
                        //                                                         onTap: () {
                        //                                                           setState(() {
                        //                                                             postid =
                        //                                                                 _con
                        //                                                                     .AccountWallVideos[0]['id']
                        //                                                                     .toString();
                        //                                                             sharePost =
                        //                                                                 "https://saasinfomedia.com/foodiz/public/sharepost/" +
                        //                                                                     postid
                        //                                                                         .toString();
                        //                                                           });
                        //                                                           _shareText();
                        //                                                         },
                        //                                                         child: Container(
                        //
                        //                                                           child: Row(
                        //                                                             crossAxisAlignment: CrossAxisAlignment
                        //                                                                 .center,
                        //                                                             children: <
                        //                                                                 Widget>[
                        //                                                               Image
                        //                                                                   .asset(
                        //                                                                 "assets/Template1/image/Foodie/icons/share.png",
                        //                                                                 height: 21,
                        //                                                                 width: 21,
                        //                                                               ),
                        //                                                               SizedBox(
                        //                                                                 width: 16,
                        //                                                               ),
                        //                                                               Column(
                        //                                                                 crossAxisAlignment: CrossAxisAlignment
                        //                                                                     .start,
                        //                                                                 children: <
                        //                                                                     Widget>[
                        //                                                                   Text(
                        //                                                                     "Share Post",
                        //                                                                     style: f15wB,
                        //                                                                   ),
                        //                                                                   SizedBox(
                        //                                                                     height: 3,
                        //                                                                   ),
                        //                                                                   Text(
                        //                                                                     "Share post externally",
                        //                                                                     style: f13w,
                        //                                                                   ),
                        //                                                                 ],
                        //                                                               )
                        //                                                             ],
                        //                                                           ),
                        //                                                         ),
                        //                                                       ),
                        //                                                     ),
                        //                                                   ],
                        //                                                 ),
                        //                                               );
                        //                                             });
                        //                                       });
                        //                                 },
                        //                                 child: Padding(
                        //                                   padding: const EdgeInsets.only(top:5.0),
                        //                                   child: Icon(
                        //                                       Icons.more_vert,
                        //                                       size: 17,
                        //                                       color: Colors
                        //                                           .white),
                        //                                 )),
                        //                           ],
                        //                         ),
                        //
                        //                       ],
                        //                     ) : Container(),
                                              //like coment share count
                                              // Container(
                                              //   child: Padding(
                                              //       padding: EdgeInsets.only(
                                              //           left: 5.0,
                                              //           right: 5.0,
                                              //           ),
                                              //       child: Column(
                                              //         crossAxisAlignment: CrossAxisAlignment
                                              //             .start,
                                              //         children: <Widget>[
                                              //           Padding(
                                              //             padding: const EdgeInsets
                                              //                 .only(
                                              //                 left: 7.0,
                                              //                 right: 7,
                                              //                 bottom: 5,
                                              //                 top: 10),
                                              //             child: GestureDetector(
                                              //               onTap: () {
                                              //                 setState(() {postid= _con
                                              //                     .AccountWallVideos[0]["id"];});
                                              //                 Navigator.push(
                                              //                     context,
                                              //                     MaterialPageRoute(
                                              //                         builder: (
                                              //                             context) =>
                                              //                             LikeCommentSharePage()));
                                              //               },
                                              //               child: Row(
                                              //                 mainAxisAlignment: MainAxisAlignment
                                              //                     .start,
                                              //                 children: <
                                              //                     Widget>[
                                              //                   GestureDetector(
                                              //                       onTap: () {
                                              //                       setState(() {postid = _con
                                              //                           .AccountWallVideos[0]["id"];});
                                              //                       Navigator.push(
                                              //                           context,
                                              //                           MaterialPageRoute(
                                              //                               builder: (context) =>
                                              //                                   LikeCommentSharePage(statusIndex: 0,)));
                                              //                     },
                                              //                     child: Row(
                                              //                       children: <
                                              //                           Widget>[
                                              //                         Text(
                                              //                           _con
                                              //                               .AccountWallVideos[0]["likes_count"]
                                              //                               .toString(),
                                              //                           style: f14y,
                                              //                         ),
                                              //                         SizedBox(
                                              //                           width: 3,),
                                              //                         Text(
                                              //                           "Likes",
                                              //                           style: f14y,
                                              //                         ),
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //                   SizedBox(
                                              //                     width: 13,
                                              //                   ),
                                              //                   GestureDetector(
                                              //                       onTap: () {
                                              //                       setState(() {postid = _con
                                              //                           .AccountWallVideos[0]["id"];});
                                              //                       Navigator.push(
                                              //                           context,
                                              //                           MaterialPageRoute(
                                              //                               builder: (context) =>
                                              //                                   LikeCommentSharePage(statusIndex: 1,)));
                                              //                     },
                                              //                     child: Row(
                                              //                       children: <
                                              //                           Widget>[
                                              //                         Text(
                                              //                           _con
                                              //                               .AccountWallVideos[0]["comments_count"]
                                              //                               .toString(),
                                              //                           style: f14y,
                                              //                         ),
                                              //                         SizedBox(
                                              //                           width: 3,),
                                              //                         Text(
                                              //                           "Comments",
                                              //                           style: f14y,
                                              //                         ),
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //                   SizedBox(
                                              //                     width: 13,
                                              //                   ),
                                              //                   GestureDetector(
                                              //                       onTap: () {
                                              //                       setState(() {postid = _con
                                              //                           .AccountWallVideos[0]["id"];});
                                              //                       Navigator.push(
                                              //                           context,
                                              //                           MaterialPageRoute(
                                              //                               builder: (context) =>
                                              //                                   LikeCommentSharePage(statusIndex: 2,)));
                                              //                     },
                                              //                     child: Row(
                                              //                       children: <
                                              //                           Widget>[
                                              //                         Text(
                                              //                           _con
                                              //                               .AccountWallVideos[0]["share_count"]
                                              //                               .toString(),
                                              //                           style: f14y,
                                              //                         ),
                                              //                         SizedBox(
                                              //                           width: 3,),
                                              //                         Text(
                                              //                           "Shares",
                                              //                           style: f14y,
                                              //                         ),
                                              //                       ],
                                              //                     ),
                                              //                   )
                                              //                 ],
                                              //               ),
                                              //             ),
                                              //           ),
                                              //           Padding(
                                              //             padding: const EdgeInsets
                                              //                 .only(
                                              //                 left: 7.0,
                                              //                 right: 7,
                                              //                 top: 5,
                                              //                 bottom: 10),
                                              //             child: Container(
                                              //               child: InkWell(
                                              //                 child: Container(
                                              //                   height: 20.0,
                                              //                   width: double
                                              //                       .infinity,
                                              //                   child: Row(
                                              //                     mainAxisAlignment:
                                              //                     MainAxisAlignment
                                              //                         .spaceBetween,
                                              //                     children: <
                                              //                         Widget>[
                                              //                       _con.AccountWallVideos[0]['like_status'] ==
                                              //                           true
                                              //                           ? GestureDetector(
                                              //                         onTap: () {
                                              //                           setState(() {
                                              //                             _likes[0] =
                                              //                             false;
                                              //                             _con
                                              //                                 .AccountWallVideos[0]['like_status'] =
                                              //                             false;
                                              //                             _con
                                              //                                 .AccountWallVideos[0]['likes_count'] =
                                              //                                 _con
                                              //                                     .AccountWallVideos[0]['likes_count'] -
                                              //                                     1;
                                              //
                                              //                             postid =
                                              //                                 _con
                                              //                                     .AccountWallVideos[0]['id']
                                              //                                     .toString();
                                              //                           });
                                              //
                                              //                           _con
                                              //                               .likePostTime(
                                              //                               userid
                                              //                                   .toString(),
                                              //                               postid
                                              //                                   .toString());
                                              //                         },
                                              //                         child: Row(
                                              //                           children: <
                                              //                               Widget>[
                                              //                             Icon(
                                              //                               Icons
                                              //                                   .favorite,
                                              //                               color: Color(
                                              //                                   0xFFffd55e),
                                              //                               size: 18,
                                              //                             ),
                                              //                             SizedBox(
                                              //                               width: 5,
                                              //                             ),
                                              //                             Text(
                                              //                               "Liked",
                                              //                               style: f14w,
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       )
                                              //                           : GestureDetector(
                                              //                         onTap: () {
                                              //                           setState(() {
                                              //                             _likes[0] =
                                              //                             true;
                                              //                             _con
                                              //                                 .AccountWallVideos[0]['like_status'] =
                                              //                             true;
                                              //                             _con
                                              //                                 .AccountWallVideos[0]['likes_count'] =
                                              //                                 _con
                                              //                                     .AccountWallVideos[0]['likes_count'] +
                                              //                                     1;
                                              //                             postid =
                                              //                                 _con
                                              //                                     .AccountWallVideos[0]['id']
                                              //                                     .toString();
                                              //                           });
                                              //
                                              //                           _con
                                              //                               .likePostTime(
                                              //                               userid
                                              //                                   .toString(),
                                              //                               postid
                                              //                                   .toString());
                                              //                         },
                                              //                         child: Row(
                                              //                           children: <
                                              //                               Widget>[
                                              //                             Icon(
                                              //                               Icons
                                              //                                   .favorite_border,
                                              //                               color: Colors
                                              //                                   .white,
                                              //                               size: 18,
                                              //                             ),
                                              //                             SizedBox(
                                              //                               width: 5,
                                              //                             ),
                                              //                             Text(
                                              //                               "Like",
                                              //                               style: f14w,
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                       GestureDetector(
                                              //                         onTap: () {
                                              //                           Navigator
                                              //                               .push(
                                              //                               context,
                                              //                               MaterialPageRoute(
                                              //                                   builder: (
                                              //                                       context) =>
                                              //                                       CommentPage()));
                                              //                         },
                                              //                         child: Row(
                                              //                           children: <
                                              //                               Widget>[
                                              //                             Icon(
                                              //                               Icons
                                              //                                   .chat_bubble_outline,
                                              //                               color: Colors
                                              //                                   .white,
                                              //                               size: 18,
                                              //                             ),
                                              //                             SizedBox(
                                              //                               width: 5,
                                              //                             ),
                                              //                             Text(
                                              //                               "Comment",
                                              //                               style: f14w,
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                       GestureDetector(
                                              //                         onTap: () {
                                              //                           setState(() {
                                              //                             postid =
                                              //                                 _con
                                              //                                     .AccountWallVideos[0]['id']
                                              //                                     .toString();
                                              //                             sharePost =
                                              //                                 "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                              //                                     postid
                                              //                                         .toString();
                                              //                           });
                                              //                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SharePost(postid: postid.toString(),sharepost: sharePost.toString(),)));
                                              //                         },
                                              //                         child: Row(
                                              //                           children: <
                                              //                               Widget>[
                                              //                             Image
                                              //                                 .asset(
                                              //                               "assets/Template1/image/Foodie/icons/share.png",
                                              //                               height: 16,
                                              //                               width: 16,
                                              //                             ),
                                              //                             SizedBox(
                                              //                               width: 5,
                                              //                             ),
                                              //                             Text(
                                              //                                 "Share",
                                              //                                 style: f14w),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                       _con.AccountWallVideos[0]['save_status'] ==
                                              //                           true
                                              //                           ? GestureDetector(
                                              //                         onTap: () {
                                              //                           setState(() {
                                              //                             _save[0] =
                                              //                             false;
                                              //                             _con
                                              //                                 .AccountWallVideos[0]['save_status'] =
                                              //                             false;
                                              //                             postid =
                                              //                                 _con
                                              //                                     .AccountWallVideos[0]["id"]
                                              //                                     .toString();
                                              //                           });
                                              //                           _con
                                              //                               .saveTimelinePost(
                                              //                               postid
                                              //                                   .toString(),
                                              //                               userid
                                              //                                   .toString());
                                              //                         },
                                              //                         child: Row(
                                              //                           children: <
                                              //                               Widget>[
                                              //                             Icon(
                                              //                               Icons
                                              //                                   .bookmark,
                                              //                               color: Color(
                                              //                                   0xFF48c0d8),
                                              //                               size: 18,
                                              //                             ),
                                              //                             SizedBox(
                                              //                               width: 5,
                                              //                             ),
                                              //                             Text(
                                              //                               "Saved",
                                              //                               style: f14w,
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       )
                                              //                           : GestureDetector(
                                              //                         onTap: () {
                                              //                           setState(() {
                                              //                             _save[0] =
                                              //                             true;
                                              //                             _con
                                              //                                 .AccountWallVideos[0]['save_status'] =
                                              //                             true;
                                              //                             postid =
                                              //                                 _con
                                              //                                     .AccountWallVideos[0]["id"]
                                              //                                     .toString();
                                              //                           });
                                              //                           _con
                                              //                               .saveTimelinePost(
                                              //                               postid
                                              //                                   .toString(),
                                              //                               userid
                                              //                                   .toString());
                                              //                         },
                                              //                         child: Row(
                                              //                           children: <
                                              //                               Widget>[
                                              //                             Icon(
                                              //                               Icons
                                              //                                   .bookmark_border,
                                              //                               color: Colors
                                              //                                   .white,
                                              //                               size: 18,
                                              //                             ),
                                              //                             SizedBox(
                                              //                               width: 5,
                                              //                             ),
                                              //                             Text(
                                              //                               "Save",
                                              //                               style: f14w,
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       )
                                              //                     ],
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       )),
                                              // ),
                                              // Divider(
                                              //   color: Colors.black87,
                                              //   thickness: 1,
                                              // ),
                                              //listview
                                              Container(
                                                height: _con
                                                    .AccountWallVideos
                                                    .length.toDouble()*140,
                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: _con
                                                        .AccountWallVideos
                                                        .length,
                                                    itemBuilder: (
                                                        BuildContext context,
                                                        int index) {
                                                      imgHtp = httpsObj + _con
                                                          .AccountWallVideos[index]["youtube_video_id"]
                                                          .toString() +
                                                          thirdHttp;
                                                      List<String> playlist2 = <
                                                          String>[
                                                        "https://www.youtube.com/watch?v=" +
                                                            _con
                                                                .AccountWallVideos[index]["youtube_video_id"]
                                                                .toString()
                                                      ];
                                                      _date = DateTime.parse(
                                                          _con
                                                              .AccountWallVideos[index]['created_at']['date']);
                                                      var c = DateTime
                                                          .now()
                                                          .difference(_date)
                                                          .inHours;
                                                      c > 24
                                                          ? d = DateTime
                                                          .now()
                                                          .difference(_date)
                                                          .inDays
                                                          .toString() +
                                                          " day ago"
                                                          : c == 0 ?
                                                      d = DateTime
                                                          .now()
                                                          .difference(_date)
                                                          .inMinutes
                                                          .toString() +
                                                          " mints ago" : d =
                                                          DateTime
                                                              .now()
                                                              .difference(_date)
                                                              .inHours
                                                              .toString() +
                                                              " hrs ago";

                                                      return
                                                          Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                             /* Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          VideoDetailPage(memberdate: DateFormat.yMMMd().format(DateTime.parse(
                                                                              repo.AbtInfo["data"][0]
                                                                              ["created_at"]["date"])).toString(),date: d.toString(),
                                                                              username: _con
                                                                                  .AccountWallVideos[index]["username"]
                                                                                  .toString(),
                                                                              timid: _con
                                                                                  .AccountWallVideos[index]["timeline_id"]
                                                                                  .toString(),
                                                                              likestatus: _con
                                                                                  .AccountWallVideos[index]["like_status"],
                                                                              savestatus: _con
                                                                                  .AccountWallVideos[index]["save_status"],
                                                                              pic: _con
                                                                              .AccountWallVideos[index]["picture"]
                                                                              .toString(),followstatus: _con
                                                                              .AccountWallVideos[index]["follow_status"],
                                                                              usertoken: _con
                                                                                  .AccountWallVideos[index]["device_token"].toString(),
                                                                              indexPass: index,
                                                                              Name: _con
                                                                                  .AccountWallVideos[index]["name"]
                                                                                  .toString(),
                                                                              videoId: _con
                                                                                  .AccountWallVideos[index]["youtube_video_id"]
                                                                                  .toString(),
                                                                              videoTitle: _con
                                                                                  .AccountWallVideos[index]["youtube_title"]
                                                                                  .toString(),
                                                                              description: _con
                                                                                  .AccountWallVideos[index]["description"]
                                                                                  .toString(),
                                                                              LikesCount: _con
                                                                                  .AccountWallVideos[index]["likes_count"],
                                                                              ShareCount: _con
                                                                                  .AccountWallVideos[index]["share_count"]
                                                                                  .toString(),
                                                                              CommentsCount: _con
                                                                                  .AccountWallVideos[index]["comments_count"]
                                                                                  .toString(),
                                                                              usrId: _con
                                                                                  .AccountWallVideos[0]['user_id']
                                                                                  .toString(),
                                                                              postid: _con
                                                                                  .AccountWallVideos[index]['id']
                                                                                  .toString())));*/
                                                              Navigator.push(context, MaterialPageRoute(
                                                                  builder: (context) => FoodieVideosList(idddd:  _con.AccountWallVideos[index]["id"],video_id: _con
                                                                      .AccountWallVideos[
                                                                  index][
                                                                  "youtube_video_id"]
                                                                      .toString(),tim_id: timelineIdFoodi.toString(),)
                                                              ));
                                                            },
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                  top: 15.0,
                                                                  bottom: 15.0,
                                                                  left: 5.0,
                                                                  right: 5.0,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        _con
                                                                            .AccountWallVideos[index]["youtube_video_id"] !=
                                                                            null &&
                                                                            _con
                                                                                .AccountWallVideos[index]["youtube_video_id"]
                                                                                .toString()
                                                                                .length ==
                                                                                11
                                                                            ? Container(
                                                                          height: 105,
                                                                          width: 146,
                                                                          decoration: BoxDecoration(
                                                                            //color: Color(0xFF48c0d8),
                                                                            border: Border
                                                                                .all(
                                                                              color: Colors
                                                                                  .white,
                                                                            ),
                                                                            borderRadius: BorderRadius
                                                                                .all(
                                                                                Radius
                                                                                    .circular(
                                                                                    5.0)),
                                                                          ),
                                                                          child: Image
                                                                              .network(
                                                                            imgHtp,
                                                                            fit: BoxFit
                                                                                .contain,
                                                                          ),
                                                                        )
                                                                            : _con
                                                                            .AccountWallVideos[index]["youtube_video_id"] !=
                                                                            null &&
                                                                            _con
                                                                                .AccountWallVideos[index]["youtube_video_id"]
                                                                                .toString()
                                                                                .length !=
                                                                                11
                                                                            ? Container(
                                                                          height: 105,
                                                                          width: 146,
                                                                          decoration: BoxDecoration(
                                                                            //color: Color(0xFF48c0d8),
                                                                            border: Border
                                                                                .all(
                                                                              color: Colors
                                                                                  .white,
                                                                            ),
                                                                            borderRadius: BorderRadius
                                                                                .all(
                                                                                Radius
                                                                                    .circular(
                                                                                    5.0)),
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(3.0),
                                                                            child: ThumbVideoWidget(
                                                                              url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                                                                  _con
                                                                                      .AccountWallVideos[index]['youtube_video_id']
                                                                                      .toString()
                                                                                      .replaceAll(
                                                                                      " ",
                                                                                      "%20") +
                                                                                  "?alt=media",
                                                                              play: true,),
                                                                          ),
                                                                        )
                                                                            : Container(),
                                                                        SizedBox(
                                                                          width: 10,
                                                                        ),
                                                                        Container(width: MediaQuery.of(context).size.width-188,
                                                                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,

                                                                            children: <
                                                                                Widget>[
                                                                              _con
                                                                                  .AccountWallVideos[index]["youtube_title"]
                                                                                  .length >
                                                                                  70
                                                                                  ? Text(
                                                                                // "Mumbai Street Foods | \nBest Indian Street Food",
                                                                                _con
                                                                                    .AccountWallVideos[index]["youtube_title"]
                                                                                    .substring(
                                                                                    0,
                                                                                    70) +
                                                                                    " ...",
                                                                                style: f14wB,
                                                                                textAlign: TextAlign
                                                                                    .start,
                                                                              )
                                                                                  : Text(
                                                                                  _con
                                                                                      .AccountWallVideos[index]["youtube_title"],
                                                                                  style: f14wB,
                                                                                  textAlign: TextAlign
                                                                                      .start),

                                                                              /*_con.AccountWallVideos[index]
                                                                ['description'] !=
                                                                    "" && _con.AccountWallVideos[index]
                                                                ['description'] != null ? SmartText(
                                                                  text:  _con
                                                                      .AccountWallVideos[index]['description'].toString().length<22 ?
                                                                  _con
                                                                      .AccountWallVideos[index]['description'] :  _con
                                                                      .AccountWallVideos[index]['description'].toString().substring(0,20)+" ...",
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                  ),
                                                                  onOpen:(link){
                                                                    Navigator.push(context, MaterialPageRoute(
                                                                        builder: (context)=>WebViewContainer(url: link,)
                                                                    ));
                                                                  },
                                                                  onTagClick: (tag) {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                HashSearchAppbar(
                                                                                  hashTag: tag,
                                                                                )));
                                                                  },
                                                                  onUserTagClick: (tag) {
                                                                    _con.getUseranametoId(tag.toString().replaceFirst("@", ""));
                                                                  },
                                                                )
                                                                    : Container(),*/
                                                                              SizedBox(height: 10,),
                                                                              Row(
                                                                                children: <
                                                                                    Widget>[
                                                                                  Text(
                                                                                    _con.AccountWallVideos[index]["view_count"].toString()+" Views | ",
                                                                                    style: f13y,
                                                                                    textAlign: TextAlign
                                                                                        .start,
                                                                                  ),
                                                                                  Text(
                                                                                    d
                                                                                        .toString(),
                                                                                    style: f13y,
                                                                                    textAlign: TextAlign
                                                                                        .start,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top: 0.0),
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          showModalBottomSheet(backgroundColor: Color(0xFF1E2026),
                                                                              context: context,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              builder: (BuildContext context) {
                                                                                return StatefulBuilder(
                                                                                    builder: (
                                                                                        BuildContext
                                                                                        context,
                                                                                        sss. StateSetter
                                                                                        state) {
                                                                                      return Padding(
                                                                                        padding: const EdgeInsets.only(bottom:
                                                                                        5.0, top: 5, right: 10, left: 10),
                                                                                        child:
                                                                                        Wrap(
                                                                                          children: <
                                                                                              Widget>[
                                                                                            //edit post
                                                                                            userid.toString() == _con.AccountWallVideos[index]
                                                                                            ["user_id"].toString() &&
                                                                                                _con.AccountWallVideos[index]["post_type"].toString() == "user"
                                                                                                ? Padding(
                                                                                              padding: const EdgeInsets
                                                                                                  .all(
                                                                                                  6.0),
                                                                                              child: InkWell(
                                                                                                onTap: () {
                                                                                                  Navigator
                                                                                                      .pop(
                                                                                                      context);
                                                                                                  Navigator
                                                                                                      .push(
                                                                                                      context,
                                                                                                      MaterialPageRoute(
                                                                                                          builder: (
                                                                                                              context) =>
                                                                                                              EditPost(
                                                                                                                desc: _con
                                                                                                                    .AccountWallVideos[index]['description']
                                                                                                                    .toString(),
                                                                                                                postid: _con
                                                                                                                    .AccountWallVideos[index]["id"]
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
                                                                                            //delete post
                                                                                            userid.toString() == _con.AccountWallVideos[index]['user_id'].toString() &&
                                                                                                _con.AccountWallVideos[index]["post_type"].toString() == "user"
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
                                                                                                            MaterialButton(
                                                                                                              height: 28,
                                                                                                              color: Color(
                                                                                                                  0xFFffd55e),
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
                                                                                                              color: Color(
                                                                                                                  0xFF48c0d8),
                                                                                                              child: new Text(
                                                                                                                "Delete",
                                                                                                                style: TextStyle(
                                                                                                                    color: Colors
                                                                                                                        .black),
                                                                                                              ),
                                                                                                              onPressed: () {
                                                                                                                _postUpdate();
                                                                                                                _con
                                                                                                                    .deleteTimelineWall(
                                                                                                                    userid
                                                                                                                        .toString(),
                                                                                                                    _con
                                                                                                                        .AccountWallVideos[index]['id']
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
                                                                                            //save post
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
                                                                                                            .AccountWallVideos[index]["id"]
                                                                                                            .toString();
                                                                                                    if(_con.AccountWallVideos[index]['save_status'] ==
                                                                                                        true)
                                                                                                    {
                                                                                                      _con.AccountWallVideos[index]['save_status'] = false;
                                                                                                      _con.AccountWallVideos[index]['save_status']=false;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                      _con.AccountWallVideos[index]['save_status'] = true;
                                                                                                      _con.AccountWallVideos[index]['save_status']=true;
                                                                                                    }
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
                                                                                                            _con.AccountWallVideos[index]['save_status']? "Saved Post" : "Save Post",
                                                                                                            style: f15wB,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 3,
                                                                                                          ),
                                                                                                          Text(_con.AccountWallVideos[index]['save_status']? "Added this to your saved post" :
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
                                                                                            //report post
                                                                                            userid.toString() != _con.AccountWallVideos[index]['user_id'].toString()
                                                                                                ? Padding(
                                                                                              padding: const EdgeInsets
                                                                                                  .all(
                                                                                                  6.0),
                                                                                              child: InkWell(
                                                                                                onTap: () {
                                                                                                  _con
                                                                                                      .reportTimeWall(
                                                                                                      userid.toString(),
                                                                                                      _con
                                                                                                          .AccountWallVideos[index]['id']);

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
                                                                                            //follooww user
                                                                                            userid.toString() != _con.AccountWallVideos[index]['user_id'].toString()
                                                                                                ? Padding(
                                                                                              padding: const EdgeInsets
                                                                                                  .all(
                                                                                                  6.0),
                                                                                              child: InkWell(
                                                                                                onTap: () {
                                                                                                  _con.AccountWallVideos[index]["follow_status"] ?
                                                                                                  showDialog(
                                                                                                      context: context,
                                                                                                      builder: (
                                                                                                          BuildContext context) {
                                                                                                        return AlertDialog(
                                                                                                          backgroundColor: Color(
                                                                                                              0xFF1E2026),
                                                                                                          content: new Text(
                                                                                                            "Do you want to Unfollow "+_con.AccountWallVideos[index]['name'].toString()+" ?",
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
                                                                                                                setState(() {

                                                                                                                });
                                                                                                                setState(() { _con
                                                                                                                    .AccountWallVideos[index]["follow_status"] = false;});
                                                                                                                _con
                                                                                                                    .followerController(
                                                                                                                    userid
                                                                                                                        .toString(),
                                                                                                                    _con
                                                                                                                        .AccountWallVideos[index]['user_id']
                                                                                                                        .toString());
                                                                                                                Navigator
                                                                                                                    .pop(
                                                                                                                    context);

                                                                                                              },
                                                                                                            ),
                                                                                                          ],
                                                                                                        );
                                                                                                      }) :
                                                                                                  _con
                                                                                                      .followerController(
                                                                                                      userid
                                                                                                          .toString(),
                                                                                                      _con
                                                                                                          .AccountWallVideos[index]['user_id']
                                                                                                          .toString());
                                                                                                  if(_con
                                                                                                      .AccountWallVideos[index]["follow_status"] ==
                                                                                                      false){
                                                                                                    setState(() { _con
                                                                                                        .AccountWallVideos[index]["follow_status"] = true;});
                                                                                                  }

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
                                                                                                              .AccountWallVideos[index]["follow_status"] ==
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
                                                                                                              .AccountWallVideos[index]["follow_status"] ==
                                                                                                              true
                                                                                                              ? Text(
                                                                                                            "Unfollow  " +
                                                                                                                _con
                                                                                                                    .AccountWallVideos[index]["name"],
                                                                                                            style: f13w,
                                                                                                          )
                                                                                                              : Text(
                                                                                                            "Follow  " +
                                                                                                                _con
                                                                                                                    .AccountWallVideos[index]["name"],
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
                                                                                            // copy   post
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
                                                                                                            .AccountWallVideos[index]['id']
                                                                                                            .toString();
                                                                                                    sharePost =
                                                                                                        "https://saasinfomedia.com/foodiz/public/sharepost/" +
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
                                                                                            //share post
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
                                                                                                            .AccountWallVideos[index]['id']
                                                                                                            .toString();
                                                                                                    sharePost =
                                                                                                        "https://saasinfomedia.com/foodiz/public/sharepost/" +
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
                                                                          Icons
                                                                              .more_vert,
                                                                          color: Colors
                                                                              .white,
                                                                          size: 14,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                          ),
                                                          Divider(
                                                            color: Colors
                                                                .black87,
                                                            thickness: 1,
                                                          ),
                                                        ],
                                                      )
                                                         ;
                                                    }),
                                              )
                                            ],
                                          )
                                              : _con.statusVideo == false
                                              ? Center(child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 100.0),
                                            child: Text(
                                              "No Videos", style: f16wB,),
                                          ))
                                              : Container(height: 0,),
                                        ],
                                    ),
                                  ),
                                      )
                                      : Container(),
                                  _tabContoller.index == 2
                                      ? AccountFoodReviews(reviwcontro: _accountControo,)
                                      : Container(),
                                  _tabContoller.index == 3
                                      ? AccountFoodMarcket(marketcontro: _accountControo,pageid: Market_pageid.toString(),)
                                      : Container(),
                                  _tabContoller.index == 4
                                      ? AccountFoodBank(bankControo: _accountControo,pageid: Foodbank_pageid.toString(),)
                                      : Container(),
                                  _tabContoller.index == 5
                                      ? AccountBlog(blogContro: _accountControo,)
                                      : Container()
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
          : CircularProgressIndicator(
        backgroundColor: Color(0xFF48c0d8),
      ),
    );
  }
}

/// Component category class to set list
class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        splashColor: Colors.white,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black87))),
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
                      style: f14w,
                    ),
                  ),
                ],
              ),
              //Icon(Icons.arrow_right, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile2 extends StatelessWidget {
  final String img;
  final String text;
  final Function onTap;

  CustomListTile2(this.img, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
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
                    Image.asset(
                      img,
                      height: 20,
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: f14w,
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
