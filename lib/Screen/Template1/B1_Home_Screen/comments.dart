import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
var focus=1;
DateTime _date;
var d;
DateTime _date2;
var d2;
var viewindex;
bool replyShow;
var indexc;
bool ReplyStatus;
bool del;
bool repdel;
var cmntid;
var repcmntid;
var comntindex;
var repcomntindex;
var replength;
var mainInd;
class CommentPage extends StatefulWidget {

  @override
  _CommentPageState createState() => _CommentPageState();
}

var s = "unlike";

class _CommentPageState extends StateMVC<CommentPage>
    with SingleTickerProviderStateMixin {
  TabController _tabContoller;
  TimelineWallController _con;

  _CommentPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  TextEditingController cmnt = TextEditingController();
  TextEditingController reply = TextEditingController();

  @override
  void initState() {
    _con.getTimCommentPage(postid.toString(), userid.toString());
    setState(() {
      ReplyStatus=false;
      replyShow=false;
      del =false;
      repdel=false;
    });
    // TODO: implement initState
    super.initState();
  }
  var contheight = 50;

  List<bool> _reply = List.filled(1000, false);
  List<bool> _replyShow = List.filled(1000, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white,),
        backgroundColor: Color(0xFF1E2026),
        actions: [
          del==true ? Row(
            children: [
              GestureDetector(
                  onTap: (){ _con.deleteTimCommnt(
                      cmntid,
                      userid
                          .toString());
                  setState(() {comntindex=null;
                  del=false;
                  });
                  },
                  child: Icon(Icons.delete_outline,color: Color(0xFF48c0d8),)),
              SizedBox(width: 15,)
            ],
          ) : repdel==true ? Row(
            children: [
              GestureDetector(
                  onTap: (){
                    setState(() { replyShow=  replength==1 ? false : true;});
                    _con.deleteTimCommnt(
                        repcmntid,
                        userid
                            .toString());
                    setState(() {repcomntindex=null;
                    repdel=false;
                    });
                  },
                  child: Icon(Icons.delete_outline,color: Color(0xFF48c0d8),)),
              SizedBox(width: 15,)
            ],
          ) : Container()
        ],
        title: Text(
          "Comments",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: InkWell(
        onTap: ()  {FocusScope.of(context).requestFocus(new FocusNode());
        ReplyStatus=false;},
        child: Stack(
          children: <Widget>[
            Center(
              child: Visibility(
                  visible: _con.statusComment,
                  child: CircularProgressIndicator()
              ),
            ),
            _con.timelineComments.length != 0 && _con.statusComment == false
                ? Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 65),
              child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: _con.timelineComments.length,
                  itemBuilder: (BuildContext context, int index) {
                    _date = DateTime.parse(
                        _con.timelineComments[index]['created_at']
                        ['date']);
                    var c =
                        DateTime.now().difference(_date).inHours;
                    c > 24
                        ? d = DateTime.now()
                        .difference(_date)
                        .inDays
                        .toString() +
                        " day ago"
                        : c == 0
                        ? d = DateTime.now()
                        .difference(_date)
                        .inMinutes
                        .toString() +
                        " mints ago"
                        : d = DateTime.now()
                        .difference(_date)
                        .inHours
                        .toString() +
                        " hrs ago";
                    _con.timelineComments[
                    index]
                    [
                    'replies'].length>0 ? _reply[index]=true : _reply[index]=false;
                    return Container(
                      color: del==true && index==comntindex ? Colors.white12.withOpacity(.2) : Colors.transparent,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 5.0,
                              right: 5.0,
                              top: 2,
                              bottom: 10),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0),
                                child: InkWell(
                                  onTap: (){setState(() {comntindex=null;
                                  del=false;});},
                                  onLongPress: () {
                                    setState(() {
                                      comntindex=index;
                                      del= userid.toString() ==
                                          _con.timelineComments[
                                          index][
                                          'user_id']
                                              .toString() ? true : false;
                                      cmntid=_con.timelineComments[
                                      index]
                                      [
                                      'id']
                                          .toString();

                                    });

                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>TimelineFoodWallDetailPage(id:_con.timelineComments[index]['user_id'].toString() ,)
                                          ));
                                        },
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundImage:
                                          NetworkImage(_con
                                              .timelineComments[
                                          index][
                                          'picture'].toString().replaceAll(" ", "%20")+"?alt=media"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap:(){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>TimelineFoodWallDetailPage(id:_con.timelineComments[index]['user_id'].toString() ,)
                                              ));
                                            },
                                            child: Text(
                                              _con.timelineComments[
                                              index]
                                              ['name'],
                                              textAlign:
                                              TextAlign
                                                  .start,
                                              style: f15wB,
                                            ),
                                          ),
                                          Container(
                                            width: 250,
                                            child: Text(
                                              _con.timelineComments[
                                              index]
                                              [
                                              'description'],
                                              textAlign:
                                              TextAlign
                                                  .start,
                                              style: f15w,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            children: <
                                                Widget>[
                                              _con.timelineComments[index]
                                              [
                                              'like_status'] ==
                                                  true
                                                  ? GestureDetector(
                                                onTap:
                                                    () {
                                                  _con.likeComment(userid.toString(),
                                                      _con.timelineComments[index]['id'].toString());
                                                },
                                                child:
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.favorite,
                                                      color: Color(0xFFffd55e),
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Liked",
                                                      style: f14w,
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : GestureDetector(
                                                onTap:
                                                    () {

                                                  _con.likeComment(userid.toString(),
                                                      _con.timelineComments[index]['id'].toString());
                                                },
                                                child:
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Like",
                                                      style: f14w,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Text(
                                                  _con.timelineComments[index]['likes_comment_count']
                                                      .toString() +
                                                      " Likes",
                                                  style:
                                                  f14w),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    indexc=index;
                                                    ReplyStatus=true;
                                                  });
                                                },
                                                child: Text(
                                                  "Reply",
                                                  style:
                                                  f14y,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                d.toString(),
                                                style: f13g,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              _con.timelineComments[
                              index]
                              [
                              'replies'].length>0 &&  _reply[index]==true && _replyShow[index]==false ? GestureDetector(
                                onTap:(){
                                  setState(() {
                                    viewindex=index;
                                    replyShow=true;
                                  _replyShow[index]=true;});
                                },
                                child: Text("_______"+_con.timelineComments[
                                index]
                                [
                                'replies'].length.toString()+" replies",style: f14g,),
                              ) :  Container(height: 0,) ,
                              _con.timelineComments[
                              index]
                              [
                              'replies'].length>0  && _replyShow[index]==true && _reply[index]==true? GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      viewindex=index;
                                      replyShow=false;
                                    _replyShow[index]=false;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom:2.0),
                                    child: Text("_______"+"Hide replies",style: f14g,),
                                  )) : Container(height: 0,),
                               _con.timelineComments[
                              index]
                              [
                              'replies'].length!= 0 && _replyShow[index]==true ? Container(height: _con.timelineComments[index]['replies'].length.toDouble() * 63,
                                child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                                    itemCount: _con.timelineComments[index]
                                    ['replies'].length,
                                    itemBuilder: (BuildContext context, int replyindex){

                                      _date2 = DateTime.parse(
                                          _con.timelineComments[index]
                                          ['replies'][replyindex]['created_at']
                                          ['date']);
                                      var e =
                                          DateTime.now().difference(_date2).inHours;
                                      e > 24
                                          ? d2 = DateTime.now()
                                          .difference(_date2)
                                          .inDays
                                          .toString() +
                                          " day ago"
                                          : e == 0
                                          ? d2 = DateTime.now()
                                          .difference(_date2)
                                          .inMinutes
                                          .toString() +
                                          " mints ago"
                                          : d2 = DateTime.now()
                                          .difference(_date2)
                                          .inHours
                                          .toString() +
                                          " hrs ago";

                                      return Container(
                                        color: repdel==true && replyindex==repcomntindex && mainInd==index ? Colors.white12.withOpacity(.2) : Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:4.0,bottom: 4,left: 60,right: 10),
                                          child: InkWell(
                                            onTap: (){setState(() {repcomntindex=null;
                                            repdel=false;});},
                                            onLongPress: () {
                                              setState(() {
                                                mainInd = index;
                                                replength=_con.timelineComments[index]
                                                ['replies'].length;
                                                repcomntindex=replyindex;
                                                repdel= userid.toString() ==
                                                    _con.timelineComments[index]['replies'][replyindex][
                                                    'user_id']
                                                        .toString() ? true : false;
                                                repcmntid=_con.timelineComments[index]['replies'][replyindex]
                                                [
                                                'id']
                                                    .toString();
                                              });
                                            },
                                            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap:(){
                                                    Navigator.push(context, MaterialPageRoute(
                                                      builder: (context)=>TimelineFoodWallDetailPage(id:_con.timelineComments[index]['replies'][replyindex]['user_id'].toString() ,)
                                                    ));
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 14,
                                                    backgroundImage: CachedNetworkImageProvider(
                                                        _con.timelineComments[index]['replies'][replyindex]["picture"].toString().replaceAll(" ", "%20")+"?alt=media"
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                        onTap:(){
                                                          Navigator.push(context, MaterialPageRoute(
                                                              builder: (context)=>TimelineFoodWallDetailPage(id:_con.timelineComments[index]['replies'][replyindex]['user_id'].toString() ,)
                                                          ));
                                                        },
                                                        child: Text(_con.timelineComments[index]['replies'][replyindex]["name"],style: f14wB,)),
                                                    SizedBox(height: 2,),
                                                    Container(width: 274,
                                                      child: LayoutBuilder(builder: (context, size,) {
                                                        final span = TextSpan(text: _con.timelineComments[index]
                                                        ['replies'][replyindex]["description"].toString(), style: f14w);
                                                        final tp = TextPainter(text: span, maxLines: 1,textDirection: TextDirection.ltr);
                                                        tp.layout(maxWidth: size.maxWidth,);
                                                        if (tp.didExceedMaxLines) {
                                                          return  Row(
                                                            children: [
                                                              Container(width: 200,
                                                                child: Text(_con.timelineComments[index]
                                                                ['replies'][replyindex]["description"].toString(),style: f14w,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                              ),
                                                           InkWell(
                                                               onTap: (){
                                                                 showDialog(
                                                                     context: context,
                                                                     builder: (context) {
                                                                       return StatefulBuilder(
                                                                           builder: (BuildContext context,
                                                                               sss.StateSetter state) {
                                                                             return AlertDialog(backgroundColor: Color(0xFF1E2026),
                                                                               content: Wrap(
                                                                                 children: [
                                                                                   Container(
                                                                                     child: Column(
                                                                                       children: [
                                                                                         Row(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                           children: [
                                                                                             CircleAvatar(
                                                                                               radius: 14,
                                                                                               backgroundImage: CachedNetworkImageProvider(
                                                                                                   _con.timelineComments[index]['replies'][replyindex]["picture"].toString().replaceAll(" ", "%20")+"?alt=media"
                                                                                               ),
                                                                                             ),
                                                                                             SizedBox(width: 10,),
                                                                                             Container(width: 200,
                                                                                               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                 children: [
                                                                                                   GestureDetector(
                                                                                                       onTap:(){
                                                                                                         Navigator.push(context, MaterialPageRoute(
                                                                                                             builder: (context)=>TimelineFoodWallDetailPage(id:_con.timelineComments[index]['replies'][replyindex]['user_id'].toString() ,)
                                                                                                         ));
                                                                                                       },
                                                                                                       child: Text(_con.timelineComments[index]['replies'][replyindex]["name"],style: f14wB,)),
                                                                                                   SizedBox(height: 3,),
                                                                                                   Text(_con.timelineComments[index]
                                                                                                   ['replies'][replyindex]["description"].toString(),style: f14w,),

                                                                                                 ],
                                                                                               ),
                                                                                             ),
                                                                                           ],
                                                                                         ),

                                                                                       ],
                                                                                     ),
                                                                                   ),
                                                                                 ],
                                                                               ),
                                                                               contentPadding: EdgeInsets.only(left:12,right: 12,top: 12),actionsPadding: EdgeInsets.all(0),
                                                                               actions: [
                                                                                 MaterialButton(
                                                                                     onPressed: (){
                                                                                       Navigator.pop(context);
                                                                                     },
                                                                                     child: Text("OK",style: f14GB,)),
                                                                               ],
                                                                             );
                                                                           });
                                                                     });
                                                               },
                                                               child: Container(height:20,alignment: Alignment.centerLeft,
                                                                   child: Text("Read more",style: f14b,)))
                                                            ],
                                                          );
                                                          // The text has more than three lines.
                                                          // TODO: display the prompt message

                                                        } else {
                                                          return  Text(_con.timelineComments[index]
                                                          ['replies'][replyindex]["description"].toString(),style: f14w,maxLines: 1,overflow: TextOverflow.ellipsis,);
                                                        }
                                                      }),
                                                    ),
                                                    /*Container(width: 212,
                                                      child: Text(_con.timelineComments[index]
                                                      ['replies'][replyindex]["description"].toString(),style: f14w,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                    ),*/
                                                    SizedBox(height: 2,),
                                                    Row(
                                                      children: <
                                                          Widget>[
                                                        _con.timelineComments[index]
                                                        ['replies'][replyindex]
                                                        [
                                                        'like_status'] ==
                                                            true
                                                            ? GestureDetector(
                                                          onTap:
                                                              () {
                                                            _con.likeComment(userid.toString(),
                                                                _con.timelineComments[index]
                                                                ['replies'][replyindex]['id'].toString());
                                                          },
                                                          child:
                                                          Row(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons.favorite,
                                                                color: Color(0xFFffd55e),
                                                                size: 18,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Liked",
                                                                style: f14w,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                            : GestureDetector(
                                                          onTap:
                                                              () {

                                                            _con.likeComment(userid.toString(),
                                                                _con.timelineComments[index]
                                                                ['replies'][replyindex]['id'].toString());
                                                          },
                                                          child:
                                                          Row(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons.favorite_border,
                                                                color: Colors.white,
                                                                size: 18,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Like",
                                                                style: f14w,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20.0,
                                                        ),
                                                        Text(
                                                            _con.timelineComments[index]
                                                            ['replies'][replyindex]['likes_comment_count']
                                                                .toString() +
                                                                " Likes",
                                                            style:
                                                            f14w),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          d2.toString(),
                                                          style: f13g,
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ) : Container(height: 0,),
                              indexc==index && ReplyStatus==true ?   Container(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height:reply.text.length>32 ? contheight.toDouble() : 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF23252E),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 5.0,
                                              spreadRadius: 0.0)
                                        ]),
                                    child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width-85,
                                          child: TextField(
                                            onChanged: (val){
                                              if(val.length>32)
                                                setState(() {contheight=100;});
                                              else
                                                setState(() {contheight=50;});
                                            },
                                            cursorColor: Colors.yellow,
                                            controller: reply,autofocus: true,
                                            expands: true,maxLines: null,minLines: null,
                                            style: TextStyle(color: Colors.white),
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "  Add a reply...",
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: Center(
                                                    child: CircleAvatar(
                                                      radius: 17,
                                                      backgroundImage: CachedNetworkImageProvider(
                                                          userPIC
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              hintStyle: f14g,

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right:10.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                reply.text.length>0  ? _con.postTimCommntReply(postid.toString(),
                                                    userid.toString(), reply.text,_con.timelineComments[index]["id"].toString()) : null;
                                                setState(() {
                                                  reply.text = "";
                                                  ReplyStatus=false;
                                                });
                                              },
                                              child: Text("Post", style: f14b)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ) : Container(height: 0,),
                            ],
                          )),
                    );
                  }),
            )
                :_con.statusComment == false ? Center(child: Text("No Comments",style: f16wB,)):Container(height: 0,),
            ReplyStatus!=true ? Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: cmnt.text.length>32 ? contheight.toDouble() : 50,
                  decoration: BoxDecoration(
                      color: Color(0xFF23252E),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 0.0)
                      ]),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width-80,
                        child: TextField(
                          cursorColor: Colors.yellow,
                          controller: cmnt,
expands: true,maxLines: null,minLines: null,
                          onChanged: (val){
                            if(val.length>32)
                              setState(() {contheight=100;});
                            else
                              setState(() {contheight=50;});
                          },

                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "  Add a comment...",

                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 25,
                                width: 25,
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundImage:userPIC!=null ?  CachedNetworkImageProvider(
                                      userPIC,
                                    ) : CachedNetworkImageProvider(
                                      "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            hintStyle: f14g,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:10.0),
                        child: GestureDetector(
                            onTap: () {
                              _con.postTimCommnt(postid.toString(),
                                  userid.toString(), cmnt.text);
                              setState(() {
                                cmnt.text = "";
                                _con.getTimelineWall(userid.toString());
                              });
                            },
                            child: Text("Post", style: f14b)),
                      )
                    ],
                  ),
                ),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
