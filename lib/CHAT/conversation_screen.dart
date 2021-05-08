import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';import 'package:jiffy/jiffy.dart';
import 'database.dart';
import 'package:intl/intl.dart';

DateTime _date;
var date_only_pre;
var date;
var date_only_current;
class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  String pic,name,username;

  ConversationScreen(this.chatRoomId, this.pic,this.name,this.username);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ScrollController _controller = ScrollController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream chatMessageStream;

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });
    super.initState();
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": userNAME,
        "time": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: ListView.builder(
                    // shrinkWrap: true
                    // primary: true,
                    reverse: false,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      if (index != 0) {
                        var dateUtc =  snapshot.data.documents[index-1].data["time"];
                        var dateTimeLocal = Jiffy(dateUtc.toString())
                            .format("dd-MM-yyyy h:mm:ss a");
                        date_only_pre = dateTimeLocal.split(" ");
                      } else {
                        var dateUtc =  snapshot.data.documents[0].data["time"];
                        var dateTimeLocal = Jiffy(dateUtc.toString())
                            .format("dd-MM-yyyy h:mm:ss a");
                        date_only_pre = dateTimeLocal.split(" ");
                      }
                      var dateUtc =  snapshot.data.documents[index].data["time"];
                      var dateTimeLocal = Jiffy(dateUtc.toString())
                          .format("dd-MM-yyyy h:mm:ss a");

                      date_only_current = dateTimeLocal.split(" ");

                      if (date_only_current[0] != date_only_pre[0]) {
                        date = date_only_current[0];
                      } else {
                        date = '';
                      }
                      return Column(
                        children: [

                           date != ''? Bubble(
                              alignment: Alignment.center,
                              color: Colors.grey,
                              elevation: 1,
                              margin: BubbleEdges.only(top: 8.0),
                              child: Text("${date}",
                                  style: TextStyle(fontSize: 10)),
                            ) : Container(), /*Bubble(
                              alignment: Alignment.center,
                              color: Colors.grey,
                              elevation: 1,
                              margin: BubbleEdges.only(top: 8.0),
                              child: Text("Today "+snapshot.data.documents[index].data["time"],
                                  style: TextStyle(fontSize: 10)),
                            ),*/

                          MessageTile(
                            snapshot.data.documents[index].data["message"],
                            snapshot.data.documents[index].data["sendBy"] ==
                                userNAME,
                            snapshot.data.documents[index].data["time"],index.toString()
                          ),
                        ],
                      );
                    }),
              )
            : Container();
      },
    );
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
                  backgroundImage: CachedNetworkImageProvider(widget.pic.toString()),
                ),
                SizedBox(width: 8,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,style: f16wB,),

                    Text("("+widget.username+")",style: f14g,),
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
      body: Container(
        child: Stack(
          children: <Widget>[
            ChatMessageList(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x54FFFFFF),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            height: 28.0,
                            width: 28.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: userPIC!= null && userPIC!=""
                                        ? CachedNetworkImageProvider(userPIC)
                                        : CachedNetworkImageProvider(
                                      "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius:
                                BorderRadius.all(Radius.circular(180.0))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(expands: true,maxLines: null,minLines: null,
                          controller: messageController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "send a message....",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none),
                        )),
                        GestureDetector(
                          onTap: () {
                       sendMessage();
                          },
                          child: Container(
                              height: 70,
                              width: 45,
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  final String _dat;
  final String ind;

  MessageTile(this.message, this.isSendByMe, this._dat,this.ind);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //     c: isSendByMe
            //         ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
            //         : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)]),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                _dat.substring(11, 16).toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          )),
    );
  }
}
