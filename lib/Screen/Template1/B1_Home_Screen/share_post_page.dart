import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
as repo;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

var contheight=50;

class SharePost extends StatefulWidget {
  SharePost({this.postid,this.sharepost});
  String postid,sharepost;

  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends StateMVC<SharePost> {

  TimelineWallController _con;

  _SharePostState() : super(TimelineWallController()) {
    _con = controller;
  }

  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post', widget.sharepost, 'text/plain');
    } catch (e) {
      //print('error: $e');
    }
  }

  @override
  void initState() {
    _con.getFollowing(userid.toString());
    setState(() {
      _sharee.text = "";
    });
    // TODO: implement initState
    super.initState();
   // print("posttt iddd & sharepost "+widget.postid+" "+widget.sharepost);
  }


  TextEditingController _sharee = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(brightness: Brightness.dark,
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        title: Text("Share Post",style:TextStyle(color:Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 12.0, top: 5, right: 10, left: 10),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 35.0,
                      width: 35.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: repo.AbtInfo != null
                                  ? CachedNetworkImageProvider(
                                  userPIC)
                                  : CachedNetworkImageProvider(
                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                              Radius.circular(180.0))),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            NAME,
                            style: f15wB,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: contheight.toDouble(),
                        width:
                        MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                            color: Color(0xFF23252E),
                            borderRadius:
                            BorderRadius.circular(8)),
                        child: Center(
                          child: TextField(
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            onChanged: (val){
                              if(val.length>50)
                                setState(() {contheight=100;});
                              else
                                setState(() {contheight=50;});
                            },
                            controller: _sharee,
                            // controller: _loc,
                            style:
                            TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                "    Write a Message....",
                                hintStyle: f14g),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _con.shareTimelinePost(context,
                                  userid.toString(), _sharee.text,
                                  widget.postid.toString());
                            },
                            child: Container(
                              height: 28,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Color(0xFFffd55e),
                                  borderRadius:
                                  BorderRadius.circular(8)),
                              child: Center(
                                  child: Text(
                                    "Share Now",
                                    style: f14B,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await launch("https://wa.me/?text=" +
                        widget.sharepost.toString());
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/Template1/image/Foodie/wtsp.png",
                          height: 33,
                          width: 33,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sent in WhatsApp",
                          style: f14w,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: InkWell(
                    onTap: () async {
                      _shareText();
                    },
                    child: Container(
                      height: 35,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/share.png",
                            height: 18,
                            width: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "More Options...",
                            style: f14w,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 43,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextField(
                      // controller: _loc,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(bottom: 0,top: 9),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white54,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: f14g),
                    ),
                  ),
                ),
                _con.followingList.length>0 ?  Container(
                  height: 60.toDouble()*_con.followingList.length,
                  child: ListView.builder(
                    itemCount:_con.followingList.length,
                    itemBuilder: (context,ind){
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF1E2016),
                                      image: DecorationImage(
                                          image:
                                          CachedNetworkImageProvider(
                                            _con.followingList[ind]['picture'].toString().replaceAll(" ", "%20")+"?alt=media",
                                            errorListener: () =>
                                            new Icon(Icons.error),
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(180.0))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _con.followingList[ind]['name'],
                                      style: f14wB,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _con.followingList[ind]['username'],
                                      style: f13g,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap:(){
                                try {
                                  String chatID = makeChatId(userid.toString(), _con
                                      .followingList[
                                  ind]
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
                                                  .followingList[
                                              ind]
                                              [
                                              'device_token']
                                                  .toString(),
                                              _con
                                                  .followingList[
                                              ind]
                                              [
                                              'user_id']
                                                  .toString(),
                                              chatID,
                                              _con
                                                  .followingList[
                                              ind]
                                              [
                                              'username']
                                                  .toString(), _con
                                              .followingList[
                                          ind]
                                          [
                                          'name']
                                              .toString(),
                                              _con
                                                  .followingList[
                                              ind]
                                              [
                                              'picture']
                                                  .toString()
                                                  .replaceAll(
                                                  " ", "%20") +
                                                  "?alt=media",widget.sharepost)));
                                } catch (e) {
                                  print(e.message);
                                }
                              },
                              child: Container(
                                height: 25,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Color(0xFF48c0d9),
                                    borderRadius:
                                    BorderRadius.circular(4)),
                                child: Center(
                                    child: Text(
                                      "Send",
                                      style: f14wB,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      );
                    },

                  ),
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
