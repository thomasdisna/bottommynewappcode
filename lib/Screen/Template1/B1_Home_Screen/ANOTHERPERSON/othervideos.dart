import 'dart:async';

import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_video_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/ANOTHERPERSON/wall_web_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/thumb_vide0_widget.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/video_widget.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/video_list_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';

import '../edit_post.dart';
import '../hashtag_search_page.dart';
var textSpan;
var httpsObj = "https://img.youtube.com/vi/";
var thirdHttp = "/0.jpg";
var imgHtp;
var s = "unlike";
var b = "unmark";
bool video;
DateTime _date;
var d;
var sharePost;
List<String> playlist;
var namePass,youtubeIdPass,titlePass,DescPass,LikePass,CommentPass,SharePass;

class OtherAccountVideos extends StatefulWidget {

  OtherAccountVideos({Key key,this.id,this.followstatus,this.memerdate,this.videoContro,this.timid}) : super(key: key);
  String id,timid;
  bool followstatus;
  String memerdate;
  ScrollController videoContro;
  @override
  _OtherAccountVideosState createState() => _OtherAccountVideosState();
}

class _OtherAccountVideosState extends StateMVC<OtherAccountVideos> {
  TimelineWallController _con;

  _OtherAccountVideosState() : super(TimelineWallController()) {
    _con = controller;
  }
  List<bool> _showutube = List.filled(1000, false);

  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  Future<void> _shareText() async {
    try {
      /*Share.text('Share Foodiz Post',
          sharePost, 'text/plain');*/
    } catch (e) {
     // print('error: $e');
    }
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  List<bool> _likes = List.filled(100,false);
  List<bool> _save = List.filled(100,false);

  _postUpdate() async{
    Timer(Duration(seconds: 2),(){
      _con. getAccountWallVideos(widget.timid.toString(),"video",userid.toString());
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
      _con. getAccountWallVideos(widget.timid.toString(),"video",userid.toString());
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    setState(() {textSpan = false;});
    _con. getAccountWallVideos(widget.timid.toString(),"video",userid.toString());
    super.initState();
    if(_con.AccountWallVideos.length>0){
      _con.AccountWallVideos[0]['like_status'] == true ? _likes[0]=true : _likes[0] = false;
      _con.AccountWallVideos[0]['save_status'] == true ? _save[0]=true : _save[0] = false;
    }

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
              ? TextSpan(text: text, style: TextStyle(fontSize: 14,color: Colors.blueAccent),)
              : TextSpan(text: text,style: f14w))
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
        children: [TextSpan(text: split.first,children: [
          TextSpan(recognizer: TapGestureRecognizer()..onTap=(){
            setState(() {
              textSpan=false;
            });
          },
              text: " Read less",
              style:f14b
          )
        ])]
          ..addAll(namespace
              .map((text) =>
          text.contains("@")
              ? TextSpan(text: text, style: TextStyle(fontSize: 14,color: Colors.blueAccent),)
              : TextSpan(text: text,style: f14w))
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
        children: [TextSpan(text: split.first.substring(0,130,)+" ...",children: [TextSpan(recognizer: TapGestureRecognizer()..onTap=(){
          setState(() {
            textSpan=true;
          });
        },
            text: " Read more",
            style:f14b
        )])]
          ..addAll(namespace
              .map((text) =>
          text.contains("@")
              ? TextSpan(text: text, style: TextStyle(fontSize: 14,color: Colors.blueAccent))
              : TextSpan(text: text,style: f14w
          ),
          )
              .toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _con.getFollowing(userid);
    if(_con.AccountWallVideos.length>0){
      playlist = <String>[
        "https://www.youtube.com/watch?v="+_con.AccountWallVideos[0]["youtube_video_id"].toString()
      ];
    }
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropMaterialHeader(color: Colors.black,backgroundColor: Color(0xFF0dc89e),),
        onRefresh: _getData,
        controller: _refreshController,
        onLoading: _onLoading,
        child: SingleChildScrollView(controller: widget.videoContro,
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
                                            .toString(),tim_id: widget.timid.toString(),)
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
                                                                                        selectedId = index;
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
      ),
    );
  }
}
