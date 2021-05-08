import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/ANOTHERPERSON/wall_web_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/video_widget.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/edit_post.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/hashtag_search_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/photos_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/share_post_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'Fire_Contro/utils.dart';
import 'chatroom.dart';
var textSpan;
var pic_url;
var dataUser;
var UserIdprefs;
var timedata;
DateTime _date;
var d;
var statusflag = 0;
var e;
DateTime _date2;
var d2;
var sharePost;
var postImage;
var postDesc;

class ChatLinkDetailPage extends StatefulWidget {
  String post_id;
  ChatLinkDetailPage({this.post_id});
  @override
  _ChatLinkDetailPageState createState() => _ChatLinkDetailPageState();
}

class _ChatLinkDetailPageState extends StateMVC<ChatLinkDetailPage> {
  TimelineWallController _con;
  VideoPlayerController _Videocontroller;

  _ChatLinkDetailPageState() : super(TimelineWallController()) {
    _con = controller;
  }
  List<bool> _showutube = List.filled(1000, false);
  List<bool> _showSharedutube = List.filled(1000, false);

  List<bool> _likes1 = List.filled(100,false);
  List<bool> _save1 = List.filled(100,false);
  List<bool> _showml1 = List.filled(1000, false);
  List<bool> _sharedshowml1 = List.filled(1000, false);
  TextEditingController _sharee = TextEditingController();
  SlidingUpPanelController panelController = SlidingUpPanelController();
  ScrollController scrollController;

  _postUpdate() async{
    Timer(Duration(seconds: 2),(){
      _con.gettimelineparticularpost(widget.post_id);
    });
  }

  @override
  void initState() {
    _con.gettimelineparticularpost(widget.post_id);
    _con.getFollowing(userid);
    setState(() {});
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
    super.initState();
  }

  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post',
          sharePost, 'text/plain');
    } catch (e) {
      //print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _con.getFollowing(userid);
    return Scaffold(
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
      backgroundColor: Color(0xFF1E2026),
      body: Column(
        children: [
          Center(
            child: Visibility(
                visible: _con.statusParticularPost,
                child: Padding(
                  padding: const EdgeInsets.only(top:250.0),
                  child: CircularProgressIndicator(),
                )
            ),
          ),
          _con.ParticularPost.length > 0 && _con.statusParticularPost == false? Expanded(
            child: InViewNotifierList(
              initialInViewIds: ['0'],
              isInViewPortCondition: (double deltaTop,
                  double deltaBottom,
                  double viewPortDimension) {
                return deltaTop < (0.5 * viewPortDimension) &&
                    deltaBottom > (0.5 * viewPortDimension);
              },
              itemCount: _con.ParticularPost.length,
              physics: const AlwaysScrollableScrollPhysics(),
              builder: (BuildContext context, int index) {
                _con.ParticularPost[index]
                [
                "youtube_video_id"]
                    .toString()
                    .length != 11 &&
                    _con.ParticularPost[
                    index][
                    "youtube_video_id"] !=
                        null
                    ?
                _Videocontroller = VideoPlayerController.network(
                    "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                        _con
                            .ParticularPost[index]['youtube_video_id']
                            .toString()
                            .replaceAll(" ", "%20") + "?alt=media")
                    : null;
                _con.ParticularPost[index]['like_status'] == true ?
                _likes1[index] = true : _likes1[index] = false;
                _con.ParticularPost[index]['save_status'] == true ?
                _save1[index] = true : _save1[index] = false;
                _date = DateTime.parse(
                    _con.ParticularPost[index]['created_at']
                    ['date']);
                _con.ParticularPost[index]["shared_post_id"] != null
                    ? _date2 = DateTime.parse(
                    _con
                        .ParticularPost[index]["shared_post_details"]['created_at']
                    ['date'])
                    : null;
                final List<String> playlist = <String>[
                  'https://www.youtube.com/watch?v=' +
                      _con.ParticularPost[index]
                      ['youtube_video_id']
                          .toString()
                ];
                var c =
                    DateTime
                        .now()
                        .difference(_date)
                        .inHours;
                _con.ParticularPost[index]["shared_post_id"] != null
                    ? e =
                    DateTime

                        .now()
                        .difference(_date2)
                        .inHours
                    : null;
                c > 24 && c<=48
                    ? d="Yesterday" : c > 48?  d =DateFormat.MMMd().format(_date)
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
                final List<String> playlist2 = _con
                    .ParticularPost[index]["shared_post_id"] != null
                    ? <String>[
                  'https://www.youtube.com/watch?v=' +
                      _con
                          .ParticularPost[index]["shared_post_details"]
                      ['youtube_video_id']
                          .toString()
                ]
                    : <String>[];
                _con.ParticularPost[index]["shared_post_id"] != null
                    ? e > 24 && e<=48
                    ? d2="Yesterday" : e > 48?  d2 =DateFormat.MMMd().format(_date2)
                    :  e == 0
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

                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: Color(
                                                          0xFF1E2026),
                                                      content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                        imageUrl: _con
                                                            .ParticularPost[index]["picture"]
                                                            .toString()
                                                            .replaceAll(
                                                            " ",
                                                            "%20") +
                                                            "?alt=media",
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
                                                        .ParticularPost[index]["picture"] !=
                                                        null
                                                        ? CachedNetworkImageProvider(
                                                      _con
                                                          .ParticularPost[index]["picture"]
                                                          .toString()
                                                          .replaceAll(
                                                          " ",
                                                          "%20") +
                                                          "?alt=media",)
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
                                                                .ParticularPost[index]['user_id']
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
                                                      .ParticularPost[
                                                  index]
                                                  ['name']
                                                      .toString(),
                                                  style: f15wB,
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        d.toString(),
                                                        style: f10g),
                                                    _con
                                                        .ParticularPost[index]
                                                    ['post_location'] !=
                                                        null &&
                                                        _con
                                                            .ParticularPost[
                                                        index]
                                                        ['post_location']
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
                                                          userid.toString() == _con.ParticularPost[index]['user_id'].toString() && _con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString().length>=45 && (_con.ParticularPost[index]["post_type"].toString()
                                                              =="page" || _con.ParticularPost[index]["post_type"].toString()
                                                              =="user")
                                                              ?   " - In " + _con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString().substring(0,45)+"..." :
                                                          userid.toString() == _con.ParticularPost[index]['user_id'].toString() && _con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString().length<40 && (_con.ParticularPost[index]["post_type"].toString()
                                                              =="page" || _con.ParticularPost[index]["post_type"].toString()
                                                              =="user")
                                                              ?   " - In " + _con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString() :  _con.ParticularPost[index]["post_type"].toString()
                                                              =="page" && _con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString().length>=21 && userid.toString() != _con.ParticularPost[index]['user_id'].toString()
                                                              ? " - In " + _con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString().substring(0,21)+"..." :
                                                          _con.ParticularPost[index]["post_type"].toString()
                                                              =="page" && _con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString().length<21 && userid.toString() != _con.ParticularPost[index]['user_id'].toString() ?" - In " +
                                                              _con
                                                                  .ParticularPost[index]
                                                              ['post_location']
                                                                  .toString() :
                                                          _con.ParticularPost[index]["post_type"].toString()
                                                              =="user" && _con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString().length>=33 && userid.toString() != _con.ParticularPost[index]['user_id'].toString() ?
                                                          " - In "+_con
                                                              .ParticularPost[index]
                                                          ['post_location']
                                                              .toString().substring(0,33)+"..." : " - In "+_con
                                                              .ParticularPost[index]
                                                          ['post_location']
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
                                        userid !=
                                            _con.ParticularPost[
                                            index][
                                            "user_id"]
                                                .toString()
                                            ? GestureDetector(
                                            onTap: () {
                                              try {
                                                String chatID = makeChatId(userid.toString(), _con
                                                    .ParticularPost[
                                                index]
                                                [
                                                'user_id']
                                                    .toString());
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ChatRoom(
                                                            userid,
                                                            NAME,
                                                            _con
                                                                .ParticularPost[
                                                            index]
                                                            [
                                                            'device_token']
                                                                .toString(),
                                                            _con
                                                                .ParticularPost[
                                                            index]
                                                            [
                                                            'user_id']
                                                                .toString(),
                                                            chatID,
                                                            _con
                                                                .ParticularPost[
                                                            index]
                                                            [
                                                            'username']
                                                                .toString(), _con
                                                            .ParticularPost[
                                                        index]
                                                        [
                                                        'name']
                                                            .toString(),
                                                            _con
                                                                .ParticularPost[
                                                            index]
                                                            [
                                                            'picture']
                                                                .toString()
                                                                .replaceAll(
                                                                " ", "%20") +
                                                                "?alt=media","")));
                                              } catch (e) {
                                                print(e.message);
                                              }
                                              /*createChatroomAndStartConversation(
                                                            cusUserNAME: _con
                                                                .ParticularPost[
                                                            index]
                                                            [
                                                            'username']
                                                                .toString(),
                                                            CusImage: _con
                                                                .ParticularPost[
                                                            index]
                                                            [
                                                            'picture']
                                                                .toString()
                                                                .replaceAll(
                                                                " ", "%20") +
                                                                "?alt=media",
                                                            cusNAME: _con
                                                                .ParticularPost[
                                                            index]
                                                            ['name']
                                                                .toString());*/
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
                                                              userid.toString() == _con.ParticularPost[index]
                                                              ["user_id"].toString() &&
                                                                  _con.ParticularPost[index]["post_type"].toString() == "user"
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
                                                                                      .ParticularPost[index]['description']
                                                                                      .toString(),
                                                                                  postid: _con
                                                                                      .ParticularPost[index]["id"]
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
                                                              userid.toString() == _con.ParticularPost[index]['user_id'].toString() &&
                                                                  _con.ParticularPost[index]["post_type"].toString() == "user"
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
                                                                                          .ParticularPost[index]['id']
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
                                                                              .ParticularPost[index]["id"]
                                                                              .toString();
                                                                      if(_con.ParticularPost[index]['save_status'] ==
                                                                          true)
                                                                      {
                                                                        _con.ParticularPost[index]['save_status'] = false;
                                                                        _con.ParticularPost[index]['save_status']=false;
                                                                      }
                                                                      else
                                                                      {
                                                                        _con.ParticularPost[index]['save_status'] = true;
                                                                        _con.ParticularPost[index]['save_status']=true;
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
                                                                              _con.ParticularPost[index]['save_status']? "Saved Post" : "Save Post",
                                                                              style: f15wB,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 3,
                                                                            ),
                                                                            Text(_con.ParticularPost[index]['save_status']? "Added this to your saved post" :
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
                                                              userid.toString() != _con.ParticularPost[index]['user_id'].toString()
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
                                                                            .ParticularPost[index]['id']);

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
                                                              userid.toString() != _con.ParticularPost[index]['user_id'].toString()
                                                                  ? Padding(
                                                                padding: const EdgeInsets
                                                                    .all(
                                                                    6.0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    _con.ParticularPost[index]["follow_status"] ?
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (
                                                                            BuildContext context) {
                                                                          return AlertDialog(
                                                                            backgroundColor: Color(
                                                                                0xFF1E2026),
                                                                            content: new Text(
                                                                              "Do you want to Unfollow "+_con.ParticularPost[index]['name'].toString()+" ?",
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
                                                                                      .ParticularPost[index]["follow_status"] = false;});
                                                                                  _con
                                                                                      .followerController(
                                                                                      userid
                                                                                          .toString(),
                                                                                      _con
                                                                                          .ParticularPost[index]['user_id']
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
                                                                            .ParticularPost[index]['user_id']
                                                                            .toString());
                                                                    if(_con
                                                                        .ParticularPost[index]["follow_status"] ==
                                                                        false){
                                                                      setState(() { _con
                                                                          .ParticularPost[index]["follow_status"] = true;});
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
                                                                                .ParticularPost[index]["follow_status"] ==
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
                                                                                .ParticularPost[index]["follow_status"] ==
                                                                                true
                                                                                ? Text(
                                                                              "Unfollow  " +
                                                                                  _con
                                                                                      .ParticularPost[index]["name"],
                                                                              style: f13w,
                                                                            )
                                                                                : Text(
                                                                              "Follow  " +
                                                                                  _con
                                                                                      .ParticularPost[index]["name"],
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
                                                                              .ParticularPost[index]['id']
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
                                                                              .ParticularPost[index]['id']
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

                            _con.ParticularPost[index]
                            ['description'] !=
                                "" && _con.ParticularPost[index]
                            ['description'] != null ? Padding(
                              padding: const EdgeInsets.only(left:8,right: 8),
                              child: _con.ParticularPost[index]
                              ['description'].length > 130 && /*textSpan==false &&*/ _showml1[index]==false ?
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmartText(
                                    text:
                                    _con
                                        .ParticularPost[index]['description'].substring(0, 129,) + " ...",
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
                                    // onUserTagClick: (tag) {
                                    //    _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                                    // },
                                  ),
                                  SizedBox(height: 3,),
                                  GestureDetector(
                                      onTap: (){
                                        setState(() {textSpan=true;
                                        _showml1[index]=true;});
                                      },
                                      child: Text("Show more...",style: f14p,)),
                                  SizedBox(height: 2,),
                                ],
                              ) : _con.ParticularPost[index]
                              ['description'].length > 130/* &&
                          textSpan == true*/ && _showml1[index]==true?
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmartText(
                                    text:
                                    _con
                                        .ParticularPost[index]['description'],
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
                                  SizedBox(height:3,),
                                  GestureDetector(
                                      onTap: (){
                                        setState(() {textSpan=false;
                                        _showml1[index]=false;});
                                      },
                                      child: Text("Show less...",style: f14p,)),
                                  SizedBox(height: 2,),
                                ],
                              ) : _con.ParticularPost[index]
                              ['description'].length <= 130 ?  SmartText(
                                text:
                                _con
                                    .ParticularPost[index]['description'],
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
                              ) : Container(),
                            )
                                : Container(),
                            _con
                                .ParticularPost[index]["shared_post_id"] !=
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
                                                                    .ParticularPost[index]["shared_post_details"]["user_id"]
                                                                    .toString(),
                                                              )));
                                                },
                                                child: Container(
                                                  height: 35.0,
                                                  width: 35.0,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: _con
                                                              .ParticularPost[index]["shared_post_details"]["picture"] !=
                                                              null
                                                              ? CachedNetworkImageProvider(
                                                              _con
                                                                  .ParticularPost[index]["shared_post_details"]["picture"]
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
                                                                      .ParticularPost[index]["shared_post_details"]['user_id']
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
                                                            .ParticularPost[index]["shared_post_details"]
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
                                      _con.ParticularPost[index]["shared_post_details"]
                                      ['description'] !=
                                          "" && _con.ParticularPost[index]["shared_post_details"]
                                      ['description'] != null ? Padding(
                                        padding: const EdgeInsets.only(left:8,right: 8),
                                        child: _con.ParticularPost[index]["shared_post_details"]
                                        ['description'].length > 130 && /*textSpan==false &&*/ _sharedshowml1[index]==false ?
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SmartText(
                                              text:
                                              _con
                                                  .ParticularPost[index]["shared_post_details"]['description'].substring(0, 129,) + " ...",
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
                                            SizedBox(height: 3,),
                                            GestureDetector(
                                                onTap: (){
                                                  setState(() {textSpan=true;
                                                  _sharedshowml1[index]=true;});
                                                },
                                                child: Text("Show more...",style: f14p,)),
                                            SizedBox(height: 2,),
                                          ],
                                        ) : _con.ParticularPost[index]["shared_post_details"]
                                        ['description'].length > 130/* &&
                          textSpan == true*/ && _sharedshowml1[index]==true?
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SmartText(
                                              text:
                                              _con
                                                  .ParticularPost[index]["shared_post_details"]['description'],
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
                                            SizedBox(height:3,),
                                            GestureDetector(
                                                onTap: (){
                                                  setState(() {textSpan=false;
                                                  _sharedshowml1[index]=false;});
                                                },
                                                child: Text("Show less...",style: f14p,)),
                                            SizedBox(height: 2,),
                                          ],
                                        ) : _con.ParticularPost[index]["shared_post_details"]
                                        ['description'].length <= 130 ?  SmartText(
                                          text:
                                          _con
                                              .ParticularPost[index]["shared_post_details"]['description'],
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
                                        ) : Container(),
                                      )
                                          : Container(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: _con.ParticularPost[
                                        index]["shared_post_details"]['url_image']!="" &&_con.ParticularPost[
                                        index]["shared_post_details"]['url_image']!=null ? GestureDetector(
                                          onTap:(){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=> WebViewContainer(url:_con.ParticularPost[
                                                index]["shared_post_details"]['url_link'] ,)
                                            ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              color:Colors.grey[800],
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  CachedNetworkImage(
                                                      imageUrl:
                                                      _con.ParticularPost[
                                                      index]["shared_post_details"][
                                                      "url_image"]
                                                          .toString(),
                                                      fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:5,bottom: 5,left: 8,right: 8),
                                                    child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
                                                      children: [
                                                        Text(_con.ParticularPost[
                                                        index]["shared_post_details"][
                                                        "url_site"]
                                                            .toString(),style: f14w,),
                                                        SizedBox(height: 4,),
                                                        Text( _con.ParticularPost[
                                                        index]["shared_post_details"][
                                                        "url_title"]
                                                            .toString(),style: f14w,),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ) : _con
                                            .ParticularPost[
                                        index]["shared_post_details"]
                                        ['post_images']
                                            .length >
                                            0 && _con
                                            .ParticularPost[
                                        index]["shared_post_details"]
                                        ['post_images']
                                            .length == 1
                                            ? GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => GalleryScreen(ImageList: _con.ParticularPost[index]
                                                ['post_images'],)
                                            ));
                                          },
                                              child: Container(
                                          height: 350,
                                          width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                                child: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                          imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                  _con.ParticularPost[
                                                  index]["shared_post_details"][
                                                  "post_images"]
                                                  [0]['source']
                                                      .toString()
                                                      .replaceAll(" ", "%20") +
                                                  "?alt=media",
                                          fit: BoxFit.cover,
                                        ),
                                              ),
                                            ) : _con
                                            .ParticularPost[
                                        index]["shared_post_details"]
                                        ['post_images']
                                            .length >
                                            0 && _con
                                            .ParticularPost[
                                        index]["shared_post_details"]
                                        ['post_images']
                                            .length > 1 ?
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => GalleryScreen(ImageList: _con.ParticularPost[index]["shared_post_details"]['post_images'],)
                                            ));
                                          },
                                          child: Container(
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
                                                images: _con
                                                    .ParticularPost[
                                                index]["shared_post_details"]
                                                ['post_images'].map((item) {
                                                  return new CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          item['source']
                                                              .toString()
                                                              .replaceAll(
                                                              " ", "%20") +
                                                          "?alt=media",
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
                                              )),
                                        )
                                            :
                                        _con.ParticularPost[
                                        index]["shared_post_details"][
                                        "youtube_video_id"]
                                            .toString()
                                            .length == 11 &&
                                            _con.ParticularPost[
                                            index]["shared_post_details"][
                                            "youtube_video_id"] !=
                                                null
                                            ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context)=>WebViewContainer(
                                                      url: 'https://www.youtube.com/watch?v=' +
                                                          _con.ParticularPost[index]["shared_post_details"]
                                                          ['youtube_video_id']
                                                              .toString(),)
                                                ));
                                              },
                                              child: Stack(alignment: Alignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                      imageUrl: "https://img.youtube.com/vi/" +
                                                          _con.ParticularPost[
                                                          index]["shared_post_details"][
                                                          "youtube_video_id"]
                                                              .toString() +
                                                          "/0.jpg",
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
                                            _con.ParticularPost[index]["shared_post_details"]
                                            ['youtube_title'].length > 130 && /*textSpan==false &&*/ _showSharedutube[index]==false ?
                                            Padding(
                                              padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SmartText(
                                                    text:
                                                    _con
                                                        .ParticularPost[index]["shared_post_details"]['youtube_title'].substring(0, 130,) + " ...",
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
                                                  SizedBox(height: 3,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        setState(() {textSpan=true;
                                                        _showSharedutube[index]=true;});
                                                      },
                                                      child: Text("Show more...",style: f14p,)),
                                                  SizedBox(height: 2,),
                                                ],
                                              ),
                                            ) : _con.ParticularPost[index]["shared_post_details"]
                                            ['youtube_title'].length > 130/* &&
                      textSpan == true*/ && _showSharedutube[index]==true?
                                            Padding(
                                              padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SmartText(
                                                    text:
                                                    _con
                                                        .ParticularPost[index]["shared_post_details"]['youtube_title'],
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
                                                  SizedBox(height:3,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        setState(() {textSpan=false;
                                                        _showSharedutube[index]=false;});
                                                      },
                                                      child: Text("Show less...",style: f14p,)),
                                                  SizedBox(height: 2,),
                                                ],
                                              ),
                                            ) : _con.ParticularPost[index]["shared_post_details"]
                                            ['youtube_title'].length <= 130 ?  Padding(
                                              padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                              child: SmartText(
                                                text:
                                                _con
                                                    .ParticularPost[index]["shared_post_details"]['youtube_title'],
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
                                            ) : Container(),
                                          ],
                                        ) : _con.ParticularPost[index]["shared_post_details"]
                                        [
                                        "youtube_video_id"]
                                            .toString()
                                            .length != 11 &&
                                            _con.ParticularPost[
                                            index]["shared_post_details"][
                                            "youtube_video_id"] !=
                                                null ?
                                        Container(
                                          alignment: Alignment.center,
                                          child: VideoWidget(
                                            url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                                _con
                                                    .ParticularPost[index]["shared_post_details"]['youtube_video_id']
                                                    .toString()
                                                    .replaceAll(
                                                    " ", "%20") +
                                                "?alt=media",
                                            play: true,),
                                          /*  child: Chewie(
                                            controller: ChewieController(
                                              videoPlayerController: VideoPlayerController.network(
                                                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/2020-10-15%2011:40:40.779801.mp4?alt=media"),
                                              aspectRatio: 3 / 2,allowFullScreen: false,
                                              // autoPlay: true,
                                              autoInitialize: true,
                                              looping: true,
                                            ),
                                          ),*/
                                        )

                                            : Container(
                                          height: 0,
                                        ),
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
                              child: _con.ParticularPost[
                              index]['url_image']!="" &&_con.ParticularPost[
                              index]['url_image']!=null ? GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> WebViewContainer(url:_con.ParticularPost[
                                      index]['url_link'] ,)
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    color:Colors.grey[800],
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl:
                                            _con.ParticularPost[
                                            index][
                                            "url_image"]
                                                .toString(),
                                            fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:5,bottom: 5,left: 8,right: 8),
                                          child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
                                            children: [
                                              Text(_con.ParticularPost[
                                              index][
                                              "url_site"]
                                                  .toString(),style: f14w,),
                                              SizedBox(height: 4,),
                                              Text( _con.ParticularPost[
                                              index][
                                              "url_title"]
                                                  .toString(),style: f14w,),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ) : _con
                                  .ParticularPost[
                              index]
                              ['post_images']
                                  .length >
                                  0 && _con
                                  .ParticularPost[
                              index]
                              ['post_images']
                                  .length == 1
                                  ? Container(
                                height: 350,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                    child: CachedNetworkImage(
                                    imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                        _con.ParticularPost[
                                        index][
                                        "post_images"]
                                        [0]['source']
                                            .toString()
                                            .replaceAll(" ", "%20") +
                                        "?alt=media",
                                    fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                              ),
                                  ) : _con
                                  .ParticularPost[
                              index]
                              ['post_images']
                                  .length >
                                  0 && _con
                                  .ParticularPost[
                              index]
                              ['post_images']
                                  .length > 1 ?
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => GalleryScreen(ImageList: _con.ParticularPost[index]['post_images'],)
                                  ));
                                },
                                child: Container(
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
                                      images: _con
                                          .ParticularPost[
                                      index]
                                      ['post_images'].map((item) {
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
                                            errorWidget: (context, url, error) => Icon(Icons.error));

                                      }).toList(),
                                    )),
                              )
                                  :
                              _con.ParticularPost[
                              index][
                              "youtube_video_id"]
                                  .toString()
                                  .length == 11 &&
                                  _con.ParticularPost[
                                  index][
                                  "youtube_video_id"] !=
                                      null
                                  ? Column(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>WebViewContainer(
                                            url: 'https://www.youtube.com/watch?v=' +
                                                _con.ParticularPost[index]
                                                ['youtube_video_id']
                                                    .toString(),)
                                      ));
                                    },
                                    child: Stack(alignment: Alignment.center,
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl: "https://img.youtube.com/vi/" +
                                                _con.ParticularPost[
                                                index][
                                                "youtube_video_id"]
                                                    .toString() +
                                                "/0.jpg",
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
                                  _con.ParticularPost[index]
                                  ['youtube_title'].length > 130 && /*textSpan==false &&*/ _showutube[index]==false ?
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SmartText(
                                          text:
                                          _con
                                              .ParticularPost[index]['youtube_title'].substring(0, 130,) + " ...",
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
                                        SizedBox(height: 3,),
                                        GestureDetector(
                                            onTap: (){
                                              setState(() {textSpan=true;
                                              _showutube[index]=true;});
                                            },
                                            child: Text("Show more...",style: f14p,)),
                                        SizedBox(height: 2,),
                                      ],
                                    ),
                                  ) : _con.ParticularPost[index]
                                  ['youtube_title'].length > 130/* &&
                      textSpan == true*/ && _showutube[index]==true?
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SmartText(
                                          text:
                                          _con
                                              .ParticularPost[index]['youtube_title'],
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
                                        SizedBox(height:3,),
                                        GestureDetector(
                                            onTap: (){
                                              setState(() {textSpan=false;
                                              _showutube[index]=false;});
                                            },
                                            child: Text("Show less...",style: f14p,)),
                                        SizedBox(height: 2,),
                                      ],
                                    ),
                                  ) : _con.ParticularPost[index]
                                  ['youtube_title'].length <= 130 ?  Padding(
                                    padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                    child: SmartText(
                                      text:
                                      _con
                                          .ParticularPost[index]['youtube_title'],
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
                                  ) : Container(),
                                ],
                              ) : _con.ParticularPost[index]
                              [
                              "youtube_video_id"]
                                  .toString()
                                  .length != 11 &&
                                  _con.ParticularPost[
                                  index][
                                  "youtube_video_id"] !=
                                      null ?
                              Container(
                                alignment: Alignment.center,
                                child: VideoWidget(
                                  url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                      _con
                                          .ParticularPost[index]['youtube_video_id']
                                          .toString()
                                          .replaceAll(
                                          " ", "%20") +
                                      "?alt=media",
                                  play: true,),
                                /*  child: Chewie(
                                            controller: ChewieController(
                                              videoPlayerController: VideoPlayerController.network(
                                                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/2020-10-15%2011:40:40.779801.mp4?alt=media"),
                                              aspectRatio: 3 / 2,allowFullScreen: false,
                                              // autoPlay: true,
                                              autoInitialize: true,
                                              looping: true,
                                            ),
                                          ),*/
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
                                                    .ParticularPost[
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
                                                _con.ParticularPost[
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
                                                    .ParticularPost[
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
                                                _con.ParticularPost[
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
                                                    .ParticularPost[
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
                                                _con.ParticularPost[
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
                                        _likes1[index] ==
                                            true /*|| _con
                                                      .ParticularPost[
                                                  index]
                                                  [
                                                  'like_status'] == true*/
                                            ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              postid = _con
                                                  .ParticularPost[
                                              index]
                                              [
                                              'id']
                                                  .toString();
                                              _likes1[index] = false;
                                              _con
                                                  .ParticularPost[index]['like_status'] =
                                              false;
                                              _con
                                                  .ParticularPost[index]['likes_count'] =
                                                  _con
                                                      .ParticularPost[index]['likes_count'] -
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
                                              postid = _con
                                                  .ParticularPost[
                                              index]
                                              [
                                              'id']
                                                  .toString();
                                              _likes1[index] = true;
                                              _con
                                                  .ParticularPost[index]['like_status'] =
                                              true;
                                              _con
                                                  .ParticularPost[index]['likes_count'] =
                                                  _con
                                                      .ParticularPost[index]['likes_count'] +
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
                                              postid = _con
                                                  .ParticularPost[
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
                                            _con.getTimelineWall(userid);
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
                                                  .ParticularPost[
                                              index]
                                              ['id']
                                                  .toString();
                                              sharePost =
                                                  "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                      postid
                                                          .toString();
                                            });
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SharePost(postid: postid.toString(),sharepost: sharePost.toString(),)));
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
                                        _save1[index] ==
                                            true
                                            ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _save1[index] = false;
                                              _con
                                                  .ParticularPost[index]['save_status'] =
                                              false;
                                              postid = _con
                                                  .ParticularPost[
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
                                              _save1[index] = true;
                                              _con
                                                  .ParticularPost[index]['save_status'] =
                                              true;
                                              postid = _con
                                                  .ParticularPost[
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
          ) : _con.statusParticularPost == false ?
          Center(child: Text("No Posts",style: f16wB,)) :
          Container(height: 0,),

        ],
      ),
    );
  }
}
