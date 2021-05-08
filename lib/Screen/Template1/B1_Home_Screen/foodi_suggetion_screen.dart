import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SuggestionScreen extends StatefulWidget {

  SuggestionScreen({this.uid});

  String uid;

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends StateMVC<SuggestionScreen> {

  TimelineWallController _con;

  _SuggestionScreenState() : super(TimelineWallController()){
    _con = controller;
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(backgroundColor: Color(0xFF1E2026),
        contentPadding: EdgeInsets.only(top: 10, left: 10),
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23, alignment: Alignment.topLeft,
        ),
        titlePadding: EdgeInsets.all(10),
        content: new Text("Are you sure you want to exit?",
            style: f15w),
        actions:
        <Widget>[
          MaterialButton(
            height: 28,
            color: Color(0xFFffd55e),
            child: new Text(
              "Cancel",
              style: TextStyle(
                  color: Colors
                      .black),
            ),
            onPressed: () => Navigator.of(context).pop(false),

          ),
          SizedBox(width: 15,),
          MaterialButton(
            height: 28,
            color: Color(0xFF48c0d8),
            child: new Text(
              "Ok",
              style: TextStyle(
                  color: Colors
                      .black),
            ),
            onPressed: () => Navigator.of(context).pop(true),

          ),
        ],

      ),
    ));
  }
  @override
  void initState() {
    _con.getSuggetstion();
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xFF1E2026),
        appBar: AppBar(
          // titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          brightness: Brightness.dark,
          elevation: 5,
          title: Image.asset(
            "assets/Template1/image/Foodie/logo.png",height: 23,
          ),
          actions: [
           Padding(
             padding: const EdgeInsets.only(right:8.0),
             child: GestureDetector(
               onTap: (){
                 _con.splashgetTimelineWall(context,widget.uid);
               },
               child: Center(
                 child: Container(
                   height: 30,
                   width: 70,
                   decoration: BoxDecoration(
                       color: Color(0xFFffd55e),
                       borderRadius: BorderRadius.circular(12)
                   ),
                   child: Center(child: Text("Next",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),)),
                 ),
               ),
             ),
           )
          ],
        ),
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left:16,top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Foodie Suggestions:",style: f18wB,),
                SizedBox(
                  height: 8,
                ),
                _con.sugStatus==false && _con.suggestionFLIST.length>0 ? Container(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: _con.suggestionFLIST.length,
                      itemBuilder: (context,index){
                    return Padding(
                      padding:  EdgeInsets.only(left:index==0 ? 0 :6,right: 6),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 125,
                            width: MediaQuery.of(context).size.width/3.5,
                            decoration:  BoxDecoration(color: Color(0xFF1E2026),boxShadow: [
                              BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.6),
                                  blurRadius: 6.0,
                                  spreadRadius: 0.0)
                            ],
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(height: 65,
                                  width: 65,clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: CachedNetworkImage(imageUrl: _con.suggestionFLIST[index]["picture"].toString().contains("firebasestorage.googleapis") ?
                                  _con.suggestionFLIST[index]["picture"].toString()+"?alt=media" : _con.suggestionFLIST[index]["picture"].toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (
                                        context,
                                        ind) =>
                                        Container(
                                          height: 65,
                                          width: 65,clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: Image
                                              .asset(
                                            "assets/Template1/image/Foodie/post_dummy.jpeg",
                                            fit: BoxFit
                                                .cover,),
                                        ),),
                                ),
                                SizedBox(height: 5,),
                                Text(_con.suggestionFLIST[index]["name"],style: f14wB,),
                                // Text("Cardio Specialist",style: f13,),
                                // Text("Quebec",style: f13,)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: (){
                              if(_con.suggestionFLIST[index]["follow_status"]==true)
                             {
                               showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                      Color(0xFF1E2026),
                                      content: new Text(
                                        "Do you want to Unfollow " + _con.suggestionFLIST[index]["name"].toString() + " ?",
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
                                            setState(() {
                                              _con.suggestionFLIST[index]["follow_status"] = false;
                                            });
                                            _con.sugfollowerController(
                                                widget.uid.toString(),
                                                _con.suggestionFLIST[index]['id']
                                                    .toString());
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });}
                              else
                                {
                                  setState(() {
                                    _con.suggestionFLIST[index]["follow_status"] = true;
                                  });
                                  _con.sugfollowerController(
                                      widget.uid.toString(),
                                      _con.suggestionFLIST[index]['id']
                                          .toString());
                                }
                            },
                            child: Container(
                              height: 27,
                              width: MediaQuery.of(context).size.width/3.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color(0xFF48c0d8)
                              ),
                              child: Center(child: Text(_con.suggestionFLIST[index]["follow_status"] == true ? "Unfollow" : "Follow",style: f14B,)),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                )
                : Center(
                  child: Container(height: 190,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:16.0),
                  child: Divider(color: Colors.grey[700],thickness: .2,),
                ),
                SizedBox(
                    height: 10
                ),
                Text("Restaurant Suggestions:",style: f18wB,),
                SizedBox(
                  height: 8,
                ),
                _con.sugStatus==false && _con.suggestionRLIST.length>0 ? Container(
                  height: 190,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _con.suggestionRLIST.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding:  EdgeInsets.only(left:index==0 ? 0 :6,right: 6),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 125,
                                width: MediaQuery.of(context).size.width/3.5,
                                decoration:  BoxDecoration(color: Color(0xFF1E2026),boxShadow: [
                                  BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.6),
                                      blurRadius: 6.0,
                                      spreadRadius: 0.0)
                                ],
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(height: 65,
                                      width: 65,clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: CachedNetworkImage(imageUrl: _con.suggestionRLIST[index]["profile_image"].toString()=="" ?
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media" :
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.suggestionRLIST[index]["profile_image"].toString()+"?alt=media",
                                        fit: BoxFit.cover,
                                        placeholder: (
                                            context,
                                            ind) =>
                                            Container(
                                              height: 65,
                                              width: 65,clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Image
                                                  .asset(
                                                "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                fit: BoxFit
                                                    .cover,),
                                            ),),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(_con.suggestionRLIST[index]["name"],style: f14wB,textAlign: TextAlign.center,),
                                    // Text("Cardio Specialist",style: f13,),
                                    // Text("Quebec",style: f13,)
                                  ],
                                )
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: (){
                                  if(_con.suggestionRLIST[index]["follow_status"]==true)
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                            Color(0xFF1E2026),
                                            content: new Text(
                                              "Do you want to Unfollow " + _con.suggestionRLIST[index]["name"].toString() + " ?",
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
                                                  setState(() {
                                                    _con.suggestionRLIST[index]["follow_status"] = false;
                                                  });
                                                  _con.BusinessFollowunFollow(
                                                    _con.suggestionRLIST[index]['page_id'].toString(),
                                                    widget.uid.toString(),);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });}
                                  else
                                  {
                                    setState(() {
                                      _con.suggestionRLIST[index]["follow_status"] = true;
                                    });
                                    _con.BusinessFollowunFollow(
                                      _con.suggestionRLIST[index]['page_id'].toString(),
                                      widget.uid.toString(),);
                                  }
                                },
                                child: Container(
                                  height: 27,
                                  width: MediaQuery.of(context).size.width/3.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Color(0xFF48c0d8)
                                  ),
                                  child: Center(child: Text(_con.suggestionRLIST[index]["follow_status"] == true ? "Unfollow" : "Follow",style: f14B,)),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
                    : Center(
                  child: Container(height: 190,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:16.0),
                  child: Divider(color: Colors.grey[700],thickness: .2,),
                ),
                SizedBox(
                    height: 10
                ),
                Text("HomeKitchen Suggestions:",style: f18wB,),
                SizedBox(
                  height: 8,
                ),
                _con.sugStatus==false && _con.suggestionHLIST.length>0 ? Container(
                  height: 190,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _con.suggestionHLIST.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding:  EdgeInsets.only(left:index==0 ? 0 :6,right: 6),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 125,
                                width: MediaQuery.of(context).size.width/3.5,
                                decoration:  BoxDecoration(color: Color(0xFF1E2026),boxShadow: [
                                  BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.6),
                                      blurRadius: 6.0,
                                      spreadRadius: 0.0)
                                ],
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(height: 65,
                                      width: 65,clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: CachedNetworkImage(imageUrl: _con.suggestionHLIST[index]["profile_image"].toString()=="" ?
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media" :
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.suggestionHLIST[index]["profile_image"].toString()+"?alt=media",
                                        fit: BoxFit.cover,
                                        placeholder: (
                                            context,
                                            ind) =>
                                            Container(
                                              height: 65,
                                              width: 65,clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Image
                                                  .asset(
                                                "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                fit: BoxFit
                                                    .cover,),
                                            ),),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(_con.suggestionHLIST[index]["name"],style: f14wB,textAlign: TextAlign.center,),
                                    // Text("Cardio Specialist",style: f13,),
                                    // Text("Quebec",style: f13,)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: (){
                                  if(_con.suggestionHLIST[index]["follow_status"]==true)
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                            Color(0xFF1E2026),
                                            content: new Text(
                                              "Do you want to Unfollow " + _con.suggestionHLIST[index]["name"].toString() + " ?",
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
                                                  setState(() {
                                                    _con.suggestionHLIST[index]["follow_status"] = false;
                                                  });
                                                  _con.BusinessFollowunFollow(
                                                    _con.suggestionHLIST[index]['page_id'].toString(),
                                                    widget.uid.toString(),);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });}
                                  else
                                  {
                                    setState(() {
                                      _con.suggestionHLIST[index]["follow_status"] = true;
                                    });
                                    _con.BusinessFollowunFollow(
                                      _con.suggestionHLIST[index]['page_id'].toString(),
                                      widget.uid.toString(),);
                                  }
                                },
                                child: Container(
                                  height: 27,
                                  width: MediaQuery.of(context).size.width/3.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Color(0xFF48c0d8)
                                  ),
                                  child: Center(child: Text(_con.suggestionHLIST[index]["follow_status"] == true ? "Unfollow" : "Follow",style: f14B,)),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
                    : Center(
                  child: Container(height: 190,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:16.0),
                  child: Divider(color: Colors.grey[700],thickness: .2,),
                ),
                SizedBox(
                    height: 10
                ),
                Text("Local Store Suggestions:",style: f18wB,),
                SizedBox(
                  height: 8,
                ),
                _con.sugStatus==false && _con.suggestionSLIST.length>0 ? Container(
                  height: 190,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _con.suggestionSLIST.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding:  EdgeInsets.only(left:index==0 ? 0 :6,right: 6),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 125,
                                width: MediaQuery.of(context).size.width/3.5,
                                decoration:  BoxDecoration(color: Color(0xFF1E2026),boxShadow: [
                                  BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.6),
                                      blurRadius: 6.0,
                                      spreadRadius: 0.0)
                                ],
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(height: 65,
                                      width: 65,clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: CachedNetworkImage(imageUrl: _con.suggestionSLIST[index]["profile_image"].toString()=="" ?
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media" :
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.suggestionSLIST[index]["profile_image"].toString()+"?alt=media",
                                        fit: BoxFit.cover,
                                        placeholder: (
                                            context,
                                            ind) =>
                                            Container(
                                              height: 65,
                                              width: 65,clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Image
                                                  .asset(
                                                "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                fit: BoxFit
                                                    .cover,),
                                            ),),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(_con.suggestionSLIST[index]["name"],style: f14wB,textAlign: TextAlign.center,),
                                    // Text("Cardio Specialist",style: f13,),
                                    // Text("Quebec",style: f13,)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: (){
                                  if(_con.suggestionSLIST[index]["follow_status"]==true)
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                            Color(0xFF1E2026),
                                            content: new Text(
                                              "Do you want to Unfollow " + _con.suggestionSLIST[index]["name"].toString() + " ?",
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
                                                  setState(() {
                                                    _con.suggestionSLIST[index]["follow_status"] = false;
                                                  });
                                                  _con.BusinessFollowunFollow(
                                                    _con.suggestionSLIST[index]['page_id'].toString(),
                                                    widget.uid.toString(),);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });}
                                  else
                                  {
                                    setState(() {
                                      _con.suggestionSLIST[index]["follow_status"] = true;
                                    });
                                    _con.BusinessFollowunFollow(
                                      _con.suggestionSLIST[index]['page_id'].toString(),
                                      widget.uid.toString(),);
                                  }
                                },
                                child: Container(
                                  height: 27,
                                  width: MediaQuery.of(context).size.width/3.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Color(0xFF48c0d8)
                                  ),
                                  child: Center(child: Text(_con.suggestionSLIST[index]["follow_status"] == true ? "Unfollow" : "Follow",style: f14B,)),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
                    : Center(
                      child: Container(height: 190,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                SizedBox(
                    height: 25
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
