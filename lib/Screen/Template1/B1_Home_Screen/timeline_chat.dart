import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class TimelineChatPage extends StatefulWidget {
  @override
  _TimelineChatPageState createState() => _TimelineChatPageState();
}

class _TimelineChatPageState extends StateMVC<TimelineChatPage> {
  TextEditingController _msg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                          errorListener: () => new Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Janet Fowler",
                          style: f15wB,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Karnataka",
                          style: f14g,
                        )
                      ],
                    ),
                  ],
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("now",
                        style: f14g),
                    SizedBox(
                      height: 3,
                    ),
                    Icon(
                      Icons.brightness_1,
                      color: Colors.blue,
                      size: 12,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
      ),
      backgroundColor: Color(0xFF1E2026),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[

            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 0, right: 24),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //     colors: [
                          //   const Color(0xff007EF4),
                          //   const Color(0xff2A75BC)
                          // ]),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(23),
                              topRight: Radius.circular(23),
                              bottomLeft: Radius.circular(23))),
                      child: Text("Helooooo!!!!!",
                          style: TextStyle(color: Colors.white, fontSize: 17))),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24, right: 0),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                        //     colors: [
                        //
                        //   const Color(0x1AFFFFFF),
                        //   const Color(0x1AFFFFFF)
                        // ]
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(23),
                            topRight: Radius.circular(23),
                            bottomRight: Radius.circular(23)),
                      ),
                      child: Text("hiiiii.... How r u????",
                          style: TextStyle(color: Colors.white, fontSize: 17))),
                ),


              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height-285,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,

                decoration: BoxDecoration(color: Color(0xFF23252E),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      children: <Widget>[
                        Container(width: MediaQuery.of(context).size.width/1.42,
                          child: TextField(
                            controller: _msg,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " Type a text",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        ),
                        Icon(Icons.insert_emoticon,color: Colors.yellow,),
                        Icon(Icons.attach_file,color: Color(0xFF48c0d8),),
                        Icon(Icons.send,color: Colors.white,)
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
