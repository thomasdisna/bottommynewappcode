import 'dart:async';

import 'package:Butomy/Screen/Template1/B1_Home_Screen/edit_post.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/rendering.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Screen/Template1/B1_Home_Screen/ANOTHERPERSON/wall_web_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/kitchen_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/restaurant_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/store_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/photos_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/video_widget.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Components/global_data.dart';
import '../../../../Controllers/TimelineController/timelineWallController.dart';
import '../comments.dart';
import '../hashtag_search_page.dart';
import '../like_comment_share_count_page.dart';
import '../share_post_page.dart';
import '../timeline_food_wall_detail_page.dart';
var pic_url;
var e;
DateTime _date2;
var d2;
var textSpan;
var dataUser;
var sharePost;
var UserIdprefs;
var timedata;
DateTime _date;
var d;
var postImage;
var postDesc;
bool _isSearching;
String _searchText = "";
class searchAppbar extends StatefulWidget {
  @override
  _searchAppbarState createState() => _searchAppbarState();
}

class _searchAppbarState extends StateMVC<searchAppbar>
    with SingleTickerProviderStateMixin {
  List<bool> _follow = List.filled(100,false);
  List<bool> foodi_follow = List.filled(100,false);
  List<bool> res_follow = List.filled(100,false);
  List<bool> kit_follow = List.filled(100,false);
  List<bool> sto_follow = List.filled(100,false);
  TextEditingController _search = TextEditingController();

  TimelineWallController _con;
  List<bool> _showutube = List.filled(1000, false);
  List<bool> _showSharedutube = List.filled(1000, false);
  List<bool> _showml = List.filled(1000, false);
  List<bool> _sharedshowml = List.filled(1000, false);

  _searchAppbarState() : super(TimelineWallController()) {
    _con = controller;
  }

  SlidingUpPanelController panelController = SlidingUpPanelController();
  ScrollController scrollController;

  @override
  void initState() {
    contrrooo=ScrollController();
    setState(() {textSpan = false;});
    // TODO: implement initState
    super.initState();
    _isSearching = false;

    _tabContoller = TabController(length: 8, vsync: this);
    _tabContoller.addListener(_handleTabSelection);
  }

  _postUpdate() async{
    Timer(Duration(seconds: 2),(){
      _con.getTimelinesearch(_search.text);
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  TabController _tabContoller;
  bool typing = false;

  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post',
          sharePost, 'text/plain');
    } catch (e) {
      //print('error: $e');
    }
  }

  void searchOperation(String searchText) {
    print("searchh 111111111111 ");
    setState(() {
      _isSearching = true;
    });
    _con.getTimelinesearch(_search.text);
  }
  ScrollController contrrooo;

  @override
  Widget build(BuildContext context) {
    // _con.getFollowing(userid);

    _search.addListener(() {
      if (_search.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _search.text;
        });
      }
    });
    var _tabModules = Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 7),
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
                child: Container(
                  height: 40,
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
                            "All",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Foodi",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Home Kitchen",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Local Store",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Foodi Market",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Restaurant",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Food Bank",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    preferredSize: Size.fromHeight(100),
                  ),
                ),
              ),
              Expanded(
                // height: MediaQuery.of(context).size.height - 127,
                child: TabBarView(
                  controller: _tabContoller,
                  children: <Widget>[
                    //tab 0
                     SingleChildScrollView(
                       child: _con.SEARCHARRAY != null ? Column(mainAxisSize: MainAxisSize.min,
                           children: [
                             _con.searchFOODIS.length>0 ? Container(
                               height: _con.searchFOODIS.length.toDouble() * 55,
                               child: ListView.builder(
                                 physics: NeverScrollableScrollPhysics(),
                                   scrollDirection: Axis.vertical,
                                   itemCount: _con.searchFOODIS.length,
                                   itemBuilder: (BuildContext context, int index) {
                                     _con.searchFOODIS[index]['follow_status'] == true ? foodi_follow[index]=true : foodi_follow[index] = false;
                                     return Padding(
                                         padding: EdgeInsets.only(
                                             left: 10.0, right: 5.0, top: 12, bottom: 12),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             GestureDetector(
                                               onTap: (){
                                                 Navigator.push(
                                                     context,
                                                     MaterialPageRoute(
                                                         builder: (context) => TimelineFoodWallDetailPage(
                                                           id: _con.searchFOODIS[index]['user_id'].toString(),
                                                         )));
                                               },
                                               child: Row(
                                                 children: <Widget>[
                                                   GestureDetector(
                                                     onTap:(){
                                                       showDialog(
                                                           context: context,
                                                           builder: (context) =>
                                                               AlertDialog(
                                                                 backgroundColor: Color(
                                                                     0xFF1E2026),
                                                                 content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                                   imageUrl: _con
                                                                       .searchFOODIS[index]["profile_image"]
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
                                                       child: CircleAvatar(
                                                         radius: 16,
                                                         backgroundImage: CachedNetworkImageProvider(
                                                           _con.searchFOODIS[index]['profile_image'].toString().replaceAll(" ", "%20")+"?alt=media",),
                                                       ),
                                                     ),
                                                   ),
                                                   SizedBox(
                                                     width: 10,
                                                   ),
                                                   Container(
                                                     child: Column(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: <Widget>[
                                                         Text(
                                                           _con.searchFOODIS[index]['name'],
                                                           style: f14wB,
                                                         ),

                                                       ],
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             _con.searchFOODIS[index]['user_id'].toString()!=userid.toString() &&foodi_follow[index]==true ?
                                             GestureDetector(
                                                 onTap: () {
                                                   showDialog(
                                                       context: context,
                                                       builder: (BuildContext context) {
                                                         return AlertDialog(
                                                           backgroundColor:
                                                           Color(0xFF1E2026),
                                                           content: new Text(
                                                             "Do you want to Unfollow " +
                                                                 _con.searchFOODIS[index]
                                                                 ["name"]
                                                                     .toString() +
                                                                 " ?",
                                                             style: f14w,
                                                           ),
                                                           actions: <Widget>[
                                                             MaterialButton(
                                                               height: 28,
                                                               color: Color(0xFFffd55e),
                                                               child: new Text(
                                                                 "Cancel",
                                                                 style: TextStyle(
                                                                     color:
                                                                     Colors.black),
                                                               ),
                                                               onPressed: () {
                                                                 Navigator.pop(
                                                                     context, 'Cancel');
                                                               },
                                                             ),
                                                             MaterialButton(
                                                               height: 28,
                                                               color: Color(0xFF48c0d8),
                                                               child: new Text(
                                                                 "Unfollow",
                                                                 style: TextStyle(
                                                                     color:
                                                                     Colors.black),
                                                               ),
                                                               onPressed: () {
                                                                 /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                                 setState(() {
                                                                  
                                                                   foodi_follow[index] = false;
                                                                   _con.searchFOODIS[index]['follow_status'] = false;
                                                                 });
                                                                 _con.followerController(
                                                                     userid.toString(),
                                                                     _con.searchFOODIS[index]['user_id']
                                                                         .toString());
                                                                 Navigator.pop(context);
                                                               },
                                                             ),
                                                           ],
                                                         );
                                                       });

                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 8),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Color(0xFF48c0d8),
                                                         borderRadius: BorderRadius.circular(5)),
                                                     height: 25,
                                                     width: 85,
                                                     child:Center(
                                                       child: Text(
                                                         "Unfollow",
                                                         style: f14B,
                                                       ),
                                                     ),
                                                   ),
                                                 )):
                                             _con.searchFOODIS[index]['user_id'].toString()!=userid.toString() &&foodi_follow[index]==false ? GestureDetector(
                                                 onTap: () {
                                                   setState(() {
                                                    
                                                     foodi_follow[index] = true;
                                                     _con.searchFOODIS[index]['follow_status'] = true;
                                                   });
                                                   _con.followerController(
                                                       userid.toString(),
                                                       _con.searchFOODIS[index]['user_id']
                                                           .toString());
                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 8),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Color(0xFF48c0d8),
                                                         borderRadius: BorderRadius.circular(5)),
                                                     height: 25,
                                                     width: 85,
                                                     child:Center(
                                                       child: Text(
                                                         "Follow",
                                                         style: f14B,
                                                       ),
                                                     ),
                                                   ),
                                                 )) :Container(height: 0,)
                                           ],
                                         ));
                                   }),
                             ) : Container(height: 0,),
                             _con.searchKITCHEN.length>0 ? Container(
                               height: _con.searchKITCHEN.length.toDouble() * 55,
                               child: ListView.builder(
                                   physics: NeverScrollableScrollPhysics(),
                                   scrollDirection: Axis.vertical,
                                   itemCount: _con.searchKITCHEN.length,
                                   itemBuilder: (BuildContext context, int index) {
                                     _con.searchKITCHEN[index]['follow_status'] == true ? kit_follow[index]=true : kit_follow[index] = false;
                                     return Padding(
                                         padding: EdgeInsets.only(
                                             left: 10.0, right: 5.0, top: 12, bottom: 12),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             GestureDetector(
                                               onTap: (){
                                                 Navigator.push(context, MaterialPageRoute(
                                                     builder: (context)=>KitchenProf(currentindex: 1,memberdate: "",pagid:  _con.searchKITCHEN[index]['page_id'].toString(),
                                                       timid:  _con.searchKITCHEN[index]['timeline_id'].toString(), )
                                                 ));
                                               },
                                               child: Row(
                                                 children: <Widget>[
                                                   GestureDetector(
                                                     onTap:(){
                                                       showDialog(
                                                           context: context,
                                                           builder: (context) =>
                                                               AlertDialog(
                                                                 backgroundColor: Color(
                                                                     0xFF1E2026),
                                                                 content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                                   imageUrl: _con
                                                                       .searchKITCHEN[index]["profile_image"].toString()!="" ?
                                                                   "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                       .searchKITCHEN[index]["profile_image"]
                                                                       .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                                   "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                                                   height: 250,
                                                                   fit: BoxFit
                                                                       .fitWidth,
                                                                 ),
                                                               ));
                                                     },
                                                     child: Container(
                                                       child: CircleAvatar(
                                                         radius: 16,
                                                         backgroundImage: CachedNetworkImageProvider(
                                                           _con
                                                               .searchKITCHEN[index]["profile_image"].toString()!="" ?
                                                           "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                               .searchKITCHEN[index]["profile_image"]
                                                               .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                           "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",),
                                                       ),
                                                     ),
                                                   ),
                                                   SizedBox(
                                                     width: 10,
                                                   ),
                                                   Container(
                                                     child: Column(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: <Widget>[
                                                         Text(
                                                           _con.searchKITCHEN[index]['name'],
                                                           style: f14wB,
                                                         ),

                                                       ],
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             _con.searchKITCHEN[index]['user_id'].toString()!=userid.toString() &&kit_follow[index]==true ?GestureDetector(
                                                 onTap: () {
                                                   showDialog(
                                                       context: context,
                                                       builder: (BuildContext context) {
                                                         return AlertDialog(
                                                           backgroundColor:
                                                           Color(0xFF1E2026),
                                                           content: new Text(
                                                             "Do you want to Unfollow " +
                                                                 _con.searchKITCHEN[index]
                                                                 ["name"]
                                                                     .toString() +
                                                                 " ?",
                                                             style: f14w,
                                                           ),
                                                           actions: <Widget>[
                                                             MaterialButton(
                                                               height: 28,
                                                               color: Color(0xFFffd55e),
                                                               child: new Text(
                                                                 "Cancel",
                                                                 style: TextStyle(
                                                                     color:
                                                                     Colors.black),
                                                               ),
                                                               onPressed: () {
                                                                 Navigator.pop(
                                                                     context, 'Cancel');
                                                               },
                                                             ),
                                                             MaterialButton(
                                                               height: 28,
                                                               color: Color(0xFF48c0d8),
                                                               child: new Text(
                                                                 "Unfollow",
                                                                 style: TextStyle(
                                                                     color:
                                                                     Colors.black),
                                                               ),
                                                               onPressed: () {
                                                                 /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                                 setState(() {
                                                                  
                                                                   kit_follow[index] = false;
                                                                   _con.searchKITCHEN[index]['follow_status'] = false;
                                                                 });
                                                                 _con.BusinessFollowunFollow(
                                                                   _con.searchKITCHEN[index]['page_id'].toString(),
                                                                   userid.toString(),);
                                                                 Navigator.pop(context);
                                                               },
                                                             ),
                                                           ],
                                                         );
                                                       });

                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 8),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Color(0xFF48c0d8),
                                                         borderRadius: BorderRadius.circular(5)),
                                                     height: 25,
                                                     width: 85,
                                                     child:Center(
                                                       child: Text(
                                                         "Unfollow",
                                                         style: f14B,
                                                       ),
                                                     ),
                                                   ),
                                                 )):
                                             _con.searchKITCHEN[index]['user_id'].toString()!=userid.toString() &&kit_follow[index]==false ? GestureDetector(
                                                 onTap: () {
                                                   setState(() {
                                                    
                                                     kit_follow[index] = true;
                                                     _con.searchKITCHEN[index]['follow_status'] = true;
                                                   });
                                                   _con.followerController(
                                                       userid.toString(),
                                                       _con.searchKITCHEN[index]['user_id']
                                                           .toString());
                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 8),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Color(0xFF48c0d8),
                                                         borderRadius: BorderRadius.circular(5)),
                                                     height: 25,
                                                     width: 85,
                                                     child:Center(
                                                       child: Text(
                                                         "Follow",
                                                         style: f14B,
                                                       ),
                                                     ),
                                                   ),
                                                 )) :Container(height: 0,)
                                           ],
                                         ));
                                   }),
                             ) : Container(height: 0,),
                             _con.searchSTORE.length>0 ?
                             Container(
                               height: _con.searchSTORE.length.toDouble() * 55,
                               child:ListView.builder(
                                   physics: NeverScrollableScrollPhysics(),
                                   scrollDirection: Axis.vertical,
                                   itemCount: _con.searchSTORE.length,
                                   itemBuilder: (BuildContext context, int index) {
                                     _con.searchSTORE[index]['follow_status'] == true ? sto_follow[index]=true : sto_follow[index] = false;
                                     return Padding(
                                         padding: EdgeInsets.only(
                                             left: 10.0, right: 5.0, top: 12, bottom: 12),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             GestureDetector(
                                               onTap: (){
                                                 Navigator.push(context, MaterialPageRoute(
                                                     builder: (context)=>StoreProf(currentindex: 1,memberdate: "",pagid:  _con.searchSTORE[index]['page_id'].toString(),
                                                       timid:  _con.searchSTORE[index]['timeline_id'].toString(), )
                                                 ));
                                               },
                                               child: Row(
                                                 children: <Widget>[
                                                   GestureDetector(
                                                     onTap:(){
                                                       showDialog(
                                                           context: context,
                                                           builder: (context) =>
                                                               AlertDialog(
                                                                 backgroundColor: Color(
                                                                     0xFF1E2026),
                                                                 content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                                   imageUrl: _con
                                                                       .searchSTORE[index]["profile_image"].toString()!="" ?
                                                                   "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                       .searchSTORE[index]["profile_image"]
                                                                       .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                                   "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                                                   height: 250,
                                                                   fit: BoxFit
                                                                       .fitWidth,
                                                                 ),
                                                               ));
                                                     },
                                                     child: Container(
                                                       child: CircleAvatar(
                                                         radius: 16,
                                                         backgroundImage: CachedNetworkImageProvider(
                                                             _con
                                                                 .searchSTORE[index]["profile_image"].toString()!="" ?
                                                             "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                 .searchSTORE[index]["profile_image"]
                                                                 .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                             "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"),
                                                       ),
                                                     ),
                                                   ),
                                                   SizedBox(
                                                     width: 10,
                                                   ),
                                                   Container(
                                                     child: Column(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: <Widget>[
                                                         Text(
                                                           _con.searchSTORE[index]['name'],
                                                           style: f14wB,
                                                         ),

                                                       ],
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             _con.searchSTORE[index]['user_id'].toString()!=userid.toString() &&sto_follow[index]==true ?
                                             GestureDetector(
                                                 onTap: () {
                                                   showDialog(
                                                       context: context,
                                                       builder: (BuildContext context) {
                                                         return AlertDialog(
                                                           backgroundColor:
                                                           Color(0xFF1E2026),
                                                           content: new Text(
                                                             "Do you want to Unfollow " +
                                                                 _con.searchSTORE[index]
                                                                 ["name"]
                                                                     .toString() +
                                                                 " ?",
                                                             style: f14w,
                                                           ),
                                                           actions: <Widget>[
                                                             MaterialButton(
                                                               height: 28,
                                                               color: Color(0xFFffd55e),
                                                               child: new Text(
                                                                 "Cancel",
                                                                 style: TextStyle(
                                                                     color:
                                                                     Colors.black),
                                                               ),
                                                               onPressed: () {
                                                                 Navigator.pop(
                                                                     context, 'Cancel');
                                                               },
                                                             ),
                                                             MaterialButton(
                                                               height: 28,
                                                               color: Color(0xFF48c0d8),
                                                               child: new Text(
                                                                 "Unfollow",
                                                                 style: TextStyle(
                                                                     color:
                                                                     Colors.black),
                                                               ),
                                                               onPressed: () {
                                                                 /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                                 setState(() {
                                                                  
                                                                   sto_follow[index] = false;
                                                                   _con.searchSTORE[index]['follow_status'] = false;
                                                                 });
                                                                 _con.BusinessFollowunFollow(
                                                                   _con.searchSTORE[index]['page_id'].toString(),
                                                                   userid.toString(),);
                                                                 Navigator.pop(context);
                                                               },
                                                             ),
                                                           ],
                                                         );
                                                       });

                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 8),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Color(0xFF48c0d8),
                                                         borderRadius: BorderRadius.circular(5)),
                                                     height: 25,
                                                     width: 85,
                                                     child:Center(
                                                       child: Text(
                                                         "Unfollow",
                                                         style: f14B,
                                                       ),
                                                     ),
                                                   ),
                                                 )):
                                             _con.searchSTORE[index]['user_id'].toString()!=userid.toString() &&sto_follow[index]==false ? GestureDetector(
                                                 onTap: () {
                                                   setState(() {
                                                    
                                                     sto_follow[index] = true;
                                                     _con.searchSTORE[index]['follow_status'] = true;
                                                   });
                                                   _con.followerController(
                                                       userid.toString(),
                                                       _con.searchSTORE[index]['user_id']
                                                           .toString());
                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 8),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Color(0xFF48c0d8),
                                                         borderRadius: BorderRadius.circular(5)),
                                                     height: 25,
                                                     width: 85,
                                                     child:Center(
                                                       child: Text(
                                                         "Follow",
                                                         style: f14B,
                                                       ),
                                                     ),
                                                   ),
                                                 )) :Container(height: 0,)
                                           ],
                                         ));
                                   }),
                             ) : Container(height: 0,),
                             _con.searchRESTAURANT.length>0 ?
                             Container(
                               height: _con.searchRESTAURANT.length.toDouble() * 55,
                               child: ListView.builder(
                                   physics: NeverScrollableScrollPhysics(),
                                   scrollDirection: Axis.vertical,
                                   itemCount: _con.searchRESTAURANT.length,
                                   itemBuilder: (BuildContext context, int index) {
                                     _con.searchRESTAURANT[index]['follow_status'] == true ? res_follow[index]=true : res_follow[index] = false;
                                     return Padding(
                                         padding: EdgeInsets.only(
                                             left: 10.0, right: 5.0, top: 12, bottom: 12),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             GestureDetector(
                                               onTap: (){
                                                 Navigator.push(context, MaterialPageRoute(
                                                     builder: (context)=>RestProf(currentindex: 1,memberdate: "",pagid:  _con.searchRESTAURANT[index]['page_id'].toString(),
                                                       timid:  _con.searchRESTAURANT[index]['timeline_id'].toString(), )
                                                 ));
                                               },
                                               child: Row(
                                                 children: <Widget>[
                                                   GestureDetector(
                                                     onTap:(){
                                                       showDialog(
                                                           context: context,
                                                           builder: (context) =>
                                                               AlertDialog(
                                                                 backgroundColor: Color(
                                                                     0xFF1E2026),
                                                                 content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                                   imageUrl:  _con
                                                                       .searchRESTAURANT[index]["profile_image"].toString()!="" ?
                                                                   "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                       .searchRESTAURANT[index]["profile_image"]
                                                                       .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                                   "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                                                   height: 250,
                                                                   fit: BoxFit
                                                                       .fitWidth,
                                                                 ),
                                                               ));
                                                     },
                                                     child: Container(
                                                       child: CircleAvatar(
                                                         radius: 16,
                                                         backgroundImage: CachedNetworkImageProvider(
                                                             _con
                                                                 .searchRESTAURANT[index]["profile_image"].toString()!="" ?
                                                             "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                 .searchRESTAURANT[index]["profile_image"]
                                                                 .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                             "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"),
                                                       ),
                                                     ),
                                                   ),
                                                   SizedBox(
                                                     width: 10,
                                                   ),
                                                   Container(
                                                     child: Column(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: <Widget>[
                                                         Text(
                                                           _con.searchRESTAURANT[index]['name'],
                                                           style: f14wB,
                                                         ),

                                                       ],
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             _con.searchRESTAURANT[index]['user_id'].toString()!=userid.toString() &&res_follow[index]==true ?
                                             GestureDetector(
                                                 onTap: () {
                                                   showDialog(
                                                       context: context,
                                                       builder: (BuildContext context) {
                                                         return AlertDialog(
                                                           backgroundColor:
                                                           Color(0xFF1E2026),
                                                           content: new Text(
                                                             "Do you want to Unfollow " +
                                                                 _con.searchRESTAURANT[index]
                                                                 ["name"]
                                                                     .toString() +
                                                                 " ?",
                                                             style: f14w,
                                                           ),
                                                           actions: <Widget>[
                                                             MaterialButton(
                                                               height: 28,
                                                               color: Color(0xFFffd55e),
                                                               child: new Text(
                                                                 "Cancel",
                                                                 style: TextStyle(
                                                                     color:
                                                                     Colors.black),
                                                               ),
                                                               onPressed: () {
                                                                 Navigator.pop(
                                                                     context, 'Cancel');
                                                               },
                                                             ),
                                                             MaterialButton(
                                                               height: 28,
                                                               color: Color(0xFF48c0d8),
                                                               child: new Text(
                                                                 "Unfollow",
                                                                 style: TextStyle(
                                                                     color:
                                                                     Colors.black),
                                                               ),
                                                               onPressed: () {
                                                                 /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                                 setState(() {
                                                                  
                                                                   res_follow[index] = false;
                                                                   _con.searchRESTAURANT[index]['follow_status'] = false;
                                                                 });
                                                                 _con.BusinessFollowunFollow(
                                                                   _con.searchRESTAURANT[index]['page_id'].toString(),
                                                                   userid.toString(),);
                                                                 Navigator.pop(context);
                                                               },
                                                             ),
                                                           ],
                                                         );
                                                       });

                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 8),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Color(0xFF48c0d8),
                                                         borderRadius: BorderRadius.circular(5)),
                                                     height: 25,
                                                     width: 85,
                                                     child:Center(
                                                       child: Text(
                                                         "Unfollow",
                                                         style: f14B,
                                                       ),
                                                     ),
                                                   ),
                                                 )):
                                             _con.searchRESTAURANT[index]['user_id'].toString()!=userid.toString() &&res_follow[index]==false ? GestureDetector(
                                                 onTap: () {
                                                   setState(() {
                                                    
                                                     res_follow[index] = true;
                                                     _con.searchRESTAURANT[index]['follow_status'] = true;
                                                   });
                                                   _con.followerController(
                                                       userid.toString(),
                                                       _con.searchRESTAURANT[index]['user_id']
                                                           .toString());
                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 8),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Color(0xFF48c0d8),
                                                         borderRadius: BorderRadius.circular(5)),
                                                     height: 25,
                                                     width: 85,
                                                     child:Center(
                                                       child: Text(
                                                         "Follow",
                                                         style: f14B,
                                                       ),
                                                     ),
                                                   ),
                                                 )) :Container(height: 0,)
                                           ],
                                         ));
                                   }),
                             ) : Container(height: 0,),
                             _con.searchPOSTS.length>0 ? Padding(
                               padding: const EdgeInsets.only(top:8.0),
                               child: Container(
                                 height: _con.searchPOSTS.length.toDouble()*500,
                                 child:  ListView.builder(
                                   itemCount: _con.searchPOSTS.length,
                                   physics: const NeverScrollableScrollPhysics(),
                                   itemBuilder: (BuildContext context, int index) {
                                     final List<String> playlist2 = _con
                                         .searchPOSTS[index]["shared_post_id"] != null
                                         ? <String>[
                                       'https://www.youtube.com/watch?v=' +
                                           _con
                                               .searchPOSTS[index]["shared_post_details"]
                                           ['youtube_video_id']
                                               .toString()
                                     ]
                                         : <String>[];
                                     _date = DateTime.parse(
                                         _con.searchPOSTS[index]['created_at']['date']);
                                     final List<String> playlist = <String>[
                                       'https://www.youtube.com/watch?v='+_con.searchPOSTS[index]['youtube_video_id'].toString()];

                                     _con.searchPOSTS[index]["shared_post_id"] != null
                                         ? _date2 = DateTime.parse(
                                         _con
                                             .searchPOSTS[index]["shared_post_details"]['created_at']
                                         ['date'])
                                         : null;
                                     _con.searchPOSTS[index]["shared_post_id"] != null
                                         ? e =
                                         DateTime
                                             .now()
                                             .difference(_date2)
                                             .inHours
                                         : null;
                                     _con.searchPOSTS[index]["shared_post_id"] != null
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
                                                     padding: const EdgeInsets.only(
                                                         left: 5.0, right: 5.0, bottom: 2),
                                                     child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                             imageUrl: _con.searchPOSTS[index]["product_id"]!=null &&  _con.searchPOSTS[index]["business_profile_image"]!=null ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                                 .searchPOSTS[index]["picture"]
                                                                                 .toString()+"?alt=media" : _con.searchPOSTS[index]["product_id"]!=null ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                                                                                 : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()!=""  ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                                 _con
                                                                                     .searchPOSTS[index]["picture"]
                                                                                     .toString()
                                                                                     .replaceAll(
                                                                                     " ",
                                                                                     "%20") +
                                                                                 "?alt=media" : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()==""  ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                                 "icu.png" +
                                                                                 "?alt=media" :  _con
                                                                                 .searchPOSTS[index]["picture"]
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
                                                                             .searchPOSTS[index]["picture"] !=
                                                                             null
                                                                             ? CachedNetworkImageProvider(
                                                                             _con.searchPOSTS[index]["product_id"]!=null &&  _con.searchPOSTS[index]["business_profile_image"]!=null ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                                 .searchPOSTS[index]["picture"]
                                                                                 .toString()+"?alt=media" : _con.searchPOSTS[index]["product_id"]!=null ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                                                                                 : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()!=""  ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                                 _con
                                                                                     .searchPOSTS[index]["picture"]
                                                                                     .toString()
                                                                                     .replaceAll(
                                                                                     " ",
                                                                                     "%20") +
                                                                                 "?alt=media" : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()==""  ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                                 "icu.png" +
                                                                                 "?alt=media"  :  _con
                                                                                 .searchPOSTS[index]["picture"]
                                                                                 .toString()
                                                                                 .replaceAll(
                                                                                 " ",
                                                                                 "%20") +
                                                                                 "?alt=media" )
                                                                             : CachedNetworkImageProvider(
                                                                           "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                         ),
                                                                         fit: BoxFit
                                                                             .cover),
                                                                     border: Border.all(color: (_con.searchPOSTS[index]["product_id"]==null  &&
                                                                         _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()=="") ||
                                                                         (_con.searchPOSTS[index]["product_id"]!=null &&  _con.searchPOSTS[index]["business_profile_image"]==null)
                                                                         ? Color(0xFF48c0d8) : Colors.transparent),
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
                                                                   _con.searchPOSTS[index]["product_id"]!=null && _con.searchPOSTS[index]["business_type"].toString()=="1"  ?
                                                                   Navigator.push(context, MaterialPageRoute(
                                                                       builder: (context)=>KitchenProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                                         timid: _con.searchPOSTS[index]['business_timeline_id'].toString(), )
                                                                   )) :_con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" &&
                                                                       _con.searchPOSTS[index]["business_type"].toString()=="1" ?
                                                                   Navigator.push(context, MaterialPageRoute(
                                                                       builder: (context)=>KitchenProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                                         timid: _con.searchPOSTS[index]['timeline_id'].toString(), )
                                                                   ))

                                                                       :  _con.searchPOSTS[index]["product_id"]!=null && _con.searchPOSTS[index]["business_type"].toString()=="2" ?

                                                                   Navigator.push(context, MaterialPageRoute(
                                                                       builder: (context)=>StoreProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                                         timid: _con.searchPOSTS[index]['business_timeline_id'].toString(), )
                                                                   )) : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" &&
                                                                       _con.searchPOSTS[index]["business_type"].toString()=="2" ?
                                                                   Navigator.push(context, MaterialPageRoute(
                                                                       builder: (context)=>StoreProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                                         timid: _con.searchPOSTS[index]['timeline_id'].toString(), ))) :  _con.searchPOSTS[index]["product_id"]!=null && _con.searchPOSTS[index]["business_type"].toString()=="3" ?
                                                                   Navigator.push(context, MaterialPageRoute(
                                                                       builder: (context)=>RestProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                                         timid:  _con.searchPOSTS[index]['business_timeline_id'].toString(), )
                                                                   ))
                                                                       : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" &&
                                                                       _con.searchPOSTS[index]["business_type"].toString()=="3" ?
                                                                   Navigator.push(context, MaterialPageRoute(
                                                                       builder: (context)=>RestProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                                         timid: _con.searchPOSTS[index]['timeline_id'].toString(), ))) : Navigator.push(
                                                                       context,
                                                                       MaterialPageRoute(
                                                                           builder: (
                                                                               context) =>
                                                                               TimelineFoodWallDetailPage(
                                                                                 id: _con
                                                                                     .searchPOSTS[index]['user_id']
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
                                                                       _con.searchPOSTS[index]["product_id"]!=null ? _con
                                                                           .searchPOSTS[
                                                                       index]
                                                                       ['business_name']
                                                                           .toString()  :  _con
                                                                           .searchPOSTS[
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
                                                                             .searchPOSTS[index]
                                                                         ['post_location'] !=
                                                                             null &&
                                                                             _con
                                                                                 .searchPOSTS[
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
                                                                               userid.toString() == _con.searchPOSTS[index]['user_id'].toString() && _con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString().length>=45 && (_con.searchPOSTS[index]["post_type"].toString()
                                                                                   =="page" || _con.searchPOSTS[index]["post_type"].toString()
                                                                                   =="user")
                                                                                   ?   " - In " + _con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString().substring(0,45)+"..." :
                                                                               userid.toString() == _con.searchPOSTS[index]['user_id'].toString() && _con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString().length<40 && (_con.searchPOSTS[index]["post_type"].toString()
                                                                                   =="page" || _con.searchPOSTS[index]["post_type"].toString()
                                                                                   =="user")
                                                                                   ?   " - In " + _con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString() :  _con.searchPOSTS[index]["post_type"].toString()
                                                                                   =="page" && _con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString().length>=21 && userid.toString() != _con.searchPOSTS[index]['user_id'].toString()
                                                                                   ? " - In " + _con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString().substring(0,21)+"..." :
                                                                               _con.searchPOSTS[index]["post_type"].toString()
                                                                                   =="page" && _con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString().length<21 && userid.toString() != _con.searchPOSTS[index]['user_id'].toString() ?" - In " +
                                                                                   _con
                                                                                       .searchPOSTS[index]
                                                                                   ['post_location']
                                                                                       .toString() :
                                                                               _con.searchPOSTS[index]["post_type"].toString()
                                                                                   =="user" && _con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString().length>=33 && userid.toString() != _con.searchPOSTS[index]['user_id'].toString() ?
                                                                               " - In "+_con
                                                                                   .searchPOSTS[index]
                                                                               ['post_location']
                                                                                   .toString().substring(0,33)+"..." : " - In "+_con
                                                                                   .searchPOSTS[index]
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
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: <Widget>[
                                                             userid!=_con.searchPOSTS[index]
                                                             ["user_id"].toString() ? GestureDetector(
                                                                 onTap: () {

                                                                   try {
                                                                     String chatID = makeChatId(timelineIdFoodi.toString(), _con.searchPOSTS[index]['timeline_id'].toString());
                                                                     Navigator.push(
                                                                         context,
                                                                         MaterialPageRoute(
                                                                             builder: (context) => ChatRoom(
                                                                                 timelineIdFoodi, NAME, _con.searchPOSTS[index]
                                                                             ['device_token'].toString(),
                                                                                 _con.searchPOSTS[index]
                                                                                 ['timeline_id'].toString(), chatID,
                                                                                 _con.searchPOSTS[index]
                                                                                 ['username'].toString(), _con.searchPOSTS[index]
                                                                             ['name'].toString(),
                                                                                 _con.searchPOSTS[
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
                                                                                   userid.toString() == _con.searchPOSTS[index]
                                                                                   ["user_id"].toString() &&
                                                                                       _con.searchPOSTS[index]["post_type"].toString() == "user"
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
                                                                                                           .searchPOSTS[index]['description']
                                                                                                           .toString(),
                                                                                                       postid: _con
                                                                                                           .searchPOSTS[index]["id"]
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
                                                                                   userid.toString() == _con.searchPOSTS[index]['user_id'].toString() &&
                                                                                       _con.searchPOSTS[index]["post_type"].toString() == "user"
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
                                                                                                               .searchPOSTS[index]['id']
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
                                                                                                   .searchPOSTS[index]["id"]
                                                                                                   .toString();
                                                                                           if(_con.searchPOSTS[index]['save_status'] ==
                                                                                               true)
                                                                                           {
                                                                                             _con.searchPOSTS[index]['save_status'] = false;
                                                                                             _con.searchPOSTS[index]['save_status']=false;
                                                                                           }
                                                                                           else
                                                                                           {
                                                                                             _con.searchPOSTS[index]['save_status'] = true;
                                                                                             _con.searchPOSTS[index]['save_status']=true;
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
                                                                                                   _con.searchPOSTS[index]['save_status']? "Saved Post" : "Save Post",
                                                                                                   style: f15wB,
                                                                                                 ),
                                                                                                 SizedBox(
                                                                                                   height: 3,
                                                                                                 ),
                                                                                                 Text(_con.searchPOSTS[index]['save_status']? "Added this to your saved post" :
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
                                                                                   userid.toString() != _con.searchPOSTS[index]['user_id'].toString()
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
                                                                                                 .searchPOSTS[index]['id']);

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
                                                                                   userid.toString() != _con.searchPOSTS[index]['user_id'].toString()
                                                                                       ? Padding(
                                                                                     padding: const EdgeInsets
                                                                                         .all(
                                                                                         6.0),
                                                                                     child: InkWell(
                                                                                       onTap: () {
                                                                                         _con.searchPOSTS[index]["follow_status"] ?
                                                                                         showDialog(
                                                                                             context: context,
                                                                                             builder: (
                                                                                                 BuildContext context) {
                                                                                               return AlertDialog(
                                                                                                 backgroundColor: Color(
                                                                                                     0xFF1E2026),
                                                                                                 content: new Text(
                                                                                                   "Do you want to Unfollow "+_con.searchPOSTS[index]['name'].toString()+" ?",
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
                                                                                                           .searchPOSTS[index]["follow_status"] = false;});
                                                                                                       _con
                                                                                                           .followerController(
                                                                                                           userid
                                                                                                               .toString(),
                                                                                                           _con
                                                                                                               .searchPOSTS[index]['user_id']
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
                                                                                                 .searchPOSTS[index]['user_id']
                                                                                                 .toString());
                                                                                         if(_con
                                                                                             .searchPOSTS[index]["follow_status"] ==
                                                                                             false){
                                                                                           setState(() { _con
                                                                                               .searchPOSTS[index]["follow_status"] = true;});
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
                                                                                                     .searchPOSTS[index]["follow_status"] ==
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
                                                                                                     .searchPOSTS[index]["follow_status"] ==
                                                                                                     true
                                                                                                     ? Text(
                                                                                                   "Unfollow  " +
                                                                                                       _con
                                                                                                           .searchPOSTS[index]["name"],
                                                                                                   style: f13w,
                                                                                                 )
                                                                                                     : Text(
                                                                                                   "Follow  " +
                                                                                                       _con
                                                                                                           .searchPOSTS[index]["name"],
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
                                                                                                   .searchPOSTS[index]['id']
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
                                                                                                   .searchPOSTS[index]['id']
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
                                                 _con.searchPOSTS[index]
                                                 ['description'] !=
                                                     "" && _con.searchPOSTS[index]
                                                 ['description'] != null ? Padding(
                                                   padding: const EdgeInsets.only(left:8,right: 8),
                                                   child: _con.searchPOSTS[index]
                                                   ['description'].length > 130 && /*textSpan==false &&*/ _showml[index]==false ?
                                                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       SmartText(
                                                         text:
                                                         _con
                                                             .searchPOSTS[index]['description'].substring(0, 129,) + " ...",
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
                                                   ) : _con.searchPOSTS[index]
                                                   ['description'].length > 130/* &&
                    textSpan == true*/ && _showml[index]==true?
                                                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       SmartText(
                                                         text:
                                                         _con
                                                             .searchPOSTS[index]['description'],
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
                                                   ) : _con.searchPOSTS[index]
                                                   ['description'].length <= 130 ?  SmartText(
                                                     text:
                                                     _con
                                                         .searchPOSTS[index]['description'],
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
                                                     .searchPOSTS[index]["shared_post_id"] !=
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
                                                                                         .searchPOSTS[index]["shared_post_details"]["user_id"]
                                                                                         .toString(),
                                                                                   )));
                                                                     },
                                                                     child: Container(
                                                                       height: 35.0,
                                                                       width: 35.0,
                                                                       decoration: BoxDecoration(
                                                                           image: DecorationImage(
                                                                               image: _con
                                                                                   .searchPOSTS[index]["shared_post_details"]["picture"] !=
                                                                                   null
                                                                                   ? CachedNetworkImageProvider(
                                                                                   _con
                                                                                       .searchPOSTS[index]["shared_post_details"]["picture"].toString().replaceAll(" ", "%20")+"?alt=media")
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
                                                                                           .searchPOSTS[index]["shared_post_details"]['user_id']
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
                                                                                 .searchPOSTS[index]["shared_post_details"]
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
                                                           _con.searchPOSTS[index]["shared_post_details"]
                                                           ['description'] !=
                                                               "" && _con.searchPOSTS[index]["shared_post_details"]
                                                           ['description'] != null ? Padding(
                                                             padding: const EdgeInsets.only(left:8,right: 8),
                                                             child: _con.searchPOSTS[index]["shared_post_details"]
                                                             ['description'].length > 130 && /*textSpan==false &&*/ _sharedshowml[index]==false ?
                                                             Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                               children: [
                                                                 SmartText(
                                                                   text:
                                                                   _con
                                                                       .searchPOSTS[index]["shared_post_details"]['description'].substring(0, 129,) + " ...",
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
                                                                       _sharedshowml[index]=true;});
                                                                     },
                                                                     child: Text("Show more...",style: f14p,)),
                                                                 SizedBox(height: 2,),
                                                               ],
                                                             ) : _con.searchPOSTS[index]["shared_post_details"]
                                                             ['description'].length > 130/* &&
                    textSpan == true*/ && _sharedshowml[index]==true?
                                                             Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                               children: [
                                                                 SmartText(
                                                                   text:
                                                                   _con
                                                                       .searchPOSTS[index]["shared_post_details"]['description'],
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
                                                                       _sharedshowml[index]=false;});
                                                                     },
                                                                     child: Text("Show less...",style: f14p,)),
                                                                 SizedBox(height: 2,),
                                                               ],
                                                             ) : _con.searchPOSTS[index]["shared_post_details"]
                                                             ['description'].length <= 130 ?  SmartText(
                                                               text:
                                                               _con
                                                                   .searchPOSTS[index]["shared_post_details"]['description'],
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
                                                             padding: const EdgeInsets
                                                                 .only(
                                                                 top: 5,
                                                                 bottom: 5,
                                                                 left: 7,
                                                                 right: 7),
                                                             child:  _con.searchPOSTS[
                                                             index]["shared_post_details"]['url_image']!="" &&_con.searchPOSTS[
                                                             index]["shared_post_details"]['url_image']!=null ? GestureDetector(
                                                               onTap:(){
                                                                 Navigator.push(context, MaterialPageRoute(
                                                                     builder: (context)=> WebViewContainer(url:_con.searchPOSTS[
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
                                                                           _con.searchPOSTS[
                                                                           index]["shared_post_details"][
                                                                           "url_image"]
                                                                               .toString(),
                                                                           fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                                                       ),
                                                                       Padding(
                                                                         padding: const EdgeInsets.only(top:5,bottom: 5,left: 8,right: 8),
                                                                         child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
                                                                           children: [
                                                                             Text(_con.searchPOSTS[
                                                                             index]["shared_post_details"][
                                                                             "url_site"]
                                                                                 .toString(),style: f14w,),
                                                                             SizedBox(height: 4,),
                                                                             Text( _con.searchPOSTS[
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
                                                                 .searchPOSTS[
                                                             index]["shared_post_details"]
                                                             ['post_images']
                                                                 .length >
                                                                 0&& _con
                                                                 .searchPOSTS[
                                                             index]
                                                             ["shared_post_details"]
                                                             ['post_images']
                                                                 .length == 1
                                                                 ? GestureDetector(
                                                               onTap: (){
                                                                 Navigator.push(context, MaterialPageRoute(
                                                                     builder: (context) => GalleryScreen(ImageList:
                                                                     _con.searchPOSTS[index]["shared_post_details"]['post_images'],)
                                                                 ));
                                                               },
                                                                   child: Container(
                                                               height: 350,
                                                               width: MediaQuery.of(context).size.width,
                                                               child: CachedNetworkImage(
                                                                   placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                                   imageUrl:  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                       _con.searchPOSTS[
                                                                       index]["shared_post_details"][
                                                                       "post_images"]
                                                                       [0]['source'].toString()
                                                                           .replaceAll(" ", "%20") +
                                                                       "?alt=media",
                                                                   fit: BoxFit.cover,
                                                               ),
                                                             ),
                                                                 ) : _con.searchPOSTS[index]
                                                             ["shared_post_details"]["post_images"].length >0 &&
                                                                 _con.searchPOSTS[index]
                                                                 ["shared_post_details"]["post_images"]
                                                                     .length > 1 ?
                                                             GestureDetector(
                                                               onTap: (){
                                                                 Navigator.push(context, MaterialPageRoute(
                                                                     builder: (context) => GalleryScreen(ImageList:
                                                                     _con.searchPOSTS[index]["shared_post_details"]['post_images'],)
                                                                 ));
                                                               },
                                                               child: Container(
                                                                   height: 350.0,
                                                                   child: new Carousel(
                                                                     boxFit: BoxFit.cover,
                                                                     dotColor: Colors.black26,
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
                                                                         .searchPOSTS[
                                                                     index]
                                                                     ["shared_post_details"]["post_images"].map((item) {
                                                                       return new CachedNetworkImage(
                                                                         placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                                         imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                             item['source']
                                                                                 .toString()
                                                                                 .replaceAll(" ", "%20") +
                                                                             "?alt=media",fit: BoxFit.cover,);
                                                                     }).toList(),
                                                                   )),
                                                             ) : _con.searchPOSTS[
                                                             index]["shared_post_details"]["youtube_video_id"].length == 11 &&
                                                                 _con.searchPOSTS[index]["shared_post_details"]["youtube_video_id"] != null
                                                                 ? Column(
                                                               children: [
                                                                 GestureDetector(
                                                                   onTap:(){
                                                                     Navigator.push(context, MaterialPageRoute(
                                                                         builder: (context)=>WebViewContainer(
                                                                           url: 'https://www.youtube.com/watch?v=' +
                                                                               _con.searchPOSTS[index]["shared_post_details"]
                                                                               ['youtube_video_id']
                                                                                   .toString(),)
                                                                     ));
                                                                   },
                                                                   child: Stack(alignment: Alignment.center,
                                                                     children: [
                                                                       CachedNetworkImage(
                                                                           imageUrl: "https://img.youtube.com/vi/" +
                                                                               _con.searchPOSTS[
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
                                                                 _con.searchPOSTS[index]["shared_post_details"]
                                                                 ['youtube_title'].length > 130 && /*textSpan==false &&*/ _showSharedutube[index]==false ?
                                                                 Padding(
                                                                   padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                     children: [
                                                                       SmartText(
                                                                         text:
                                                                         _con
                                                                             .searchPOSTS[index]["shared_post_details"]['youtube_title'].substring(0, 129,) + " ...",
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
                                                                 ) : _con.searchPOSTS[index]["shared_post_details"]
                                                                 ['youtube_title'].length > 130/* &&
                    textSpan == true*/ && _showSharedutube[index]==true?
                                                                 Padding(
                                                                   padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                     children: [
                                                                       SmartText(
                                                                         text:
                                                                         _con
                                                                             .searchPOSTS[index]["shared_post_details"]['youtube_title'],
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
                                                                 ) : _con.searchPOSTS[index]["shared_post_details"]
                                                                 ['youtube_title'].length <= 130 ?  Padding(
                                                                   padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                                   child: SmartText(
                                                                     text:
                                                                     _con
                                                                         .searchPOSTS[index]["shared_post_details"]['youtube_title'],
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
                                                             ) : _con.searchPOSTS[index]
                                                             ["shared_post_details"]["youtube_video_id"]
                                                                 .toString()
                                                                 .length != 11 &&
                                                                 _con.searchPOSTS[
                                                                 index]["shared_post_details"]["youtube_video_id"] !=
                                                                     null ?
                                                             Container(
                                                               alignment: Alignment.center,
                                                               child: VideoWidget(
                                                                 url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                                                     _con
                                                                         .searchPOSTS[index]["shared_post_details"]["youtube_video_id"]
                                                                         .toString()
                                                                         .replaceAll(
                                                                         " ", "%20") +
                                                                     "?alt=media",
                                                                 play: true,),
                                                             )
                                                                 : Container(height: 0),
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
                                                   child: _con.searchPOSTS[
                                                   index]['url_image']!="" &&_con.searchPOSTS[
                                                   index]['url_image']!=null ? GestureDetector(
                                                     onTap:(){
                                                       Navigator.push(context, MaterialPageRoute(
                                                           builder: (context)=> WebViewContainer(url:_con.searchPOSTS[
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
                                                                 _con.searchPOSTS[
                                                                 index][
                                                                 "url_image"]
                                                                     .toString(),
                                                                 fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                                             ),
                                                             Padding(
                                                               padding: const EdgeInsets.only(top:5,bottom: 5,left: 8,right: 8),
                                                               child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
                                                                 children: [
                                                                   Text(_con.searchPOSTS[
                                                                   index][
                                                                   "url_site"]
                                                                       .toString(),style: f14w,),
                                                                   SizedBox(height: 4,),
                                                                   Text( _con.searchPOSTS[
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
                                                       .searchPOSTS[
                                                   index]
                                                   ['post_images']
                                                       .length >
                                                       0 && _con
                                                       .searchPOSTS[
                                                   index]
                                                   ['post_images']
                                                       .length == 1
                                                       ? GestureDetector(
                                                     onTap: (){
                                                       Navigator.push(context, MaterialPageRoute(
                                                           builder: (context) => GalleryScreen(ImageList:
                                                           _con.searchPOSTS[index]['post_images'],)
                                                       ));
                                                     },
                                                         child: Container(
                                                     height: 350,
                                                     width: MediaQuery.of(context).size.width,
                                                     child: CachedNetworkImage(
                                                         placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                         imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                             _con.searchPOSTS[
                                                             index][
                                                             "post_images"]
                                                             [0]['source']
                                                                 .toString()
                                                                 .replaceAll(" ", "%20") +
                                                             "?alt=media",
                                                         fit: BoxFit.cover,
                                                     ),
                                                   ),
                                                       ) : _con
                                                       .searchPOSTS[
                                                   index]
                                                   ['post_images']
                                                       .length >
                                                       0 && _con
                                                       .searchPOSTS[
                                                   index]
                                                   ['post_images']
                                                       .length > 1 ?
                                                   GestureDetector(
                                                     onTap: (){
                                                       Navigator.push(context, MaterialPageRoute(
                                                           builder: (context) => GalleryScreen(ImageList:
                                                           _con.searchPOSTS[index]['post_images'],)
                                                       ));
                                                     },
                                                     child: Container(
                                                         height: 350.0,
                                                         child: new Carousel(
                                                           boxFit: BoxFit.cover,
                                                           dotColor: Colors.black26,
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
                                                               .searchPOSTS[
                                                           index]
                                                           ['post_images'].map((item) {
                                                             return new CachedNetworkImage(
                                                               placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                               imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                   item['source']
                                                                       .toString()
                                                                       .replaceAll(
                                                                       " ", "%20") +
                                                                   "?alt=media",fit: BoxFit.cover,);
                                                           }).toList(),
                                                         )),
                                                   )
                                                       :
                                                   _con.searchPOSTS[
                                                   index][
                                                   "youtube_video_id"].toString().length == 11 &&
                                                       _con.searchPOSTS[
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
                                                                     _con.searchPOSTS[index]
                                                                     ['youtube_video_id']
                                                                         .toString(),)
                                                           ));
                                                         },
                                                         child: Stack(alignment: Alignment.center,
                                                           children: [
                                                             CachedNetworkImage(
                                                                 imageUrl: "https://img.youtube.com/vi/" +
                                                                     _con.searchPOSTS[
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
                                                       _con.searchPOSTS[index]
                                                       ['youtube_title'].length > 130 && /*textSpan==false &&*/ _showutube[index]==false ?
                                                       Padding(
                                                         padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             SmartText(
                                                               text:
                                                               _con
                                                                   .searchPOSTS[index]['youtube_title'].substring(0, 129,) + " ...",
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
                                                       ) : _con.searchPOSTS[index]
                                                       ['youtube_title'].length > 130/* &&
                    textSpan == true*/ && _showutube[index]==true?
                                                       Padding(
                                                         padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             SmartText(
                                                               text:
                                                               _con
                                                                   .searchPOSTS[index]['youtube_title'],
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
                                                       ) : _con.searchPOSTS[index]
                                                       ['youtube_title'].length <= 130 ?  Padding(
                                                         padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                         child: SmartText(
                                                           text:
                                                           _con
                                                               .searchPOSTS[index]['youtube_title'],
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
                                                   ) : _con.searchPOSTS[index]
                                                   [
                                                   "youtube_video_id"]
                                                       .toString()
                                                       .length != 11 &&
                                                       _con.searchPOSTS[
                                                       index][
                                                       "youtube_video_id"] !=
                                                           null ?
                                                   Container(
                                                     alignment: Alignment.center,
                                                     child: VideoWidget(
                                                       url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                                           _con
                                                               .searchPOSTS[index]['youtube_video_id']
                                                               .toString()
                                                               .replaceAll(
                                                               " ", "%20") +
                                                           "?alt=media",
                                                       play: true,),
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
                                                                 onTap: () {setState(() { postid= _con.searchPOSTS[index]['id'].toString();});
                                                                 Navigator.push(
                                                                     context,
                                                                     MaterialPageRoute(
                                                                         builder: (context) =>
                                                                             LikeCommentSharePage(
                                                                               statusIndex: 0,)));
                                                                 },
                                                                 child: Text(
                                                                     _con.searchPOSTS[index]
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
                                                                   setState(() { postid= _con.searchPOSTS[index]['id'].toString();});
                                                                   Navigator.push(
                                                                       context,
                                                                       MaterialPageRoute(
                                                                           builder: (context) =>
                                                                               LikeCommentSharePage(
                                                                                 statusIndex: 1,)));
                                                                   _con.getTimelineWall(userid.toString());

                                                                 },
                                                                 child: Text(
                                                                     _con.searchPOSTS[index]
                                                                     ['comments_count']
                                                                         .toString() +
                                                                         " Comments",
                                                                     style: f14y),
                                                               ),
                                                               SizedBox(
                                                                 width: 13,
                                                               ),
                                                               GestureDetector(
                                                                 onTap: () {setState(() { postid= _con.searchPOSTS[index]['id'].toString();});
                                                                 Navigator.push(
                                                                     context,
                                                                     MaterialPageRoute(
                                                                         builder: (context) =>
                                                                             LikeCommentSharePage(
                                                                               statusIndex: 2,)));
                                                                 },
                                                                 child: Text(
                                                                     _con.searchPOSTS[index]
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
                                                             _con.searchPOSTS[index]
                                                             ['like_status'] ==
                                                                 true
                                                                 ? GestureDetector(
                                                               onTap: () {

                                                                 setState(() { postid=_con.searchPOSTS[index]['id'].toString();});
                                                                 _con.likeSearchPostTime(
                                                                     userid.toString(),postid.toString(),_search.text);

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

                                                                 setState(() { postid=_con.searchPOSTS[index]['id'].toString();});
                                                                 _con.likeSearchPostTime(
                                                                     userid.toString(),postid.toString(),_search.text);
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
                                                                 setState(() { postid= _con.searchPOSTS[index]['id'].toString();});
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
                                                                   postid= _con.searchPOSTS[index]['id'].toString();
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
                                                             _con.searchPOSTS[index]["save_status"] == true ? GestureDetector(
                                                               onTap: () {
                                                                 setState(() { postid = _con.searchPOSTS[index]["id"].toString();});
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
                                                                 setState(() { postid = _con.searchPOSTS[index]["id"].toString();});
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
                                           Divider(
                                             thickness: 1,
                                             color: Colors.black87,
                                           ),
                                         ],
                                       ),
                                     );
                                   },
                                 ),
                               ),
                             ) : Container(height: 0,),
                           ],
                         ) :
                       Padding(
                           padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                           child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/search_screen.png",height: 100,color: Colors.white,),
                            Text("No Results Found",style: f21wB,),
                            SizedBox(height: 5,),
                            Text("Enter a few words to search in Butomy",style: f15w,),
                          ],
                        ),
                    ),
                         ),
                     ),
                    //tab 1
                    _con.searchPOSTS.length>0 ?    Container(
                      height:  _con.searchPOSTS.length.toDouble()*500,
                      child: ListView.builder(
                        itemCount: _con.searchPOSTS.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final List<String> playlist2 = _con
                              .searchPOSTS[index]["shared_post_id"] != null
                              ? <String>[
                            'https://www.youtube.com/watch?v=' +
                                _con
                                    .searchPOSTS[index]["shared_post_details"]
                                ['youtube_video_id']
                                    .toString()
                          ]
                              : <String>[];
                          _date = DateTime.parse(
                              _con.searchPOSTS[index]['created_at']['date']);
                          final List<String> playlist = <String>[
                            'https://www.youtube.com/watch?v='+_con.searchPOSTS[index]['youtube_video_id'].toString()];

                          _con.searchPOSTS[index]["shared_post_id"] != null
                              ? _date2 = DateTime.parse(
                              _con
                                  .searchPOSTS[index]["shared_post_details"]['created_at']
                              ['date'])
                              : null;
                          _con.searchPOSTS[index]["shared_post_id"] != null
                              ? e =
                              DateTime
                                  .now()
                                  .difference(_date2)
                                  .inHours
                              : null;
                          _con.searchPOSTS[index]["shared_post_id"] != null
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
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5.0, bottom: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                                              imageUrl: _con.searchPOSTS[index]["product_id"]!=null &&  _con.searchPOSTS[index]["business_profile_image"]!=null ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                  .searchPOSTS[index]["picture"]
                                                                  .toString()+"?alt=media" : _con.searchPOSTS[index]["product_id"]!=null ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                                                                  : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()!=""  ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                  _con
                                                                      .searchPOSTS[index]["picture"]
                                                                      .toString()
                                                                      .replaceAll(
                                                                      " ",
                                                                      "%20") +
                                                                  "?alt=media" : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()==""  ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                  "icu.png" +
                                                                  "?alt=media" :  _con
                                                                  .searchPOSTS[index]["picture"]
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
                                                              .searchPOSTS[index]["picture"] !=
                                                              null
                                                              ? CachedNetworkImageProvider(
                                                              _con.searchPOSTS[index]["product_id"]!=null &&  _con.searchPOSTS[index]["business_profile_image"]!=null ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                  .searchPOSTS[index]["picture"]
                                                                  .toString()+"?alt=media" : _con.searchPOSTS[index]["product_id"]!=null ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                                                                  : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()!=""  ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                  _con
                                                                      .searchPOSTS[index]["picture"]
                                                                      .toString()
                                                                      .replaceAll(
                                                                      " ",
                                                                      "%20") +
                                                                  "?alt=media" : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()==""  ?  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                  "icu.png" +
                                                                  "?alt=media"  :  _con
                                                                  .searchPOSTS[index]["picture"]
                                                                  .toString()
                                                                  .replaceAll(
                                                                  " ",
                                                                  "%20") +
                                                                  "?alt=media" )
                                                              : CachedNetworkImageProvider(
                                                            "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                          ),
                                                          fit: BoxFit
                                                              .cover),
                                                      border: Border.all(color: (_con.searchPOSTS[index]["product_id"]==null  &&
                                                          _con.searchPOSTS[index]["post_type"].toString()=="page" && _con.searchPOSTS[index]["picture"].toString()=="") ||
                                                          (_con.searchPOSTS[index]["product_id"]!=null &&  _con.searchPOSTS[index]["business_profile_image"]==null)
                                                          ? Color(0xFF48c0d8) : Colors.transparent),
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
                                                    _con.searchPOSTS[index]["product_id"]!=null && _con.searchPOSTS[index]["business_type"].toString()=="1"  ?
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>KitchenProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                          timid: _con.searchPOSTS[index]['business_timeline_id'].toString(), )
                                                    )) :_con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" &&
                                                        _con.searchPOSTS[index]["business_type"].toString()=="1" ?
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>KitchenProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                          timid: _con.searchPOSTS[index]['timeline_id'].toString(), )
                                                    ))

                                                        :  _con.searchPOSTS[index]["product_id"]!=null && _con.searchPOSTS[index]["business_type"].toString()=="2" ?

                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>StoreProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                          timid: _con.searchPOSTS[index]['business_timeline_id'].toString(), )
                                                    )) : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" &&
                                                        _con.searchPOSTS[index]["business_type"].toString()=="2" ?
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>StoreProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                          timid: _con.searchPOSTS[index]['timeline_id'].toString(), ))) :  _con.searchPOSTS[index]["product_id"]!=null && _con.searchPOSTS[index]["business_type"].toString()=="3" ?
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>RestProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                          timid:  _con.searchPOSTS[index]['business_timeline_id'].toString(), )
                                                    ))
                                                        : _con.searchPOSTS[index]["product_id"]==null  &&  _con.searchPOSTS[index]["post_type"].toString()=="page" &&
                                                        _con.searchPOSTS[index]["business_type"].toString()=="3" ?
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>RestProf(currentindex: 1,memberdate: "",pagid:  _con.searchPOSTS[index]['business_page_id'].toString(),
                                                          timid: _con.searchPOSTS[index]['timeline_id'].toString(), ))) : Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                TimelineFoodWallDetailPage(
                                                                  id: _con
                                                                      .searchPOSTS[index]['user_id']
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
                                                        _con.searchPOSTS[index]["product_id"]!=null ? _con
                                                            .searchPOSTS[
                                                        index]
                                                        ['business_name']
                                                            .toString()  :  _con
                                                            .searchPOSTS[
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
                                                              .searchPOSTS[index]
                                                          ['post_location'] !=
                                                              null &&
                                                              _con
                                                                  .searchPOSTS[
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
                                                                userid.toString() == _con.searchPOSTS[index]['user_id'].toString() && _con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString().length>=45 && (_con.searchPOSTS[index]["post_type"].toString()
                                                                    =="page" || _con.searchPOSTS[index]["post_type"].toString()
                                                                    =="user")
                                                                    ?   " - In " + _con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString().substring(0,45)+"..." :
                                                                userid.toString() == _con.searchPOSTS[index]['user_id'].toString() && _con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString().length<40 && (_con.searchPOSTS[index]["post_type"].toString()
                                                                    =="page" || _con.searchPOSTS[index]["post_type"].toString()
                                                                    =="user")
                                                                    ?   " - In " + _con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString() :  _con.searchPOSTS[index]["post_type"].toString()
                                                                    =="page" && _con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString().length>=21 && userid.toString() != _con.searchPOSTS[index]['user_id'].toString()
                                                                    ? " - In " + _con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString().substring(0,21)+"..." :
                                                                _con.searchPOSTS[index]["post_type"].toString()
                                                                    =="page" && _con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString().length<21 && userid.toString() != _con.searchPOSTS[index]['user_id'].toString() ?" - In " +
                                                                    _con
                                                                        .searchPOSTS[index]
                                                                    ['post_location']
                                                                        .toString() :
                                                                _con.searchPOSTS[index]["post_type"].toString()
                                                                    =="user" && _con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString().length>=33 && userid.toString() != _con.searchPOSTS[index]['user_id'].toString() ?
                                                                " - In "+_con
                                                                    .searchPOSTS[index]
                                                                ['post_location']
                                                                    .toString().substring(0,33)+"..." : " - In "+_con
                                                                    .searchPOSTS[index]
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
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  userid!=_con.searchPOSTS[index]
                                                  ["user_id"].toString() ? GestureDetector(
                                                      onTap: () {

                                                        try {
                                                          String chatID = makeChatId(timelineIdFoodi.toString(), _con.searchPOSTS[index]['timeline_id'].toString());
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ChatRoom(
                                                                      timelineIdFoodi, NAME, _con.searchPOSTS[index]
                                                                  ['device_token'].toString(),
                                                                      _con.searchPOSTS[index]
                                                                      ['timeline_id'].toString(), chatID,
                                                                      _con.searchPOSTS[index]
                                                                      ['username'].toString(), _con.searchPOSTS[index]
                                                                  ['name'].toString(),
                                                                      _con.searchPOSTS[
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
                                                                        userid.toString() == _con.searchPOSTS[index]
                                                                        ["user_id"].toString() &&
                                                                            _con.searchPOSTS[index]["post_type"].toString() == "user"
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
                                                                                                .searchPOSTS[index]['description']
                                                                                                .toString(),
                                                                                            postid: _con
                                                                                                .searchPOSTS[index]["id"]
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
                                                                        userid.toString() == _con.searchPOSTS[index]['user_id'].toString() &&
                                                                            _con.searchPOSTS[index]["post_type"].toString() == "user"
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
                                                                                                    .searchPOSTS[index]['id']
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
                                                                                        .searchPOSTS[index]["id"]
                                                                                        .toString();
                                                                                if(_con.searchPOSTS[index]['save_status'] ==
                                                                                    true)
                                                                                {
                                                                                  _con.searchPOSTS[index]['save_status'] = false;
                                                                                  _con.searchPOSTS[index]['save_status']=false;
                                                                                }
                                                                                else
                                                                                {
                                                                                  _con.searchPOSTS[index]['save_status'] = true;
                                                                                  _con.searchPOSTS[index]['save_status']=true;
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
                                                                                        _con.searchPOSTS[index]['save_status']? "Saved Post" : "Save Post",
                                                                                        style: f15wB,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 3,
                                                                                      ),
                                                                                      Text(_con.searchPOSTS[index]['save_status']? "Added this to your saved post" :
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
                                                                        userid.toString() != _con.searchPOSTS[index]['user_id'].toString()
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
                                                                                      .searchPOSTS[index]['id']);

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
                                                                        userid.toString() != _con.searchPOSTS[index]['user_id'].toString()
                                                                            ? Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              6.0),
                                                                          child: InkWell(
                                                                            onTap: () {
                                                                              _con.searchPOSTS[index]["follow_status"] ?
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (
                                                                                      BuildContext context) {
                                                                                    return AlertDialog(
                                                                                      backgroundColor: Color(
                                                                                          0xFF1E2026),
                                                                                      content: new Text(
                                                                                        "Do you want to Unfollow "+_con.searchPOSTS[index]['name'].toString()+" ?",
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
                                                                                                .searchPOSTS[index]["follow_status"] = false;});
                                                                                            _con
                                                                                                .followerController(
                                                                                                userid
                                                                                                    .toString(),
                                                                                                _con
                                                                                                    .searchPOSTS[index]['user_id']
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
                                                                                      .searchPOSTS[index]['user_id']
                                                                                      .toString());
                                                                              if(_con
                                                                                  .searchPOSTS[index]["follow_status"] ==
                                                                                  false){
                                                                                setState(() { _con
                                                                                    .searchPOSTS[index]["follow_status"] = true;});
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
                                                                                          .searchPOSTS[index]["follow_status"] ==
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
                                                                                          .searchPOSTS[index]["follow_status"] ==
                                                                                          true
                                                                                          ? Text(
                                                                                        "Unfollow  " +
                                                                                            _con
                                                                                                .searchPOSTS[index]["name"],
                                                                                        style: f13w,
                                                                                      )
                                                                                          : Text(
                                                                                        "Follow  " +
                                                                                            _con
                                                                                                .searchPOSTS[index]["name"],
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
                                                                                        .searchPOSTS[index]['id']
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
                                                                                        .searchPOSTS[index]['id']
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
                                      _con.searchPOSTS[index]
                                      ['description'] !=
                                          "" && _con.searchPOSTS[index]
                                      ['description'] != null ? Padding(
                                        padding: const EdgeInsets.only(left:8,right: 8),
                                        child: _con.searchPOSTS[index]
                                        ['description'].length > 130 && /*textSpan==false &&*/ _showml[index]==false ?
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SmartText(
                                              text:
                                              _con
                                                  .searchPOSTS[index]['description'].substring(0, 129,) + " ...",
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
                                        ) : _con.searchPOSTS[index]
                                        ['description'].length > 130/* &&
                    textSpan == true*/ && _showml[index]==true?
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SmartText(
                                              text:
                                              _con
                                                  .searchPOSTS[index]['description'],
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
                                        ) : _con.searchPOSTS[index]
                                        ['description'].length <= 130 ?  SmartText(
                                          text:
                                          _con
                                              .searchPOSTS[index]['description'],
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
                                          .searchPOSTS[index]["shared_post_id"] !=
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
                                                                              .searchPOSTS[index]["shared_post_details"]["user_id"]
                                                                              .toString(),
                                                                        )));
                                                          },
                                                          child: Container(
                                                            height: 35.0,
                                                            width: 35.0,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: _con
                                                                        .searchPOSTS[index]["shared_post_details"]["picture"] !=
                                                                        null
                                                                        ? CachedNetworkImageProvider(
                                                                        _con
                                                                            .searchPOSTS[index]["shared_post_details"]["picture"].toString().replaceAll(" ", "%20")+"?alt=media")
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
                                                                                .searchPOSTS[index]["shared_post_details"]['user_id']
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
                                                                      .searchPOSTS[index]["shared_post_details"]
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
                                                _con.searchPOSTS[index]["shared_post_details"]
                                                ['description'] !=
                                                    "" && _con.searchPOSTS[index]["shared_post_details"]
                                                ['description'] != null ? Padding(
                                                  padding: const EdgeInsets.only(left:8,right: 8),
                                                  child: _con.searchPOSTS[index]["shared_post_details"]
                                                  ['description'].length > 130 && /*textSpan==false &&*/ _sharedshowml[index]==false ?
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SmartText(
                                                        text:
                                                        _con.searchPOSTS[index]["shared_post_details"]['description'].substring(0, 129,) + " ...",
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
                                                            _sharedshowml[index]=true;});
                                                          },
                                                          child: Text("Show more...",style: f14p,)),
                                                      SizedBox(height: 2,),
                                                    ],
                                                  ) : _con.searchPOSTS[index]["shared_post_details"]
                                                  ['description'].length > 130/* &&
                    textSpan == true*/ && _sharedshowml[index]==true?
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SmartText(
                                                        text:
                                                        _con
                                                            .searchPOSTS[index]["shared_post_details"]['description'],
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
                                                            _sharedshowml[index]=false;});
                                                          },
                                                          child: Text("Show less...",style: f14p,)),
                                                      SizedBox(height: 2,),
                                                    ],
                                                  ) : _con.searchPOSTS[index]["shared_post_details"]
                                                  ['description'].length <= 130 ?  SmartText(
                                                    text:
                                                    _con
                                                        .searchPOSTS[index]["shared_post_details"]['description'],
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
                                                  padding: const EdgeInsets
                                                      .only(
                                                      top: 5,
                                                      bottom: 5,
                                                      left: 7,
                                                      right: 7),
                                                  child:  _con.searchPOSTS[
                                                  index]["shared_post_details"]['url_image']!="" &&_con.searchPOSTS[
                                                  index]["shared_post_details"]['url_image']!=null ? GestureDetector(
                                                    onTap:(){
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context)=> WebViewContainer(url:_con.searchPOSTS[
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
                                                                _con.searchPOSTS[
                                                                index]["shared_post_details"][
                                                                "url_image"]
                                                                    .toString(),
                                                                fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:5,bottom: 5,left: 8,right: 8),
                                                              child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(_con.searchPOSTS[
                                                                  index]["shared_post_details"][
                                                                  "url_site"]
                                                                      .toString(),style: f14w,),
                                                                  SizedBox(height: 4,),
                                                                  Text( _con.searchPOSTS[
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
                                                      .searchPOSTS[
                                                  index]["shared_post_details"]
                                                  ['post_images']
                                                      .length >
                                                      0&& _con
                                                      .searchPOSTS[
                                                  index]
                                                  ["shared_post_details"]
                                                  ['post_images']
                                                      .length == 1
                                                      ? GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => GalleryScreen(ImageList:
                                                          _con.searchPOSTS[index]["shared_post_details"]['post_images'],)
                                                      ));
                                                    },
                                                        child: Container(
                                                    height: 350,
                                                    width: MediaQuery.of(context).size.width,
                                                          child: CachedNetworkImage(
                                                    placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                    imageUrl:  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                            _con.searchPOSTS[
                                                            index]["shared_post_details"][
                                                            "post_images"]
                                                            [0]['source'].toString()
                                                                .replaceAll(" ", "%20") +
                                                            "?alt=media",
                                                    fit: BoxFit.cover,
                                                  ),
                                                        ),
                                                      ) : _con.searchPOSTS[index]
                                                  ["shared_post_details"]["post_images"].length >0 &&
                                                      _con.searchPOSTS[index]
                                                      ["shared_post_details"]["post_images"]
                                                          .length > 1 ?
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => GalleryScreen(ImageList:
                                                          _con.searchPOSTS[index]["shared_post_details"]['post_images'],)
                                                      ));
                                                    },
                                                    child: Container(
                                                        height: 350.0,
                                                        child: new Carousel(
                                                          boxFit: BoxFit.cover,
                                                          dotColor: Colors.black26,
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
                                                              .searchPOSTS[
                                                          index]
                                                          ["shared_post_details"]["post_images"].map((item) {
                                                            return new CachedNetworkImage(
                                                                placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                                imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                    item['source']
                                                                        .toString()
                                                                        .replaceAll(" ", "%20") +
                                                                    "?alt=media",fit: BoxFit.cover,);
                                                          }).toList(),
                                                        )),
                                                  ) : _con.searchPOSTS[
                                                  index]["shared_post_details"]["youtube_video_id"].length == 11 &&
                                                      _con.searchPOSTS[index]["shared_post_details"]["youtube_video_id"] != null
                                                      ? Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap:(){
                                                          Navigator.push(context, MaterialPageRoute(
                                                              builder: (context)=>WebViewContainer(
                                                                url: 'https://www.youtube.com/watch?v=' +
                                                                    _con.searchPOSTS[index]["shared_post_details"]
                                                                    ['youtube_video_id']
                                                                        .toString(),)
                                                          ));
                                                        },
                                                        child: Stack(alignment: Alignment.center,
                                                          children: [
                                                            CachedNetworkImage(
                                                                imageUrl: "https://img.youtube.com/vi/" +
                                                                    _con.searchPOSTS[
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
                                                      _con.searchPOSTS[index]["shared_post_details"]
                                                      ['youtube_title'].length > 130 && /*textSpan==false &&*/ _showSharedutube[index]==false ?
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SmartText(
                                                              text:
                                                              _con
                                                                  .searchPOSTS[index]["shared_post_details"]['youtube_title'].substring(0, 130,) + " ...",
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
                                                      ) : _con.searchPOSTS[index]["shared_post_details"]
                                                      ['youtube_title'].length > 130/* &&
                    textSpan == true*/ && _showSharedutube[index]==true?
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SmartText(
                                                              text:
                                                              _con
                                                                  .searchPOSTS[index]["shared_post_details"]['youtube_title'],
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
                                                      ) : _con.searchPOSTS[index]["shared_post_details"]
                                                      ['youtube_title'].length <= 130 ?  Padding(
                                                        padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                                        child: SmartText(
                                                          text:
                                                          _con
                                                              .searchPOSTS[index]["shared_post_details"]['youtube_title'],
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
                                                  ) : _con.searchPOSTS[index]
                                                  ["shared_post_details"]["youtube_video_id"]
                                                      .toString()
                                                      .length != 11 &&
                                                      _con.searchPOSTS[
                                                      index]["shared_post_details"]["youtube_video_id"] !=
                                                          null ?
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: VideoWidget(
                                                      url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                                          _con
                                                              .searchPOSTS[index]["shared_post_details"]["youtube_video_id"]
                                                              .toString()
                                                              .replaceAll(
                                                              " ", "%20") +
                                                          "?alt=media",
                                                      play: true,),
                                                  )
                                                      : Container(height: 0),
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
                                        child: _con.searchPOSTS[
                                        index]['url_image']!="" &&_con.searchPOSTS[
                                        index]['url_image']!=null ? GestureDetector(
                                          onTap:(){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=> WebViewContainer(url:_con.searchPOSTS[
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
                                                      _con.searchPOSTS[
                                                      index][
                                                      "url_image"]
                                                          .toString(),
                                                      fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:5,bottom: 5,left: 8,right: 8),
                                                    child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
                                                      children: [
                                                        Text(_con.searchPOSTS[
                                                        index][
                                                        "url_site"]
                                                            .toString(),style: f14w,),
                                                        SizedBox(height: 4,),
                                                        Text( _con.searchPOSTS[
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
                                            .searchPOSTS[
                                        index]
                                        ['post_images']
                                            .length >
                                            0 && _con
                                            .searchPOSTS[
                                        index]
                                        ['post_images']
                                            .length == 1
                                            ? GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => GalleryScreen(ImageList:
                                                _con.searchPOSTS[index]['post_images'],)
                                            ));
                                          },
                                              child: Container(
                                          height: 350,
                                          width: MediaQuery.of(context).size.width,
                                                child: CachedNetworkImage(
                                          placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                          imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                  _con.searchPOSTS[
                                                  index][
                                                  "post_images"]
                                                  [0]['source']
                                                      .toString()
                                                      .replaceAll(" ", "%20") +
                                                  "?alt=media",
                                          fit: BoxFit.cover,
                                        ),
                                              ),
                                            ) : _con
                                            .searchPOSTS[
                                        index]
                                        ['post_images']
                                            .length >
                                            0 && _con
                                            .searchPOSTS[
                                        index]
                                        ['post_images']
                                            .length > 1 ?
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => GalleryScreen(ImageList:
                                                _con.searchPOSTS[index]['post_images'],)
                                            ));
                                          },
                                          child: Container(
                                              height: 350.0,
                                              child: new Carousel(
                                                boxFit: BoxFit.cover,
                                                dotColor: Colors.black26,
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
                                                    .searchPOSTS[
                                                index]
                                                ['post_images'].map((item) {
                                                  return new CachedNetworkImage(
                                                      placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          item['source']
                                                              .toString()
                                                              .replaceAll(
                                                              " ", "%20") +
                                                          "?alt=media",fit: BoxFit.cover,);
                                                }).toList(),
                                              )),
                                        )
                                            :
                                        _con.searchPOSTS[
                                        index][
                                        "youtube_video_id"].toString().length == 11 &&
                                            _con.searchPOSTS[
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
                                                          _con.searchPOSTS[index]
                                                          ['youtube_video_id']
                                                              .toString(),)
                                                ));
                                              },
                                              child: Stack(alignment: Alignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                      imageUrl: "https://img.youtube.com/vi/" +
                                                          _con.searchPOSTS[
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
                                            _con.searchPOSTS[index]
                                            ['youtube_title'].length > 130 && /*textSpan==false &&*/ _showutube[index]==false ?
                                            Padding(
                                              padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SmartText(
                                                    text:
                                                    _con
                                                        .searchPOSTS[index]['youtube_title'].substring(0, 130,) + " ...",
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
                                            ) : _con.searchPOSTS[index]
                                            ['youtube_title'].length > 130/* &&
                    textSpan == true*/ && _showutube[index]==true?
                                            Padding(
                                              padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SmartText(
                                                    text:
                                                    _con
                                                        .searchPOSTS[index]['youtube_title'],
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
                                            ) : _con.searchPOSTS[index]
                                            ['youtube_title'].length <= 130 ?  Padding(
                                              padding: const EdgeInsets.only(left:8.0,right: 8,top: 5,bottom: 2),
                                              child: SmartText(
                                                text:
                                                _con
                                                    .searchPOSTS[index]['youtube_title'],
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
                                        ) : _con.searchPOSTS[index]
                                        [
                                        "youtube_video_id"]
                                            .toString()
                                            .length != 11 &&
                                            _con.searchPOSTS[
                                            index][
                                            "youtube_video_id"] !=
                                                null ?
                                        Container(
                                          alignment: Alignment.center,
                                          child: VideoWidget(
                                            url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                                _con
                                                    .searchPOSTS[index]['youtube_video_id']
                                                    .toString()
                                                    .replaceAll(
                                                    " ", "%20") +
                                                "?alt=media",
                                            play: true,),
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
                                                      onTap: () {setState(() { postid= _con.searchPOSTS[index]['id'].toString();});
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LikeCommentSharePage(
                                                                    statusIndex: 0,)));
                                                      },
                                                      child: Text(
                                                          _con.searchPOSTS[index]
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
                                                        setState(() { postid= _con.searchPOSTS[index]['id'].toString();});
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    LikeCommentSharePage(
                                                                      statusIndex: 1,)));
                                                        _con.getTimelineWall(userid.toString());

                                                      },
                                                      child: Text(
                                                          _con.searchPOSTS[index]
                                                          ['comments_count']
                                                              .toString() +
                                                              " Comments",
                                                          style: f14y),
                                                    ),
                                                    SizedBox(
                                                      width: 13,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {setState(() { postid= _con.searchPOSTS[index]['id'].toString();});
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LikeCommentSharePage(
                                                                    statusIndex: 2,)));
                                                      },
                                                      child: Text(
                                                          _con.searchPOSTS[index]
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
                                                  _con.searchPOSTS[index]
                                                  ['like_status'] ==
                                                      true
                                                      ? GestureDetector(
                                                    onTap: () {

                                                      setState(() { postid=_con.searchPOSTS[index]['id'].toString();});
                                                      _con.likeSearchPostTime(
                                                          userid.toString(),postid.toString(),_search.text);

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

                                                      setState(() { postid=_con.searchPOSTS[index]['id'].toString();});
                                                      _con.likeSearchPostTime(
                                                          userid.toString(),postid.toString(),_search.text);
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
                                                      setState(() { postid= _con.searchPOSTS[index]['id'].toString();});
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
                                                        postid= _con.searchPOSTS[index]['id'].toString();
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
                                                  _con.searchPOSTS[index]["save_status"] == true ? GestureDetector(
                                                    onTap: () {
                                                      setState(() { postid = _con.searchPOSTS[index]["id"].toString();});
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
                                                      setState(() { postid = _con.searchPOSTS[index]["id"].toString();});
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
                                Divider(
                                  thickness: 7,
                                  color: Colors.black87,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ) :  Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/search_screen.png",height: 100,color: Colors.white,),
                            Text("No Results Found",style: f21wB,),
                            SizedBox(height: 5,),
                            Text("Enter a few words to search in Butomy",style: f15w,),
                          ],
                        ),
                      ),
                    ),
                    // tab 2
                    _con.searchFOODIS.length>0 ?
                         ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _con.searchFOODIS.length,
                        itemBuilder: (BuildContext context, int index) {
                          _con.searchFOODIS[index]['follow_status'] == true ? foodi_follow[index]=true : foodi_follow[index] = false;
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 5.0, top: 12, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TimelineFoodWallDetailPage(
                                                id: _con.searchFOODIS[index]['user_id'].toString(),
                                              )));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap:(){
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: Color(
                                                          0xFF1E2026),
                                                      content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                        imageUrl: _con
                                                            .searchFOODIS[index]["profile_image"]
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
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundImage: CachedNetworkImageProvider(
                                                _con.searchFOODIS[index]['profile_image'].toString().replaceAll(" ", "%20")+"?alt=media",),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _con.searchFOODIS[index]['name'],
                                                style: f14wB,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _con.searchFOODIS[index]['user_id'].toString()!=userid.toString() &&foodi_follow[index]==true ?
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                Color(0xFF1E2026),
                                                content: new Text(
                                                  "Do you want to Unfollow " +
                                                      _con.searchFOODIS[index]
                                                      ["name"]
                                                          .toString() +
                                                      " ?",
                                                  style: f14w,
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFFffd55e),
                                                    child: new Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                  ),
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFF48c0d8),
                                                    child: new Text(
                                                      "Unfollow",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                     /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                      setState(() {

                                                        foodi_follow[index] = false;
                                                        _con.searchFOODIS[index]['follow_status'] = false;
                                                      });
                                                      _con.followerController(
                                                          userid.toString(),
                                                          _con.searchFOODIS[index]['user_id']
                                                              .toString());
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Unfollow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )):
                                  _con.searchFOODIS[index]['user_id'].toString()!=userid.toString() &&foodi_follow[index]==false ? GestureDetector(
                                      onTap: () {
                                        setState(() {

                                          foodi_follow[index] = true;
                                          _con.searchFOODIS[index]['follow_status'] = true;
                                        });
                                        _con.followerController(
                                            userid.toString(),
                                            _con.searchFOODIS[index]['user_id']
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Follow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )) :Container(height: 0,)
                                ],
                              ));
                        }) :  Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/search_screen.png",height: 100,color: Colors.white,),
                            Text("No Results Found",style: f21wB,),
                            SizedBox(height: 5,),
                            Text("Enter a few words to search in Butomy",style: f15w,),
                          ],
                        ),
                      ),
                    ),
                    // tab 3
                    _con.searchKITCHEN.length>0 ?
                    ListView.builder(

                        scrollDirection: Axis.vertical,
                        itemCount: _con.searchKITCHEN.length,
                        itemBuilder: (BuildContext context, int index) {
                          _con.searchKITCHEN[index]['follow_status'] == true ? kit_follow[index]=true : kit_follow[index] = false;
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 5.0, top: 12, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>KitchenProf(currentindex: 1,memberdate: "",pagid:  _con.searchKITCHEN[index]['page_id'].toString(),
                                            timid:  _con.searchKITCHEN[index]['timeline_id'].toString(), )
                                      ));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap:(){
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: Color(
                                                          0xFF1E2026),
                                                      content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                        imageUrl: _con
                                                            .searchKITCHEN[index]["profile_image"].toString()!="" ?
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                            .searchKITCHEN[index]["profile_image"]
                                                            .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                                        height: 250,
                                                        fit: BoxFit
                                                            .fitWidth,
                                                      ),
                                                    ));
                                          },
                                          child: Container(
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundImage: CachedNetworkImageProvider(
                                                _con
                                                    .searchKITCHEN[index]["profile_image"].toString()!="" ?
                                                "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                    .searchKITCHEN[index]["profile_image"]
                                                    .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _con.searchKITCHEN[index]['name'],
                                                style: f14wB,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _con.searchKITCHEN[index]['user_id'].toString()!=userid.toString() &&kit_follow[index]==true ?GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                Color(0xFF1E2026),
                                                content: new Text(
                                                  "Do you want to Unfollow " +
                                                      _con.searchKITCHEN[index]
                                                      ["name"]
                                                          .toString() +
                                                      " ?",
                                                  style: f14w,
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFFffd55e),
                                                    child: new Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                  ),
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFF48c0d8),
                                                    child: new Text(
                                                      "Unfollow",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                      setState(() {
                                                       
                                                        kit_follow[index] = false;
                                                        _con.searchKITCHEN[index]['follow_status'] = false;
                                                      });
                                                       _con.BusinessFollowunFollow(
                                                        _con.searchKITCHEN[index]['page_id'].toString(),
                                                        userid.toString(),);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Unfollow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )):
                                  _con.searchKITCHEN[index]['user_id'].toString()!=userid.toString() &&kit_follow[index]==false ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                         
                                          kit_follow[index] = true;
                                          _con.searchKITCHEN[index]['follow_status'] = true;
                                        });
                                        _con.followerController(
                                            userid.toString(),
                                            _con.searchKITCHEN[index]['user_id']
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Follow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )) :Container(height: 0,)
                                ],
                              ));
                        }) :  Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/search_screen.png",height: 100,color: Colors.white,),
                            Text("No Results Found",style: f21wB,),
                            SizedBox(height: 5,),
                            Text("Enter a few words to search in Butomy",style: f15w,),
                          ],
                        ),
                      ),
                    ),
                    //tab 4
                    _con.searchSTORE.length>0 ?
                    ListView.builder(

                        scrollDirection: Axis.vertical,
                        itemCount: _con.searchSTORE.length,
                        itemBuilder: (BuildContext context, int index) {
                          _con.searchSTORE[index]['follow_status'] == true ? sto_follow[index]=true : sto_follow[index] = false;
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 5.0, top: 12, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>StoreProf(currentindex: 1,memberdate: "",pagid:  _con.searchSTORE[index]['page_id'].toString(),
                                            timid:  _con.searchSTORE[index]['timeline_id'].toString(), )
                                      ));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap:(){
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: Color(
                                                          0xFF1E2026),
                                                      content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                        imageUrl: _con
                                                            .searchSTORE[index]["profile_image"].toString()!="" ?
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                            .searchSTORE[index]["profile_image"]
                                                            .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                                        height: 250,
                                                        fit: BoxFit
                                                            .fitWidth,
                                                      ),
                                                    ));
                                          },
                                          child: Container(
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundImage: CachedNetworkImageProvider(
                                                  _con
                                                      .searchSTORE[index]["profile_image"].toString()!="" ?
                                                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                      .searchSTORE[index]["profile_image"]
                                                      .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _con.searchSTORE[index]['name'],
                                                style: f14wB,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _con.searchSTORE[index]['user_id'].toString()!=userid.toString() &&sto_follow[index]==true ?
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                Color(0xFF1E2026),
                                                content: new Text(
                                                  "Do you want to Unfollow " +
                                                      _con.searchSTORE[index]
                                                      ["name"]
                                                          .toString() +
                                                      " ?",
                                                  style: f14w,
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFFffd55e),
                                                    child: new Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                  ),
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFF48c0d8),
                                                    child: new Text(
                                                      "Unfollow",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                      setState(() {
                                                       
                                                        sto_follow[index] = false;
                                                        _con.searchSTORE[index]['follow_status'] = false;
                                                      });
                                                      _con.BusinessFollowunFollow(
                                                        _con.searchSTORE[index]['page_id'].toString(),
                                                        userid.toString(),);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Unfollow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )):
                                  _con.searchSTORE[index]['user_id'].toString()!=userid.toString() &&sto_follow[index]==false ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                         
                                          sto_follow[index] = true;
                                          _con.searchSTORE[index]['follow_status'] = true;
                                        });
                                        _con.followerController(
                                            userid.toString(),
                                            _con.searchSTORE[index]['user_id']
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Follow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )) :Container(height: 0,)
                                ],
                              ));
                        }) :  Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/search_screen.png",height: 100,color: Colors.white,),
                            Text("No Results Found",style: f21wB,),
                            SizedBox(height: 5,),
                            Text("Enter a few words to search in Butomy",style: f15w,),
                          ],
                        ),
                      ),
                    ),
                    // tab 5
                    _con.searchMARKET.length>0 ?
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _con.searchMARKET.length,
                        itemBuilder: (BuildContext context, int index) {
                          _con.searchMARKET[index]['follow_status'] == true ? foodi_follow[index]=true : foodi_follow[index] = false;
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 5.0, top: 12, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TimelineFoodWallDetailPage(
                                                id: _con.searchMARKET[index]['user_id'].toString(),
                                              )));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap:(){
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: Color(
                                                          0xFF1E2026),
                                                      content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                        imageUrl: _con
                                                            .searchMARKET[index]["profile_image"]
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
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundImage: CachedNetworkImageProvider(
                                                _con.searchMARKET[index]['profile_image'].toString().replaceAll(" ", "%20")+"?alt=media",),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _con.searchMARKET[index]['name'],
                                                style: f14wB,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _con.searchMARKET[index]['user_id'].toString()!=userid.toString() &&foodi_follow[index]==true ?
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                Color(0xFF1E2026),
                                                content: new Text(
                                                  "Do you want to Unfollow " +
                                                      _con.searchMARKET[index]
                                                      ["name"]
                                                          .toString() +
                                                      " ?",
                                                  style: f14w,
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFFffd55e),
                                                    child: new Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                  ),
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFF48c0d8),
                                                    child: new Text(
                                                      "Unfollow",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                      setState(() {
                                                       
                                                        foodi_follow[index] = false;
                                                        _con.searchMARKET[index]['follow_status'] = false;
                                                      });
                                                      _con.followerController(
                                                          userid.toString(),
                                                          _con.searchMARKET[index]['user_id']
                                                              .toString());
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Unfollow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )):
                                  _con.searchMARKET[index]['user_id'].toString()!=userid.toString() &&foodi_follow[index]==false ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                         
                                          foodi_follow[index] = true;
                                          _con.searchMARKET[index]['follow_status'] = true;
                                        });
                                        _con.followerController(
                                            userid.toString(),
                                            _con.searchMARKET[index]['user_id']
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Follow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )) :Container(height: 0,)
                                ],
                              ));
                        }) :  Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/search_screen.png",height: 100,color: Colors.white,),
                            Text("No Results Found",style: f21wB,),
                            SizedBox(height: 5,),
                            Text("Enter a few words to search in Butomy",style: f15w,),
                          ],
                        ),
                      ),
                    ),
                    // tab 6
                    _con.searchRESTAURANT.length>0 ?
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _con.searchRESTAURANT.length,
                        itemBuilder: (BuildContext context, int index) {
                          _con.searchRESTAURANT[index]['follow_status'] == true ? res_follow[index]=true : res_follow[index] = false;
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 5.0, top: 12, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>RestProf(currentindex: 1,memberdate: "",pagid:  _con.searchRESTAURANT[index]['page_id'].toString(),
                                            timid:  _con.searchRESTAURANT[index]['timeline_id'].toString(), )
                                      ));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap:(){
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: Color(
                                                          0xFF1E2026),
                                                      content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                        imageUrl:  _con
                                                            .searchRESTAURANT[index]["profile_image"].toString()!="" ?
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                            .searchRESTAURANT[index]["profile_image"]
                                                            .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                                        height: 250,
                                                        fit: BoxFit
                                                            .fitWidth,
                                                      ),
                                                    ));
                                          },
                                          child: Container(
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundImage: CachedNetworkImageProvider(
                                                  _con
                                                      .searchRESTAURANT[index]["profile_image"].toString()!="" ?
                                                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                      .searchRESTAURANT[index]["profile_image"]
                                                      .toString().replaceAll(" ", "%20") + "?alt=media" :
                                                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _con.searchRESTAURANT[index]['name'],
                                                style: f14wB,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _con.searchRESTAURANT[index]['user_id'].toString()!=userid.toString() &&res_follow[index]==true ?
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                Color(0xFF1E2026),
                                                content: new Text(
                                                  "Do you want to Unfollow " +
                                                      _con.searchRESTAURANT[index]
                                                      ["name"]
                                                          .toString() +
                                                      " ?",
                                                  style: f14w,
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFFffd55e),
                                                    child: new Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                  ),
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFF48c0d8),
                                                    child: new Text(
                                                      "Unfollow",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                      setState(() {
                                                       
                                                        res_follow[index] = false;
                                                        _con.searchRESTAURANT[index]['follow_status'] = false;
                                                      });
                                                      _con.BusinessFollowunFollow(
                                                        _con.searchRESTAURANT[index]['page_id'].toString(),
                                                        userid.toString(),);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Unfollow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )):
                                  _con.searchRESTAURANT[index]['user_id'].toString()!=userid.toString() &&res_follow[index]==false ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                         
                                          res_follow[index] = true;
                                          _con.searchRESTAURANT[index]['follow_status'] = true;
                                        });
                                        _con.followerController(
                                            userid.toString(),
                                            _con.searchRESTAURANT[index]['user_id']
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Follow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )) :Container(height: 0,)
                                ],
                              ));
                        }) :  Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/search_screen.png",height: 100,color: Colors.white,),
                            Text("No Results Found",style: f21wB,),
                            SizedBox(height: 5,),
                            Text("Enter a few words to search in Butomy",style: f15w,),
                          ],
                        ),
                      ),
                    ),
                    // tab 7
                    _con.searchBANK.length>0 ?
                    ListView.builder(

                        scrollDirection: Axis.vertical,
                        itemCount: _con.searchBANK.length,
                        itemBuilder: (BuildContext context, int index) {
                          _con.searchBANK[index]['follow_status'] == true ? foodi_follow[index]=true : foodi_follow[index] = false;
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 5.0, top: 12, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TimelineFoodWallDetailPage(
                                                id: _con.searchBANK[index]['user_id'].toString(),
                                              )));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap:(){
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: Color(
                                                          0xFF1E2026),
                                                      content: CachedNetworkImage(placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,),
                                                        imageUrl: _con
                                                            .searchBANK[index]["profile_image"]
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
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundImage: CachedNetworkImageProvider(
                                                _con.searchBANK[index]['profile_image'].toString().replaceAll(" ", "%20")+"?alt=media",),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _con.searchBANK[index]['name'],
                                                style: f14wB,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _con.searchBANK[index]['user_id'].toString()!=userid.toString() &&foodi_follow[index]==true ?
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                Color(0xFF1E2026),
                                                content: new Text(
                                                  "Do you want to Unfollow " +
                                                      _con.searchBANK[index]
                                                      ["name"]
                                                          .toString() +
                                                      " ?",
                                                  style: f14w,
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFFffd55e),
                                                    child: new Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                  ),
                                                  MaterialButton(
                                                    height: 28,
                                                    color: Color(0xFF48c0d8),
                                                    child: new Text(
                                                      "Unfollow",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      /* _con.BusinessFollowunFollow(
                                                        _con.searchPOSTS[index]['business_page_id'].toString(),
                                                        userid.toString(),);*/
                                                      setState(() {
                                                       
                                                        foodi_follow[index] = false;
                                                        _con.searchBANK[index]['follow_status'] = false;
                                                      });
                                                      _con.followerController(
                                                          userid.toString(),
                                                          _con.searchBANK[index]['user_id']
                                                              .toString());
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Unfollow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )):
                                  _con.searchBANK[index]['user_id'].toString()!=userid.toString() &&foodi_follow[index]==false ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                         
                                          foodi_follow[index] = true;
                                          _con.searchBANK[index]['follow_status'] = true;
                                        });
                                        _con.followerController(
                                            userid.toString(),
                                            _con.searchBANK[index]['user_id']
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF48c0d8),
                                              borderRadius: BorderRadius.circular(5)),
                                          height: 25,
                                          width: 85,
                                          child:Center(
                                            child: Text(
                                              "Follow",
                                              style: f14B,
                                            ),
                                          ),
                                        ),
                                      )) :Container(height: 0,)
                                ],
                              ));
                        }) :  Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/search_screen.png",height: 100,color: Colors.white,),
                            Text("No Results Found",style: f21wB,),
                            SizedBox(height: 5,),
                            Text("Enter a few words to search in Butomy",style: f15w,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );



    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xFF1E2026),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            // backgroundColor: Color(0xFF1E2026),
            backgroundColor: Color(0xFF1E2026),
            brightness: Brightness.dark,titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Container(
                height: 45.0,
                decoration: BoxDecoration(
                    color: Color(0xFF23252E),
                    border: Border.all(color: Colors.grey[800],
                      width: 1,),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15.0,
                          spreadRadius: 0.0)
                    ]),
                child: Center(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    /*  onEditingComplete: (){
                      _con.getTimelinesearch(_search.text);
                    },*/
                    onChanged: (val){
                      setState(() {
                        _isSearching = true;
                      });
                      val.toString().length>2 ? _con.getTimelinesearch(val) : null;
                    },
                    controller: _search,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 9),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,size: 21,
                          color: Colors.white,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            Icons.clear,size: 21,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _isSearching=false;
                            setState(() {
                              _search.text="";
                            });
                          },
                        ),
                        hintText: "Search",
                        hintStyle: f15g),
                  ),
                ),
              ),
            ),
          ),
          body: _tabModules,
        ),

      ],
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.clear),
            hintText: "Find you want",
            hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: "Sofia",
                fontWeight: FontWeight.w400)),
      ),
    );
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
