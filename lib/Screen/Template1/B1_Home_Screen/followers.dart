import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/kitchen_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/restaurant_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/store_prof.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Components/global_data.dart';
import '../../../Controllers/TimelineController/timelineWallController.dart';
int selectedId;
bool _isSearchingFollow;
String _searchTextFollow = "";
bool _isSearchingFollowing;
String _searchTextFollowing = "";
class Followers extends StatefulWidget {
  Followers({
    Key key,
    this.statusIndex,this.following,this.followers,this.user_id
  }) : super(key: key);
  int statusIndex;
  String followers,following,user_id;
  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends StateMVC<Followers>
    with SingleTickerProviderStateMixin {
  TabController _tabContoller;
  TextEditingController _Followers = TextEditingController();
  TextEditingController _Following = TextEditingController();

  TimelineWallController _con;

  _FollowersState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearchingFollow = false;
    _isSearchingFollowing = false;
    _con.getFollowers(widget.user_id,userid.toString());
    _con.getFollowing(widget.user_id);
    _tabContoller =
        TabController(length: 2, vsync: this, initialIndex: widget.statusIndex);
  }

  List _searchFollowerResult = [];
  List _searchFollowingResult = [];

  void searchOperation(String searchText) {
    _searchFollowerResult.clear();
    if (searchText.isEmpty) {
      setState(() {
        _Followers.text = "";
      });
      return;
    }

    _con.followersList.forEach((userDetail) {
      var ll = _searchFollowerResult.length;
      if (userDetail["name"].toString().toLowerCase().contains(searchText.toLowerCase()) )
      {
        print("REEEEE 555 "+userDetail.toString());
        setState(() {
          _searchFollowerResult.insert(ll,userDetail);
        });
      }
      print("REEEEE 333 "+_searchFollowerResult.toString());
    });

    setState(() {});
  }

  void searchOperationFollowing(String searchText) {
    _searchFollowingResult.clear();
    if (searchText.isEmpty) {
      setState(() {
        _Following.text = "";
      });
      return;
    }
    _con.followingList.forEach((userDetail) {
      var ll = _searchFollowingResult.length;
      if (userDetail["name"].toString().toLowerCase().contains(searchText.toLowerCase()) )
      {
        print("REEEEE 555 "+userDetail.toString());
        setState(() {
          _searchFollowingResult.insert(ll,userDetail);
        });
      }
      print("REEEEE 333 "+_searchFollowingResult.toString());
    });

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    _con.getFollowers(widget.user_id,userid.toString());
    searchOperation(_Followers.text);
    searchOperationFollowing(_Following.text);
    _con.getFollowing(widget.user_id);
    var _searchFollower = Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15, bottom: 3),
        child: InkWell(
          child: Container(
            height: 48.0,
            decoration: BoxDecoration(
                color: Color(0xFF23252E),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 0.0)
                ]),
            child: TextField(
              onChanged: searchOperation,
              controller: _Followers,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFffd55e),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        searchOperation('');
                      },
                      child: Icon(Icons.clear,color: Color(0xFFffd55e),)
                  ),
                  border: InputBorder.none,
                  hintText: " Search.....",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
        ));
    var _searchFollowing = Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15, bottom: 3),
        child: InkWell(
          child: Container(
            height: 48.0,
            decoration: BoxDecoration(
                color: Color(0xFF23252E),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 0.0)
                ]),
            child: TextField(
              onChanged: searchOperationFollowing,
              controller: _Following,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFffd55e),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        searchOperationFollowing('');
                      },
                      child: Icon(Icons.clear,color: Color(0xFFffd55e),)
                  ),
                  border: InputBorder.none,
                  hintText: " Search.....",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
        ));
    var _followersGridView =  Column(
      children: [
        Center(
          child: Visibility(
              visible: _con.statusFollower,
              child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3, ),
                  child: CircularProgressIndicator()
              )
          ),
        ),
        Container(
          height: _con.followersList.length.toDouble() * 51.4,
          // height: _con.statusFollower==false ? MediaQuery.of(context).size.height - 200 :  MediaQuery.of(context).size.height - 330,
          child: _searchFollowerResult.length != 0 && _con.statusFollower==false ?
          ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _searchFollowerResult.length,
              itemBuilder: (BuildContext context, int index) {
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
                                      id: _searchFollowerResult[index]['user_id'].toString(),
                                    )));
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: CachedNetworkImageProvider(
                                    _searchFollowerResult[index]['picture'].toString().replaceAll(" ", "%20")+"?alt=media",),
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
                                      _searchFollowerResult[index]['name'],
                                      style: f14wB,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            _searchFollowerResult[index]['user_id'].toString()!=userid?Container(
                              child:  _searchFollowerResult[index]['following_status']==true ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (
                                            BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Color(
                                                0xFF1E2026),
                                            content: new Text(
                                              "Do you want to Unfollow "+_searchFollowerResult[index]['name'].toString()+" ?",
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
                                                  _con.followerController(
                                                      userid.toString(),
                                                      _searchFollowerResult[index]['user_id']
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
                                        )
                                    ),
                                  )) :
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedId = index;
                                    });

                                    _con.followerController(
                                        userid.toString(),
                                        _searchFollowerResult[index]['user_id']
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
                                        )
                                    ),
                                  )),
                            ):Container(height: 0,),

                          ],
                        )
                      ],
                    ));
              }) : _con.followersList.length != 0 && _con.statusFollower==false
              ?  ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _con.followersList.length,
              itemBuilder: (BuildContext context, int index) {
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
                                      id: _con.followersList[index]['user_id'].toString(),
                                    )));
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: CachedNetworkImageProvider(
                                    _con.followersList[index]['picture'].toString().replaceAll(" ", "%20")+"?alt=media",),
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
                                      _con.followersList[index]['name'],
                                      style: f14wB,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            _con.followersList[index]['user_id'].toString()!=userid.toString() ? Container(
                              child:  _con.followersList[index]['following_status'] == true ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Color(
                                                0xFF1E2026),
                                            content: new Text(
                                              "Do you want to Unfollow "+_con.followersList[index]['name'].toString()+" ?",
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
                                                  _con.followerController(
                                                      userid.toString(),
                                                      _con.followersList[index]['user_id']
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
                                      )
                                    ),
                                  )) :
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedId = index;
                                    });
                                    _con.followerController(
                                        userid.toString(),
                                        _con.followersList[index]['user_id']
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
                                        )
                                    ),
                                  )),
                            ) : Container(height: 0,),
                          ],
                        ),
                      ],
                    ));
              })
              : _con.statusFollower == false ? Center(child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3, ),
            child: Text("No Followers",style: f16wB,),
          )):Container(height: 0,),
        )
      ],
    );
    var _followingGridView = Column(
      children: [
        Center(
          child: Visibility(
              visible: _con.statusFollowing,
              child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3, ),
                  child: CircularProgressIndicator()
              )
          ),
        ),
        Container(
          height: _con.followingList.length.toDouble() * 56,
          // height: _con.statusFollowing==false ? MediaQuery.of(context).size.height - 200 :  MediaQuery.of(context).size.height - 330,
          child: _searchFollowingResult.length != 0 && _con.statusFollowing==false
              ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
              itemCount: _searchFollowingResult.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,

                      right: 5.0,
                      top: 12,
                      bottom: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TimelineFoodWallDetailPage(
                                      id: _searchFollowingResult[index]['user_id'].toString(),
                                    )));
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: CachedNetworkImageProvider(
                                      _searchFollowingResult[index]['picture'].toString().replaceAll(" ", "%20")+"?alt=media"),
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
                                      _searchFollowingResult[index]['name'],
                                      style: f14wB,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Container(
                                height: 25,
                                child: MaterialButton(
                                  color: Color(0xFF48c0d8),
                                  child: Center(
                                    child: Text(
                                      "Unfollow",
                                      style: f14B,
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (
                                            BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Color(
                                                0xFF1E2026),
                                            content: new Text(
                                              "Do you want to Unfollow "+_searchFollowingResult[index]['name'].toString()+" ?",
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
                                                  _con.followingController(
                                                      userid.toString(),
                                                      _searchFollowingResult[index]['user_id']
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
                                ),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                );
              }) :
          _con.followingList.length != 0 && _con.statusFollowing==false
              ? ListView.builder(physics: NeverScrollableScrollPhysics(),
              // physics: NeverScrollableScrollPhysics(),
              itemCount: _con.followingList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,

                      right: 5.0,
                      top: 12,
                      bottom: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TimelineFoodWallDetailPage(
                                      id: _con.followingList[index]['user_id'].toString(),
                                    )));
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: CachedNetworkImageProvider(
                                      _con.followingList[index]['picture'].toString().replaceAll(" ", "%20")+"?alt=media"),
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
                                      _con.followingList[index]['name'],
                                      style: f14wB,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Container(
                                height: 25,
                                child: MaterialButton(
                                  color: Color(0xFF48c0d8),
                                  child: Center(
                                    child: Text(
                                      "Unfollow",
                                      style: f14B,
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (
                                            BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Color(
                                                0xFF1E2026),
                                            content: new Text(
                                              "Do you want to Unfollow "+_con.followingList[index]['name'].toString()+" ?",
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
                                                  _con.followingController(
                                                      userid.toString(),
                                                      _con.followingList[index]['user_id']
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
                                ),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
              :  _con.statusFollower == false ? Center(child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3, ),
            child: Text("No Followings",style: f16wB,),
          )):Container(height: 0,),
        ),
        Container(
          height: _con.businessFollowingList.length.toDouble() * 58,
          // height: _con.statusFollower==false ? MediaQuery.of(context).size.height - 200 :  MediaQuery.of(context).size.height - 330,
          child: _con.businessFollowingList.length > 0 && _con.statusFollowing==false
              ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),

              // physics: NeverScrollableScrollPhysics(),
              itemCount: _con.businessFollowingList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            _con.businessFollowingList[index]['business_type']==1 ?
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => KitchenProf(currentindex: 1,memberdate: "",pagid:  _con.businessFollowingList[index]['page_id'].toString(),
                                      timid:  _con.businessFollowingList[index]['timeline_id'].toString(), ))) :
                            _con.businessFollowingList[index]['business_type']==2 ?
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => StoreProf(currentindex: 1,memberdate: "",pagid:  _con.businessFollowingList[index]['page_id'].toString(),
                                      timid:  _con.businessFollowingList[index]['timeline_id'].toString(), ))) :
                            _con.businessFollowingList[index]['business_type']==3 ?  Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => RestProf(currentindex: 1,memberdate: "",pagid:  _con.businessFollowingList[index]['page_id'].toString(),
                                      timid:  _con.businessFollowingList[index]['timeline_id'].toString(), )))  : null
                            ;
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                          _con.businessFollowingList[index]['picture'].toString().replaceAll(" ", "%20")+"?alt=media"),
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
                                      _con.businessFollowingList[index]['name'],
                                      style: f14wB,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            _con.businessFollowingList[index]['user_id'].toString()!=userid ?Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                height: 25,
                                child: MaterialButton(
                                  color: Color(0xFF48c0d8),
                                  child: Text(
                                    _con.businessFollowingList[index]['following_status']==true ?  "Unfollow" : "Follow",
                                    style: f14B,
                                  ),
                                  onPressed: () {
                                    _con.businessFollowingList[index]['following_status']==true?  showDialog(
                                        context: context,
                                        builder: (
                                            BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Color(
                                                0xFF1E2026),
                                            content: new Text(
                                              "Do you want to Unfollow "+_con.businessFollowingList[index]['name'].toString()+" ?",
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
                                                  _con.BusinessFollowunFollow(
                                                    _con.businessFollowingList[index]['page_id']
                                                        .toString(),
                                                    userid.toString(),);
                                                  Navigator
                                                      .pop(
                                                      context);
                                                },
                                              ),
                                            ],
                                          );
                                        }) :  _con.BusinessFollowunFollow(
                                      _con.businessFollowingList[index]['page_id']
                                          .toString(),
                                      userid.toString(),);
                                  },
                                ),
                              ),
                            ):Container(height: 0,),

                          ],
                        )
                      ],
                    ));
              })
              :Container(height: 0,),
        ),
      ],
    );

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
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Color(0xFFffd55e),
          tabs: [
            new Tab(
              child: Text(
                _con.followersList.length.toString()+" Followers",
                style: f15B,
              ),
            ),
            new Tab(
              child: Text(_con.followingList.length.toString()+" Following", style: f15B),
            ),
          ],
          controller: _tabContoller,
          indicatorColor: Color(0xFFffd55e),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          controller: _tabContoller,
          children: <Widget>[
            Column(
              children: <Widget>[
                _searchFollower,
                _followersGridView,
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _searchFollowing,
                  _followingGridView,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}