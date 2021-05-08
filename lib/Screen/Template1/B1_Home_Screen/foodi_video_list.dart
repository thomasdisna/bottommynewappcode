import 'dart:async';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/edit_post.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/share_post_page.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Screen/Template1/B1_Home_Screen/ANOTHERPERSON/wall_web_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/kitchen_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/restaurant_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/store_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/hashtag_search_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FoodieVideosList extends StatefulWidget {

  FoodieVideosList({this.idddd,this.video_id,this.tim_id});

  String tim_id;
  int idddd;
  String video_id;

  @override
  _FoodieVideosListState createState() => _FoodieVideosListState();
}

class _FoodieVideosListState extends StateMVC<FoodieVideosList> {

  TimelineWallController _con;

  _FoodieVideosListState() : super(TimelineWallController()) {
    _con = controller;
  }

  YoutubePlayerController _utubecontroller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    _con.updateViewCountOfPost(widget.idddd.toString());
    // TODO: implement initState
    super.initState();
    setState(() {
      mainVideo = {};
      _showml = false;
    });
    _con.getFoodieFullVideosList(widget.idddd,widget.tim_id,);
    _utubecontroller = YoutubePlayerController(
      initialVideoId: widget.video_id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_isPlayerReady && mounted && !_utubecontroller.value.isFullScreen) {
      setState(() {
        _playerState = _utubecontroller.value.playerState;
        _videoMetaData = _utubecontroller.metadata;
      });
    }
  }

  DateTime _date;
  DateTime _date2;
  var d;
  var gg;
  var sharePost;
  bool  _showml;

  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post', sharePost, 'text/plain');
    } catch (e) {
      //print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    if(mainVideo !=null && _con.fullVideosList.length>0){
      _date = DateTime.parse(
          mainVideo['created_at']['date']);
      var c = DateTime.now().difference(_date).inHours;
      c > 24 && c <= 48
          ? d = "Yesterday" : c > 48 ?
      d = DateFormat.MMMd().format(_date)
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

      print("fgvbhnjmk "+mainVideo['like_status'] .toString());

    }
    print("dctfvgbhjn "+mainVideo["youtube_video_id"].toString());
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
      body:  _con.fullVideosList.length>0  && _con.statusFollower == false?
      SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SizedBox(height: 5,),
            mainVideo!=null ?  Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /*mainVideo["shared_post_id"] !=
                      null ? Padding(
                    padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 5,),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors
                                  .grey[300],
                              width: .2)),
                      child: Padding(
                        padding: const EdgeInsets
                            .only(
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
                                    right: 5.0,
                                    top: 10,
                                    bottom: 2),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .center,
                                  children: <
                                      Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator
                                            .push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (
                                                    context) =>
                                                    TimelineFoodWallDetailPage(
                                                      id:   mainVideo["shared_post_details"]["user_id"]
                                                          .toString(),
                                                    )));
                                      },
                                      child: Stack(alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            height: 38.0,
                                            width: 38.0,
                                            child: Center(
                                              child: Container(
                                                height: 35.0,
                                                width: 35.0,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: mainVideo["shared_post_details"]["picture"] !=
                                                            null
                                                            ? CachedNetworkImageProvider(
                                                            mainVideo["shared_post_details"]["picture"]
                                                                .toString()
                                                                .replaceAll(
                                                                " ",
                                                                "%20") +
                                                                "?alt=media")
                                                            : CachedNetworkImageProvider(
                                                          "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                        ),
                                                        fit: BoxFit
                                                            .cover),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius
                                                            .circular(
                                                            180.0))),
                                              ),
                                            ),
                                          ),
                                          mainVideo["shared_post_details"]["business_type"].toString() == "3" && mainVideo["shared_post_details"]["post_type"].toString() == "business"  ?  Padding(
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
                                          ) :
                                          mainVideo["shared_post_details"]["business_type"].toString() == "2" && mainVideo["shared_post_details"]["post_type"].toString() == "business" ? Padding(
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
                                                      "assets/Template1/image/Foodie/icons/market.png",
                                                      height: 12,
                                                      width: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ) :
                                          mainVideo["shared_post_details"]["business_type"].toString() == "1" && mainVideo["shared_post_details"]["post_type"].toString() == "business" ?
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
                                                      "assets/chef.png",
                                                      height: 12,
                                                      width: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ) : Container(height: 0,)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child:
                                      GestureDetector(
                                        onTap: () {
                                          Navigator
                                              .push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (
                                                      context) =>
                                                      TimelineFoodWallDetailPage(
                                                        id:mainVideo["shared_post_details"]['user_id']
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
                                              mainVideo["shared_post_details"]
                                              [
                                              'name']
                                                  .toString(),
                                              style: f15wB,
                                            ),
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
                            mainVideo["shared_post_details"]
                            ['description'] !=
                                "" && mainVideo["shared_post_details"]
                            ['description'] != null
                                ? Padding(
                              padding: const EdgeInsets
                                  .only(left: 8,
                                  right: 8),
                              child: mainVideo["shared_post_details"]
                              ['description']
                                  .length >
                                  130 && *//*textSpan==false &&*/
                  /*
                                  _sharedshowml ==
                                      false ?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  SmartText(
                                    text:
                                    mainVideo["shared_post_details"]['description']
                                        .substring(
                                      0, 129,) +
                                        " ...",
                                    style: TextStyle(
                                      color: Colors
                                          .white,
                                    ),
                                    onOpen: (link) {
                                      Navigator
                                          .push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (
                                                  context) =>
                                                  WebViewContainer(
                                                    url: link,)
                                          ));
                                    },
                                    onTagClick: (
                                        tag) {
                                      Navigator
                                          .push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (
                                                  context) =>
                                                  HashSearchAppbar(
                                                    hashTag: tag,
                                                  )));
                                    },
                                    onUserTagClick: (
                                        tag) {
                                      _con
                                          .getUseranametoId(context,
                                          tag
                                              .toString()
                                              .replaceFirst(
                                              "@",
                                              ""));
                                    },
                                  ),
                                  SizedBox(
                                    height: 3,),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          textSpan =
                                          true;
                                          _sharedshowml =
                                          true;
                                        });
                                      },
                                      child: Text(
                                        "Show more...",
                                        style: f14p,)),
                                  SizedBox(
                                    height: 2,),
                                ],
                              ) : mainVideo["shared_post_details"]
                              ['description']
                                  .length > 130 */
                  /* &&
                                textSpan == true*/
                  /* && _sharedshowml ==
                                  true ?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  SmartText(
                                    text:
                                    mainVideo["shared_post_details"]['description'],
                                    style: TextStyle(
                                      color: Colors
                                          .white,
                                    ),
                                    onOpen: (link) {
                                      Navigator
                                          .push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (
                                                  context) =>
                                                  WebViewContainer(
                                                    url: link,)
                                          ));
                                    },
                                    onTagClick: (
                                        tag) {
                                      Navigator
                                          .push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (
                                                  context) =>
                                                  HashSearchAppbar(
                                                    hashTag: tag,
                                                  )));
                                    },
                                    onUserTagClick: (
                                        tag) {
                                      _con
                                          .getUseranametoId(context,
                                          tag
                                              .toString()
                                              .replaceFirst(
                                              "@",
                                              ""));
                                    },
                                  ),
                                  SizedBox(
                                    height: 3,),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          textSpan =
                                          false;
                                          _sharedshowml =
                                          false;
                                        });
                                      },
                                      child: Text(
                                        "Show less...",
                                        style: f14p,)),
                                  SizedBox(
                                    height: 2,),
                                ],
                              ) : mainVideo["shared_post_details"]
                              ['description']
                                  .length <= 130
                                  ? SmartText(
                                text:
                                mainVideo["shared_post_details"]['description'],
                                style: TextStyle(
                                  color: Colors
                                      .white,
                                ),
                                onOpen: (link) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) =>
                                              WebViewContainer(
                                                url: link,)
                                      ));
                                },
                                onTagClick: (tag) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) =>
                                              HashSearchAppbar(
                                                hashTag: tag,
                                              )));
                                },
                                onUserTagClick: (
                                    tag) {
                                  _con
                                      .getUseranametoId(context,
                                      tag.toString()
                                          .replaceFirst(
                                          "@", ""));
                                },
                              )
                                  : Container(),
                            )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top: 5,
                                  bottom: 5),
                              child: mainVideo["shared_post_details"]
                              [
                              "youtube_video_id"]
                                  .toString()
                                  .length != 11 &&
                                  mainVideo["shared_post_details"][
                                  "youtube_video_id"] !=
                                      null ?
                              VimeoPlayer(id: mainVideo["shared_post_details"]["youtube_video_id"].toString().replaceAll("/videos/", ""),
                                autoPlay: false,looping: true,)
                                  : Container(
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(height: 0),*/
                  /* mainVideo["shared_post_id"] ==null ? */ SizedBox(height: 5,) /*: Container()*/,
                  /* mainVideo["shared_post_id"] ==null ? */ YoutubePlayer(
                    controller: _utubecontroller,
                    liveUIColor: Colors.amber,
                  ), /*: Container()*/
                  /*mainVideo["shared_post_id"] ==null ? */SizedBox(height: 8,) /*: Container()*/,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7,left: 8,right: 8),
                    child: SmartText(
                      text:
                      mainVideo["youtube_title"]
                          .toString(),
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
                        _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                      },
                    ),
                  ),
                  mainVideo['description'] != "" &&
                      mainVideo['description'] != null
                      ?  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8,bottom: 7),
                    child: mainVideo['description'].toString().length >
                        130 && /*textSpan==false &&*/
                        _showml == false ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        SmartText(
                          text:
                          mainVideo['description'].toString()
                              .substring(0, 129,) +
                              " ...",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          onOpen: (link) {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (
                                        context) =>
                                        WebViewContainer(
                                          url: link,)
                                ));
                          },

                          onTagClick: (tag) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        context) =>
                                        HashSearchAppbar(
                                          hashTag: tag,
                                        )));
                          },
                          onUserTagClick: (tag) {
                            _con.getUseranametoId(context,
                                tag.toString()
                                    .replaceFirst(
                                    "@", ""));
                          },
                        ),
                        SizedBox(height: 3,),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                textSpan = true;
                                _showml =
                                true;
                              });
                            },
                            child: Text(
                              "Show more...",
                              style: f14p,)),
                        SizedBox(height: 2,),
                      ],
                    ) :mainVideo['description'].length > 130 /* &&
                                  textSpan == true*/ && _showml == true ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        SmartText(
                          text:
                          mainVideo['description'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          onOpen: (link) {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (
                                        context) =>
                                        WebViewContainer(
                                          url: link,)
                                ));
                          },
                          onTagClick: (tag) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        context) =>
                                        HashSearchAppbar(
                                          hashTag: tag,
                                        )));
                          },
                          onUserTagClick: (tag) {
                            _con.getUseranametoId(context,
                                tag.toString()
                                    .replaceFirst(
                                    "@", ""));
                          },
                        ),
                        SizedBox(height: 3,),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                textSpan = false;
                                _showml =
                                false;
                              });
                            },
                            child: Text(
                              "Show less...",
                              style: f14p,)),
                        SizedBox(height: 2,),
                      ],
                    ) :mainVideo['description'].length <= 130
                        ? SmartText(
                      text:
                      mainVideo['description'],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onOpen: (link) {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (
                                    context) =>
                                    WebViewContainer(
                                      url: link,)
                            ));
                      },
                      onTagClick: (tag) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) =>
                                    HashSearchAppbar(
                                      hashTag: tag,
                                    )));
                      },
                      onUserTagClick: (tag) {
                        _con.getUseranametoId(context,tag
                            .toString()
                            .replaceFirst("@", ""));
                      },
                    )
                        : Container(),
                  )
                      : Container(),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets
                          .only(
                          left: 5.0,

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
                              // GestureDetector(
                              //   onTap: () {
                              //     showDialog(
                              //         context: context,
                              //         child:
                              //         Dialog(
                              //           backgroundColor: Color(
                              //               0xFF1E2026),
                              //           child: Container(
                              //             height: 230,width: 350,
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: CachedNetworkImage(
                              //                 placeholder: (
                              //                     context,
                              //                     ind) =>
                              //                     Image
                              //                         .asset(
                              //                       "assets/Template1/image/Foodie/post_dummy.jpeg",
                              //                       fit: BoxFit
                              //                           .cover,),
                              //                 imageUrl: mainVideo["business_type"]
                              //                     .toString() ==
                              //                     "4" ||   mainVideo["business_type"]
                              //                     .toString() ==
                              //                     "6"  ? mainVideo["picture"]
                              //                     .toString()
                              //                     .replaceAll(
                              //                     " ",
                              //                     "%20") +
                              //                     "?alt=media" :
                              //                 mainVideo["product_id"] !=
                              //                     null &&
                              //                     mainVideo["business_profile_image"] !=
                              //                         null && mainVideo["business_profile_image"] !=""
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                              //                     mainVideo["picture"]
                              //                         .toString() +
                              //                     "?alt=media"
                              //                     :mainVideo["product_id"] !=
                              //                     null && mainVideo["business_profile_image"] ==""
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                              //                     : mainVideo["product_id"] ==
                              //                     null &&
                              //                     mainVideo["post_type"]
                              //                         .toString() ==
                              //                         "page" &&
                              //                     mainVideo["picture"]
                              //                         .toString() !=
                              //                         ""
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                              //                     mainVideo["picture"]
                              //                         .toString()
                              //                         .replaceAll(
                              //                         " ",
                              //                         "%20") +
                              //                     "?alt=media"
                              //                     : mainVideo["product_id"] ==
                              //                     null &&
                              //                     mainVideo["post_type"]
                              //                         .toString() ==
                              //                         "page" &&
                              //                     mainVideo["picture"]
                              //                         .toString() ==
                              //                         ""
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                              //                     "icu.png" +
                              //                     "?alt=media"
                              //                     :mainVideo["picture"]
                              //                     .toString()
                              //                     .replaceAll(
                              //                     " ",
                              //                     "%20") +
                              //                     "?alt=media",
                              //
                              //                 fit: BoxFit
                              //                     .cover,
                              //               ),
                              //             ),
                              //           ),
                              //         ));
                              //   },
                              //   child: Container(
                              //     height: 35.0,
                              //     width: 35.0,
                              //
                              //     decoration: BoxDecoration(
                              //         image: DecorationImage(
                              //             image: mainVideo["picture"] !=
                              //                 null
                              //                 ? CachedNetworkImageProvider(
                              //                 mainVideo["post_type"]
                              //                     .toString() ==
                              //                     "page" &&
                              //                     mainVideo["picture"]
                              //                         .toString() ==
                              //                         ""
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                              //                     "icu.png" +
                              //                     "?alt=media" :
                              //                 mainVideo["business_type"]
                              //                     .toString() ==
                              //                     "4"  ||   mainVideo["business_type"]
                              //                     .toString() ==
                              //                     "6" ? mainVideo["picture"]
                              //                     .toString()
                              //                     .replaceAll(
                              //                     " ",
                              //                     "%20") +
                              //                     "?alt=media" :
                              //                 mainVideo["product_id"] !=
                              //                     null &&
                              //                     mainVideo["business_profile_image"] != null &&  mainVideo["business_profile_image"] != ""
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                              //                     mainVideo["picture"]
                              //                         .toString() +
                              //                     "?alt=media"
                              //                     : mainVideo["product_id"] !=
                              //                     null && mainVideo["business_profile_image"] == null
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                              //                     :mainVideo["product_id"] ==
                              //                     null &&
                              //                     mainVideo["post_type"]
                              //                         .toString() ==
                              //                         "page" &&
                              //                     mainVideo["picture"]
                              //                         .toString() !=
                              //                         ""
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                              //                     mainVideo["picture"]
                              //                         .toString()
                              //                         .replaceAll(
                              //                         " ",
                              //                         "%20") +
                              //                     "?alt=media"
                              //                     :  mainVideo["product_id"] ==
                              //                     null &&
                              //                     mainVideo["post_type"]
                              //                         .toString() ==
                              //                         "page" &&
                              //                     mainVideo["picture"]
                              //                         .toString() ==
                              //                         ""
                              //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                              //                     "icu.png" +
                              //                     "?alt=media"
                              //                     : mainVideo["picture"]
                              //                     .toString()
                              //                     .replaceAll(
                              //                     " ",
                              //                     "%20") +
                              //                     "?alt=media")
                              //                 : CachedNetworkImageProvider(
                              //               "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                              //             ),
                              //             fit: BoxFit
                              //                 .cover),
                              //         border: Border
                              //             .all(
                              //             color: (mainVideo["product_id"] ==
                              //                 null &&
                              //                 mainVideo["post_type"]
                              //                     .toString() ==
                              //                     "page" &&
                              //                 mainVideo["picture"]
                              //                     .toString() ==
                              //                     "") ||
                              //                 (mainVideo["product_id"] !=
                              //                     null &&  mainVideo["picture"]
                              //                     .toString() ==
                              //                     "" &&
                              //                     mainVideo["business_profile_image"] ==
                              //                         null) || (mainVideo["business_profile_image"] == "" &&
                              //                 mainVideo["post_type"]
                              //                     .toString() ==
                              //                     "page" &&  mainVideo["picture"]
                              //                 .toString() ==
                              //                 "")
                              //                 ? Color(
                              //                 0xFF48c0d8)
                              //                 : Colors
                              //                 .transparent),
                              //         borderRadius: BorderRadius
                              //             .all(
                              //             Radius
                              //                 .circular(
                              //                 180.0))),
                              //   ),
                              // ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child:
                                GestureDetector(
                                  onTap: () {
                                    mainVideo["product_id"] !=
                                        null && mainVideo["business_type"]
                                        .toString() ==
                                        "1" ?
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                KitchenProf(
                                                  currentindex: 1,
                                                  memberdate: "",
                                                  pagid: mainVideo['business_page_id']
                                                      .toString(),
                                                  timid:mainVideo['business_timeline_id']
                                                      .toString(),)
                                        )) : mainVideo["product_id"] ==
                                        null && mainVideo["post_type"]
                                        .toString() ==
                                        "page" &&
                                        mainVideo["business_type"]
                                            .toString() ==
                                            "1" ?
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                KitchenProf(
                                                  currentindex: 1,
                                                  memberdate: "",
                                                  pagid:mainVideo['business_page_id']
                                                      .toString(),
                                                  timid:mainVideo['timeline_id']
                                                      .toString(),)
                                        ))

                                        : mainVideo["product_id"] !=
                                        null && mainVideo["business_type"]
                                        .toString() ==
                                        "2" ?

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                StoreProf(
                                                  currentindex: 1,
                                                  memberdate: "",
                                                  pagid:mainVideo['business_page_id']
                                                      .toString(),
                                                  timid: mainVideo['business_timeline_id']
                                                      .toString(),)
                                        )) : mainVideo["product_id"] ==
                                        null && mainVideo["post_type"]
                                        .toString() ==
                                        "page" &&
                                        mainVideo["business_type"]
                                            .toString() ==
                                            "2"
                                        ?
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                StoreProf(
                                                  currentindex: 1,
                                                  memberdate: "",
                                                  pagid: mainVideo['business_page_id']
                                                      .toString(),
                                                  timid: mainVideo['timeline_id']
                                                      .toString(),)))
                                        :mainVideo["product_id"] !=
                                        null &&mainVideo["business_type"]
                                        .toString() ==
                                        "3" ?
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                RestProf(
                                                  currentindex: 1,
                                                  memberdate: "",
                                                  pagid: mainVideo['business_page_id']
                                                      .toString(),
                                                  timid: mainVideo['business_timeline_id']
                                                      .toString(),)
                                        ))
                                        : mainVideo["product_id"] ==
                                        null && mainVideo["post_type"]
                                        .toString() ==
                                        "page" &&
                                        mainVideo["business_type"]
                                            .toString() ==
                                            "3"
                                        ?
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                RestProf(
                                                  currentindex: 1,
                                                  memberdate: "",
                                                  pagid: mainVideo['business_page_id']
                                                      .toString(),
                                                  timid: mainVideo['timeline_id']
                                                      .toString(),)))
                                        : Navigator
                                        .push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                TimelineFoodWallDetailPage(
                                                  id: mainVideo['user_id']
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
                                        mainVideo["product_id"] !=
                                            null
                                            ? mainVideo['business_name']
                                            .toString()
                                            :mainVideo['name']
                                            .toString(),
                                        style: f15wB,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              d
                                                  .toString(),
                                              style: f10g),
                                          mainVideo['post_location'] !=
                                              null &&
                                              mainVideo['post_location']
                                                  .toString()
                                                  .length >
                                                  0
                                              ?
                                          Row(
                                            children: [
                                              Text("   - ",style: f10g,),
                                              Icon(Icons.location_on,color: Colors.grey,size: 13,),
                                              SizedBox(width: 1,),
                                              Text(
                                                userid.toString() == mainVideo['user_id'].toString() &&mainVideo['post_location']
                                                    .toString().length>=45 && (mainVideo["post_type"].toString()
                                                    =="page" || mainVideo["post_type"].toString()
                                                    =="user")
                                                    ?   mainVideo['post_location']
                                                    .toString().substring(0,45)+"..." :
                                                userid.toString() == mainVideo['user_id'].toString() && mainVideo['post_location']
                                                    .toString().length<40 && (mainVideo["post_type"].toString()
                                                    =="page" || mainVideo["post_type"].toString()
                                                    =="user")
                                                    ?   mainVideo['post_location']
                                                    .toString() :  mainVideo["post_type"].toString()
                                                    =="page" && mainVideo['post_location']
                                                    .toString().length>=21 && userid.toString() != mainVideo['user_id'].toString()
                                                    ? mainVideo['post_location']
                                                    .toString().substring(0,21)+"..." :
                                                mainVideo["post_type"].toString()
                                                    =="page" && mainVideo['post_location']
                                                    .toString().length<21 && userid.toString() != mainVideo['user_id'].toString() ?
                                                mainVideo['post_location']
                                                    .toString() :
                                                mainVideo["post_type"].toString()
                                                    =="user" && mainVideo['post_location']
                                                    .toString().length>=33 && userid.toString() !=mainVideo['user_id'].toString() ?
                                                mainVideo['post_location']
                                                    .toString().substring(0,33)+"..." :mainVideo['post_location']
                                                    .toString(),
                                                style: f10g,
                                              ),
                                            ],
                                          )
                                              : Container(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: <Widget>[
                              userid.toString() !=
                                  mainVideo["user_id"]
                                      .toString() &&
                                  mainVideo["post_type"]
                                      .toString() ==
                                      "page" && mainVideo["business_type"]
                                  .toString() !="4" &&mainVideo["business_type"]
                                  .toString() !="6"
                                  ? Container(height: 23,
                                child: MaterialButton(

                                  onPressed: () {
                                    if (mainVideo["follow_status"] ==
                                        true) {
                                      showDialog(
                                          context: context,
                                          builder: (
                                              BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                              Color(
                                                  0xFF1E2026),
                                              content: new Text(
                                                "Do you want to Unfollow " +
                                                    mainVideo["name"]
                                                        .toString() +
                                                    " ?",
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
                                                        color:
                                                        Colors
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
                                                    "Unfollow",
                                                    style: TextStyle(
                                                        color:
                                                        Colors
                                                            .black),
                                                  ),
                                                  onPressed: () {
                                                    _con
                                                        .BusinessFollowunFollow(
                                                      mainVideo['business_page_id']
                                                          .toString(),
                                                      userid
                                                          .toString(),);
                                                    setState(() {
                                                      mainVideo["follow_status"] =
                                                      false;
                                                    });
                                                    Navigator
                                                        .pop(
                                                        context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                    else {
                                      _con
                                          .BusinessFollowunFollow(
                                        mainVideo['business_page_id']
                                            .toString(),
                                        userid
                                            .toString(),);
                                      setState(() {
                                        mainVideo["follow_status"] =
                                        true;
                                      });
                                    }
                                  },
                                  splashColor: Color(0xFFffd55e),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          2)
                                  ),
                                  height: 23,
                                  minWidth: 70,
                                  color: Color(
                                      0xFF48c0d9),
                                  child: Center(
                                      child: mainVideo[
                                      "follow_status"] ==
                                          true
                                          ? Text(
                                          "Unfollow",
                                          style: f14B)
                                          : Text(
                                          "Follow",
                                          style: f14B)),
                                ),
                              ) : Container(),
                              SizedBox(width: 12),
                              userid.toString() !=
                                  mainVideo[
                                  "user_id"]
                                      .toString() &&mainVideo["business_type"]
                                  .toString() !="6" && mainVideo["business_type"]
                                  .toString() !="4"
                                  ? GestureDetector(
                                  onTap: () {
                                    try {
                                      String chatID = makeChatId(
                                          timelineIdFoodi
                                              .toString(),
                                          mainVideo[
                                          'timeline_id']
                                              .toString());
                                      Navigator
                                          .push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (
                                                  context) =>
                                                  ChatRoom(
                                                      timelineIdFoodi.toString(),
                                                      NAME,
                                                      mainVideo[
                                                      'device_token']
                                                          .toString(),
                                                      mainVideo ['timeline_id']
                                                          .toString(),
                                                      chatID,
                                                      mainVideo['username']
                                                          .toString(),
                                                      mainVideo[
                                                      'name']
                                                          .toString(),
                                                      mainVideo[
                                                      'post_type'] =="page"  ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+mainVideo[
                                                      'picture']
                                                          .toString()
                                                          .replaceAll(
                                                          " ",
                                                          "%20") +
                                                          "?alt=media" : mainVideo[
                                                      'picture']
                                                          .toString()
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
                                          (
                                          BuildContext
                                          context) {
                                        return StatefulBuilder(
                                            builder: (
                                                BuildContext
                                                context,
                                                sss. StateSetter
                                                state) {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom:
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
                                                        mainVideo['user_id']
                                                            .toString() &&
                                                        mainVideo["post_type"]
                                                            .toString() ==
                                                            "user"
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
                                                                        desc: mainVideo['description']
                                                                            .toString(),
                                                                        postid: mainVideo["id"]
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
                                                        mainVideo['user_id']
                                                            .toString() &&
                                                        mainVideo["post_type"]
                                                            .toString() ==
                                                            "user"
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
                                                                        _con
                                                                            .deleteTimelineWall(
                                                                            userid
                                                                                .toString(),
                                                                            mainVideo['id']
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
                                                                mainVideo["id"]
                                                                    .toString();
                                                            if(mainVideo['save_status']==
                                                                true)
                                                            {

                                                              mainVideo['save_status']=false;
                                                            }
                                                            else
                                                            {

                                                              mainVideo['save_status']=true;
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
                                                                    mainVideo['save_status']==
                                                                        true ? "Saved Post"  : "Save Post",
                                                                    style: f15wB,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Text(
                                                                    mainVideo['save_status']==
                                                                        true ? "Added this to your saved post" :  "Add this to your saved post",
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
                                                        mainVideo['user_id']
                                                            .toString()
                                                        ? Padding(
                                                      padding: const EdgeInsets
                                                          .all(
                                                          6.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          _con
                                                              .reportTimeWall(
                                                              userid.toString(),
                                                              mainVideo['id']);

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
                                                        mainVideo['user_id']
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
                                                              mainVideo['user_id']
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
                                                                  mainVideo["follow_status"] ==
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
                                                                  mainVideo["follow_status"] ==
                                                                      true
                                                                      ? Text(
                                                                    "Unfollow  " +
                                                                        mainVideo["name"],
                                                                    style: f13w,
                                                                  )
                                                                      : Text(
                                                                    "Follow  " +
                                                                        mainVideo["name"],
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
                                                                mainVideo['id']
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
                                                                mainVideo['id']
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
                  SizedBox(height: 7,),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 7.0,
                        right: 7,
                        bottom: 5),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              postid = mainVideo
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
                              mainVideo
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
                              postid = mainVideo
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
                            _con
                                .getTimelineWall(
                                userid
                                    .toString());
                          },
                          child: Text(
                              mainVideo
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
                              postid = mainVideo
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
                              mainVideo
                              [
                              'share_count']
                                  .toString() +
                                  " Shares",
                              style: f14y),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 7.0,
                        right: 7,
                        top: 5),
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
                              mainVideo['like_status'] ==
                                  true ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    postid = mainVideo[
                                    'id'].toString();
                                    mainVideo['like_status'] = false;
                                    mainVideo['likes_count'] =
                                        mainVideo['likes_count'] -
                                            1;
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
                                    postid = mainVideo[
                                    'id']
                                        .toString();
                                    mainVideo['like_status'] =
                                    true;
                                    mainVideo['likes_count'] =
                                        mainVideo['likes_count'] +
                                            1;
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
                                    postid = mainVideo
                                    ['id']
                                        .toString();
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder:
                                              (
                                              context) =>
                                              CommentPage()));
                                  _con
                                      .getTimelineWall(
                                      userid);
                                },
                                child: Row(
                                  children: <
                                      Widget>[
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
                                    postid = mainVideo
                                    ['id']
                                        .toString();
                                    sharePost =
                                        "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                            postid
                                                .toString();
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) =>
                                              SharePost(
                                                postid: postid
                                                    .toString(),
                                                sharepost: sharePost
                                                    .toString(),)));
                                  /* panelController
                                                                    .expand();*/
                                },
                                child: Row(
                                  children: <
                                      Widget>[
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
                              mainVideo['save_status'] ==
                                  true
                                  ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mainVideo['save_status'] =
                                    false;
                                    postid = mainVideo
                                    [
                                    "id"]
                                        .toString();
                                  });
                                  _con
                                      .saveTimelinePost(
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
                                    mainVideo['save_status'] =
                                    true;
                                    postid = mainVideo
                                    [
                                    "id"]
                                        .toString();
                                  });
                                  _con
                                      .saveTimelinePost(
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
            ) : Container(),
            SizedBox(height: 7,),
            Divider(
              thickness: 7,
              color: Colors.black87,
            ),
            // Text("Related Videos",style: f21BB,),
            // SizedBox(height: 20,),
            Container(
              height: _con.fullVideosList.length.toDouble()*135,
              child: ListView.separated(physics: NeverScrollableScrollPhysics(),
                  itemCount: _con.fullVideosList.length,
                  separatorBuilder: (context,inddddd){
                    return _con.fullVideosList[inddddd]["id"]==widget.idddd ? Container() : Padding(
                      padding: const EdgeInsets.only(left:12,right: 12),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black87,
                      ),
                    );
                  },
                  itemBuilder: (context,ind){
                    _date2 = DateTime.parse(
                        _con
                            .fullVideosList[ind]['created_at']['date']);
                    var b = DateTime
                        .now()
                        .difference(_date2)
                        .inHours;
                    b > 24
                        ? gg = DateTime
                        .now()
                        .difference(_date2)
                        .inDays
                        .toString() +
                        " day ago"
                        : b == 0 ?
                    gg = DateTime
                        .now()
                        .difference(_date2)
                        .inMinutes
                        .toString() +
                        " mints ago" : gg =
                        DateTime
                            .now()
                            .difference(_date2)
                            .inHours
                            .toString() +
                            " hrs ago";
                    return  _con.fullVideosList[ind]["id"]==widget.idddd ? Container() :InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => FoodieVideosList(idddd:  _con.fullVideosList[ind]["id"],video_id: _con
                                .fullVideosList[
                            ind][
                            "youtube_video_id"]
                                .toString(),tim_id: widget.tim_id,)
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:12, right: 12,bottom: 10,top: 10),
                        child: Container(
                            child:  Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(height: 100,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white)),
                                  child: Center(
                                    child: Container(clipBehavior: Clip.antiAlias,
                                      height: 97,
                                      width: 127,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                          imageUrl:"https://img.youtube.com/vi/" +
                                              _con
                                                  .fullVideosList[
                                              ind][
                                              "youtube_video_id"]
                                                  .toString() +
                                              "/0.jpg",
                                          fit: BoxFit.cover,
                                          placeholder: (context,
                                              ind) => Container( height: 97,
                                            width: 127,
                                            child: Image.asset(
                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                              fit: BoxFit.cover,),
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width-190,
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(_con.fullVideosList[ind]["description"]!=""?_con.fullVideosList[ind]["description"] : _con.fullVideosList[ind]["youtube_title"],style: f15w,overflow: TextOverflow.ellipsis,maxLines: 3,),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: <
                                                  Widget>[
                                                Text(
                                                  _con.fullVideosList[ind]["view_count"].toString()+" Views | ",
                                                  style: f13y,
                                                  textAlign: TextAlign
                                                      .start,
                                                ),
                                                Text(
                                                  gg
                                                      .toString(),
                                                  style: f13y,
                                                  textAlign: TextAlign
                                                      .start,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
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
                                                (
                                                BuildContext
                                                context) {
                                              return StatefulBuilder(
                                                  builder: (
                                                      BuildContext
                                                      context,
                                                      sss. StateSetter
                                                      state) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(bottom:
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
                                                              _con.fullVideosList[ind]['user_id']
                                                                  .toString() &&
                                                              _con.fullVideosList[ind]["post_type"]
                                                                  .toString() ==
                                                                  "user"
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
                                                                              desc: _con.fullVideosList[ind]['description']
                                                                                  .toString(),
                                                                              postid: _con.fullVideosList[ind]["id"]
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
                                                              _con.fullVideosList[ind]['user_id']
                                                                  .toString() &&
                                                              _con.fullVideosList[ind]["post_type"]
                                                                  .toString() ==
                                                                  "user"
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
                                                                              _con
                                                                                  .deleteTimelineWall(
                                                                                  userid
                                                                                      .toString(),
                                                                                  _con.fullVideosList[ind]['id']
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
                                                                      _con.fullVideosList[ind]["id"]
                                                                          .toString();
                                                                  if(_con.fullVideosList[ind]['save_status'] ==
                                                                      true)
                                                                  {
                                                                    _con.fullVideosList[ind]['save_status']=false;
                                                                  }
                                                                  else
                                                                  {
                                                                    _con.fullVideosList[ind]['save_status']=true;
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
                                                              _con.fullVideosList[ind]['user_id']
                                                                  .toString()
                                                              ? Padding(
                                                            padding: const EdgeInsets
                                                                .all(
                                                                6.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                _con
                                                                    .reportTimeWall(
                                                                    userid.toString(),
                                                                    _con.fullVideosList[ind]['id']);

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
                                                              _con.fullVideosList[ind]['user_id']
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
                                                                    _con.fullVideosList[ind]['user_id']
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
                                                                        _con.fullVideosList[ind]["follow_status"] ==
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
                                                                        _con.fullVideosList[ind]["follow_status"] ==
                                                                            true
                                                                            ? Text(
                                                                          "Unfollow  " +
                                                                              _con.fullVideosList[ind]["name"],
                                                                          style: f13w,
                                                                        )
                                                                            : Text(
                                                                          "Follow  " +
                                                                              _con.fullVideosList[ind]["name"],
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
                                                                      _con.fullVideosList[ind]['id']
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
                                                                      _con.fullVideosList[ind]['id']
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
                                        Icons.more_vert,
                                        color:
                                        Colors.white,size: 18,),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ) :
      _con.fullVideosList.length==0 && _con.statusFollower==true ? Center(
        child: CircularProgressIndicator(),
      ) : Center(
        child: Text("No Videos",style: f16bB,),
      ),
    );
  }
}
