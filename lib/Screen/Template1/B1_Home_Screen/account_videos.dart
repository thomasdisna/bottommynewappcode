import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutube/flutube.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/video_list_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
var httpsObj = "https://img.youtube.com/vi/";
var thirdHttp = "/0.jpg";
var imgHtp;
var s = "unlike";
var b = "unmark";
bool video;
DateTime _date;
var d;
List<String> playlist;
var namePass,youtubeIdPass,titlePass,DescPass,LikePass,CommentPass,SharePass;

class AccountVideos extends StatefulWidget {
  @override
  _AccountVideosState createState() => _AccountVideosState();
}

class _AccountVideosState extends StateMVC<AccountVideos> {
  TimelineWallController _con;

  _AccountVideosState() : super(TimelineWallController()) {
    _con = controller;
  }
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  @override
  void initState() {
//    _con. getAccountWallVideos(userid.toString(),"video");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(_con.AccountWallVideos.length>0){
      playlist = <String>[
        "https://www.youtube.com/watch?v="+_con.AccountWallVideos[0]["youtube_video_id"].toString()
      ];
    }
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Visibility(
                  visible: _con.statusVideo,
                  child: Container(
                      margin: EdgeInsets.only(top: 100, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            _con.AccountWallVideos.length>0 && _con.statusVideo == false ? Column(
              children: <Widget>[
                FluTube.playlist(
                  playlist,
                  autoInitialize: true,
                  aspectRatio: 16 / 9,
                  allowMuting: false,
                  looping: true,
                  deviceOrientationAfterFullscreen: [
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 15,
                    right: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _con.AccountWallVideos[0]["youtube_title"].length >40 ?Text(
                        _con.AccountWallVideos[0]["youtube_title"].toString().substring(0,40)+"...",
                        style: f14wB,
                      ):Text(_con.AccountWallVideos[0]["youtube_title"].toString(),style:f14wB),
                      Icon(Icons.more_vert, size: 16, color: Colors.white),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 7.0, right: 7, bottom: 5, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LikeCommentSharePage()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          _con.AccountWallVideos[0]["likes_count"].toString(),
                                          style: f14y,
                                        ),
                                        SizedBox(width: 3,),
                                        Text(
                                          "Likes",
                                          style: f14y,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 13,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        _con.AccountWallVideos[0]["comments_count"].toString(),
                                        style: f14y,
                                      ),
                                      SizedBox(width: 3,),
                                      Text(
                                        "Comments",
                                        style: f14y,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 13,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        _con.AccountWallVideos[0]["share_count"].toString(),
                                        style: f14y,
                                      ),
                                      SizedBox(width: 3,),
                                      Text(
                                        "Shares",
                                        style: f14y,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 7.0, right: 7, top: 5, bottom: 10),
                            child: Container(
                              child: InkWell(
                                child: Container(
                                  height: 20.0,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      _con.AccountWallVideos[0]
                                      ['like_status'] ==
                                          true
                                          ? GestureDetector(
                                        onTap: () {
                                          setState(() { postid=_con.AccountWallVideos[0]['id'].toString();});
                                          _con.likePostTime(
                                              userid.toString(),postid.toString());
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite,
                                              color: Color(0xFFffd55e),
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Liked",
                                              style: f14w,
                                            ),
                                          ],
                                        ),
                                      )
                                          : GestureDetector(
                                        onTap: () {
                                          setState(() { postid=_con.AccountWallVideos[0]['id'].toString();});
                                          _con.likePostTime(
                                              userid.toString(),postid.toString());
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Like",
                                              style: f14w,
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
                                                      CommentPage()));
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.chat_bubble_outline,
                                              color: Colors.white,
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
                                          showModalBottomSheet(
                                              backgroundColor: Color(0xFF1E2026),
                                              context: context,
                                              clipBehavior: Clip.antiAlias,
                                              builder: (BuildContext context) {
                                                return SingleChildScrollView(
                                                  child: StatefulBuilder(builder:
                                                      (BuildContext context,
                                                      sss.StateSetter state) {
                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 12.0,
                                                          top: 5,
                                                          right: 10,
                                                          left: 10),
                                                      child: Container(
                                                        height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                            1.2,
                                                        child: Wrap(
                                                          children: <Widget>[
                                                            Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: <Widget>[
                                                                Container(
                                                                  height: 35.0,
                                                                  width: 35.0,
                                                                  decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                          image: CachedNetworkImageProvider(
                                                                            "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                            errorListener:
                                                                                () =>
                                                                            new Icon(Icons.error),
                                                                          ),
                                                                          fit: BoxFit.cover),
                                                                      borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Varun Mohan Chempankulam",
                                                                        style:
                                                                        f15wB,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(14.0),
                                                              child: Container(
                                                                height: 50,
                                                                width:
                                                                MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xFF23252E),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        8)),
                                                                child: Center(
                                                                  child: TextField(
                                                                    // controller: _loc,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                    decoration: InputDecoration(
                                                                        border:
                                                                        InputBorder
                                                                            .none,
                                                                        hintText:
                                                                        "    Write a Message....",
                                                                        hintStyle:
                                                                        f14g),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10.0),
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Container(
                                                                    height: 35.0,
                                                                    width: 35.0,
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image: CachedNetworkImageProvider(
                                                                              "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                              errorListener: () =>
                                                                              new Icon(Icons.error),
                                                                            ),
                                                                            fit: BoxFit.cover),
                                                                        borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    "Add to your Timeline",
                                                                    style: f14b,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                bottom: 10.0,
                                                              ),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Share.share(
                                                                      'check out my website https://protocoderspoint.com/');
                                                                },
                                                                child: Container(
                                                                  height: 35,
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
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
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                              child: Container(
                                                                height: 43,
                                                                width:
                                                                MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xFF23252E),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        8)),
                                                                child: TextField(
                                                                  // controller: _loc,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                  decoration:
                                                                  InputDecoration(
                                                                      prefixIcon:
                                                                      Icon(
                                                                        Icons
                                                                            .search,
                                                                        color: Colors
                                                                            .white54,
                                                                        size:
                                                                        20,
                                                                      ),
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                      "Search",
                                                                      hintStyle:
                                                                      f14g),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 15,
                                                                  bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                        35.0,
                                                                        width: 35.0,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.green,
                                                                            image: DecorationImage(
                                                                                image: CachedNetworkImageProvider(
                                                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                                  errorListener: () => new Icon(Icons.error),
                                                                                ),
                                                                                fit: BoxFit.cover),
                                                                            borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14w,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                            5,
                                                                          ),
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14g,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFF48c0d9),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                        35.0,
                                                                        width: 35.0,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.green,
                                                                            image: DecorationImage(
                                                                                image: CachedNetworkImageProvider(
                                                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                                  errorListener: () => new Icon(Icons.error),
                                                                                ),
                                                                                fit: BoxFit.cover),
                                                                            borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14w,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                            5,
                                                                          ),
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14g,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFF48c0d9),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                        35.0,
                                                                        width: 35.0,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.green,
                                                                            image: DecorationImage(
                                                                                image: CachedNetworkImageProvider(
                                                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                                  errorListener: () => new Icon(Icons.error),
                                                                                ),
                                                                                fit: BoxFit.cover),
                                                                            borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14w,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                            5,
                                                                          ),
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14g,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFF48c0d9),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                        35.0,
                                                                        width: 35.0,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.green,
                                                                            image: DecorationImage(
                                                                                image: CachedNetworkImageProvider(
                                                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                                  errorListener: () => new Icon(Icons.error),
                                                                                ),
                                                                                fit: BoxFit.cover),
                                                                            borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14w,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                            5,
                                                                          ),
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14g,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFF48c0d9),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                        35.0,
                                                                        width: 35.0,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.green,
                                                                            image: DecorationImage(
                                                                                image: CachedNetworkImageProvider(
                                                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                                  errorListener: () => new Icon(Icons.error),
                                                                                ),
                                                                                fit: BoxFit.cover),
                                                                            borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14w,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                            5,
                                                                          ),
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14g,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFF48c0d9),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                        35.0,
                                                                        width: 35.0,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.green,
                                                                            image: DecorationImage(
                                                                                image: CachedNetworkImageProvider(
                                                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                                  errorListener: () => new Icon(Icons.error),
                                                                                ),
                                                                                fit: BoxFit.cover),
                                                                            borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14w,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                            5,
                                                                          ),
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14g,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFF48c0d9),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                        35.0,
                                                                        width: 35.0,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.green,
                                                                            image: DecorationImage(
                                                                                image: CachedNetworkImageProvider(
                                                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                                  errorListener: () => new Icon(Icons.error),
                                                                                ),
                                                                                fit: BoxFit.cover),
                                                                            borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14w,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                            5,
                                                                          ),
                                                                          Text(
                                                                            "aishwaraya_madhav",
                                                                            style:
                                                                            f14g,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFF48c0d9),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
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
                                                    );
                                                  }),
                                                );
                                              });
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
                                            Text("Share", style: f14w),
                                          ],
                                        ),
                                      ),
                                      _con.AccountWallVideos[0]["save_status"] == true ? GestureDetector(
                                        onTap: () {
                                          setState(() { postid = _con.AccountWallVideos[0]["id"].toString();});
                                          _con.saveTimelinePost(postid.toString(),userid.toString());
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.bookmark,
                                              color: Color(0xFF48c0d8),
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Saved",
                                              style: f14w,
                                            ),
                                          ],
                                        ),
                                      ) : GestureDetector(
                                        onTap: () {
                                          setState(() { postid = _con.AccountWallVideos[0]["id"].toString();});
                                          _con.saveTimelinePost(postid.toString(),userid.toString());
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.bookmark_border,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Save",
                                              style: f14w,
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
                      )),
                ),
                Divider(
                  color: Colors.black87,
                  thickness: 1,
                ),
                Container(
                  height: 900,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _con.AccountWallVideos.length,
                      itemBuilder: (BuildContext context, int index) {

                        imgHtp = httpsObj+_con.AccountWallVideos[index]["youtube_video_id"].toString()+thirdHttp;
                        List<String> playlist2 = <String>[
                          "https://www.youtube.com/watch?v="+_con.AccountWallVideos[index]["youtube_video_id"].toString()
                        ];
                        _date = DateTime.parse(
                            _con.AccountWallVideos[index]['created_at']['date']);
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
                            : c==0 ? d = DateTime
                            .now()
                            .difference(_date)
                            .inMinutes
                            .toString() +
                            " mints ago" : d = DateTime
                            .now()
                            .difference(_date)
                            .inHours
                            .toString() +
                            " hrs ago";

                        return index!=0 ?  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoDetailPage(

                                              indexPass: index,Name:_con.AccountWallVideos[index]["name"].toString(),videoId:_con.AccountWallVideos[index]["youtube_video_id"].toString(),videoTitle: _con.AccountWallVideos[index]["youtube_title"].toString(),description:_con.AccountWallVideos[index]["description"].toString(),LikesCount:_con.AccountWallVideos[index]["likes_count"],ShareCount: _con.AccountWallVideos[index]["share_count"].toString(),CommentsCount:_con.AccountWallVideos[index]["comments_count"].toString(),usrId: _con.AccountWallVideos[0]['user_id'].toString(),)));
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 15.0,
                                    bottom: 15.0,
                                    left: 5.0,
                                    right: 5.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 105,
                                            width: 146,
                                            decoration: BoxDecoration(
                                              //color: Color(0xFF48c0d8),
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                            ),
                                            child:Image.network(
                                              imgHtp,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  _con.AccountWallVideos[index]["youtube_title"].length>20?Text(
                                                    // "Mumbai Street Foods | \nBest Indian Street Food",
                                                    _con.AccountWallVideos[index]["youtube_title"].substring(0,20)+"...",
                                                    style: f14wB,
                                                    textAlign: TextAlign.start,
                                                  ):Text(_con.AccountWallVideos[index]["youtube_title"], style: f14wB,
                                                      textAlign: TextAlign.start),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  _con.AccountWallVideos[index]["description"].length>0?Text(
                                                    _con.AccountWallVideos[index]["description"],
                                                    style: f13w,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    softWrap: false,
                                                  ):Text("Foodi Foods", style: f13w),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "1k Views | ",
                                                        style: f13y,
                                                        textAlign: TextAlign.start,
                                                      ),
                                                      Text(
                                                        d.toString(),
                                                        style: f13y,
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 0.0),
                                        child: Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            Divider(
                              color: Colors.black87,
                              thickness: 1,
                            ),
                          ],
                        ) : Container(height: 0,);
                      }),
                )
              ],
            ) :_con.statusVideo == false ? Center(child: Padding(
              padding: const EdgeInsets.only(top:100.0),
              child: Text("No Videos",style: f16wB,),
            )):Container(height: 0,),
          ],
        ),
      ),
    );
  }
}
