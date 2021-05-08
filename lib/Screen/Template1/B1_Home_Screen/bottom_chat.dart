import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/CHAT/conversation_screen.dart';
import 'package:Butomy/CHAT/database.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/notification.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'B1_Home_Screen_T1.dart';
import 'New_Entry_Form.dart';

class BottomChat extends StatefulWidget {
  @override
  _BottomChatState createState() => _BottomChatState();
}

class _BottomChatState extends StateMVC<BottomChat> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    databaseMethods.getChatRooms(userNAME).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  Widget chatRoomList() {
    return Container(
      height: MediaQuery.of(context).size.height - 192,
      child: StreamBuilder(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                        snapshot.data.documents[index].data["chatroomId"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(userNAME, ""),
                        snapshot.data.documents[index].data["chatroomId"],
                        snapshot.data.documents[index].data["avatars"]
                            .toString()
                            .replaceAll("_"+userPIC, "")
                            ,
                        snapshot.data.documents[index].data["names"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(NAME, ""));
                  })
              : Container();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TimeLine(false)));
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
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/chat.png",
                      height: 21,
                      color: Color(0xFFffd55e),
                      width: 21,
                    ),
                    Text(
                      "Chat",
                      style: f15y,
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
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/shopping-basket.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23,
                      ),
                      Text(
                        "Purchase",
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
                      Image.asset(
                          "assets/Template1/image/Foodie/icons/cart.png",
                          height: 23,
                          color: Colors.white54,
                          width: 23),
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
                      notificationCount!=0 ?   Padding(
                          padding: const EdgeInsets.only(left:11.0),
                          child: /*CircleAvatar(backgroundColor: Color(0xFF48c0d8),
                            radius: 7,
                            child: Center(child: Text(notificationCount.toString(),style: f10B,textAlign: TextAlign.center,)),
                          ),*/Container(
                            height: 14,width: 14,
                            decoration: BoxDecoration(
                                color: Color(0xFF48c0d8),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text(notificationCount.toString(),style: f10B,textAlign: TextAlign.center,)),
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
          ],
        ),
        backgroundColor: Color(0xFF1E2026),
        body: Column(
          children: <Widget>[
            Container(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/Template1/image/Foodie/icons/pencil.png",
                      height: 20,
                      width: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("1 new message", style: f15wB),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/Template1/image/Foodie/icons/search.png",
                      height: 20,
                      width: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            chatRoomList(),
          ],
        ));
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String Name;
  final String chatRoomId;
  final String pic;

  ChatRoomTile(this.userName, this.chatRoomId, this.pic, this.Name);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConversationScreen(chatRoomId, pic, Name,userName)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 8),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                  pic.toString()),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Name,
                  style: f15wB,
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  userName,
                  style: f14g,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
