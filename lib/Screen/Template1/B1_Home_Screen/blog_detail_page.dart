import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/ANOTHERPERSON/wall_web_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_market_item_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/hashtag_search_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/share_post_page.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
var s = "unlike";

class BlogDetailPage extends StatefulWidget {

  BlogDetailPage({this.title,this.imageList,this.desc,this.blogList,this.comments,
  this.date,this.id,this.likes,this.likeStatus,this.saveStatus,this.shares,this.views,this.video_id,this.video_title});

  String id,title,date,views,comments,shares,desc,video_id,video_title;
  bool likeStatus,saveStatus;
  List imageList,blogList;
  int likes;

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends StateMVC<BlogDetailPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.updateViewCountOfPost(widget.id);
  }

  TimelineWallController _con;

  _BlogDetailPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  var d;
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    _date = DateTime.parse(widget.date);
    var c =
        DateTime
            .now()
            .difference(_date)
            .inHours;
    // d =DateFormat('dd/MM/yyyy').format(_date);
    c > 24 && c <= 48
        ? d = "1 Day Ago" : c > 48 ?
    d = DateFormat.yMMMd().format(_date)
        : c == 0
        ? d = DateTime
        .now()
        .difference(_date)
        .inMinutes
        .toString() +
        " Mints Ago"
        : d = DateTime
        .now()
        .difference(_date)
        .inHours
        .toString() +
        " Hrs Ago";
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        elevation: 5,
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0,bottom: 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: widget.imageList
                          .length >
                          0 && widget.imageList
                          .length == 1
                          ? Container(
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                            imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                widget.imageList
                                [0]['source']
                                    .toString()
                                    .replaceAll(" ", "%20") +
                                "?alt=media",
                            fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                        ),
                      ) : widget.imageList
                          .length >
                          0 && widget.imageList.length > 1 ?
                      Container(
                          height: 350.0,
                          child: new Carousel(
                            boxFit: BoxFit.fill,
                            dotColor: Colors.black,
                            dotSize: 5.5,
                            autoplay: false,
                            dotSpacing: 16.0,
                            dotIncreasedColor: Color(
                                0xFF48c0d8),
                            dotBgColor: Colors.transparent,
                            showIndicator: true,
                            overlayShadow: true,
                            overlayShadowColors: Colors.white
                                .withOpacity(0.2),
                            overlayShadowSize: 0.9,
                            images: widget.imageList.map((item) {
                              return new CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                    item['source']
                                        .toString()
                                        .replaceAll(" ", "%20")+"?alt=media",
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );

                            }).toList(),
                          )) : widget.imageList
          .length==0 && widget.video_id.length!=11 && widget.video_id!=null ?
                      VimeoPlayer(id: widget.video_id.toString()
                          .replaceAll("/videos/", ""),autoPlay: false,looping: true,) : Container(
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Posted "+d.toString(),style: f14w,),
                        Row(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/eye.png",height: 17,width: 17,),
                            SizedBox(width: 4,),
                            Text(widget.views+" Views",style: f14b,)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              postid = widget.id;
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
                              widget.likes
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
                              postid = widget.id;
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
                            /* _con.getTimelineWall(
                            userid
                                .toString());*/
                          },
                          child: Text(
                              widget.comments
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
                              postid = widget.id;
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
                              widget.shares
                                  .toString() +
                                  " Shares",
                              style: f14y),
                        )
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        widget.likeStatus ==
                            true
                            ? GestureDetector(
                          onTap: () {

                            setState(() {
                              widget.likeStatus = false;
                              widget.likes =  widget.likes-1;
                              postid=widget.id;});
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

                            setState(() {
                              widget.likeStatus = true;
                              widget.likes =  widget.likes+1;
                              postid=widget.id;});
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
                            setState(() { postid= widget.id;});
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
                            setState(() {
                              postid= widget.id;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        context) =>
                                        SharePost(
                                            postid: postid
                                                .toString(),
                                            sharepost: "https://saasinfomedia.com/foodiz/public/sharepost/"+widget.id)));
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
                        widget.saveStatus ==
                            true
                            ? GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.saveStatus =
                              false;
                              postid = widget.id;
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
                              widget.saveStatus =
                              true;
                              postid = widget.id;
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
                    SizedBox(height: 15,),
                    Text(
                      widget.title,
                      style: f21wB,
                    ),
                    SizedBox(height: 8,),
                    Text(widget.desc,style: f15w,),
                    SizedBox(height: 15,),
                    Container(
                      height: 240,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[400],
                      child: Center(child: Text("Ad Space",style: f18wB,)),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),

              widget.video_id!=null  &&  widget.video_id.length==11 ?  Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>WebViewContainer(
                          url: "https://www.youtube.com/watch?v="+widget.video_id.toString(),)
                    ));
                  },
                  child: Stack(alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                          imageUrl: "https://img.youtube.com/vi/" +
                              widget.video_id.toString()+
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
              ) :
              widget.imageList
                  .length==0 &&  widget.video_id!=null  && widget.video_id.length!=11 ?  VimeoPlayer(id: widget.video_id.toString()
              .replaceAll("/videos/", ""),autoPlay: false,looping: true,) : widget.imageList
                  .length>0 &&  widget.video_id!=null  && widget.video_id.length!=11 ?  VimeoPlayer(id: widget.video_id.toString()
                  .replaceAll("/videos/", ""),autoPlay: false,looping: true,) :
              Container(),
              widget.video_id!=null &&  widget.video_id.length==11 ? Padding(
                padding: const EdgeInsets.only(left:20,right: 20,),
                child: Text(widget.video_title.toString(),style: f14w,),
              ) : Container(),
              SizedBox(height: 20,),
              widget.blogList.length >= 2 ? Text("Related Blogs",style: f15wB,) : Container(),
              widget.blogList.length >= 2 ?   SizedBox(height: 10,) : Container(),
              widget.blogList.length >= 2 ?    Container(height: 150,
                alignment: Alignment.center,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.blogList.length,
                    itemBuilder:(context,index){
                      return widget.id!=widget.blogList[index]["id"].toString() ?
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3, top: 3),
                        child: InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context)=>BlogDetailPage(
                                  video_id: widget.blogList[index]["youtube_video_id"],
                                  video_title: widget.blogList[index]["youtube_title"],
                                  id: widget.blogList[index]["id"].toString(),
                                  blogList: widget.blogList,
                                  imageList: widget.blogList[index]["post_images"],
                                  title: widget.blogList[index]["post_title"],
                                  desc: widget.blogList[index]['description'],
                                  date: widget.blogList[index]['created_at']['date'].toString(),
                                  views: "1.3k",
                                  comments: widget.blogList[index]["comments_count"].toString(),
                                  likes: widget.blogList[index]["likes_count"],
                                  shares: widget.blogList[index]["share_count"].toString(),
                                  saveStatus: widget.blogList[index]["save_status"],
                                  likeStatus: widget.blogList[index]["like_status"],
                                  // comments: ,
                                )
                            ));
                          },
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width-95,
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width-205,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.blogList[index]["post_title"],
                                            style: f16wB,maxLines: 2,overflow: TextOverflow.ellipsis
                                          ),
                                          Text(widget.blogList[index]
                                          ['description'],style: f13w,overflow: TextOverflow.ellipsis,maxLines: 3,),


                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Posted "+d.toString(),style: f10w,),
                                              Row(
                                                children: [
                                                  Image.asset("assets/Template1/image/Foodie/icons/eye.png",height: 13,width: 13,),
                                                  SizedBox(width: 2,),
                                                  Text("1.3K Views",style: f10b,)
                                                ],
                                              )
                                            ],
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(right:4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      postid = widget.blogList[
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
                                                      widget.blogList[
                                                      index]
                                                      [
                                                      'likes_count']
                                                          .toString() +
                                                          " Likes",
                                                      style: f10Y),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      postid = widget.blogList[
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
                                                      widget.blogList[
                                                      index]
                                                      [
                                                      'comments_count']
                                                          .toString() +
                                                          " Comments",
                                                      style: f10Y),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      postid = widget.blogList[
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
                                                      widget.blogList[
                                                      index]
                                                      [
                                                      'share_count']
                                                          .toString() +
                                                          " Shares",
                                                      style: f10Y),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    widget.blogList[index]
                                    ['post_images']
                                        .length >
                                        0 ? Container(clipBehavior: Clip.antiAlias,
                                      width: 105,
                                      height: 132,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2)
                                      ),
                                      child: CachedNetworkImage(
                                          imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                              widget.blogList[
                                              index][
                                              "post_images"]
                                              [0]['source']
                                                  .toString()
                                                  .replaceAll(" ", "%20") +
                                              "?alt=media",
                                          fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                      ),
                                    ) : Container(height: 0,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ) : Container(height: 0,);
                    } ),
              ) : Container(),
              widget.blogList.length >= 2 ?    SizedBox(height: 20,) : Container(),

            ],
          ),
        ),
      ),
    );
  }
}
