import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_LocalShop_Product_List_Page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_local_shop_new_entry.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_timeline.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'Business_HomeKitchen_Product_List_page.dart';
import 'business_home_kitchen_new_entry.dart';
import 'business_home_kitchen_timeline.dart';
import 'business_homekit_orders.dart';

class BusinessLocalShopChatList extends StatefulWidget {
  BusinessLocalShopChatList({this.myID, this.myName,this.timid,this.memberdate,this.pagid});

  String myID;
  String myName,timid,pagid,memberdate;

  @override
  _BusinessLocalShopChatListState createState() => _BusinessLocalShopChatListState();
}

class _BusinessLocalShopChatListState extends StateMVC<BusinessLocalShopChatList> {
  TimelineWallController _con;

  _BusinessLocalShopChatListState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    FirebaseController.instanace.getUnreadMSGCount();
    _con.notification(userid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        elevation: 5,
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),
        /* actions: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new QRCODE()));
                  },
                  child: Image.asset(
                    "assets/Template1/image/Foodie/QRcode.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                IconButton(
                  icon:  Stack(
                    children: [
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/bell.png",
                        height: 20,
                        width: 20,
                      ),
                      _con.notificationReadStatus!=0 &&  _con.notificationReadStatus!=null?
                      Padding(
                          padding: const EdgeInsets.only(left:11.0),
                          child: */ /*CircleAvatar(backgroundColor: Color(0xFF48c0d8),
        radius: 7,
        child: Center(child: Text(notificationCount.toString(),style: f10B,textAlign: TextAlign.center,)),
      ),*/ /*Container(
                            height: 14,width: 14,
                            decoration: BoxDecoration(
                                color: Color(0xFF48c0d8),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text(_con.notificationReadStatus.toString(),style: f10B,textAlign: TextAlign.center,)),
                          )
                      ) : Container(height: 0,)
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Notifications()));
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new HomeScreenT1()));
                  },
                  child: Padding(
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
          ],*/
      ),
      backgroundColor: Color(0xFF1E2026),
      body: VisibilityDetector(
        key: Key("1"),
        onVisibilityChanged: ((visibility) {
          if (visibility.visibleFraction == 1.0) {
            FirebaseController.instanace.getUnreadMSGCount();
          }
        }),
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                  color: Colors.white.withOpacity(0.7),
                );
              return countChatListUsers(userid.toString(), snapshot) > 0
                  ? ListView(
                  children: snapshot.data.documents.map((data) {
                    if (data['userId'] == userid.toString()) {
                      return Container();
                    } else {
                      return StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('users')
                              .document(userid.toString())
                              .collection('chatlist')
                              .where(
                            'chatWith',
                            isEqualTo: data['userId'],
                          )
                              .snapshots(),
                          builder: (context, chatListSnapshot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                      CachedNetworkImageProvider(
                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                            data['userImageUrl'] +
                                            "?alt=media",
                                      ),
                                    ),
                                    title: Text(
                                      data['name'],
                                      style: f15wB,
                                    ),
                                    subtitle: Text(
                                      (chatListSnapshot.hasData &&
                                          chatListSnapshot
                                              .data.documents.length >
                                              0 &&
                                          chatListSnapshot
                                              .data
                                              .documents[0]
                                          ['lastChat']
                                              .toString()
                                              .length >
                                              30)
                                          ? chatListSnapshot.data
                                          .documents[0]['lastChat']
                                          .toString()
                                          .substring(0, 30) +
                                          " ..."
                                          : (chatListSnapshot.hasData &&
                                          chatListSnapshot.data
                                              .documents.length >
                                              0 &&
                                          chatListSnapshot
                                              .data
                                              .documents[0]
                                          ['lastChat']
                                              .toString()
                                              .length <
                                              30)
                                          ? chatListSnapshot.data
                                          .documents[0]['lastChat']
                                          .toString()
                                          : data['username'],
                                      style: f13g,
                                    ),
                                    trailing: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 4, 4),
                                        child: (chatListSnapshot.hasData &&
                                            chatListSnapshot.data
                                                .documents.length >
                                                0)
                                            ? StreamBuilder<QuerySnapshot>(
                                            stream: Firestore.instance
                                                .collection('chatroom')
                                                .document(chatListSnapshot
                                                .data.documents[0]
                                            ['chatID'])
                                                .collection(
                                                chatListSnapshot.data
                                                    .documents[0]
                                                ['chatID'])
                                                .where('idTo',
                                                isEqualTo: userid)
                                                .where('isread', isEqualTo: false)
                                                .snapshots(),
                                            builder: (context, notReadMSGSnapshot) {
                                              return Container(
                                                width: 60,
                                                height: 50,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      (chatListSnapshot
                                                          .hasData &&
                                                          chatListSnapshot
                                                              .data
                                                              .documents
                                                              .length >
                                                              0)
                                                          ? readTimestamp(
                                                          chatListSnapshot
                                                              .data
                                                              .documents[0]
                                                          [
                                                          'timestamp'])
                                                          : '',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors
                                                              .white70),
                                                    ),
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            0,
                                                            5,
                                                            0,
                                                            0),
                                                        child:
                                                        CircleAvatar(
                                                          radius: 9,
                                                          child: Text(
                                                            (chatListSnapshot
                                                                .hasData &&
                                                                chatListSnapshot.data.documents.length >
                                                                    0)
                                                                ? ((notReadMSGSnapshot.hasData &&
                                                                notReadMSGSnapshot.data.documents.length > 0)
                                                                ? '${notReadMSGSnapshot.data.documents.length}'
                                                                : '')
                                                                : '',
                                                            style: TextStyle(
                                                                fontSize:
                                                                10),
                                                          ),
                                                          backgroundColor: (notReadMSGSnapshot.hasData &&
                                                              notReadMSGSnapshot.data.documents.length >
                                                                  0 &&
                                                              notReadMSGSnapshot
                                                                  .hasData &&
                                                              notReadMSGSnapshot.data.documents.length >
                                                                  0)
                                                              ? Colors.red[
                                                          400]
                                                              : Colors
                                                              .transparent,
                                                          foregroundColor:
                                                          Colors
                                                              .white,
                                                        )),
                                                  ],
                                                ),
                                              );
                                            })
                                            : Text('')),
                                    onTap: () {
                                      _moveTochatRoom(
                                          data['FCMToken'],
                                          data['userId'],
                                          data['name'],
                                          data['username'],
                                          data['userImageUrl']);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25),
                                  child: Divider(
                                    color: Colors.grey[800],
                                  ),
                                )
                              ],
                            );
                          });
                    }
                  }).toList())
                  : Container(
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.forum,
                          color: Colors.grey[700],
                          size: 64,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'There are no Chats.',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              );
            }),
      ),
     /* bottomNavigationBar: Container(
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
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      BusinessLocalShopTimeline(memberdate: widget.memberdate,pagid: widget.pagid,
                        timid: widget.timid,upld: false,)), );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/home.png",
                      height: 21,
                      color: Colors.white54,
                      width: 21,
                    ),
                    Text(
                      "Home",
                      style: f14w54,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/chat.png",
                      height: 21,
                      color: Color(0xFFffd55e),
                      width: 21,
                    ),
                    Text(
                      "Chat",
                      style: f14y,
                    )
                  ],
                ),
              ),
              Container(
                height: 42,
                width: 42,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocalShopNewEntryForm(
                              timid: widget.timid,
                              pagid: widget.pagid,
                              memberdate: widget.memberdate,
                            )));
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusinessLocalShopProductListPage(
                                memberdate: widget.memberdate,
                                pagid: widget.pagid,
                                timid: widget.timid,
                              )));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/list.png",
                      height: 23,
                      color: Colors.white54,
                      width: 23,
                    ),
                    Text(
                      "Product list",
                      style: f14w54,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusinessLocalShopOrderPage(memberdate: widget.memberdate,timid: widget.timid,pagid: widget.pagid,)));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        "assets/Template1/image/Foodie/icons/order-list.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23),
                    Text(
                      "Orders",
                      style: f14w54,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),*/
    );
  }

  Future<void> _moveTochatRoom(selectedUserToken, selectedUserID, selectedName,
      selectedUserName, selectedUserThumbnail) async {
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
                  selectedUserName,
                  selectedName,
                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                      selectedUserThumbnail +
                      "?alt=media",
                  "")));
    } catch (e) {
      print(e.message);
    }
  }
}
