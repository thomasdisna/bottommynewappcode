import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class BusinessFollowingPage extends StatefulWidget {
  BusinessFollowingPage({Key key,this.pageId,this.type}) : super(key: key);

  String pageId,type;

  @override
  _BusinessFollowingPageState createState() => _BusinessFollowingPageState();
}

class _BusinessFollowingPageState extends StateMVC<BusinessFollowingPage> {
  TextEditingController _Following = TextEditingController();

  HomeKitchenRegistration _con;

  _BusinessFollowingPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.HomeKitchenBusinessFollowing(widget.pageId.toString(),userid.toString());
  }
  @override
  Widget build(BuildContext context) {
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

      ),
      body:SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            children: [
              Container(
                  height: 20,
                  child: _con.busFollowing.length != 0 && _con.busstatusFollowing==false?Text(_con.busFollowing.length.toString()+" Followers", style: f15yB):Text(" 0 Following", style: f15yB)),
              Divider(thickness: 1,color:  Color(0xFFffd55e),),
              Center(
                child: Visibility(
                    visible: _con.busstatusFollowing,
                    child: Container(
                        margin: EdgeInsets.only(top: 250, ),
                        child: CircularProgressIndicator()
                    )
                ),
              ),
              
              Container(
                height: MediaQuery.of(context).size.height ,
                //height: _con.busstatusFollowing==false ? MediaQuery.of(context).size.height - 200 :  MediaQuery.of(context).size.height - 330,
                child: _con.busFollowing.length != 0 && _con.busstatusFollowing==false
                    ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _con.busFollowing.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Padding(
                          padding: EdgeInsets.only(

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
                                            id: _con.busFollowing[index]['user_id'].toString(),
                                          )));
                                },
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: CircleAvatar(
                                        backgroundImage: CachedNetworkImageProvider(
                                            _con.busFollowing[index]['picture'].toString().replaceAll(" ", "%20")+"?alt=media"),
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
                                            _con.busFollowing[index]['name'],
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
                                          child:  _con.busFollowing[index]['following_status']==true?Text(
                                            "Unfollow",
                                            style: f14B,
                                          ):Text(
                                            "Follow",
                                            style: f14B,
                                          ),
                                        ),
                                        onPressed: () {
                                         if( _con.busFollowing[index]['following_status']==true ){  showDialog(
                                              context: context,
                                              builder: (
                                                  BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor: Color(
                                                      0xFF1E2026),
                                                  content: new Text(
                                                    "Do you want to UnFollow "+_con.busFollowing[index]['name'].toString()+" ?",
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
                                                          _con.busFollowing[index]['following_status']=false;
                                                        });
                                                        _con.BusinessFollowunFollow(widget.pageId.toString(),userid.toString(),widget.type);
                                                        Navigator
                                                            .pop(
                                                            context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              })  ;}
                                         else{
                                           setState(() {
                                             _con.busFollowing[index]['following_status']=true;
                                           });
                                           _con.BusinessFollowunFollow(widget.pageId.toString(),userid.toString(),widget.type);
                      }


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
                    :  _con.busstatusFollowing == false ? Center(child: Text("No Followings",style: f16wB,)):Container(height: 0,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}