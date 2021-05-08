import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/FIREBASE/chat_link_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
DateTime _date;
DateTime _date2;
var dp;
var d;
var e;
var d2;

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends StateMVC<Notifications>
    with SingleTickerProviderStateMixin {
  TimelineWallController _con;

  _NotificationsState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    setState(() {
      _con.notificationListarr=NOTIFICATIONLIST;
    });
    // TODO: implement initState
    super.initState();
    _con.notificationRead(userid.toString());
    _con.notification(userid.toString());
  }

  @override
  Widget build(BuildContext context) {
    // _con.notification(userid.toString());
    return Scaffold(
        backgroundColor: Color(0xFF1E2026),
        appBar: AppBar(brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          title: Text(
            "Activity",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
           /* Center(
              child: Visibility(
                  visible: _con.notificationStatus,
                  child: Container(
                      margin: EdgeInsets.only(top: 250, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),*/
            _con.notificationListarr!=null  ?  Expanded(
              // height: MediaQuery.of(context).size.height-90,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(thickness: 1,color: Colors.black87,);
                },
                itemCount: _con.notificationListarr["data"].length,
                physics: const AlwaysScrollableScrollPhysics (),
                itemBuilder: (BuildContext context, int index) {
                  _date = DateTime.parse(
                      _con.notificationListarr["data"][index]['created_at']
                      ['date']);

                  var c =
                      DateTime
                          .now()
                          .difference(_date)
                          .inHours;

                  c > 24 && c<=48
                      ? d="Yesterday  at  " : c > 48?  d =DateFormat.MMMd().format(_date)+"  at  "
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
                  e= DateFormat.jm().format(_date);
                  return Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 12, bottom: 12),
                      child: InkWell(
                        onTap: (){
                          _con.notificationListarr["data"][index]["type"]== "follow" ||
                              _con.notificationListarr["data"][index]["type"]== "unfollow" ?
                          Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => TimelineFoodWallDetailPage(
                                        id: _con.notificationListarr["data"][index]['user_id']
                                            .toString(),))) :  _con.notificationListarr["data"][index]["type"]== "mention" ||
                              _con.notificationListarr["data"][index]["type"]== "like_post" ?  Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>ChatLinkDetailPage(post_id: _con.notificationListarr["data"][index]['post_id']
                                  .toString(),)
                          )) : null;
                          /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TimelineFoodWallDetailPage(
                                  id: _con.followersList[index]['user_id'].toString(),
                                )));*/
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: <Widget>[
                                Container(
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundImage: CachedNetworkImageProvider(
                                      _con.notificationListarr["data"][index]['picture'].toString().replaceAll(" ", "%20")+"?alt=media",),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width: MediaQuery.of(context).size.width-66,
                                      child: Text(
                                     _con.notificationListarr["data"][index]['description'],
                                        style: f14wB,
                                      ),
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: [
                                        Text(d ,style: f11p,),
                                        d.toString().contains("ago")?Container() : Text(e,style: f11p,),
                                      ],
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            /* Padding(
                              padding: const EdgeInsets.only(right:5.0),
                              child: Column(
                                children: [

                                ],
                              ),
                            )*/
                          ],
                        ),

                      ));

                },
              ),

            ) :  _con.notificationStatus == false ? Center(child: Padding(
              padding: const EdgeInsets.only(top:250.0),
              child: Text("No Notifications",style: f16wB,),
            )):Container(height: 0,),
          ],
        ));
  }
}
