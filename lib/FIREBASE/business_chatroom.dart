import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/FIREBASE/chat_link_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Each_Item_Detail_view_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/food_bank_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_market_item_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'Fire_Contro/firebaseController.dart';
import 'Fire_Contro/notificationController.dart';
import 'Fire_Contro/pickImageController.dart';
import 'Fire_Contro/utils.dart';
import 'fullphoto.dart';

class BusinessChatRoom extends StatefulWidget {
  BusinessChatRoom(this.myID,this.myName,this.selectedUserToken, this.selectedUserID, this.chatID, this.selectedUserName,this.selectedname ,this.selectedUserThumbnail,this.sharedPost);

  String myID;
  String sharedPost;
  String myName;
  String selectedUserToken;
  String selectedUserID;
  String chatID;
  String selectedname;
  String selectedUserName;
  String selectedUserThumbnail;

  @override
  _BusinessChatRoomState createState() => _BusinessChatRoomState();
}

class _BusinessChatRoomState extends State<BusinessChatRoom> {
  final TextEditingController _msgTextController = new TextEditingController();
  final ScrollController _chatListController = ScrollController();
  String messageType = 'text';
  bool _isLoading = false;
  int chatListLength = 20;
  double _scrollPosition = 560;

  _scrollListener() {
    setState(() {
      if (_scrollPosition < _chatListController.position.pixels ){
        _scrollPosition = _scrollPosition + 560;
        chatListLength = chatListLength + 20;
      }
    });
  }

  var contheight = 50;

  @override
  void initState() {
    // sendNotificationMessageToPeerUser("hhhhhhhhhh");
    Future.delayed(Duration.zero, () {
      this._addpost();
    });
    setCurrentChatRoomID(widget.chatID);
    FirebaseController.instanace.getUnreadMSGCountBusiness(widget.myID).then((value) {
      setState(() {
        businesschatcount=value;
      });
    });
    _chatListController.addListener(_scrollListener);
    super.initState();
  }
  Future<void> sendNotificationMessageToPeerUser(msg) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAHqqKmaE:APA91bEpsNQZ4xDAv1IKKE_DYNptY6s35PeOoY15vll9o1LG70xYm5hQhoSS1AS19LveEIwJJrz3jpFyMPhgEy6WYIA1C022nkRNNzMCb9Cswfx4RTkmlLfONRBBBoaSvOjKKHx_QVfv',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': msg,
            'icon' : widget.selectedUserThumbnail,
            'title': widget.myName,
            // "image" : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/FCMImages%2Fic_launcher.png?alt=media&token=49b32466-e21a-48cc-bc81-9d15b11db979",
            "sound" : "default",
            "playSound": true
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          // 'to': "f74A19nA9tA:APA91bEoHzunNfz1YQGLKFJWkvbr9oAYMxVGrObNsX2RfP25AM15usUy3wFVMfwSwV55C5QcRdms-5_OtUN4_G6ZXm3lcgTDvoJUF7d7gzsNWxqJvL7I1ZXPK2PeZfcSdFr3pB5DKHm7",
          'to': widget.selectedUserToken,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
  }

  Future<void> sendNotificationMessageToPeerUserimag(imag) async {
    print("sendingg imaggg url "+imag);
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAHqqKmaE:APA91bEpsNQZ4xDAv1IKKE_DYNptY6s35PeOoY15vll9o1LG70xYm5hQhoSS1AS19LveEIwJJrz3jpFyMPhgEy6WYIA1C022nkRNNzMCb9Cswfx4RTkmlLfONRBBBoaSvOjKKHx_QVfv',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': widget.myName,
            "image" : imag.toString(),
            "body" : "Photo",
            "sound" : "default",
            "playSound": true
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': widget.selectedUserToken,
          // 'to': "f74A19nA9tA:APA91bEoHzunNfz1YQGLKFJWkvbr9oAYMxVGrObNsX2RfP25AM15usUy3wFVMfwSwV55C5QcRdms-5_OtUN4_G6ZXm3lcgTDvoJUF7d7gzsNWxqJvL7I1ZXPK2PeZfcSdFr3pB5DKHm7",
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
  }

  _addpost(){
    widget.sharedPost.length>5? _handleSubmitted(widget.sharedPost) : null;
    widget.sharedPost.length>5? sendNotificationMessageToPeerUser(widget.sharedPost) : null;
  }

  @override
  void dispose() {
    setCurrentChatRoomID('none');
    super.dispose();
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
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: CachedNetworkImageProvider(widget.selectedUserThumbnail.toString()),
                  ),
                  SizedBox(width: 8,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.selectedname,style: f16wB,),
                      Text("("+widget.selectedUserName+")",style: f14g,),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right:13.0),
                child: Column(
                  children: [
                    Text("now",style: f14g,),
                    SizedBox(height: 3,),
                    Icon(Icons.brightness_1,color: Colors.greenAccent[700],size: 10,)
                  ],
                ),
              )
            ],
          ),
        ),
        body: VisibilityDetector(
          key: Key("1"),
          onVisibilityChanged: ((visibility) {
            if (visibility.visibleFraction == 1.0) {
              FirebaseController.instanace.getUnreadMSGCountBusiness(widget.myID).then((value) {
                setState(() {
                  businesschatcount=value;
                });
              });
            }
          }),
          child: StreamBuilder<QuerySnapshot> (
              stream:
              Firestore.instance.
              collection('chatroom').
              document(widget.chatID).
              collection(widget.chatID).
              orderBy('timestamp',descending: true).
              limit(chatListLength).
              snapshots(),
              builder: (context,snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                if (snapshot.hasData) {
                  for (var data in snapshot.data.documents) {
                    if(data['idTo'] == widget.myID && data['isread'] == false) {
                      if (data.reference != null) {
                        Firestore.instance.runTransaction((Transaction myTransaction) async {
                          await myTransaction.update(data.reference, {'isread': true});
                        });
                      }
                    }
                  }
                }
                return Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                              reverse: true,
                              shrinkWrap: true,
                              padding: const EdgeInsets.fromLTRB(4.0,10,4,10),
                              controller: _chatListController,
                              children: snapshot.data.documents.map((data) { //snapshot.data.documents.reversed.map((data) {
                                return data['idFrom'] == widget.selectedUserID ? _listItemOther(context,
                                    widget.selectedUserName,
                                    widget.selectedUserThumbnail,
                                    data['content'],
                                    returnTimeStamp(data['timestamp']),
                                    data['type']) :
                                _listItemMine(context,data.documentID,
                                    widget.chatID,
                                    data['content'],
                                    returnTimeStamp(data['timestamp']),
                                    data['isread'],
                                    data['type']);
                              }).toList()
                          ),
                        ),
                        _buildTextComposer(),
                      ],
                    ),
//                Positioned(
//                  // Loading view in the center.
//                  child: _isLoading
//                      ? Container(
//                    child: Center(
//                      child: CircularProgressIndicator(),
//                    ),
//                    color: Colors.white.withOpacity(0.7),
//                  )
//                      : Container(),
//                ),
                  ],
                );
              }
          ),
        )
    );
  }

  Widget _listItemOther(BuildContext context, String name, String thumbnail, String message, String time, String type) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:4.0,left: 8),
      child: GestureDetector(
        onTap: (){

        },
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /*Text(name),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.fromLTRB(4,4,0,8),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: size.width - 150),
                              decoration: BoxDecoration(
                                // gradient: LinearGradient(
                                //     colors:  [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)]
                                // ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(23),
                                    topRight: Radius.circular(23),
                                    bottomRight: Radius.circular(23)),
                              ),
                              child:  Padding(
                                padding: EdgeInsets.all(type == 'text' ? 8.0:0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: type == 'text' ? SmartText(
                                          text:message,
                                          style: TextStyle(color: Colors.white),
                                          onOpen: (link){
                                            if(link.contains("https://saasinfomedia.com/butomy/foodbank/product")){
                                              var linkcut=link.replaceAll("https://saasinfomedia.com/butomy/foodbank/product/", "").toString();
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>FoodBankDetailPage(product_id: linkcut.toString(),req_show: true)
                                              ));
                                            }
                                            else if(link.contains("https://saasinfomedia.com/butomy/foodimarket/product")){
                                              var linkcut=link.replaceAll("https://saasinfomedia.com/butomy/foodimarket/product/", "").toString();
                                              print("likkkkk "+linkcut.toString());
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>FoodiMarketDetailPage(product_id: linkcut.toString(),itemname: "",price: "",)
                                              ));
                                            }
                                            else{
                                              var linkcut=link.replaceAll("https://saasinfomedia.com/foodiz/public/sharepost/", "").toString();
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>ChatLinkDetailPage(post_id: linkcut,)
                                              ));
                                            }
                                          },
                                        ) :
                                        _imageMessage(message,name)
                                    ),
                                    Padding(
                                      padding:type == 'text' ?  EdgeInsets.only(top: 8) : EdgeInsets.all( 8),
                                      child: Container(
                                          constraints: BoxConstraints(maxWidth: 58),
                                          child: Text(time,style: TextStyle(fontSize: 10,color: Colors.white70),)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItemMine (BuildContext context,docid,chatid, String message, String time, bool isRead, String type) {

    final size = MediaQuery.of(context).size;
    return Padding( padding: const EdgeInsets.only(top:2.0,right: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (
                              BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(
                                  0xFF1E2026),
                              title: new Text(
                                "Delete Message?",
                                style: f16wB,
                              ),
                              content: new Text(
                                "Do you want to delete the message",
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
                                  onPressed: () async {
                                    Navigator
                                        .pop(
                                        context);
                                    await FirebaseController.instanace.deleteMessageFromChatRoom(chatid, docid);

                                  },
                                ),
                              ],
                            );
                          });

                    },
                    child: Padding(padding: const EdgeInsets.fromLTRB(0,8,4,8),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: size.width - size.width*0.26),
                        decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //     colors:  [const Color(0xff007EF4), const Color(0xff2A75BC)]
                          // ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(23),
                              topRight: Radius.circular(23),
                              bottomLeft: Radius.circular(23)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(type == 'text' ? 8.0:0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      child: type == 'text' ? SmartText(
                                        text:message,
                                        style: TextStyle(color: Colors.white),
                                        linkStyle: TextStyle(color: Color(0xFFffd55e)),
                                        onOpen: (link){
                                          if(link.contains("https://saasinfomedia.com/butomy/foodbank/product")){
                                            var linkcut=link.replaceAll("https://saasinfomedia.com/butomy/foodbank/product/", "").toString();
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>FoodBankDetailPage(product_id: linkcut.toString(),req_show: true)
                                            ));
                                          }
                                          else if(link.contains("https://saasinfomedia.com/butomy/foodimarket/product")){
                                            var linkcut=link.replaceAll("https://saasinfomedia.com/butomy/foodimarket/product/", "").toString();
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>FoodiMarketDetailPage(product_id: linkcut.toString(),itemname: "",price: "",)
                                            ));
                                          }
                                          else{
                                            var linkcut=link.replaceAll("https://saasinfomedia.com/foodiz/public/sharepost/", "").toString();
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>ChatLinkDetailPage(post_id: linkcut,)
                                            ));
                                          }
                                        },
                                      ) :
                                      _imageMessage(message,name)
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(type == 'text' ? 0.0:8),
                                    child: Container(
                                        constraints: BoxConstraints(maxWidth: 63),
                                        child: Row(
                                          children: [
                                            Text(time,style: TextStyle(fontSize: 10,color: Colors.white70),),
                                            SizedBox(width: 3,),
                                            Icon(Icons.done_all,color: isRead==true ? Colors.lightGreenAccent[700]: Colors.grey,size: 17,)
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget _imageMessage(imageUrlFromFB,name) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 157,
      height: 157,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FullPhoto(url: imageUrlFromFB,name: name.toString(),)));
        },
        child: CachedNetworkImage(
          imageUrl: imageUrlFromFB,
          placeholder: (context, url) => Container(
            transform: Matrix4.translationValues(0, 0, 0),
            child: Container( width: 60, height: 80,
                child: Center(child: new CircularProgressIndicator())),
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          width: 60,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        height: _msgTextController.text.length > 32 ? contheight.toDouble() : 50 ,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:BorderRadius.circular(5)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 2.0),
              child: new IconButton(
                  icon: new Icon(Icons.photo,color: Colors.blueGrey,),
                  onPressed: () {
                    PickImageController.instance.cropImageFromFile().then((croppedFile) {
                      if (croppedFile != null) {
                        setState(() { messageType = 'image'; _isLoading = true; });
                        _saveUserImageToFirebaseStorage(croppedFile);
                      }else {
                        _showDialog('Pick Image error');
                      }
                    });
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width-125,
              child: Padding(
                padding: const EdgeInsets.only(top:16.0,bottom: 8),
                child: new TextField(
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  onChanged: (val){
                    if(val.length>32)
                      setState(() {contheight=100;});
                    else
                      setState(() {contheight=50;});
                  },
                  controller: _msgTextController,
                  // onSubmitted: _msgTextController.text.length>0  ? _handleSubmitted : null,
                  decoration: new InputDecoration.collapsed(
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: "Send a message"),
                ),
              ),
            ),

            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 2.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () {
                    setState(() { messageType = 'text'; });
                    _msgTextController.text.length>0   ?  sendNotificationMessageToPeerUser(_msgTextController.text): null ;
                    _msgTextController.text.length>0   ? _handleSubmitted(_msgTextController.text): null ;

                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveUserImageToFirebaseStorage(croppedFile) async {
    try {
      String takeImageURL = await FirebaseController.instanace.sendImageToUserInChatRoom(croppedFile,widget.chatID);
      sendNotificationMessageToPeerUserimag(takeImageURL);
      _handleSubmitted(takeImageURL);

    }catch(e) {
      _showDialog('Error add user image to storage');
    }
  }

  Future<void> _handleSubmitted(String text) async {

    print("cccccccccccccccccccccccccccccccccc ");
    try {
      print("cccccccccccccccccccccccccccccccccc 111111111111111");
      _resetTextFieldAndLoading();
      setState(() { _isLoading = true; });
      await FirebaseController.instanace.sendMessageToChatRoom(widget.chatID,widget.myID,widget.selectedUserID,text,messageType);
      await FirebaseController.instanace.updateChatRequestField(widget.selectedUserID, messageType == 'text' ? text : '(Photo)',widget.chatID,widget.myID,widget.selectedUserID);
      await FirebaseController.instanace.updateLstChatUser(widget.selectedUserID, messageType == 'text' ? text : '(Photo)',widget.chatID,widget.myID,widget.selectedUserID);
      await FirebaseController.instanace.updateLstChatUser(widget.myID, messageType == 'text' ? text : '(Photo)',widget.chatID,widget.myID,widget.selectedUserID);
      await FirebaseController.instanace.updateChatRequestField(widget.myID, messageType == 'text' ? text : '(Photo)',widget.chatID,widget.myID,widget.selectedUserID);
      // _getUnreadMSGCountThenSendMessage(text);
    }catch(e){
      print("cccccccccccccccccccccccccccccccccc 22222222222222222 "+e.toString() );
      _showDialog('Error user information to database');
      _resetTextFieldAndLoading();
    }
  }

  Future<void> _getUnreadMSGCountThenSendMessage(text) async{
    try {
      int unReadMSGCount = await FirebaseController.instanace.getUnreadMSGCount();
      // await NotificationController.instance.sendNotificationMessageToPeerUser(unReadMSGCount, messageType, text, widget.myName, widget.chatID, widget.selectedUserToken);
    }catch (e) {
      print(e.message);
    }
    // _resetTextFieldAndLoading();
  }

  _resetTextFieldAndLoading() {
    // FocusScope.of(context).requestFocus(FocusNode());
    _msgTextController.text = '';
    setState(() { _isLoading = false; });
  }

  _showDialog(String msg){
    showDialog(
        context: context,
        builder:(context) {
          return AlertDialog(
            content: Text(msg),
          );
        }
    );
  }
}