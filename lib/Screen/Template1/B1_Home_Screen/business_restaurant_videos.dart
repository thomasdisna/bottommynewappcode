import 'package:cached_network_image/cached_network_image.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/video_list_detail_page.dart';
bool video;
var s = "unlike";
var b = "unmark";
class BusinessRestaurantVideos extends StatefulWidget {
  BusinessRestaurantVideos({this.controo});
  ScrollController controo;
  @override
  _BusinessRestaurantVideosState createState() => _BusinessRestaurantVideosState();
}

class _BusinessRestaurantVideosState extends State<BusinessRestaurantVideos> {



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
    // TODO: implement initState
    super.initState();
    video=false;
    _videoPlayerController1 = VideoPlayerController.network(
        'https://saasinfomedia.com/foodiz/public/video/videoplayback.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
     autoInitialize: true,
      looping: true,
//      startAt: Duration(seconds: 10),
      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Color(0xFFffd55e),
        handleColor: Color(0xFF48c0d8),
        backgroundColor: Color(0xFF1E2026),
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Color(0xFF23252E),
      ),
      // autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        controller: widget.controo,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: video == false
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    video = true;
                  });
                },
                child: Container(
                  child: Image.asset(
                    "assets/Template1/image/Foodie/youtube.png",
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
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
                  Text(
                    "Nadan kerala parotta and beef preparation videos \nat home",
                    style: f14wB,
                  ),
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
                                child: Text(
                                  "150 Likes",
                                  style: f14y,
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                "500 Comments",
                                style: f14y,
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                "25 Shares",
                                style: f14y,
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (s == "unlike") {
                                          s = "like";
                                        } else {
                                          s = "unlike";
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        s == "unlike"
                                            ? Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                            : Icon(
                                          Icons.favorite,
                                          color: Color(0xFFffd55e),
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        s == "unlike"
                                            ? Text(
                                          "Like",
                                          style: f14w,
                                        )
                                            : Text(
                                          "Liked",
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
                                                  StateSetter state) {
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
                                                                  /*SizedBox(
                                                                  height:
                                                                      3,
                                                                ),
                                                                Text(
                                                                    "Changanassery,Kottayam",
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 12)),*/
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (b == "unmark") {
                                          b = "mark";
                                        } else {
                                          b = "unmark";
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        b == "unmark"
                                            ? Icon(
                                          Icons.bookmark_border,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                            : Icon(
                                          Icons.bookmark,
                                          color: Color(0xFF48c0d8),
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Save", style: f14w),
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
              height: 800,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoDetailPage(Name: "Arya Bhavan",)));
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
                                                  color: Color(0xFF48c0d8),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 5.0,
                                                      spreadRadius: 0.0)
                                                ]),
                                            child: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 35,
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
                                                  Text(
                                                    "Mumbai Street Foods | \nBest Indian Street Food",
                                                    style: f14wB,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Mumbai Street Food,this \nvideo is the best street...",
                                                    style: f13w,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    softWrap: false,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "#StreetFood #mumbai #t...",
                                                    style: f14wB,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "1k Views |  4Days Ago",
                                                    style: f13y,
                                                    textAlign: TextAlign.start,
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
                        ),
                        onTap: () {
                          setState(() {
                            // selectedIndex = index;
                          });
                        });
                  }),
            )
          ],
        ),
      ),

    );
  }
}
