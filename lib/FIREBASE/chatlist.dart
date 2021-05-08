import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/B1_Home_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/New_Entry_Form.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/notification.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'Fire_Contro/utils.dart';
import 'chatroom.dart';

class ChatList extends StatefulWidget {
  ChatList(this.myID, this.myName);

  String myID;
  String myName;

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends StateMVC<ChatList> {
  TimelineWallController _con;
  _ChatListState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    setState(() {
      chatLength=true;
    });
    FirebaseController.instanace.getUnreadMSGCount().then((value) {
      setState(() {
        chatmsgcount=value;
      });
    });
    _con.notification(userid.toString());
    _con.getFollowing(userid.toString());
    super.initState();
  }

  _setT(){
      chatLength = true;
      print(" CHHHHHHHAAAAAATTTTTTTTTTTTTTT");
  }

  _setF(){
    chatLength = false;
    print("NOOOO CHHHHHHHAAAAAATTTTTTTTTTTTTTT");
  }

  bool chatLength;
  @override
  Widget build(BuildContext context) {
    print("chatt length "+chatLength.toString());
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xFF1E2026),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black54,
                blurRadius: 2,
              ),
            ],
          ),
          height: 56,
          child: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                   /* Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TimeLine(false)));*/
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeLine(false)), (route) => false);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/home.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23,
                      ),
                      Text(
                        "Home",
                        style: f14w54,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(alignment: Alignment.topRight,
                      children: [
                        Container(width: 38,
                          child: Image.asset(
                            "assets/Template1/image/Foodie/icons/chat.png",
                            height: 21,
                            color: Color(0xFFffd55e),
                            width: 21,
                          ),
                        ),
                         chatmsgcount>0 ?   Container(
                          height: 14,width: 14,
                          decoration: BoxDecoration(
                              color: Color(0xFF0dc89e),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(child: Text(chatmsgcount.toString(),style: f10B,textAlign: TextAlign.center,)),
                        ) : Container()
                      ],
                    ),
                    Text(
                      "Chat",
                      style: f14y,
                    )
                  ],
                ),
                Container(
                  height: 42,
                  width: 42,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddNewEntries(videooo: "",vid_show: false,typpp: "",)));
                    },
                    elevation: 5,
                    backgroundColor: Color(0xFF48c0d9),
                    child: Icon(
                      Icons.add,
                      size: 35,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => purchase()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(alignment: Alignment.topRight,
                        children: [
                          Container(width: 40,
                            child: Image.asset(
                              "assets/Template1/image/Foodie/icons/shopping-basket.png",
                              height: 23,
                              color: Colors.white54,
                              width: 23,
                            ),
                          ),
                          purchasecount>0 ? Container(
                            height: 14,width: 14,
                            decoration: BoxDecoration(
                                color: Color(0xFF0dc89e),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text(purchasecount.toString(),style: f10B,textAlign: TextAlign.center,)),
                          ) : Container()
                        ],
                      ),
                      Text(
                        "Bucket list",
                        style: f14w54,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartScreenT1(null,null,false)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(alignment: Alignment.topRight,
                        children: [
                          Container(width: 38,
                            child: Image.asset(
                              "assets/Template1/image/Foodie/icons/cart.png",
                              height: 23,
                              color: Colors.white54,
                              width: 23,
                            ),
                          ),
                          cartCount > 0 ? Container(
                            height: 14, width: 14,
                            decoration: BoxDecoration(
                                color: Color(0xFF0dc89e),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text(
                              cartCount.toString(), style: f10B,
                              textAlign: TextAlign.center,)),
                          ) : Container()
                        ],
                      ),
                      Text(
                        "Cart",
                        style: f14w54,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          brightness: Brightness.dark,
          elevation: 5,
          title: Image.asset(
            "assets/Template1/image/Foodie/logo.png",
            height: 23,
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  splashColor: Color(0xFF48c0d8),
                  icon: Image.asset(
                    "assets/Template1/image/Foodie/icons/search.png",
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new searchAppbar()));
                  },
                ),
                IconButton(
                  splashColor: Color(0xFF48c0d8),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new QRCODE()));
                  },
                  icon: Image.asset(
                    "assets/Template1/image/Foodie/QRcode.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                IconButton(
                  splashColor: Color(0xFF48c0d8),
                  icon:  Stack(
                    children: [
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/bell.png",
                        height: 20,
                        width: 20,
                      ),
                      notificationReadStatus!=0 &&  notificationReadStatus!=null?
                      Padding(
                          padding: const EdgeInsets.only(left:11.0),
                          child: /*CircleAvatar(backgroundColor: Color(0xFF48c0d8),
        radius: 7,
        child: Center(child: Text(notificationCount.toString(),style: f10B,textAlign: TextAlign.center,)),
      ),*/Container(
                            height: 14,width: 14,
                            decoration: BoxDecoration(
                                color: Color(0xFF0dc89e),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text(notificationReadStatus.toString(),style: f10B,textAlign: TextAlign.center,)),
                          )
                      ) : Container(height: 0,)
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Notifications()));
                  },
                ),
                IconButton(
                  splashColor: Color(0xFF48c0d8),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new HomeScreenT1()));
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: userPIC != null&& userPIC!=""
                        ? CircleAvatar(
                      radius: 13,
                      backgroundImage: CachedNetworkImageProvider(
                        userPIC,

                      ),
                    )
                        : Image.asset(
                      "assets/Template1/image/Foodie/icons/person.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        backgroundColor: Color(0xFF1E2026),
      body: VisibilityDetector(
        key: Key("1"),
        onVisibilityChanged: ((visibility) {
          if (visibility.visibleFraction == 1.0) {
            FirebaseController.instanace.getUnreadMSGCount().then((value) {
              setState(() {
                chatmsgcount=value;
              });
            });
          }
        }),
        child: chatLength ? Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('users').orderBy('createdAt', descending: false).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                return countChatListUsers(timelineIdFoodi.toString(), snapshot) > 0
                ? Container(alignment: Alignment.topCenter,
                  child: ListView(primary: true,
                      children: snapshot.data.documents.reversed.map((data) {
                      if (data['userId'] ==timelineIdFoodi.toString()) {
                        return Container();
                      } else {
                        return StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('users')
                              .document(timelineIdFoodi.toString())
                              .collection('chatlist')
                              .where('chatWith', isEqualTo:  data['userId'],)
                              .snapshots(),
                          builder: (context, chatListSnapshot) {
                           chatListSnapshot.hasData ? _setT() : _setF();
                            return chatListSnapshot.hasData && chatListSnapshot.data.documents.length >0 && chatListSnapshot.data.documents[0]['chatWith'].toString()== data['userId'].toString() ?
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Container(height: 70,
                                  child: ListTile(
                                    leading: CircleAvatar(radius: 20,
                                      backgroundImage: CachedNetworkImageProvider(
                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"
                                            +data['userImageUrl']+"?alt=media",
                                              ),
                                    ),
                                            title: Text(data['name'],style: f15wB,),
                                            subtitle: Text((chatListSnapshot.hasData && chatListSnapshot.data.documents.length >0 && chatListSnapshot.data.documents[0]['lastChat'].toString().length>30)
                                                ? chatListSnapshot.data.documents[0]['lastChat'].toString().substring(0,30)+" ..." : (chatListSnapshot.hasData && chatListSnapshot.data.documents.length >0 &&chatListSnapshot.data.documents[0]['lastChat'].toString().length<30 )
                                                ? chatListSnapshot.data.documents[0]['lastChat'].toString()
                                                : data['username'],style: f13g,),
                                            trailing: Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 8, 4, 4),
                                                child: (chatListSnapshot.hasData && chatListSnapshot.data.documents.length > 0)
                                                    ? StreamBuilder<QuerySnapshot>(
                                                        stream: Firestore.instance
                                                            .collection('chatroom')
                                                            .document(chatListSnapshot.data.documents[0]['chatID'])
                                                            .collection(chatListSnapshot.data.documents[0]['chatID'])
                                                            .where('idTo',isEqualTo: timelineIdFoodi)
                                                            .where('isread', isEqualTo: false)
                                                            .snapshots(),
                                                        builder: (context,notReadMSGSnapshot) {
                                                          return Container(
                                                            width: 60,
                                                            height: 50,
                                                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Text((chatListSnapshot.hasData && chatListSnapshot.data.documents.length >0)
                                                                      ? readTimestamp(chatListSnapshot.data.documents[0]['timestamp'])
                                                                      : '',style: TextStyle(fontSize: 11,color: Colors.white70),
                                                                ),
                                                          (chatListSnapshot.hasData && chatListSnapshot.data.documents.length > 0)
                                                          && ((notReadMSGSnapshot.hasData && notReadMSGSnapshot.data.documents.length >0)) ? Padding(
                                                                    padding:const EdgeInsets.fromLTRB( 0, 5, 0, 0),
                                                                    child: CircleAvatar(
                                                                    radius: 9,
                                                                    child: Text(
                                                                      (chatListSnapshot.hasData && chatListSnapshot.data.documents.length > 0)
                                                                          ? ((notReadMSGSnapshot.hasData && notReadMSGSnapshot.data.documents.length >0)
                                                                              ? '${notReadMSGSnapshot.data.documents.length}' : ''): '',
                                                                      style: TextStyle(fontSize: 10),),
                                                                    backgroundColor: (notReadMSGSnapshot.hasData && notReadMSGSnapshot.data.documents.length >0 &&
                                                                            notReadMSGSnapshot.hasData && notReadMSGSnapshot.data.documents.length >0)
                                                                        ? Colors.red[400] : Colors.transparent,foregroundColor:Colors.white,
                                                                  )) : Container(),
                                                              ],
                                                            ),
                                                          );
                                                        })
                                                    : Text('')),
                                                    onTap: () {
                                                      _moveTochatRoom(data['FCMToken'],data['userId'],data['name'],data['username'],data['userImageUrl']);
                                                    },
                                    ),
                                ) ,
                                Padding(
                                  padding: const EdgeInsets.only(left:25.0,right: 25),
                                  child: Divider(color: Colors.grey[800],),
                                )
                              ],
                            ) : Container();
                            });
                      }
                    }).toList()),
                )
                : Container(

                  );
              }),
        ) : SingleChildScrollView(
          child: Column(
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
              SizedBox(height: 5,),
              Container(
                height: _con.followingList.length.toDouble() * 72,
                // height: _con.statusFollowing==false ? MediaQuery.of(context).size.height - 200 :  MediaQuery.of(context).size.height - 330,
                child:/* _searchFollowingResult.length != 0 && _con.statusFollowing==false
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
                    }) :*/
                _con.followingList.length != 0 && _con.statusFollowing==false
                    ? ListView.separated(physics: NeverScrollableScrollPhysics(),
                    itemCount: _con.followingList.length,
                    separatorBuilder: (context,inddd){
                      return Padding(
                        padding: const EdgeInsets.only(left:25.0,right: 25),
                        child: Divider(color: Colors.grey[800],),
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          String chatID = makeChatId(widget.myID, _con.followingList[index]['timeline_id'].toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                      widget.myID,
                                      widget.myName,
                                      _con.followingList[index]['device_token'].toString(),
                                      _con.followingList[index]['timeline_id'].toString(),
                                      chatID,
                                      _con.followingList[index]['username'].toString(),_con.followingList[index]['name'].toString(),
                                      _con.followingList[index]['picture'].toString()+"?alt=media","")));
                        },

                        child: Container(
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
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: CircleAvatar(
                                          radius: 20,
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
                                            Text(
                                              _con.followingList[index]['username'],
                                              style: f13g,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                    :Container(height: 0,),
              ),
              _con.followingList.length>0 ?   Padding(
                padding: const EdgeInsets.only(left:25.0,right: 25),
                child: Divider(color: Colors.grey[800],),
              ) : Container(),
              Container(
                height: _con.businessFollowingList.length.toDouble() * 75,
                child: _con.businessFollowingList.length > 0 && _con.statusFollowing==false
                    ? ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context,inddd){
                      return Padding(
                        padding: const EdgeInsets.only(left:25.0,right: 25),
                        child: Divider(color: Colors.grey[800],),
                      );
                    },
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: _con.businessFollowingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          String chatID = makeChatId(widget.myID, _con.businessFollowingList[index]['timeline_id'].toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                      widget.myID,
                                      widget.myName,
                                      _con.businessFollowingList[index]['device_token'].toString(),
                                      _con.businessFollowingList[index]['timeline_id'].toString(),
                                      chatID,
                                      _con.businessFollowingList[index]['username'].toString(),_con.businessFollowingList[index]['name'].toString(),
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.businessFollowingList[index]['picture'].toString()+"?alt=media","")));
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 5.0, top: 12, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: CircleAvatar(
                                          radius: 20,
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
                                            Text(
                                              _con.businessFollowingList[index]['username'],
                                              style: f14wB,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    })
                    :Container(height: 0,),
              ),
            ],
          ),
        )

      ));
  }

  Future<void> _moveTochatRoom(selectedUserToken, selectedUserID, selectedName,selectedUserName,selectedUserThumbnail) async {
    try {
      String chatID = makeChatId(widget.myID, selectedUserID);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatRoom(
                  widget.myID,
                  widget.myName,
                  selectedUserToken,
                  selectedUserID,
                  chatID,
                  selectedUserName,selectedName,
                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+selectedUserThumbnail+"?alt=media","")));
    } catch (e) {
      print(e.message);
    }
  }
}
