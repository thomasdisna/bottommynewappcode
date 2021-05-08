import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/kitchen_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/restaurant_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/store_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/blog_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_food_bank_request_form.dart';
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
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart' as repo;
import 'package:smart_text_view/smart_text_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ANOTHERPERSON/wall_web_view_page.dart';
import 'Search_Screen/video_widget.dart';
import 'edit_post.dart';
import 'hashtag_search_page.dart';
bool textSpan;
var s = "unlike";
var b = "mark";
DateTime _date;
var d;
var statusflag = 0;
var sharePost;
var postImage;
var postDesc;
DateTime _date2;
var d2;
var e;
class DrawerAccountSavedItem extends StatefulWidget {
  @override
  _DrawerAccountSavedItemState createState() =>
      _DrawerAccountSavedItemState();
}
class _DrawerAccountSavedItemState
    extends StateMVC<DrawerAccountSavedItem> {
  TextEditingController _sharee = TextEditingController();
  ScrollController scrollController;
  List<bool> _likes = List.filled(100,false);
  List<bool> _save = List.filled(100,false);
  List<bool> _showutube = List.filled(1000, false);

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();



  @override
  void initState() {
    // TODO: implement initState]
    setState(() {textSpan = false;});
    _con.savePostListController(userid.toString());
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

  _postUpdate() async{
    Timer(Duration(seconds: 2),(){
      _con.savePostListController(userid.toString());
    });
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

  List<bool> _showml = List.filled(1000, false);
  List<bool> _sharedshowml = List.filled(1000, false);
  List<bool> _showSharedutube = List.filled(1000, false);
  List<bool> splashcolor = List.filled(1000, false);
  DateTime selectedDate;
  int sel;
  TimeOfDay selectedTime;
  var listDate=[];
  int quantity;
  int total;
  int sel_ind;
  String timeF = "am";
  Future<Null> _selectTime(BuildContext context,sss.StateSetter state) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      state(() {
        selectedTime = picked;
        var a =selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString().split(":");
        print("dfgh "+a.toString());
        if(int.parse(a[0])<=12)
          timeF="am";
        else
          timeF="pm";
      });
    print("timmmmeewe -"+selectedTime.toString());
    print("timmmmeewe cuuutttt 11111 -"+selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", ""));
  }

  Future<Null> _selectDate(BuildContext context,sss.StateSetter state) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      state(() {
        selectedDate = picked;
      });
    listDate = selectedDate.toString().split(" ");
    print("ddaaateeeeee "+selectedDate.toString());
    print("ddaaateeeeee listtttt"+listDate.toString());
    print("ddaaateeeeee 333333333"+DateFormat.yMMMEd().format(selectedDate).toString());
    _selectTime(context,state);
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
        children: [TextSpan(text: split.first.substring(0,130,)+" ...",children: [
          TextSpan(recognizer: TapGestureRecognizer()..onTap=(){
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
  TimelineWallController _con;

  _DrawerAccountSavedItemState() : super(TimelineWallController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    _con.getFollowing(userid);
    return Scaffold(
        backgroundColor: Color(0xFF1E2026),

        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          title: Text("Saved Items",style:TextStyle(color:Colors.white),),
          centerTitle: true,

        ),
        body: Column(
          children: [
            Center(
              child: Visibility(
                  visible: _con.statusSavedPost,
                  child: Container(
                      margin: EdgeInsets.only(top: 250, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            _con.savePostInfo!=null && _con.statusSavedPost==false ?  Expanded(
              child:InViewNotifierList(
                initialInViewIds: ['0'],
                isInViewPortCondition: (double deltaTop,
                    double deltaBottom,
                    double viewPortDimension) {
                  return deltaTop < (0.5 * viewPortDimension) &&
                      deltaBottom > (0.5 * viewPortDimension);
                },
                itemCount: _con.savePostInfo.length,
                physics: const AlwaysScrollableScrollPhysics(),
                builder: (BuildContext context, int index) {
                  _con.savePostInfo[index]['like_status'] == true ? _likes[index]=true : _likes[index] = false;
                  _con.savePostInfo[index]['save_status'] == true ? _save[index]=true : _save[index] = false;
                  _date = DateTime.parse(
                      _con.savePostInfo[index]['created_at']['date']);
                  _con
                      .savePostInfo[index]["shared_post_id"] !=
                      null
                      ? _date2 = DateTime.parse(
                      _con
                          .savePostInfo[index]["shared_post_details"]['created_at']
                      ['date'])
                      : null;
                  final List<String> playlist = <String>[
                    'https://www.youtube.com/watch?v='+_con.savePostInfo[index]['youtube_video_id'].toString()];
                  var c = DateTime
                      .now()
                      .difference(_date)
                      .inHours;
                  _con
                      .savePostInfo[index]["shared_post_id"] !=
                      null
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
                  _con
                      .savePostInfo[index]["shared_post_id"] !=
                      null
                      ? e > 24 && e <= 48
                      ? d2 = "Yesterday" : e > 48 ?
                  d2 = DateFormat.MMMd().format(_date2)
                      : e == 0
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
                          padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
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
                                          //                 imageUrl: _con
                                          //                     .savePostInfo[index]["business_type"]
                                          //                     .toString() ==
                                          //                     "4" ||   _con
                                          //                     .savePostInfo[index]["business_type"]
                                          //                     .toString() ==
                                          //                     "6"  ? _con
                                          //                     .savePostInfo[index]["picture"]
                                          //                     .toString()
                                          //                     .replaceAll(
                                          //                     " ",
                                          //                     "%20") +
                                          //                     "?alt=media" :
                                          //                 _con
                                          //                     .savePostInfo[index]["product_id"] !=
                                          //                     null &&
                                          //                     _con
                                          //                         .savePostInfo[index]["business_profile_image"] !=
                                          //                         null && _con
                                          //                     .savePostInfo[index]["business_profile_image"] !=""
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString() +
                                          //                     "?alt=media"
                                          //                     : _con
                                          //                     .savePostInfo[index]["product_id"] !=
                                          //                     null && _con
                                          //                     .savePostInfo[index]["business_profile_image"] ==""
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                                          //                     : _con
                                          //                     .savePostInfo[index]["product_id"] ==
                                          //                     null &&
                                          //                     _con
                                          //                         .savePostInfo[index]["post_type"]
                                          //                         .toString() ==
                                          //                         "page" &&
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString() !=
                                          //                         ""
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString()
                                          //                         .replaceAll(
                                          //                         " ",
                                          //                         "%20") +
                                          //                     "?alt=media"
                                          //                     : _con
                                          //                     .savePostInfo[index]["product_id"] ==
                                          //                     null &&
                                          //                     _con
                                          //                         .savePostInfo[index]["post_type"]
                                          //                         .toString() ==
                                          //                         "page" &&
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString() ==
                                          //                         ""
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                          //                     "icu.png" +
                                          //                     "?alt=media"
                                          //                     : _con
                                          //                     .savePostInfo[index]["picture"]
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
                                          //     decoration: BoxDecoration(
                                          //         image: DecorationImage(
                                          //             image: _con
                                          //                 .savePostInfo[index]["picture"] !=
                                          //                 null
                                          //                 ? CachedNetworkImageProvider(
                                          //                 _con
                                          //                     .savePostInfo[index]["post_type"]
                                          //                     .toString() ==
                                          //                     "page" &&
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString() ==
                                          //                         ""
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                          //                     "icu.png" +
                                          //                     "?alt=media" :
                                          //                 _con
                                          //                     .savePostInfo[index]["business_type"]
                                          //                     .toString() ==
                                          //                     "4"  ||   _con
                                          //                     .savePostInfo[index]["business_type"]
                                          //                     .toString() ==
                                          //                     "6" ? _con
                                          //                     .savePostInfo[index]["picture"]
                                          //                     .toString()
                                          //                     .replaceAll(
                                          //                     " ",
                                          //                     "%20") +
                                          //                     "?alt=media" :
                                          //                 _con
                                          //                     .savePostInfo[index]["product_id"] !=
                                          //                     null &&
                                          //                     _con.savePostInfo[index]["business_profile_image"] != null &&  _con.savePostInfo[index]["business_profile_image"] != ""
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString() +
                                          //                     "?alt=media"
                                          //                     : _con
                                          //                     .savePostInfo[index]["product_id"] !=
                                          //                     null && _con.savePostInfo[index]["business_profile_image"] == null
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                                          //                     : _con
                                          //                     .savePostInfo[index]["product_id"] ==
                                          //                     null &&
                                          //                     _con
                                          //                         .savePostInfo[index]["post_type"]
                                          //                         .toString() ==
                                          //                         "page" &&
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString() !=
                                          //                         ""
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString()
                                          //                         .replaceAll(
                                          //                         " ",
                                          //                         "%20") +
                                          //                     "?alt=media"
                                          //                     :   _con
                                          //                     .savePostInfo[index]["product_id"] ==
                                          //                     null &&
                                          //                     _con
                                          //                         .savePostInfo[index]["post_type"]
                                          //                         .toString() ==
                                          //                         "page" &&
                                          //                     _con
                                          //                         .savePostInfo[index]["picture"]
                                          //                         .toString() ==
                                          //                         ""
                                          //                     ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                          //                     "icu.png" +
                                          //                     "?alt=media"
                                          //                     :  _con
                                          //                     .savePostInfo[index]["picture"]
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
                                          //             color: (_con
                                          //                 .savePostInfo[index]["product_id"] ==
                                          //                 null &&
                                          //                 _con
                                          //                     .savePostInfo[index]["post_type"]
                                          //                     .toString() ==
                                          //                     "page" &&
                                          //                 _con
                                          //                     .savePostInfo[index]["picture"]
                                          //                     .toString() ==
                                          //                     "") ||
                                          //                 (_con
                                          //                     .savePostInfo[index]["product_id"] !=
                                          //                     null &&  _con
                                          //                     .savePostInfo[index]["picture"]
                                          //                     .toString() ==
                                          //                     "" &&
                                          //                     _con
                                          //                         .savePostInfo[index]["business_profile_image"] ==
                                          //                         null) || (_con
                                          //                 .savePostInfo[index]["business_profile_image"] == "" &&
                                          //                 _con
                                          //                     .savePostInfo[index]["post_type"]
                                          //                     .toString() ==
                                          //                     "page" &&  _con
                                          //                 .savePostInfo[index]["picture"]
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
                                                _con
                                                    .savePostInfo[index]["product_id"] !=
                                                    null && _con
                                                    .savePostInfo[index]["business_type"]
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
                                                              pagid: _con
                                                                  .savePostInfo[index]['business_page_id']
                                                                  .toString(),
                                                              timid: _con
                                                                  .savePostInfo[index]['business_timeline_id']
                                                                  .toString(),)
                                                    )) : _con
                                                    .savePostInfo[index]["product_id"] ==
                                                    null && _con
                                                    .savePostInfo[index]["post_type"]
                                                    .toString() ==
                                                    "page" &&
                                                    _con
                                                        .savePostInfo[index]["business_type"]
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
                                                              pagid: _con
                                                                  .savePostInfo[index]['business_page_id']
                                                                  .toString(),
                                                              timid: _con
                                                                  .savePostInfo[index]['timeline_id']
                                                                  .toString(),)
                                                    ))

                                                    : _con
                                                    .savePostInfo[index]["product_id"] !=
                                                    null && _con
                                                    .savePostInfo[index]["business_type"]
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
                                                              pagid: _con
                                                                  .savePostInfo[index]['business_page_id']
                                                                  .toString(),
                                                              timid: _con
                                                                  .savePostInfo[index]['business_timeline_id']
                                                                  .toString(),)
                                                    )) : _con
                                                    .savePostInfo[index]["product_id"] ==
                                                    null && _con
                                                    .savePostInfo[index]["post_type"]
                                                    .toString() ==
                                                    "page" &&
                                                    _con
                                                        .savePostInfo[index]["business_type"]
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
                                                              pagid: _con
                                                                  .savePostInfo[index]['business_page_id']
                                                                  .toString(),
                                                              timid: _con
                                                                  .savePostInfo[index]['timeline_id']
                                                                  .toString(),)))
                                                    : _con
                                                    .savePostInfo[index]["product_id"] !=
                                                    null && _con
                                                    .savePostInfo[index]["business_type"]
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
                                                              pagid: _con
                                                                  .savePostInfo[index]['business_page_id']
                                                                  .toString(),
                                                              timid: _con
                                                                  .savePostInfo[index]['business_timeline_id']
                                                                  .toString(),)
                                                    ))
                                                    : _con
                                                    .savePostInfo[index]["product_id"] ==
                                                    null && _con
                                                    .savePostInfo[index]["post_type"]
                                                    .toString() ==
                                                    "page" &&
                                                    _con
                                                        .savePostInfo[index]["business_type"]
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
                                                              pagid: _con
                                                                  .savePostInfo[index]['business_page_id']
                                                                  .toString(),
                                                              timid: _con
                                                                  .savePostInfo[index]['timeline_id']
                                                                  .toString(),)))
                                                    : Navigator
                                                    .push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (
                                                            context) =>
                                                            TimelineFoodWallDetailPage(
                                                              id: _con
                                                                  .savePostInfo[index]['user_id']
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
                                                        .savePostInfo[index]["product_id"] !=
                                                        null
                                                        ? _con
                                                        .savePostInfo[
                                                    index]
                                                    ['business_name']
                                                        .toString()
                                                        : _con
                                                        .savePostInfo[
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
                                                          d
                                                              .toString(),
                                                          style: f10g),
                                                      _con
                                                          .savePostInfo[index]
                                                      ['post_location'] !=
                                                          null &&
                                                          _con
                                                              .savePostInfo[
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
                                                            userid.toString() == _con.savePostInfo[index]['user_id'].toString() && _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString().length>=45 && (_con.savePostInfo[index]["post_type"].toString()
                                                                =="page" || _con.savePostInfo[index]["post_type"].toString()
                                                                =="user")
                                                                ?   _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString().substring(0,45)+"..." :
                                                            userid.toString() == _con.savePostInfo[index]['user_id'].toString() && _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString().length<40 && (_con.savePostInfo[index]["post_type"].toString()
                                                                =="page" || _con.savePostInfo[index]["post_type"].toString()
                                                                =="user")
                                                                ?   _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString() :  _con.savePostInfo[index]["post_type"].toString()
                                                                =="page" && _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString().length>=21 && userid.toString() != _con.savePostInfo[index]['user_id'].toString()
                                                                ?  _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString().substring(0,21)+"..." :
                                                            _con.savePostInfo[index]["post_type"].toString()
                                                                =="page" && _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString().length<21 && userid.toString() != _con.savePostInfo[index]['user_id'].toString() ?
                                                            _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString() :
                                                            _con.savePostInfo[index]["post_type"].toString()
                                                                =="user" && _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString().length>=33 && userid.toString() != _con.savePostInfo[index]['user_id'].toString() ?
                                                            _con
                                                                .savePostInfo[index]
                                                            ['post_location']
                                                                .toString().substring(0,33)+"..." : _con
                                                                .savePostInfo[index]
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
                                          userid.toString() !=
                                              _con
                                                  .savePostInfo[index]["user_id"]
                                                  .toString() &&
                                              _con
                                                  .savePostInfo[index]["post_type"]
                                                  .toString() ==
                                                  "page" && _con
                                              .savePostInfo[index]["business_type"]
                                              .toString() !="4" && _con
                                              .savePostInfo[index]["business_type"]
                                              .toString() !="6"
                                              ? Container(height: 23,
                                            child: MaterialButton(

                                              onPressed: () {
                                                if (_con
                                                    .savePostInfo[index]["follow_status"] ==
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
                                                                _con
                                                                    .savePostInfo[index]
                                                                ["name"]
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
                                                                  _con
                                                                      .savePostInfo[index]['business_page_id']
                                                                      .toString(),
                                                                  userid
                                                                      .toString(),);
                                                                setState(() {
                                                                  _con
                                                                      .savePostInfo[index]["follow_status"] =
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
                                                    _con
                                                        .savePostInfo[index]['business_page_id']
                                                        .toString(),
                                                    userid
                                                        .toString(),);
                                                  setState(() {
                                                    _con
                                                        .savePostInfo[index]["follow_status"] =
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
                                                  child: _con
                                                      .savePostInfo[index][
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
                                              _con
                                                  .savePostInfo[
                                              index][
                                              "user_id"]
                                                  .toString() && _con
                                              .savePostInfo[index]["business_type"]
                                              .toString() !="6" && _con
                                              .savePostInfo[index]["business_type"]
                                              .toString() !="4"
                                              ? GestureDetector(
                                              onTap: () {
                                                try {
                                                  String chatID = makeChatId(
                                                      timelineIdFoodi
                                                          .toString(),
                                                      _con
                                                          .savePostInfo[
                                                      index]
                                                      [
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
                                                                  _con
                                                                      .savePostInfo[
                                                                  index]
                                                                  [
                                                                  'device_token']
                                                                      .toString(),
                                                                  _con
                                                                      .savePostInfo[
                                                                  index]
                                                                  ['timeline_id']
                                                                      .toString(),
                                                                  chatID,
                                                                  _con
                                                                      .savePostInfo[
                                                                  index]
                                                                  [
                                                                  'username']
                                                                      .toString(),
                                                                  _con
                                                                      .savePostInfo[
                                                                  index]
                                                                  [
                                                                  'name']
                                                                      .toString(),
                                                                  _con
                                                                      .savePostInfo[
                                                                  index]
                                                                  [
                                                                  'post_type'] =="page"  ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                      .savePostInfo[
                                                                  index]
                                                                  [
                                                                  'picture']
                                                                      .toString()
                                                                      .replaceAll(
                                                                      " ",
                                                                      "%20") +
                                                                      "?alt=media" : _con
                                                                      .savePostInfo[
                                                                  index]
                                                                  [
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
                                                                userid.toString() == _con.savePostInfo[index]
                                                                ["user_id"].toString() &&
                                                                    _con.savePostInfo[index]["post_type"].toString() == "user"
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
                                                                                        .savePostInfo[index]['description']
                                                                                        .toString(),
                                                                                    postid: _con
                                                                                        .savePostInfo[index]["id"]
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
                                                                userid.toString() == _con.savePostInfo[index]['user_id'].toString() &&
                                                                    _con.savePostInfo[index]["post_type"].toString() == "user"
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
                                                                                            .savePostInfo[index]['id']
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
                                                                                .savePostInfo[index]["id"]
                                                                                .toString();
                                                                        if(_con.savePostInfo[index]['save_status'] ==
                                                                            true)
                                                                        {
                                                                          _con.savePostInfo[index]['save_status'] = false;
                                                                          _con.savePostInfo[index]['save_status']=false;
                                                                        }
                                                                        else
                                                                        {
                                                                          _con.savePostInfo[index]['save_status'] = true;
                                                                          _con.savePostInfo[index]['save_status']=true;
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
                                                                                _con.savePostInfo[index]['save_status']? "Saved Post" : "Save Post",
                                                                                style: f15wB,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 3,
                                                                              ),
                                                                              Text(_con.savePostInfo[index]['save_status']? "Added this to your saved post" :
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
                                                                userid.toString() != _con.savePostInfo[index]['user_id'].toString()
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
                                                                              .savePostInfo[index]['id']);

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
                                                                userid.toString() != _con.savePostInfo[index]['user_id'].toString()
                                                                    ? Padding(
                                                                  padding: const EdgeInsets
                                                                      .all(
                                                                      6.0),
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      _con.savePostInfo[index]["follow_status"] ?
                                                                      showDialog(
                                                                          context: context,
                                                                          builder: (
                                                                              BuildContext context) {
                                                                            return AlertDialog(
                                                                              backgroundColor: Color(
                                                                                  0xFF1E2026),
                                                                              content: new Text(
                                                                                "Do you want to Unfollow "+_con.savePostInfo[index]['name'].toString()+" ?",
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
                                                                                        .savePostInfo[index]["follow_status"] = false;});
                                                                                    _con
                                                                                        .followerController(
                                                                                        userid
                                                                                            .toString(),
                                                                                        _con
                                                                                            .savePostInfo[index]['user_id']
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
                                                                              .savePostInfo[index]['user_id']
                                                                              .toString());
                                                                      if(_con
                                                                          .savePostInfo[index]["follow_status"] ==
                                                                          false){
                                                                        setState(() { _con
                                                                            .savePostInfo[index]["follow_status"] = true;});
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
                                                                                  .savePostInfo[index]["follow_status"] ==
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
                                                                                  .savePostInfo[index]["follow_status"] ==
                                                                                  true
                                                                                  ? Text(
                                                                                "Unfollow  " +
                                                                                    _con
                                                                                        .savePostInfo[index]["name"],
                                                                                style: f13w,
                                                                              )
                                                                                  : Text(
                                                                                "Follow  " +
                                                                                    _con
                                                                                        .savePostInfo[index]["name"],
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
                                                                                .savePostInfo[index]['id']
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
                                                                                .savePostInfo[index]['id']
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
                              _con.savePostInfo[index]
                              ['post_title'] == null &&
                                  _con.savePostInfo[index]
                                  ['description'] !=
                                      "" &&
                                  _con.savePostInfo[index]
                                  ['description'] != null && _con
                                  .savePostInfo[index]["business_type"]
                                  .toString() !="4" && _con
                                  .savePostInfo[index]["business_type"]
                                  .toString() !="6"
                                  ?  Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8),
                                child: _con
                                    .savePostInfo[index]
                                ['description'].length >
                                    130 && /*textSpan==false &&*/
                                    _showml[index] == false ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    SmartText(

                                      text:
                                      _con
                                          .savePostInfo[index]['description']
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
                                            _showml[index] =
                                            true;
                                          });
                                        },
                                        child: Text(
                                          "Show more...",
                                          style: f14p,)),
                                    SizedBox(height: 2,),
                                  ],
                                ) : _con.savePostInfo[index]
                                ['description'].length > 130 /* &&
                            textSpan == true*/ && _showml[index] == true ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    SmartText(
                                      text:
                                      _con
                                          .savePostInfo[index]['description'],
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
                                            _showml[index] =
                                            false;
                                          });
                                        },
                                        child: Text(
                                          "Show less...",
                                          style: f14p,)),
                                    SizedBox(height: 2,),
                                  ],
                                ) : _con.savePostInfo[index]
                                ['description'].length <= 130
                                    ? SmartText(
                                  text:
                                  _con
                                      .savePostInfo[index]['description'],
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
                              _con
                                  .savePostInfo[index]["shared_post_id"] !=
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
                                                                  id: _con
                                                                      .savePostInfo[index]["shared_post_details"]["user_id"]
                                                                      .toString(),
                                                                )));
                                                  },
                                                  child: Container(
                                                    height: 35.0,
                                                    width: 35.0,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: _con
                                                                .savePostInfo[index]["shared_post_details"]["picture"] !=
                                                                null
                                                                ? CachedNetworkImageProvider(
                                                                _con
                                                                    .savePostInfo[index]["shared_post_details"]["picture"]
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
                                                                    id: _con
                                                                        .savePostInfo[index]["shared_post_details"]['user_id']
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
                                                              .savePostInfo[index]["shared_post_details"]
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
                                        _con
                                            .savePostInfo[index]["shared_post_details"]
                                        ['description'] !=
                                            "" && _con
                                            .savePostInfo[index]["shared_post_details"]
                                        ['description'] != null
                                            ? Padding(
                                          padding: const EdgeInsets
                                              .only(left: 8,
                                              right: 8),
                                          child: _con
                                              .savePostInfo[index]["shared_post_details"]
                                          ['description']
                                              .length >
                                              130 && /*textSpan==false &&*/
                                              _sharedshowml[index] ==
                                                  false ?
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              SmartText(
                                                text:
                                                _con
                                                    .savePostInfo[index]["shared_post_details"]['description']
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
                                                      _sharedshowml[index] =
                                                      true;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Show more...",
                                                    style: f14p,)),
                                              SizedBox(
                                                height: 2,),
                                            ],
                                          ) : _con
                                              .savePostInfo[index]["shared_post_details"]
                                          ['description']
                                              .length > 130 /* &&
                            textSpan == true*/ && _sharedshowml[index] ==
                                              true ?
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              SmartText(
                                                text:
                                                _con
                                                    .savePostInfo[index]["shared_post_details"]['description'],
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
                                                      _sharedshowml[index] =
                                                      false;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Show less...",
                                                    style: f14p,)),
                                              SizedBox(
                                                height: 2,),
                                            ],
                                          ) : _con
                                              .savePostInfo[index]["shared_post_details"]
                                          ['description']
                                              .length <= 130
                                              ? SmartText(
                                            text:
                                            _con
                                                .savePostInfo[index]["shared_post_details"]['description'],
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
                                          child: _con
                                              .savePostInfo[
                                          index]["shared_post_details"]['url_image'] !=
                                              "" && _con
                                              .savePostInfo[
                                          index]["shared_post_details"]['url_image'] !=
                                              null
                                              ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (
                                                          context) =>
                                                          WebViewContainer(
                                                            url: _con
                                                                .savePostInfo[
                                                            index]["shared_post_details"]['url_link'],)
                                                  ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .all(5.0),
                                              child: Container(
                                                color: Colors
                                                    .grey[800],
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .stretch,
                                                  children: [
                                                    CachedNetworkImage(
                                                        imageUrl:
                                                        _con
                                                            .savePostInfo[
                                                        index]["shared_post_details"][
                                                        "url_image"]
                                                            .toString(),
                                                        fit: BoxFit
                                                            .cover,
                                                        placeholder: (
                                                            context,
                                                            ind) =>
                                                            Image
                                                                .asset(
                                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                              fit: BoxFit
                                                                  .cover,)
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          top: 5,
                                                          bottom: 5,
                                                          left: 8,
                                                          right: 8),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            _con
                                                                .savePostInfo[
                                                            index]["shared_post_details"][
                                                            "url_site"]
                                                                .toString(),
                                                            style: f14w,),
                                                          SizedBox(
                                                            height: 4,),
                                                          Text(
                                                            _con
                                                                .savePostInfo[
                                                            index]["shared_post_details"][
                                                            "url_title"]
                                                                .toString(),
                                                            style: f14w,),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                              : _con
                                              .savePostInfo[
                                          index]["shared_post_details"]
                                          ['post_images']
                                              .length >
                                              0 && _con
                                              .savePostInfo[
                                          index]["shared_post_details"]
                                          ['post_images']
                                              .length == 1
                                              ? GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => GalleryScreen(ImageList: _con.savePostInfo[index]["shared_post_details"]['post_images'],)
                                              ));
                                            },
                                            child: Container(
                                              height: 350,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              child: CachedNetworkImage(
                                                placeholder: (
                                                    context,
                                                    ind) =>
                                                    Image.asset(
                                                      "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                      fit: BoxFit
                                                          .cover,),
                                                imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                    _con
                                                        .savePostInfo[
                                                    index]["shared_post_details"][
                                                    "post_images"]
                                                    [0]['source']
                                                        .toString()
                                                        .replaceAll(
                                                        " ",
                                                        "%20") +
                                                    "?alt=media",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ) : _con
                                              .savePostInfo[
                                          index]["shared_post_details"]
                                          ['post_images']
                                              .length >
                                              0 && _con
                                              .savePostInfo[
                                          index]["shared_post_details"]
                                          ['post_images']
                                              .length > 1 ?
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => GalleryScreen(ImageList: _con.savePostInfo[index]["shared_post_details"]['post_images'],)
                                              ));
                                            },
                                            child: Container(
                                                height: 350.0,
                                                child: new Carousel(
                                                  boxFit: BoxFit
                                                      .fill,
                                                  dotColor: Colors
                                                      .black,
                                                  dotSize: 5.5,
                                                  autoplay: false,
                                                  dotSpacing: 16.0,
                                                  dotIncreasedColor: Color(
                                                      0xFF48c0d8),
                                                  dotBgColor: Colors
                                                      .transparent,
                                                  showIndicator: true,
                                                  overlayShadow: true,
                                                  overlayShadowColors: Colors
                                                      .white
                                                      .withOpacity(
                                                      0.2),
                                                  overlayShadowSize: 0.9,
                                                  images: _con
                                                      .savePostInfo[
                                                  index]["shared_post_details"]
                                                  ['post_images']
                                                      .map((
                                                      item) {
                                                    return new CachedNetworkImage(
                                                        placeholder: (
                                                            context,
                                                            ind) =>
                                                            Image
                                                                .asset(
                                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                              fit: BoxFit
                                                                  .cover,),
                                                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                            item['source']
                                                                .toString()
                                                                .replaceAll(
                                                                " ",
                                                                "%20") +
                                                            "?alt=media",
                                                        imageBuilder: (
                                                            context,
                                                            imageProvider) =>
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                  image: imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                        errorWidget: (
                                                            context,
                                                            url,
                                                            error) =>
                                                            Icon(
                                                                Icons
                                                                    .error));
                                                  }).toList(),
                                                )),
                                          )
                                              :
                                          _con.savePostInfo[
                                          index]["shared_post_details"][
                                          "youtube_video_id"]
                                              .toString()
                                              .length == 11 &&
                                              _con
                                                  .savePostInfo[
                                              index]["shared_post_details"][
                                              "youtube_video_id"] !=
                                                  null
                                              ? Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator
                                                      .push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (
                                                              context) =>
                                                              WebViewContainer(
                                                                url: 'https://www.youtube.com/watch?v=' +
                                                                    _con
                                                                        .savePostInfo[index]["shared_post_details"]
                                                                    ['youtube_video_id']
                                                                        .toString(),)
                                                      ));
                                                },
                                                child: Stack(
                                                  alignment: Alignment
                                                      .center,
                                                  children: [
                                                    CachedNetworkImage(
                                                        imageUrl: "https://img.youtube.com/vi/" +
                                                            _con
                                                                .savePostInfo[
                                                            index]["shared_post_details"][
                                                            "youtube_video_id"]
                                                                .toString() +
                                                            "/0.jpg",
                                                        height: 200,
                                                        width: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width,
                                                        fit: BoxFit
                                                            .cover,
                                                        placeholder: (
                                                            context,
                                                            ind) =>
                                                            Image
                                                                .asset(
                                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                              fit: BoxFit
                                                                  .cover,)
                                                    ),
                                                    Image.asset(
                                                      "assets/Template1/image/Foodie/icons/youtube.png",
                                                      height: 32,
                                                      width: 32,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              _con
                                                  .savePostInfo[index]["shared_post_details"]
                                              ['youtube_title']
                                                  .length >
                                                  130 && /*textSpan==false &&*/
                                                  _showSharedutube[index] ==
                                                      false ?
                                              Padding(
                                                padding: const EdgeInsets
                                                    .only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 5,
                                                    bottom: 2),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SmartText(
                                                      text:
                                                      _con
                                                          .savePostInfo[index]["shared_post_details"]['youtube_title']
                                                          .substring(
                                                        0,
                                                        130,) +
                                                          " ...",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                      ),
                                                      onOpen: (
                                                          link) {
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
                                                            _showSharedutube[index] =
                                                            true;
                                                          });
                                                        },
                                                        child: Text(
                                                          "Show more...",
                                                          style: f14p,)),
                                                    SizedBox(
                                                      height: 2,),
                                                  ],
                                                ),
                                              ) : _con
                                                  .savePostInfo[index]["shared_post_details"]
                                              ['youtube_title']
                                                  .length > 130 /* &&
                            textSpan == true*/ && _showSharedutube[index] ==
                                                  true ?
                                              Padding(
                                                padding: const EdgeInsets
                                                    .only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 5,
                                                    bottom: 2),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SmartText(
                                                      text:
                                                      _con
                                                          .savePostInfo[index]["shared_post_details"]['youtube_title'],
                                                      style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                      ),
                                                      onOpen: (
                                                          link) {
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
                                                            _showSharedutube[index] =
                                                            false;
                                                          });
                                                        },
                                                        child: Text(
                                                          "Show less...",
                                                          style: f14p,)),
                                                    SizedBox(
                                                      height: 2,),
                                                  ],
                                                ),
                                              ) : _con
                                                  .savePostInfo[index]["shared_post_details"]
                                              ['youtube_title']
                                                  .length <= 130
                                                  ? Padding(
                                                padding: const EdgeInsets
                                                    .only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 5,
                                                    bottom: 2),
                                                child: SmartText(
                                                  text:
                                                  _con
                                                      .savePostInfo[index]["shared_post_details"]['youtube_title'],
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  onOpen: (
                                                      link) {
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
                                              )
                                                  : Container(),
                                            ],
                                          ) : _con
                                              .savePostInfo[index]["shared_post_details"]
                                          [
                                          "youtube_video_id"]
                                              .toString()
                                              .length != 11 &&
                                              _con
                                                  .savePostInfo[
                                              index]["shared_post_details"][
                                              "youtube_video_id"] !=
                                                  null ?
                                          Container(
                                            alignment: Alignment
                                                .center,
                                            child: VideoWidget(
                                              url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                                  _con
                                                      .savePostInfo[index]["shared_post_details"]['youtube_video_id']
                                                      .toString()
                                                      .replaceAll(
                                                      " ",
                                                      "%20") +
                                                  "?alt=media",
                                              play: true,),

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
                              _con
                                  .savePostInfo[index]["business_type"]
                                  .toString() =="6" ? Padding(
                                padding: const EdgeInsets.only(top:5.0),
                                child: Container(
                                  color: Colors.grey[850],
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8,),
                                      Padding(
                                        padding: const EdgeInsets.only(left:10,right: 10,bottom: 5),
                                        child: Text(_con
                                            .savePostInfo[index]
                                        ['item_name'].toString()+" @ Rs."+_con
                                            .savePostInfo[index]
                                        ['item_price'].toString(),style: f15wB,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:6,),
                                        child: _con
                                            .savePostInfo[index]
                                        ['post_images']
                                            .length >
                                            0 && _con
                                            .savePostInfo[
                                        index]
                                        ['post_images']
                                            .length == 1 && _con
                                            .savePostInfo[index]["business_type"]
                                            .toString() =="6"
                                            ? Container(
                                          height: 300,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          child: CachedNetworkImage(
                                              imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                  _con.savePostInfo[
                                                  index][
                                                  "post_images"]
                                                  [0]['source']
                                                      .toString()
                                                      .replaceAll(
                                                      " ", "%20") +
                                                  "?alt=media",
                                              fit: BoxFit.cover,
                                              placeholder: (context,
                                                  ind) => Image.asset(
                                                "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                fit: BoxFit.cover,)
                                          ),
                                        ) : _con
                                            .savePostInfo[
                                        index]
                                        ['post_images']
                                            .length >
                                            0 && _con
                                            .savePostInfo[
                                        index]
                                        ['post_images']
                                            .length > 1 && _con
                                            .savePostInfo[index]["business_type"]
                                            .toString() =="6" ?
                                        Container(
                                            height: 300.0,
                                            child: new Carousel(
                                              boxFit: BoxFit.fill,
                                              dotColor: Colors.black,
                                              dotSize: 5.5,
                                              autoplay: false,
                                              dotSpacing: 16.0,
                                              dotIncreasedColor: Color(
                                                  0xFF48c0d8),
                                              dotBgColor: Colors
                                                  .transparent,
                                              showIndicator: true,
                                              overlayShadow: true,
                                              overlayShadowColors: Colors
                                                  .white
                                                  .withOpacity(0.2),
                                              overlayShadowSize: 0.9,
                                              images: _con
                                                  .savePostInfo[
                                              index]
                                              ['post_images'].map((
                                                  item) {
                                                return new CachedNetworkImage(
                                                  placeholder: (context,
                                                      ind) =>
                                                      Image.asset(
                                                        "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                        fit: BoxFit
                                                            .cover,),
                                                  imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                      item['source']
                                                          .toString()
                                                          .replaceAll(
                                                          " ", "%20") +
                                                      "?alt=media",
                                                  imageBuilder: (
                                                      context,
                                                      imageProvider) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit
                                                                .cover,
                                                          ),
                                                        ),
                                                      ),
                                                );
                                              }).toList(),
                                            ))
                                            : Container(height: 0,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:8,bottom: 8,left: 10,right: 10),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(DateFormat.yMMMd().format(DateTime.parse(
                                                _con.savePostInfo[index]["created_at"]["date"])).toString(),style: f13w,),
                                            Row(
                                              children: [
                                                Text("\u20B9 "+_con
                                                    .savePostInfo[index]
                                                ['item_price'].toString(),style: f16wB,),
                                                userid.toString()!= _con.savePostInfo[index]["user_id"].toString() ?  SizedBox(width: 15,) : Container(height: 0,),
                                                userid.toString()!= _con.savePostInfo[index]["user_id"].toString() ?   Container(
                                                  height: 25,
                                                  child: MaterialButton(
                                                    color: Color(0xFFffd55e),
                                                    splashColor: Color(0xFF48c0d8),
                                                    height: 25,
                                                    minWidth: 90,

                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8)
                                                    ),
                                                    onPressed: (){
                                                      try {
                                                        String chatID = makeChatId(
                                                            userid
                                                                .toString(),
                                                            _con
                                                                .savePostInfo[index]["user_id"].toString());
                                                        Navigator
                                                            .push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    ChatRoom(
                                                                        userid,
                                                                        NAME,
                                                                        _con
                                                                            .savePostInfo[
                                                                        index]
                                                                        [
                                                                        'device_token']
                                                                            .toString(),
                                                                        _con
                                                                            .savePostInfo[
                                                                        index]
                                                                        [
                                                                        'user_id']
                                                                            .toString(),
                                                                        chatID,
                                                                        _con
                                                                            .savePostInfo[
                                                                        index]
                                                                        [
                                                                        'username']
                                                                            .toString(),
                                                                        _con
                                                                            .savePostInfo[
                                                                        index]
                                                                        [
                                                                        'name']
                                                                            .toString(),
                                                                        _con
                                                                            .savePostInfo[
                                                                        index]
                                                                        [
                                                                        'picture']
                                                                            .toString()
                                                                            .replaceAll(
                                                                            " ",
                                                                            "%20") +
                                                                            "?alt=media",
                                                                        "Hai "+_con.savePostInfo[index]["name"].toString()+" . I'am interested this item https://saasinfomedia.com/butomy/foodimarket/product/"+
                                                                            _con.savePostInfo[index]["product_id"].toString())));
                                                      } catch (e) {
                                                        print(e
                                                            .message);
                                                      }},
                                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.chat,
                                                          size: 17,
                                                          color: Colors.black,
                                                        ),
                                                        SizedBox(width: 3,),
                                                        Text("Chat",style: f14B,),
                                                      ],
                                                    ),
                                                  ),
                                                ) : Container(height: 0,)
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ) : Container(height: 0,),
                              _con
                                  .savePostInfo[index]["business_type"]
                                  .toString() =="6" ?  SizedBox(height: 5,) : Container(),
                              _con
                                  .savePostInfo[index]["business_type"]
                                  .toString() =="4" ? Padding(
                                padding: const EdgeInsets.only(left:8,right: 8,top: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors
                                              .grey[300],
                                          width: .2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("FREE FOOD ITEM",style: f16wB,),
                                        SizedBox(height: 3,),
                                        Text(_con
                                            .savePostInfo[index]
                                        ['item_name'].toString(),style: f15wB,),
                                        Padding(
                                          padding: const EdgeInsets.only(top:6,bottom: 7),
                                          child: _con
                                              .savePostInfo[index]
                                          ['post_images']
                                              .length >
                                              0 && _con
                                              .savePostInfo[
                                          index]
                                          ['post_images']
                                              .length == 1 && _con
                                              .savePostInfo[index]["business_type"]
                                              .toString() =="4"
                                              ? Container(
                                            height: 300,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: CachedNetworkImage(
                                                imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                    _con.savePostInfo[
                                                    index][
                                                    "post_images"]
                                                    [0]['source']
                                                        .toString()
                                                        .replaceAll(
                                                        " ", "%20") +
                                                    "?alt=media",
                                                fit: BoxFit.cover,
                                                placeholder: (context,
                                                    ind) => Image.asset(
                                                  "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                  fit: BoxFit.cover,)
                                            ),
                                          ) : _con
                                              .savePostInfo[
                                          index]
                                          ['post_images']
                                              .length >
                                              0 && _con
                                              .savePostInfo[
                                          index]
                                          ['post_images']
                                              .length > 1 && _con
                                              .savePostInfo[index]["business_type"]
                                              .toString() =="4" ?
                                          Container(
                                              height: 300.0,
                                              child: new Carousel(
                                                boxFit: BoxFit.fill,
                                                dotColor: Colors.black,
                                                dotSize: 5.5,
                                                autoplay: false,
                                                dotSpacing: 16.0,
                                                dotIncreasedColor: Color(
                                                    0xFF48c0d8),
                                                dotBgColor: Colors
                                                    .transparent,
                                                showIndicator: true,
                                                overlayShadow: true,
                                                overlayShadowColors: Colors
                                                    .white
                                                    .withOpacity(0.2),
                                                overlayShadowSize: 0.9,
                                                images: _con
                                                    .savePostInfo[
                                                index]
                                                ['post_images'].map((
                                                    item) {
                                                  return new CachedNetworkImage(
                                                    placeholder: (context,
                                                        ind) =>
                                                        Image.asset(
                                                          "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                          fit: BoxFit
                                                              .cover,),
                                                    imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                        item['source']
                                                            .toString()
                                                            .replaceAll(
                                                            " ", "%20") +
                                                        "?alt=media",
                                                    imageBuilder: (
                                                        context,
                                                        imageProvider) =>
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit
                                                                  .cover,
                                                            ),
                                                          ),
                                                        ),
                                                  );
                                                }).toList(),
                                              ))
                                              : Container(height: 0,),
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.location_on,color: Colors.grey,size: 18,),
                                                Text(_con
                                                    .savePostInfo[
                                                index]
                                                ['item_distance'].toString()+" km Away",style: f15w,)
                                              ],
                                            ),
                                            userid.toString()!= _con
                                                .savePostInfo[
                                            index]
                                            ['user_id'].toString() ?  Padding(
                                              padding: const EdgeInsets.only(bottom:4.0,top: 4),
                                              child: Container(height: 30,
                                                child: MaterialButton(
                                                  splashColor: Color(0xFFffd55e),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          6)
                                                  ),
                                                  height: 30,
                                                  minWidth: 150,
                                                  color: Color(
                                                      0xFF48c0d9),
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => FoodBankRequestForm(
                                                          prod_id: _con
                                                              .savePostInfo[
                                                          index]
                                                          ['product_id'].toString(),
                                                          title: _con
                                                              .savePostInfo[
                                                          index]
                                                          ['item_name'].toString(),
                                                          owner_devicetoken: _con
                                                              .savePostInfo[
                                                          index]
                                                          ['device_token'].toString(),
                                                          owner_username: _con
                                                              .savePostInfo[
                                                          index]
                                                          ['username'].toString(),
                                                          owner_id: _con
                                                              .savePostInfo[
                                                          index]
                                                          ['timeline_parent_id'].toString(),
                                                          owner: _con
                                                              .savePostInfo[
                                                          index]
                                                          ['name'].toString(),pic: _con
                                                            .savePostInfo[
                                                        index]
                                                        ['post_images'][0]["source"].toString(),
                                                          post_id: _con
                                                              .savePostInfo[
                                                          index]
                                                          ['id'].toString(),owner_pic: _con
                                                            .savePostInfo[
                                                        index]
                                                        ['picture']+"?alt=media",pickup: _con
                                                            .savePostInfo[
                                                        index]
                                                        ['pickup_time'],
                                                        )
                                                    ));
                                                  },
                                                  child: Center(child: Text("Request This",style: f15B,)),
                                                ),
                                              ),
                                            ) : Container(height: 0,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ) : Container(height: 0,),
                              _con.savePostInfo[index]
                              ['post_title'] != null ? Padding(
                                padding: const EdgeInsets.only(left: 6, right: 6, bottom: 8, top: 3),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>BlogDetailPage(
                                          video_id: _con.savePostInfo[index]["youtube_video_id"],
                                          video_title: _con.savePostInfo[index]["youtube_title"],
                                          id: _con.savePostInfo[index]["id"].toString(),
                                          blogList:  [],
                                          imageList: _con.savePostInfo[index]["post_images"],
                                          title: _con.savePostInfo[index]["post_title"],
                                          desc: _con.savePostInfo[index]['description'],
                                          date: _con.savePostInfo[index]['created_at']['date'].toString(),
                                          views: "1.3k",
                                          comments: _con.savePostInfo[index]["comments_count"].toString(),
                                          likes: _con.savePostInfo[index]["likes_count"],
                                          shares: _con.savePostInfo[index]["share_count"].toString(),
                                          saveStatus: _con.savePostInfo[index]["save_status"],
                                          likeStatus: _con.savePostInfo[index]["like_status"],
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
                                        width: width,
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: width-165,
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    _con.savePostInfo[index]["post_title"],
                                                    style: f16wB,maxLines: 2,overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text( _con.savePostInfo[index]
                                                  ['description'],style: f13w,maxLines: 3,overflow: TextOverflow.ellipsis,),

                                                  /* _con.savePostInfo[index]
                                                              ['description'] !=
                                                                  "" && _con.savePostInfo[index]
                                                              ['description'] != null && _con.savePostInfo[index]
                                                              ['description'].length > 85 && *//*textSpan==false &&*//* _showml[index]==false ?
                                                              SmartText(
                                                                text:
                                                                _con
                                                                    .savePostInfo[index]['description'].substring(0, 85,) + " .....",
                                                                style: f13w,
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
                                                              ) : _con.savePostInfo[index]
                                                              ['description'].length > 85*//* &&
                                     textSpan == true*//* && _showml[index]==true?
                                                              SmartText(
                                                                text:
                                                                _con
                                                                    .savePostInfo[index]['description'],
                                                                style: f13w,
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
                                                              ) : _con.savePostInfo[index]
                                                              ['description'].length <= 85 ?  SmartText(
                                                                text:
                                                                _con
                                                                    .savePostInfo[index]['description'],
                                                                style: f13w,
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
                                                              ) : Container(),*/

                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Posted "+d.toString(),style: f13w,),
                                                      Row(
                                                        children: [
                                                          Image.asset("assets/Template1/image/Foodie/icons/eye.png",height: 15,width: 15,),
                                                          SizedBox(width: 4,),
                                                          Text("1.3K Views",style: f13b,)
                                                        ],
                                                      )
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text("Blog By  ",style: f14w,),
                                                      Text(_con
                                                          .savePostInfo[index]['name'],style: f14yB,),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            _con
                                                .savePostInfo[index]
                                            ['post_images']
                                                .length >
                                                0 ? Stack(alignment: Alignment.bottomRight,
                                              children: [
                                                Container(clipBehavior: Clip.antiAlias,
                                                  width: 120,
                                                  height: 132,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(2)
                                                  ),
                                                  child: CachedNetworkImage(
                                                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          _con.savePostInfo[
                                                          index][
                                                          "post_images"]
                                                          [0]['source']
                                                              .toString()
                                                              .replaceAll(" ", "%20") +
                                                          "?alt=media",
                                                      fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                                  ),
                                                ),
                                                userid.toString()== _con.savePostInfo[index]["user_id"].toString() &&
                                                    _con.savePostInfo[index]["post_type"].toString() =="user" ?
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: Center(
                                                    child: Container(
                                                      height: 33,
                                                      width: 33,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius: BorderRadius.circular(100)
                                                      ),
                                                      child: Center(child: Image.asset("assets/Template1/image/Foodie/icons/edit.png",color: Colors.white,height:15,width: 15,)),
                                                    ),
                                                  ),
                                                ) : Container(height: 0,)
                                              ],
                                            ) : Container(height: 0,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ) : Container(height:0),
                              _con
                                  .savePostInfo[index]["business_type"]
                                  .toString() !="6" && _con.savePostInfo[index]
                              ['post_title'] == null ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5),
                                child:
                                _con.savePostInfo[
                                index]['url_image'] != "" &&
                                    _con.savePostInfo[
                                    index]['url_image'] != null && _con
                                    .savePostInfo[index]["business_type"]
                                    .toString() !="4"
                                    ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                WebViewContainer(
                                                  url: _con
                                                      .savePostInfo[
                                                  index]['url_link'],)
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets
                                        .all(5.0),
                                    child: Container(

                                      color: Colors.grey[800],
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .stretch,
                                        children: [
                                          CachedNetworkImage(
                                              imageUrl:
                                              _con
                                                  .savePostInfo[
                                              index][
                                              "url_image"]
                                                  .toString(),
                                              fit: BoxFit
                                                  .cover,
                                              placeholder: (
                                                  context,
                                                  ind) =>
                                                  Image.asset(
                                                    "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                    fit: BoxFit
                                                        .cover,)
                                          ),
                                          Padding(
                                            padding: const EdgeInsets
                                                .only(top: 5,
                                                bottom: 5,
                                                left: 8,
                                                right: 8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(_con
                                                    .savePostInfo[
                                                index][
                                                "url_site"]
                                                    .toString(),
                                                  style: f14w,),
                                                SizedBox(
                                                  height: 4,),
                                                Text(_con
                                                    .savePostInfo[
                                                index][
                                                "url_title"]
                                                    .toString(),
                                                  style: f14w,),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                    :
                                _con
                                    .savePostInfo[index]
                                ['post_images']
                                    .length >
                                    0 && _con
                                    .savePostInfo[
                                index]
                                ['post_images']
                                    .length == 1 && _con
                                    .savePostInfo[index]["business_type"]
                                    .toString() !="4"
                                    ? GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => GalleryScreen(ImageList: _con.savePostInfo[index]['post_images'],)
                                    ));
                                  },
                                  child: Container(
                                    height: 350,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    child: CachedNetworkImage(
                                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                            _con.savePostInfo[
                                            index][
                                            "post_images"]
                                            [0]['source']
                                                .toString()
                                                .replaceAll(
                                                " ", "%20") +
                                            "?alt=media",
                                        fit: BoxFit.cover,
                                        placeholder: (context,
                                            ind) => Image.asset(
                                          "assets/Template1/image/Foodie/post_dummy.jpeg",
                                          fit: BoxFit.cover,)
                                    ),
                                  ),
                                ) : _con
                                    .savePostInfo[
                                index]
                                ['post_images']
                                    .length >
                                    0 && _con
                                    .savePostInfo[
                                index]
                                ['post_images']
                                    .length > 1 && _con
                                    .savePostInfo[index]["business_type"]
                                    .toString() !="4" ?
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => GalleryScreen(ImageList: _con.savePostInfo[index]['post_images'],)
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
                                        dotBgColor: Colors
                                            .transparent,
                                        showIndicator: true,
                                        overlayShadow: true,
                                        overlayShadowColors: Colors
                                            .white
                                            .withOpacity(0.2),
                                        overlayShadowSize: 0.9,
                                        images: _con
                                            .savePostInfo[
                                        index]
                                        ['post_images'].map((
                                            item) {
                                          return new CachedNetworkImage(
                                            placeholder: (context,
                                                ind) =>
                                                Image.asset(
                                                  "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                  fit: BoxFit
                                                      .cover,),
                                            imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                item['source']
                                                    .toString()
                                                    .replaceAll(
                                                    " ", "%20") +
                                                "?alt=media",
                                            imageBuilder: (
                                                context,
                                                imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit
                                                          .cover,
                                                    ),
                                                  ),
                                                ),
                                          );
                                        }).toList(),
                                      )),
                                )
                                    :
                                _con.savePostInfo[
                                index][
                                "youtube_video_id"]
                                    .toString()
                                    .length == 11 &&
                                    _con.savePostInfo[
                                    index]["youtube_video_id"] !=
                                        null && _con
                                    .savePostInfo[index]["business_type"]
                                    .toString() !="4"
                                    ?
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (
                                                    context) =>
                                                    WebViewContainer(
                                                      url: 'https://www.youtube.com/watch?v=' +
                                                          _con
                                                              .savePostInfo[index]
                                                          ['youtube_video_id']
                                                              .toString(),)
                                            ));
                                      },
                                      child: Stack(
                                        alignment: Alignment
                                            .center,
                                        children: [
                                          CachedNetworkImage(
                                              imageUrl: "https://img.youtube.com/vi/" +
                                                  _con
                                                      .savePostInfo[
                                                  index][
                                                  "youtube_video_id"]
                                                      .toString() +
                                                  "/0.jpg",
                                              height: 200,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                              placeholder: (
                                                  context,
                                                  ind) =>
                                                  Image.asset(
                                                    "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                    fit: BoxFit
                                                        .cover,)
                                          ),
                                          Image.asset(
                                            "assets/Template1/image/Foodie/icons/youtube.png",
                                            height: 32,
                                            width: 32,
                                          )
                                        ],
                                      ),
                                    ),
                                    _con.savePostInfo[index]
                                    ['youtube_title'].length >
                                        130 && /*textSpan==false &&*/
                                        _showutube[index] ==
                                            false ?
                                    Padding(
                                      padding: const EdgeInsets
                                          .only(left: 8.0,
                                          right: 8,
                                          top: 5,
                                          bottom: 2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          SmartText(
                                            text:
                                            _con
                                                .savePostInfo[index]['youtube_title']
                                                .substring(
                                              0, 130,) + " ...",
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
                                          ),
                                          SizedBox(height: 3,),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  textSpan =
                                                  true;
                                                  _showutube[index] =
                                                  true;
                                                });
                                              },
                                              child: Text(
                                                "Show more...",
                                                style: f14p,)),
                                          SizedBox(height: 2,),
                                        ],
                                      ),
                                    ) : _con
                                        .savePostInfo[index]
                                    ['youtube_title'].length >
                                        130 /* &&
                            textSpan == true*/ && _showutube[index] == true
                                        ?
                                    Padding(
                                      padding: const EdgeInsets
                                          .only(left: 8.0,
                                          right: 8,
                                          top: 5,
                                          bottom: 2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          SmartText(
                                            text:
                                            _con
                                                .savePostInfo[index]['youtube_title'],
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
                                          ),
                                          SizedBox(height: 3,),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  textSpan =
                                                  false;
                                                  _showutube[index] =
                                                  false;
                                                });
                                              },
                                              child: Text(
                                                "Show less...",
                                                style: f14p,)),
                                          SizedBox(height: 2,),
                                        ],
                                      ),
                                    )
                                        : _con
                                        .savePostInfo[index]
                                    ['youtube_title'].length <=
                                        130 ? Padding(
                                      padding: const EdgeInsets
                                          .only(left: 8.0,
                                          right: 8,
                                          top: 5,
                                          bottom: 2),
                                      child: SmartText(
                                        text:
                                        _con
                                            .savePostInfo[index]['youtube_title'],
                                        style: TextStyle(
                                          color: Colors.white,
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
                                        onUserTagClick: (tag) {
                                          _con.getUseranametoId(context,
                                              tag.toString()
                                                  .replaceFirst(
                                                  "@", ""));
                                        },
                                      ),
                                    ) : Container(),
                                  ],
                                ) : _con.savePostInfo[index]
                                ["youtube_video_id"]
                                    .toString()
                                    .length != 11 &&
                                    _con.savePostInfo[
                                    index][
                                    "youtube_video_id"] !=
                                        null && _con
                                    .savePostInfo[index]["business_type"]
                                    .toString() !="4" ?
                                Container(
                                  alignment: Alignment.center,
                                  child: VideoWidget(
                                    url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                        _con
                                            .savePostInfo[index]['youtube_video_id']
                                            .toString()
                                            .replaceAll(
                                            " ", "%20") +
                                        "?alt=media",
                                    play: true,),
                                )
                                    : Container(
                                  height: 0,
                                ),
                              ) : Container(height: 0,),
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
                                                      .savePostInfo[
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
                                                  _con
                                                      .savePostInfo[
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
                                                      .savePostInfo[
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
                                                _con
                                                    .getTimelineWall(
                                                    userid
                                                        .toString());
                                              },
                                              child: Text(
                                                  _con
                                                      .savePostInfo[
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
                                                      .savePostInfo[
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
                                                  _con
                                                      .savePostInfo[
                                                  index]
                                                  [
                                                  'share_count']
                                                      .toString() +
                                                      " Shares",
                                                  style: f14y),
                                            )
                                          ],
                                        ),
                                        _con
                                            .savePostInfo[index]["product_id"] !=
                                            null && _con
                                            .savePostInfo[index]["business_type"]
                                            .toString() !="4" && _con
                                            .savePostInfo[index]["business_type"]
                                            .toString() !="6" ? Row(
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _con
                                                        .AddtoPurchaseList(
                                                        userid
                                                            .toString(),
                                                        _con
                                                            .savePostInfo[index]['product_id']
                                                            .toString(),
                                                        _con
                                                            .savePostInfo[index]['business_type']
                                                            .toString(),
                                                        "1",
                                                        _con
                                                            .savePostInfo[index]['item_price']
                                                            .toString(),
                                                        _con
                                                            .savePostInfo[index]['business_page_id']
                                                            .toString());
                                                    setState(() {
                                                      splashcolor[index] =
                                                      true;
                                                    });
                                                  },

                                                  child: Image
                                                      .asset(
                                                    "assets/Template1/image/Foodie/icons/shopping-basket.png",
                                                    height: 24,
                                                    width: 24,
                                                    color: splashcolor[index]
                                                        ? Color(
                                                        0xFF48c0d8)
                                                        : Color(
                                                        0xFFffd55e),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  height: 27,
                                                  child: MaterialButton(
                                                    splashColor: _con.savePostInfo[index]['placeorder_type']
                                                        .toString()=="0" ? Color(0xFF48c0d8) : Color(0xFFffd55e),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(6)
                                                    ),
                                                    height: 27,
                                                    minWidth: 80,
                                                    color:_con.savePostInfo[index]['placeorder_type']
                                                        .toString()=="0" ?  Color(0xFFffd55e) : Color(0xFF0dc89e),

                                                    onPressed: (){
                                                      if(_con
                                                          .savePostInfo[index]['placeorder_type']
                                                          .toString()=="0")
                                                      { _con
                                                          .buyNow(context,
                                                          userid.toString(),
                                                          _con.savePostInfo[index]['product_id'].toString(),
                                                          _con.savePostInfo[index]['business_type'].toString(),
                                                          "1",
                                                          _con
                                                              .savePostInfo[index]['item_price'],
                                                          _con
                                                              .savePostInfo[index]['business_page_id']
                                                              .toString(),_con.savePostInfo[index]["item_name"],
                                                          1,_con.savePostInfo[index]["business_name"],_con.savePostInfo[index]["business_address"]);
                                                        /*  showClearDialog == true ?  showModalBottomSheet(
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
                                                                               BuildContext context, StateSetter state) {
                                                                             return Padding(
                                                                               padding: const EdgeInsets.only( top: 10,),
                                                                               child: Wrap(
                                                                                 children: [

                                                                                   Padding(
                                                                                     padding: const EdgeInsets.only(top:10.0),
                                                                                     child: GestureDetector(

                                                                                       child: Container(
                                                                                         height: 47,
                                                                                         width: width,
                                                                                         color: Color(0xFFffd55e),
                                                                                         child: Center(child: Text("Proceed To Cart",style: f16B,)),
                                                                                       ),
                                                                                     ),
                                                                                   )


                                                                                 ],
                                                                               ),
                                                                             );
                                                                           });
                                                                     }) : null;*/
                                                      }
                                                      if(_con
                                                          .savePostInfo[index]['placeorder_type']
                                                          .toString()=="1")
                                                      {
                                                        setState(() {
                                                          selectedDate = DateTime.now().add(Duration(days: 1));
                                                          listDate = selectedDate.toString().split(" ");
                                                          selectedTime = TimeOfDay.now();
                                                          quantity = 1;
                                                          total = _con
                                                              .savePostInfo[index]['item_price'];
                                                          sel_ind = index;
                                                          var a =selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString().split(":");
                                                          print("dfgh "+a.toString());
                                                          if(int.parse(a[0])<=12)
                                                            timeF="am";
                                                          else
                                                            timeF="pm";
                                                        });
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
                                                                      BuildContext context, sss.StateSetter state) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets.only( top: 10,),
                                                                      child: Wrap(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 12, right: 12,bottom: 5),
                                                                            child: Row(
                                                                              children: [
                                                                                Image.asset("assets/Template1/image/Foodie/icons/meal.png",
                                                                                  height: 30,width: 30,color: Colors.white,),
                                                                                SizedBox(width: 10,),
                                                                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text("Pre Order Scheduled On",style: f16wB,),
                                                                                    SizedBox(height: 3,),
                                                                                    Text(DateFormat.yMMMEd().format(selectedDate).toString()+", "+
                                                                                        selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString(),style: f12w,)
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 12, right: 12,bottom: 5,top: 5),
                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: (){
                                                                                    _selectDate(context,state);
                                                                                    // Navigator.pop(context);
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 30,
                                                                                    width: 120,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color(0xFF0dc89e),
                                                                                        borderRadius: BorderRadius.circular(8)
                                                                                    ),
                                                                                    child: Center(child: Text("Change Schedule",style: f14B,)),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(top: 5,bottom: 5),
                                                                            child: Container(
                                                                              color: Color(0xFF23252E),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(12.0),
                                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text("Item to Order",style: f16wB,),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 10,bottom: 5),
                                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Row(
                                                                                            children: [
                                                                                              _con
                                                                                                  .savePostInfo[index]
                                                                                              ['post_images']
                                                                                                  .length > 0 ?  Container(
                                                                                                height: 60.0,
                                                                                                width: 60.0,
                                                                                                decoration: BoxDecoration(
                                                                                                    image: DecorationImage(
                                                                                                        image: CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                                                            _con
                                                                                                                .savePostInfo[index]
                                                                                                            ['post_images'][0]["source"]+"?alt=media"),
                                                                                                        fit: BoxFit.cover)),
                                                                                              ) : Container(),
                                                                                              SizedBox(width: 7,),
                                                                                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(_con
                                                                                                      .savePostInfo[index]['item_name'].toString().length>14 ?
                                                                                                  _con
                                                                                                      .savePostInfo[index]['item_name'].toString().substring(0,14)+"..." :
                                                                                                  _con
                                                                                                      .savePostInfo[index]['item_name'].toString(), style: f15wB),
                                                                                                  SizedBox(height: 3,),
                                                                                                  Text(
                                                                                                    _con
                                                                                                        .savePostInfo[index]
                                                                                                    ['name']
                                                                                                    , style:f14wB,),
                                                                                                  SizedBox(height: 3,),
                                                                                                  Text("\u20B9 "+
                                                                                                      _con
                                                                                                          .savePostInfo[index]['item_price'].toString(), style:f14wB,),
                                                                                                ],
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          Container(
                                                                                            width: 112.0,
                                                                                            decoration:
                                                                                            BoxDecoration(
                                                                                                color: Color(
                                                                                                    0xFF1E2026)),
                                                                                            child: Row(
                                                                                              mainAxisAlignment:
                                                                                              MainAxisAlignment
                                                                                                  .spaceAround,
                                                                                              children: <Widget>[
                                                                                                /// Decrease of value item
                                                                                                InkWell(
                                                                                                  onTap: () {
                                                                                                    state(() {
                                                                                                      quantity = quantity - 1;
                                                                                                      quantity = quantity > 0 ? quantity : 0;

                                                                                                      total = quantity* _con
                                                                                                          .savePostInfo[index]['item_price'];
                                                                                                    });
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 30.0,
                                                                                                    width: 30.0,
                                                                                                    decoration:
                                                                                                    BoxDecoration(
                                                                                                      color: Color(
                                                                                                          0xFF1E2026),
                                                                                                    ),
                                                                                                    child: Center(
                                                                                                        child: Text(
                                                                                                          "-",
                                                                                                          style: TextStyle(
                                                                                                              color: Colors
                                                                                                                  .white,
                                                                                                              fontWeight:
                                                                                                              FontWeight
                                                                                                                  .w800,
                                                                                                              fontSize:
                                                                                                              16.0),
                                                                                                        )),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets
                                                                                                      .symmetric(
                                                                                                      horizontal:
                                                                                                      18.0),
                                                                                                  child: Text(
                                                                                                    quantity.toString(),
                                                                                                    style: TextStyle(
                                                                                                        color: Colors
                                                                                                            .white,
                                                                                                        fontWeight:
                                                                                                        FontWeight
                                                                                                            .w500,

                                                                                                        fontSize:
                                                                                                        16.0),
                                                                                                  ),
                                                                                                ),

                                                                                                /// Increasing value of item
                                                                                                InkWell(
                                                                                                  onTap: () {
                                                                                                    state(() {
                                                                                                      quantity = quantity + 1;
                                                                                                      total = quantity* _con
                                                                                                          .savePostInfo[index]['item_price'];
                                                                                                    });
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 30.0,
                                                                                                    width: 28.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                        color: Color(
                                                                                                            0xFF1E2026)),
                                                                                                    child: Center(
                                                                                                        child: Text(
                                                                                                          "+",
                                                                                                          style: TextStyle(
                                                                                                              color: Colors
                                                                                                                  .white,
                                                                                                              fontWeight:
                                                                                                              FontWeight
                                                                                                                  .w500,
                                                                                                              fontSize:
                                                                                                              16.0),
                                                                                                        )),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(top:10.0),
                                                                            child: GestureDetector(
                                                                              onTap: (){
                                                                                _con.Preorder(context,userid.toString(),_con
                                                                                    .savePostInfo[index]['product_id']
                                                                                    .toString().toString(),_con
                                                                                    .savePostInfo[index]["business_type"]
                                                                                    .toString(),quantity.toString(),_con
                                                                                    .savePostInfo[index]['item_price']
                                                                                    .toString(),
                                                                                    _con
                                                                                        .savePostInfo[index]['business_page_id']
                                                                                        .toString(),listDate[0].toString(),
                                                                                    selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString(),
                                                                                    _con.savePostInfo[index]["item_name"],
                                                                                    1,_con.savePostInfo[index]["business_name"],_con.savePostInfo[index]["business_address"]
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                height: 47,
                                                                                width: width,
                                                                                color: Color(0xFFffd55e),
                                                                                child: Center(child: Text("Proceed To Cart",style: f16B,)),
                                                                              ),
                                                                            ),
                                                                          )


                                                                        ],
                                                                      ),
                                                                    );
                                                                  });
                                                            });
                                                      }
                                                    },
                                                    child: _con
                                                        .savePostInfo[index]['placeorder_type']
                                                        .toString()!="" ? Center(
                                                        child: Text(
                                                          _con
                                                              .savePostInfo[index]['placeorder_type']
                                                              .toString()=="0" ?
                                                          "Buy Now" : "Pre Order",
                                                          style: f14B,)) : Container(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,)
                                              ],
                                            ),
                                          ],
                                        ) : Container()
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
                                              true /*|| _con
                                                              .savePostInfo[
                                                          index]
                                                          [
                                                          'like_status'] == true*/
                                              ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                postid = _con
                                                    .savePostInfo[
                                                index]
                                                [
                                                'id']
                                                    .toString();
                                                _likes[index] =
                                                false;
                                                _con
                                                    .savePostInfo[index]['like_status'] =
                                                false;
                                                _con
                                                    .savePostInfo[index]['likes_count'] =
                                                    _con
                                                        .savePostInfo[index]['likes_count'] -
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
                                                    .savePostInfo[
                                                index]
                                                [
                                                'id']
                                                    .toString();
                                                _likes[index] =
                                                true;
                                                _con
                                                    .savePostInfo[index]['like_status'] =
                                                true;
                                                _con
                                                    .savePostInfo[index]['likes_count'] =
                                                    _con
                                                        .savePostInfo[index]['likes_count'] +
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
                                                    .savePostInfo[
                                                index]
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
                                                postid = _con
                                                    .savePostInfo[
                                                index]
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
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                postid = _con.savePostInfo[index]["id"].toString();});
                                              _con.saveTimelinePost(postid.toString(),userid.toString());
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Remove",
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
                        Divider(
                          thickness: 7,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ) :
            _con.statusSavedPost == false ? Center(child: Padding(
              padding: const EdgeInsets.only(top:250.0),
              child: Text("No Posts",style: f16wB,),
            )):Container(height: 0,),
          ],
        ));
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

/* GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    postid = _con.savePostInfo[index]["id"].toString();});
                                                  _con.saveTimelinePost(postid.toString(),userid.toString());
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Remove",
                                                      style: f14w,
                                                    ),
                                                  ],
                                                ),
                                              )*/