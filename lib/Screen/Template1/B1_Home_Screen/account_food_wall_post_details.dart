import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/photos_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/share_post_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:intl/intl.dart';
import 'package:Butomy/CHAT/conversation_screen.dart';
import 'package:Butomy/CHAT/database.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart' as repo;
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ANOTHERPERSON/wall_web_view_page.dart';
import 'edit_post.dart';
import 'hashtag_search_page.dart';
bool textSpan;
var s = "unlike";
var b = "unmark";
DateTime _date;
var d;
var sharePost;
var postImage;
var postDesc;
int focus_ind;

class AccountFoodWallPostDetailPage extends StatefulWidget {

  AccountFoodWallPostDetailPage({Key key, this.id,this.sel_ind,this.total_ind,this.timid}) : super(key: key);
  String id,timid;
  int sel_ind;
  int total_ind;

  @override
  _AccountFoodWallPostDetailPageState createState() =>
      _AccountFoodWallPostDetailPageState();
}
TimelineWallController _con;
class _AccountFoodWallPostDetailPageState
    extends StateMVC<AccountFoodWallPostDetailPage> {
  _AccountFoodWallPostDetailPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  List<bool> _showml =  List.filled(total_count, false);

  _postUpdate() async{
    Timer(Duration(seconds: 2),(){
      _con.getAccountWallImage(widget.timid.toString());
    });
  }

  @override
  void initState() {
    setState(() {
      focus_ind=widget.sel_ind;
      textSpan = false;});
    _con.getAccountWallImage(widget.timid.toString());
    // controller1.jumpToIndex(focus_ind);

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
    // TODO: implement initState
    super.initState();
  }
  List<bool> _likes =  List.filled(total_count, false);
  List<bool> _save =  List.filled(total_count, false);


  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post',
          sharePost, 'text/plain');
    } catch (e) {
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
  // static IndexedScrollController controller1 = IndexedScrollController();
  ScrollController scrollController1 = ScrollController(
    initialScrollOffset: 40, // or whatever offset you wish
    keepScrollOffset: true,
  );

  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();
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
                  visible: _con.statusAccWall,
                  child: Padding(
                    padding: const EdgeInsets.only(top:250.0),
                    child: CircularProgressIndicator(),
                  )
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2,  bottom: 10),
                child: _con.AccountWall.length>0 &&_con.statusAccWall == false ? ScrollablePositionedList.builder(
                  initialScrollIndex: widget.sel_ind,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemCount: _con.AccountWall.length,
                  // controller: scrollController1,
                  // maxItemCount: total_count+1,
                  itemBuilder: (context,index){
                    _con.AccountWall[index]['like_status'] == true ? _likes[index]=true : _likes[index] = false;
                    _con.AccountWall[index]['save_status'] == true ? _save[index]=true : _save[index] = false;
                    _date = DateTime.parse(
                        _con.AccountWall[index]['created_at']['date']);
                    final List<String> playlist = <String>[
                      'https://www.youtube.com/watch?v='+_con.AccountWall[index]['youtube_video_id'].toString()];
                    var c = DateTime
                        .now()
                        .difference(_date)
                        .inHours;
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
                      return GestureDetector(
                        child: new Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5,),
                              child: Container(
                                // color: Colors.white.withOpacity(0.5),
                                padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5.0, bottom: 2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TimelineFoodWallDetailPage(id: _con.AccountWall[index]
                                                                ["user_id"].toString(),)));
                                                  },
                                                  child: Container(
                                                    height: 35.0,
                                                    width: 35.0,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image:
                                                            _con.AccountWall[index]
                                                            ["picture"]!=null ?  CachedNetworkImageProvider(
                                                                _con.AccountWall[index]
                                                                ["picture"].toString().replaceAll(" ", "%20")+"?alt=media"
                                                            ) : CachedNetworkImageProvider(
                                                              "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                            ),
                                                            fit: BoxFit.cover),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(180.0))),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TimelineFoodWallDetailPage(id: _con.AccountWall[index]
                                                                  ['user_id']
                                                                      .toString(),)));
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            Text(
                                                              _con
                                                                  .AccountWall[
                                                              index]
                                                              [
                                                              'name']
                                                                  .toString(),
                                                              style: f15wB,
                                                            ),
                                                            SizedBox(width: 3,),
                                                            _con
                                                                .AccountWall[index]
                                                            ['location']!=null && _con.AccountWall[
                                                            index]
                                                            [
                                                            'location'].toString().length>16 && _con.AccountWall[
                                                            index]
                                                            [
                                                            'name'].toString().length>7?  Text(" - In "+
                                                                _con.AccountWall[index]
                                                                ['location']
                                                                    .toString().substring(0,16)+" ...",
                                                              style: f14g,
                                                            )    :
                                                            _con
                                                                .AccountWall[index]
                                                            ['location']!=null && _con.AccountWall[
                                                            index]
                                                            [
                                                            'location'].toString().length>=19 && _con.AccountWall[
                                                            index]
                                                            [
                                                            'name'].toString().length<=7?  Text(" - In "+
                                                                _con.AccountWall[index]
                                                                ['location']
                                                                    .toString().substring(0,19)+" ...",
                                                              style: f14g,
                                                            )

                                                                : _con.AccountWall[index]
                                                            ['location']!=null && _con.AccountWall[
                                                            index]
                                                            ['location'].toString().length>4&& _con.AccountWall[
                                                            index]
                                                            ['location'].toString().length<=16&& _con.AccountWall[
                                                            index]
                                                            [
                                                            'name'].toString().length<=7 ?
                                                            Text(" - In "+
                                                                _con.AccountWall[index]
                                                                ['location'].toString(),
                                                              style: f14g,
                                                            )
                                                                :Container(),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(d.toString(), style: f10g)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                userid!=_con.AccountWall[index]
                                                ["user_id"].toString() ? GestureDetector(
                                                    onTap: () {
                                                      try {
                                                        String chatID = makeChatId(userid.toString(), _con.AccountWall[index]['user_id'].toString());
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => ChatRoom(
                                                                    userid, NAME, _con.AccountWall[index]
                                                                ['device_token'].toString(),
                                                                    _con.AccountWall[index]
                                                                    ['user_id'].toString(), chatID,
                                                                    _con.AccountWall[index]
                                                                    ['username'].toString(), _con.AccountWall[index]
                                                                ['name'].toString(),
                                                                    _con.AccountWall[
                                                                    index]
                                                                    ['picture'].toString().replaceAll(" ", "%20") + "?alt=media","")));
                                                      } catch (e) {print(e.message);}

                                                    },
                                                    child: Icon(
                                                      Icons.chat,
                                                      color: Color((0xFFffd55e)),
                                                    )) : Container(height: 0,),
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
                                                                      userid.toString() == _con.AccountWall[index]
                                                                      ["user_id"].toString() &&
                                                                          _con.AccountWall[index]["post_type"].toString() == "user"
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
                                                                                              .AccountWall[index]['description']
                                                                                              .toString(),
                                                                                          postid: _con
                                                                                              .AccountWall[index]["id"]
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
                                                                      userid.toString() == _con.AccountWall[index]['user_id'].toString() &&
                                                                          _con.AccountWall[index]["post_type"].toString() == "user"
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
                                                                                                  .AccountWall[index]['id']
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
                                                                                      .AccountWall[index]["id"]
                                                                                      .toString();
                                                                              if(_con.AccountWall[index]['save_status'] ==
                                                                                  true)
                                                                              {
                                                                                _con.AccountWall[index]['save_status'] = false;
                                                                                _con.AccountWall[index]['save_status']=false;
                                                                              }
                                                                              else
                                                                              {
                                                                                _con.AccountWall[index]['save_status'] = true;
                                                                                _con.AccountWall[index]['save_status']=true;
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
                                                                                      _con.AccountWall[index]['save_status']? "Saved Post" : "Save Post",
                                                                                      style: f15wB,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 3,
                                                                                    ),
                                                                                    Text(_con.AccountWall[index]['save_status']? "Added this to your saved post" :
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
                                                                      userid.toString() != _con.AccountWall[index]['user_id'].toString()
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
                                                                                    .AccountWall[index]['id']);

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
                                                                      userid.toString() != _con.AccountWall[index]['user_id'].toString()
                                                                          ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            6.0),
                                                                        child: InkWell(
                                                                          onTap: () {
                                                                            _con.AccountWall[index]["follow_status"] ?
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (
                                                                                    BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    backgroundColor: Color(
                                                                                        0xFF1E2026),
                                                                                    content: new Text(
                                                                                      "Do you want to Unfollow "+_con.AccountWall[index]['name'].toString()+" ?",
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
                                                                                              .AccountWall[index]["follow_status"] = false;});
                                                                                          _con
                                                                                              .followerController(
                                                                                              userid
                                                                                                  .toString(),
                                                                                              _con
                                                                                                  .AccountWall[index]['user_id']
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
                                                                                    .AccountWall[index]['user_id']
                                                                                    .toString());
                                                                            if(_con
                                                                                .AccountWall[index]["follow_status"] ==
                                                                                false){
                                                                              setState(() { _con
                                                                                  .AccountWall[index]["follow_status"] = true;});
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
                                                                                        .AccountWall[index]["follow_status"] ==
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
                                                                                        .AccountWall[index]["follow_status"] ==
                                                                                        true
                                                                                        ? Text(
                                                                                      "Unfollow  " +
                                                                                          _con
                                                                                              .AccountWall[index]["name"],
                                                                                      style: f13w,
                                                                                    )
                                                                                        : Text(
                                                                                      "Follow  " +
                                                                                          _con
                                                                                              .AccountWall[index]["name"],
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
                                                                                      .AccountWall[index]['id']
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
                                                                                      .AccountWall[index]['id']
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
                                                  child: Icon(Icons.more_vert,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    _con.AccountWall[index]
                                    ['description'] !=
                                        "" && _con.AccountWall[index]
                                    ['description'] != null ? Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8),
                                      child: _con.AccountWall[index]
                                      ['description'].length > 130 && /*textSpan==false &&*/ _showml[index]==false ?
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SmartText(
                                            text:
                                            _con
                                                .AccountWall[index]['description'].substring(0, 129,) + " ...",
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
                                                _showml[index]=true;});
                                              },
                                              child: Text("Show more...",style: f14p,)),
                                          SizedBox(height: 2,),
                                        ],
                                      ) : _con.AccountWall[index]
                                      ['description'].length > 130/* &&
                        textSpan == true*/ && _showml[index]==true?
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SmartText(
                                            text:
                                            _con
                                                .AccountWall[index]['description'],
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
                                                _showml[index]=false;});
                                              },
                                              child: Text("Show less...",style: f14p,)),
                                          SizedBox(height: 2,),
                                        ],
                                      ) : _con.AccountWall[index]
                                      ['description'].length <= 130 ?  SmartText(
                                        text:
                                        _con
                                            .AccountWall[index]['description'],
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
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: _con
                                          .AccountWall[
                                      index]
                                      ['post_images']
                                          .length >
                                          0&& _con
                                          .AccountWall[
                                      index]
                                      ['post_images']
                                          .length == 1
                                          ? GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => GalleryScreen(ImageList:
                                              _con.AccountWall[index]['post_images'],)
                                          ));
                                        },
                                            child: Container(height: 350,
                                        width: MediaQuery.of(context).size.width,
                                              child: CachedNetworkImage(
                                        placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                _con.AccountWall[
                                                index][
                                                "post_images"]
                                                [0]['source']
                                                    .toString()
                                                    .replaceAll(" ", "%20") +
                                                "?alt=media",fit: BoxFit.cover,
                                      ),
                                            ),
                                          )
                                          : _con
                                          .AccountWall[
                                      index]
                                      ['post_images']
                                          .length >
                                          0 && _con
                                          .AccountWall[
                                      index]
                                      ['post_images']
                                          .length > 1 ?
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => GalleryScreen(ImageList:
                                              _con.AccountWall[index]['post_images'],)
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
                                                  .AccountWall[
                                              index]
                                              ['post_images'].map((item) {
                                                return new CachedNetworkImage(
                                                    placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
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
                                                    errorWidget: (context, url, error) => Icon(Icons.error));

                                              }).toList(),
                                            )),
                                      )
                                          : Container(
                                        height: 0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7.0, right: 7, bottom: 5),
                                      child: Container(
                                        child: InkWell(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {setState(() { postid= _con.AccountWall[index]['id'].toString();});
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LikeCommentSharePage(
                                                                  statusIndex: 0,)));
                                                    },
                                                    child: Text(
                                                        _con.AccountWall[index]
                                                        ['likes_count']
                                                            .toString() +
                                                            " Likes",
                                                        style: f14y),
                                                  ),
                                                  SizedBox(
                                                    width: 13,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() { postid= _con.AccountWall[index]['id'].toString();});
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LikeCommentSharePage(
                                                                    statusIndex: 1,)));
                                                      _con.getTimelineWall(userid.toString());

                                                    },
                                                    child: Text(
                                                        _con.AccountWall[index]
                                                        ['comments_count']
                                                            .toString() +
                                                            " Comments",
                                                        style: f14y),
                                                  ),
                                                  SizedBox(
                                                    width: 13,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {setState(() { postid= _con.AccountWall[index]['id'].toString();});
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LikeCommentSharePage(
                                                                  statusIndex: 2,)));
                                                    },
                                                    child: Text(
                                                        _con.AccountWall[index]
                                                        ['share_count']
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
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                _likes[index] ==
                                                    true
                                                    ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _likes[index] = false;
                                                      _con.AccountWall[index]['like_status'] =false;
                                                      _con.AccountWall[index]['likes_count'] =  _con.AccountWall[index]['likes_count']-1;
                                                      postid=_con.AccountWall[index]['id'].toString();});
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
                                                      _likes[index] = true;
                                                      _con.AccountWall[index]['like_status'] =true;
                                                      _con.AccountWall[index]['likes_count'] =  _con.AccountWall[index]['likes_count']+1;
                                                      postid=_con.AccountWall[index]['id'].toString();});
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
                                                    setState(() { postid= _con.AccountWall[index]['id'].toString();});
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
                                                      postid= _con.AccountWall[index]['id'].toString();
                                                      sharePost="https://saasinfomedia.com/foodiz/public/sharepost/"+postid.toString();
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
                                                _save[index] == true ? GestureDetector(
                                                  onTap: () {

                                                    setState(() {
                                                      _save[index] = false;
                                                      _con.AccountWall[index]['save_status'] = false;
                                                      postid = _con.AccountWall[index]["id"].toString();});
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
                                                    setState(() {
                                                      _save[index] = true;
                                                      _con.AccountWall[index]['save_status'] = true;
                                                      postid = _con.AccountWall[index]["id"].toString();});
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
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 7,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      );
                  },
                ) :
                _con.statusAccWall == false ? Center(child: Text("No Posts",style: f15wB,)) : Container(height: 0,),
              ),
            ),
          ],
        ));
  }
}

getNames(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
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

