import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/CHAT/conversation_screen.dart';
import 'package:Butomy/CHAT/database.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/share_post_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
    as repo;

import 'ANOTHERPERSON/wall_web_view_page.dart';
import 'Search_Screen/thumb_vide0_widget.dart';
import 'Search_Screen/video_widget.dart';
import 'edit_post.dart';
import 'hashtag_search_page.dart';

DateTime _date;
var d;
var httpsObj = "https://img.youtube.com/vi/";
var thirdHttp = "/0.jpg";
var imgHtp;
List<String> playlist;
var likesCountApi;
var flag = 0;
var sharePost;
var postImage;
var postDesc;

class VideoDetailPage extends StatefulWidget {
  String Name,
      username,
      dateStr,

      CommentsCount,
      ShareCount,
      description,
      videoTitle,
      videoId,
      usrId,
      date,
      pic,timid,
      postid,usertoken,memberdate;
  int indexPass,LikesCount;
  bool followstatus,likestatus,savestatus;

  VideoDetailPage(
      {this.Name,this.timid,
      this.description,
      this.likestatus,
      this.savestatus,
      this.date,
      this.CommentsCount,
      this.username,
      this.dateStr,
      this.LikesCount,
      this.ShareCount,
      this.videoId,
      this.videoTitle,
      this.memberdate,
      this.usrId,
      this.indexPass,
      this.followstatus,
      this.usertoken,
      this.pic,
      this.postid});

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}
bool followw;
var s = "unlike";
var b = "unmark";

class _VideoDetailPageState extends StateMVC<VideoDetailPage> {
  TimelineWallController _con;

  _VideoDetailPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  List<bool> _showutube = List.filled(1000, false);
  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {followw=widget.followstatus; });
    _con.getAccountWallVideos(widget.timid, "video", userid.toString());
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    setState(() {
      if (flag != 1) {
        likesCountApi = widget.LikesCount;
      }
    });
    playlist = <String>[
      "https://www.youtube.com/watch?v=" + widget.videoId.toString(),
    ];
    _videoPlayerController1 = VideoPlayerController.network(
        'https://saasinfomedia.com/foodiz/public/video/videoplayback.mp4');
    _chewieController = ChewieController(
      autoInitialize: true,
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Color(0xFFffd55e),
        handleColor: Color(0xFF48c0d8),
        backgroundColor: Color(0xFF1E2026),
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Color(0xFF23252E),
      ),
      // autoInitialize: true,
    );
  }

  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post', sharePost, 'text/plain');
    } catch (e) {
      //print('error: $e');
    }
  }

  createChatroomAndStartConversation(
      {String cusUserNAME, String CusImage, String cusNAME}) {
    String chatRoomId = getChatRoomId(cusUserNAME, userNAME);
    String avatars = getAvatar(CusImage, userPIC);
    String names = getNames(cusNAME, NAME);
    List<String> users = [cusUserNAME, userNAME];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "avatars": avatars,
      "chatroomId": chatRoomId,
      "names": names
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(
                chatRoomId, CusImage, cusNAME, cusUserNAME)));
  }

  @override
  Widget build(BuildContext context) {
    _con.getFollowing(userid);
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
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: _con.AccountWallVideos.length > 0
            ? Column(
                children: <Widget>[
                  widget.videoId.length == 11
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewContainer(
                                          url: 'https://www.youtube.com/watch?v=' +
                                              widget.videoId
                                                  .toString(),
                                        )));
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CachedNetworkImage(
                                  imageUrl: "https://img.youtube.com/vi/" +
                                      widget.videoId
                                          .toString() +
                                      "/0.jpg",height: 200,width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, ind) =>
                                      Image.asset(
                                        "assets/Template1/image/Foodie/post_dummy.jpeg",
                                        fit: BoxFit.cover, height: 200,width: MediaQuery.of(context).size.width,
                                      )),
                              Image.asset(
                                "assets/Template1/image/Foodie/icons/youtube.png",
                                height: 32,
                                width: 32,
                              )
                            ],
                          ),
                        )
                      : widget.videoId.length != 11
                          ? Container(
                              alignment: Alignment.center,
                              child: VideoWidget(
                                url:
                                    "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                        widget.videoId
                                            .toString()
                                            .replaceAll(" ", "%20") +
                                        "?alt=media",
                                play: true,
                              )

                              /*  child: Chewie(
                                        controller: ChewieController(
                                          videoPlayerController: VideoPlayerController.network(
                                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/2020-10-15%2011:40:40.779801.mp4?alt=media"),
                                          aspectRatio: 3 / 2,allowFullScreen: false,
                                          // autoPlay: true,
                                          autoInitialize: true,
                                          looping: true,
                                        ),
                                      ),*/
                              )
                          : Container(),
                  Container(
                    height: widget.videoId.length != 11
                        ? MediaQuery.of(context).size.height - 338
                        : MediaQuery.of(context).size.height - 291,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                            top: 5,
                            right: 6,
                          ),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width-29,
                                child: widget.videoTitle.length > 130 && /*textSpan==false &&*/ _showutube[0]==false ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,bottom: 2),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SmartText(
                                        text:
                                        widget.videoTitle.substring(0, 130,) + " ...",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        onOpen:(link){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>WebViewContainer(url: link,)
                                          ));
                                        },

                                        onTagClick: (tag) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HashSearchAppbar(
                                                        hashTag: tag,
                                                      )));
                                        },
                                        onUserTagClick: (tag) {
                                          _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                                        },
                                      ),
                                      SizedBox(height: 3,),
                                      GestureDetector(
                                          onTap: (){
                                            setState(() {
                                            _showutube[0]=true;});
                                          },
                                          child: Text("Show more...",style: f14p,)),
                                      SizedBox(height: 2,),
                                    ],
                                  ),
                                ) : widget.videoTitle.length > 130/* &&
                      textSpan == true*/ && _showutube[0]==true?
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,bottom: 2),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SmartText(
                                        text:
                                        widget.videoTitle,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        onOpen:(link){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>WebViewContainer(url: link,)
                                          ));
                                        },
                                        onTagClick: (tag) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HashSearchAppbar(
                                                        hashTag: tag,
                                                      )));
                                        },
                                        onUserTagClick: (tag) {
                                          _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                                        },
                                      ),
                                      SizedBox(height:3,),
                                      GestureDetector(
                                          onTap: (){
                                            setState(() {
                                            _showutube[0]=false;});
                                          },
                                          child: Text("Show less...",style: f14p,)),
                                      SizedBox(height: 2,),
                                    ],
                                  ),
                                ) : widget.videoTitle.length <= 130 ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,bottom: 2),
                                  child: SmartText(
                                    text:
                                    widget.videoTitle,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    onOpen:(link){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>WebViewContainer(url: link,)
                                      ));
                                    },
                                    onTagClick: (tag) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HashSearchAppbar(
                                                    hashTag: tag,
                                                  )));
                                    },
                                    onUserTagClick: (tag) {
                                      _con.getUseranametoId(context,tag.toString().replaceFirst("@", ""));
                                    },
                                  ),
                                ) : Container(),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                        Color(
                                            0xFF1E2026),
                                        context:
                                        context,
                                        clipBehavior: Clip
                                            .antiAlias,
                                        builder:
                                            (BuildContext
                                        context) {
                                          return StatefulBuilder(
                                              builder: (
                                                  BuildContext
                                                  context,
                                                  sss.StateSetter
                                                  state) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      bottom:
                                                      5.0,
                                                      top:
                                                      5,
                                                      right:
                                                      10,
                                                      left:
                                                      10),
                                                  child:
                                                  Wrap(
                                                    children: <
                                                        Widget>[
                                                      userid
                                                          .toString() ==
                                                          _con
                                                              .AccountWallVideos[0]['user_id']
                                                              .toString()
                                                          ? Padding(
                                                        padding: const EdgeInsets
                                                            .all(
                                                            6.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator
                                                                .push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        EditPost(
                                                                          desc: _con
                                                                              .AccountWallVideos[0]['description']
                                                                              .toString(),
                                                                          postid: _con
                                                                              .AccountWallVideos[0]["id"]
                                                                              .toString(),
                                                                        )));
                                                          },
                                                          child: Container(
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Image
                                                                    .asset(
                                                                  "assets/Template1/image/Foodie/icons/pencil.png",
                                                                  height: 21,
                                                                  width: 21,
                                                                ),
                                                                SizedBox(
                                                                  width: 16,
                                                                ),
                                                                Text(
                                                                  "Edit Post",
                                                                  style: f15wB,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          : Container(
                                                        height: 0,
                                                      ),
                                                      userid
                                                          .toString() ==
                                                          _con
                                                              .AccountWallVideos[0]['user_id']
                                                              .toString()
                                                          ? Padding(
                                                        padding: const EdgeInsets
                                                            .all(
                                                            6.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator
                                                                .pop(
                                                                context);
                                                            showDialog(
                                                                context: context,
                                                                builder: (
                                                                    BuildContext context) {
                                                                  return AlertDialog(
                                                                    backgroundColor: Color(
                                                                        0xFF1E2026),
                                                                    title: new Text(
                                                                      "Delete Post?",
                                                                      style: f16wB,
                                                                    ),
                                                                    content: new Text(
                                                                      "Do you want to delete the post",
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
                                                                          "Delete",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .black),
                                                                        ),
                                                                        onPressed: () {
                                                                          _con
                                                                              .deleteTimelineWall(
                                                                              userid
                                                                                  .toString(),
                                                                              _con
                                                                                  .AccountWallVideos[0]['id']
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
                                                          child: Container(

                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .delete_outline,
                                                                  size: 26,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Delete Post",
                                                                      style: f15wB,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Text(
                                                                      "Delete the entire post",
                                                                      style: f13w,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          : Container(
                                                        height: 0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(
                                                            6.0),
                                                        child:
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              postid =
                                                                  _con
                                                                      .AccountWallVideos[0]["id"]
                                                                      .toString();
                                                            });
                                                            _con
                                                                .saveTimelinePost(
                                                                postid
                                                                    .toString(),
                                                                userid
                                                                    .toString());
                                                            Navigator
                                                                .pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .bookmark_border,
                                                                  size: 26,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Save Post",
                                                                      style: f15wB,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Text(
                                                                      "Add this to your saved post",
                                                                      style: f13w,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      userid
                                                          .toString() !=
                                                          _con
                                                              .AccountWallVideos[0]['user_id']
                                                              .toString()
                                                          ? Padding(
                                                        padding: const EdgeInsets
                                                            .all(
                                                            6.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            _con
                                                                .reportTimeWall(
                                                                userid,
                                                                _con
                                                                    .AccountWallVideos[0]['id']);

                                                            Navigator
                                                                .pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .block,
                                                                  size: 26,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Report & Support",
                                                                      style: f15wB,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Text(
                                                                      "I'am concerned about this post",
                                                                      style: f13w,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          : Container(
                                                        height: 0,
                                                      ),
                                                      userid
                                                          .toString() !=
                                                          _con
                                                              .AccountWallVideos[0]['user_id']
                                                              .toString()
                                                          ? Padding(
                                                        padding: const EdgeInsets
                                                            .all(
                                                            6.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            _con
                                                                .followerController(
                                                                userid
                                                                    .toString(),
                                                                _con
                                                                    .AccountWallVideos[0]['user_id']
                                                                    .toString());
                                                            Navigator
                                                                .pop(
                                                                context);
                                                          },
                                                          child: Container(

                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Image
                                                                    .asset(
                                                                  "assets/Template1/image/Foodie/icons/person.png",
                                                                  height: 21,
                                                                  width: 21,
                                                                ),
                                                                SizedBox(
                                                                  width: 16,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    _con
                                                                        .AccountWallVideos[0]["follow_status"] ==
                                                                        true
                                                                        ? Text(
                                                                      "Unfollow",
                                                                      style: f15wB,
                                                                    )
                                                                        : Text(
                                                                      "Follow",
                                                                      style: f15wB,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    _con
                                                                        .AccountWallVideos[0]["follow_status"] ==
                                                                        true
                                                                        ? Text(
                                                                      "Unfollow  " +
                                                                          _con
                                                                              .AccountWallVideos[0]["name"],
                                                                      style: f13w,
                                                                    )
                                                                        : Text(
                                                                      "Follow  " +
                                                                          _con
                                                                              .AccountWallVideos[0]["name"],
                                                                      style: f13w,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          : Container(
                                                        height: 0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(
                                                            6.0),
                                                        child:
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              postid =
                                                                  _con
                                                                      .AccountWallVideos[0]['id']
                                                                      .toString();
                                                              sharePost =
                                                                  "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                                      postid
                                                                          .toString();
                                                            });

                                                            Clipboard
                                                                .setData(
                                                                new ClipboardData(
                                                                    text: sharePost
                                                                        .toString()));
                                                            Navigator
                                                                .pop(
                                                                context);
                                                            Fluttertoast
                                                                .showToast(
                                                                msg: "Link Copied",
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                gravity: ToastGravity
                                                                    .TOP,
                                                                timeInSecForIosWeb: 10,
                                                                backgroundColor: Color(
                                                                    0xFF48c0d8),
                                                                textColor: Colors
                                                                    .white,
                                                                fontSize: 16.0);
                                                          },
                                                          child: Container(

                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .link,
                                                                  size: 26,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Copy Link",
                                                                      style: f15wB,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Text(
                                                                      "Copy Post link",
                                                                      style: f13w,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(
                                                            6.0),
                                                        child:
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              postid =
                                                                  _con
                                                                      .AccountWallVideos[0]['id']
                                                                      .toString();
                                                              sharePost =
                                                                  "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                                      postid
                                                                          .toString();
                                                            });
                                                            _shareText();
                                                          },
                                                          child: Container(

                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Image
                                                                    .asset(
                                                                  "assets/Template1/image/Foodie/icons/share.png",
                                                                  height: 21,
                                                                  width: 21,
                                                                ),
                                                                SizedBox(
                                                                  width: 16,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Share Post",
                                                                      style: f15wB,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Text(
                                                                      "Share post externally",
                                                                      style: f13w,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:5.0),
                                    child: Icon(
                                        Icons.more_vert,
                                        size: 17,
                                        color: Colors
                                            .white),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 6,right: 6),
                          child: Container(
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  CachedNetworkImageProvider(
                                              widget.pic.length>5? widget.pic+"?alt=media" :  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      180.0))),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.Name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                                  FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text("Member Since "+widget.memberdate,
                                            style: f11g)
                                      ],
                                    ),
                                  ],
                                ),
                              userid!= widget.usrId ?  Row(
                                  children: [
                                    GestureDetector(
                                        onTap:(){
                                          try {
                                            String chatID = makeChatId(userid.toString(), widget.usrId
                                                .toString());
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ChatRoom(
                                                        userid,
                                                        NAME,
                                                       widget.usertoken
                                                            .toString(),

                                                            widget.usrId
                                                            .toString(),
                                                        chatID,
                                                       widget.username
                                                            .toString(),widget.Name
                                                        .toString(),
                                                       widget.pic
                                                            .toString()
                                                            .replaceAll(
                                                            " ", "%20") +
                                                            "?alt=media","")));
                                          } catch (e) {
                                            print(e.message);
                                          }
                                        },
                                        child: Icon(Icons.chat,size: 22,color: Color(0xFFffd55e),)),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap: (){
                                        followw ==true?   showDialog(
                                            context: context,
                                            builder: (
                                                BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Color(
                                                    0xFF1E2026),
                                                content: new Text(
                                                  "Do you want to Unfollow "+widget.Name.toString()+" ?",
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
                                                        followw = true;
                                                      });
                                                      _con.followerController(
                                                          userid.toString(),
                                                          widget.usrId
                                                              .toString());
                                                      Navigator
                                                          .pop(
                                                          context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            }) :
                                        _con.followerController(
                                            userid.toString(),
                                            widget.usrId
                                                .toString());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFF48c0d8),
                                            borderRadius: BorderRadius.circular(5)),
                                        height:  23,
                                        width:followw==true? 85: 75,
                                        child: followw==true?Center(
                                          child: Text(
                                            "Unfollow",
                                            style: f14B,
                                          ),
                                        ):Center(
                                          child: Text(
                                            "Follow",
                                            style: f14B,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ) : Container()
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 5),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0,
                                        right: 6,
                                        bottom: 5,
                                        top: 10),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {postid = widget.postid;});
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LikeCommentSharePage(statusIndex: 0,)));
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    widget.LikesCount.toString(),
                                                    style: f14y,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "Likes",
                                                    style: f14y,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 13,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {postid = widget.postid;});
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LikeCommentSharePage(statusIndex: 1,)));
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    widget.CommentsCount,
                                                    style: f14y,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "Comments",
                                                    style: f14y,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 13,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {postid = widget.postid;});
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LikeCommentSharePage(statusIndex: 2,)));
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    widget.ShareCount,
                                                    style: f14y,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "Shares",
                                                    style: f14y,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <
                                              Widget>[
                                            Text(
                                              "1k Views | ",
                                              style: f13y,
                                              textAlign: TextAlign
                                                  .start,
                                            ),
                                            Text(
                                              widget.date.toString(),
                                              style: f13y,
                                              textAlign: TextAlign
                                                  .start,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7.0,
                                        right: 7,
                                        top: 5,
                                        bottom: 10),
                                    child: Container(
                                      child: InkWell(
                                        child: Container(
                                          height: 20.0,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: <Widget>[
                                             widget.likestatus ==
                                                      true
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = widget.postid
                                                              .toString();
                                                          widget.likestatus=false;
                                                          widget.LikesCount=widget.LikesCount-1;
                                                        });
                                                        flag = 1;
                                                        _con.likePostTime(
                                                            userid
                                                                .toString(),
                                                            postid
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.favorite,
                                                            color: Color(
                                                                0xFFffd55e),
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
                                                      onTap: () {
                                                        setState(() {
                                                          postid = widget.postid;
                                                          widget.likestatus=true;
                                                          widget.LikesCount=widget.LikesCount+1;
                                                        });
                                                        flag = 1;
                                                        _con.likePostTime(
                                                            userid
                                                                .toString(),
                                                            postid
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors
                                                                .white,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    postid = widget.postid;
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CommentPage()));
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons
                                                          .chat_bubble_outline,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Comment",
                                                      style: f14w,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    postid = widget.postid;
                                                    sharePost =
                                                        "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                            postid
                                                                .toString();
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SharePost(postid: postid.toString(),sharepost: sharePost.toString(),)));
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/Template1/image/Foodie/icons/share.png",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text("Share",
                                                        style: f14w),
                                                  ],
                                                ),
                                              ),
                                              widget.savestatus ==
                                                      true
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = widget.postid;
                                                          widget.savestatus=false;
                                                        });
                                                        _con.saveTimelinePost(
                                                            postid
                                                                .toString(),
                                                            userid
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.bookmark,
                                                            color: Color(
                                                                0xFF48c0d8),
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Saved",
                                                            style: f14w,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          postid = widget.postid;
                                                          widget.savestatus=true;
                                                        });
                                                        _con.saveTimelinePost(
                                                            postid
                                                                .toString(),
                                                            userid
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .bookmark_border,
                                                            color: Colors
                                                                .white,
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Save",
                                                            style: f14w,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Divider(
                          color: Colors.black87,
                          thickness: 1,
                        ),

                        Container(
                          height: _con
                              .AccountWallVideos
                              .length.toDouble()*140,
                          child: _con.AccountWallVideos.length > 0
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _con.AccountWallVideos.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    imgHtp = httpsObj +
                                        _con.AccountWallVideos[index]
                                                ["youtube_video_id"]
                                            .toString() +
                                        thirdHttp;
                                    _date = DateTime.parse(
                                        _con.AccountWallVideos[index]
                                            ['created_at']['date']);
                                    var c = DateTime.now()
                                        .difference(_date)
                                        .inHours;
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

                                    List<String> playlistVid = <String>[
                                      "https://www.youtube.com/watch?v=" +
                                          _con.AccountWallVideos[index]
                                                  ["youtube_video_id"]
                                              .toString()
                                    ];
                                    return index != widget.indexPass
                                        ? Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) =>
                                                        VideoDetailPage(
                                                            timid: _con
                                                                .AccountWallVideos[index]["timeline_id"]
                                                                .toString(),
                                                            memberdate: widget.memberdate.toString(),date: d.toString(),
                                                            username: _con
                                                                .AccountWallVideos[index]["username"]
                                                                .toString(),pic: _con
                                                                .AccountWallVideos[index]["picture"]
                                                                .toString(),followstatus: _con
                                                                .AccountWallVideos[index]["follow_status"],
                                                            likestatus: _con
                                                                .AccountWallVideos[index]["like_status"],
                                                            savestatus: _con
                                                                .AccountWallVideos[index]["save_status"],
                                                            usertoken: _con
                                                                .AccountWallVideos[index]["device_token"].toString(),
                                                            indexPass: index,
                                                            Name: _con
                                                                .AccountWallVideos[index]["name"]
                                                                .toString(),
                                                            videoId: _con
                                                                .AccountWallVideos[index]["youtube_video_id"]
                                                                .toString(),
                                                            videoTitle: _con
                                                                .AccountWallVideos[index]["youtube_title"]
                                                                .toString(),
                                                            description: _con
                                                                .AccountWallVideos[index]["description"]
                                                                .toString(),
                                                            LikesCount: _con
                                                                .AccountWallVideos[index]["likes_count"],
                                                            ShareCount: _con
                                                                .AccountWallVideos[index]["share_count"]
                                                                .toString(),
                                                            CommentsCount: _con
                                                                .AccountWallVideos[index]["comments_count"]
                                                                .toString(),
                                                            usrId: _con
                                                                .AccountWallVideos[0]['user_id']
                                                                .toString(),
                                                            postid: _con
                                                                .AccountWallVideos[index]['id']
                                                                .toString())));
                                          },
                                          child: Padding(
                                              padding: EdgeInsets
                                                  .only(
                                                top: 15.0,
                                                bottom: 15.0,
                                                left: 5.0,
                                                right: 5.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: <
                                                    Widget>[
                                                  Row(
                                                    children: <
                                                        Widget>[
                                                      _con
                                                          .AccountWallVideos[index]["youtube_video_id"] !=
                                                          null &&
                                                          _con
                                                              .AccountWallVideos[index]["youtube_video_id"]
                                                              .toString()
                                                              .length ==
                                                              11
                                                          ? Container(
                                                        height: 105,
                                                        width: 146,
                                                        decoration: BoxDecoration(
                                                          //color: Color(0xFF48c0d8),
                                                          border: Border
                                                              .all(
                                                            color: Colors
                                                                .white,
                                                          ),
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius
                                                                  .circular(
                                                                  5.0)),
                                                        ),
                                                        child: Image
                                                            .network(
                                                          imgHtp,
                                                          fit: BoxFit
                                                              .contain,
                                                        ),
                                                      )
                                                          : _con
                                                          .AccountWallVideos[index]["youtube_video_id"] !=
                                                          null &&
                                                          _con
                                                              .AccountWallVideos[index]["youtube_video_id"]
                                                              .toString()
                                                              .length !=
                                                              11
                                                          ? Container(
                                                        height: 105,
                                                        width: 146,
                                                        decoration: BoxDecoration(
                                                          //color: Color(0xFF48c0d8),
                                                          border: Border
                                                              .all(
                                                            color: Colors
                                                                .white,
                                                          ),
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius
                                                                  .circular(
                                                                  5.0)),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(3.0),
                                                          child: ThumbVideoWidget(
                                                            url: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                                                _con
                                                                    .AccountWallVideos[index]['youtube_video_id']
                                                                    .toString()
                                                                    .replaceAll(
                                                                    " ",
                                                                    "%20") +
                                                                "?alt=media",
                                                            play: true,),
                                                        ),
                                                      )
                                                          : Container(),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(width: MediaQuery.of(context).size.width-180,
                                                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,

                                                          children: <
                                                              Widget>[
                                                            _con
                                                                .AccountWallVideos[index]["youtube_title"]
                                                                .length >
                                                                70
                                                                ? Text(
                                                              // "Mumbai Street Foods | \nBest Indian Street Food",
                                                              _con
                                                                  .AccountWallVideos[index]["youtube_title"]
                                                                  .substring(
                                                                  0,
                                                                  70) +
                                                                  " ...",
                                                              style: f14wB,
                                                              textAlign: TextAlign
                                                                  .start,
                                                            )
                                                                : Text(
                                                                _con
                                                                    .AccountWallVideos[index]["youtube_title"],
                                                                style: f14wB,
                                                                textAlign: TextAlign
                                                                    .start),

                                                            /*_con.AccountWallVideos[index]
                                                            ['description'] !=
                                                                "" && _con.AccountWallVideos[index]
                                                            ['description'] != null ? SmartText(
                                                              text:  _con
                                                                  .AccountWallVideos[index]['description'].toString().length<22 ?
                                                              _con
                                                                  .AccountWallVideos[index]['description'] :  _con
                                                                  .AccountWallVideos[index]['description'].toString().substring(0,20)+" ...",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                              ),
                                                              onOpen:(link){
                                                                Navigator.push(context, MaterialPageRoute(
                                                                    builder: (context)=>WebViewContainer(url: link,)
                                                                ));
                                                              },
                                                              onTagClick: (tag) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            HashSearchAppbar(
                                                                              hashTag: tag,
                                                                            )));
                                                              },
                                                              onUserTagClick: (tag) {
                                                                _con.getUseranametoId(tag.toString().replaceFirst("@", ""));
                                                              },
                                                            )
                                                                : Container(),*/
                                                           SizedBox(height: 10,),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "1k Views | ",
                                                                  style: f13y,
                                                                  textAlign: TextAlign
                                                                      .start,
                                                                ),
                                                                Text(
                                                                  d
                                                                      .toString(),
                                                                  style: f13y,
                                                                  textAlign: TextAlign
                                                                      .start,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        top: 0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            backgroundColor: Color(
                                                                0xFF1E2026),
                                                            context: context,
                                                            clipBehavior: Clip
                                                                .antiAlias,
                                                            builder: (
                                                                BuildContext context) {
                                                              return StatefulBuilder(
                                                                  builder:
                                                                      (
                                                                      BuildContext context,
                                                                      sss.StateSetter state) {
                                                                    return Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom: 5.0,
                                                                          top: 5,
                                                                          right: 10,
                                                                          left: 10),
                                                                      child: Wrap(
                                                                        children: <
                                                                            Widget>[
                                                                          userid
                                                                              .toString() ==
                                                                              _con
                                                                                  .AccountWallVideos[
                                                                              index]
                                                                              ['user_id']
                                                                                  .toString()
                                                                              ? Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              child: Container(
                                                                                height: 35,
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Image
                                                                                        .asset(
                                                                                      "assets/Template1/image/Foodie/icons/pencil.png",
                                                                                      height:
                                                                                      21,
                                                                                      width: 21,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 16,
                                                                                    ),
                                                                                    Text(
                                                                                      "Edit Post",
                                                                                      style:
                                                                                      f15wB,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : Container(
                                                                            height: 0,),
                                                                          userid
                                                                              .toString() ==
                                                                              _con
                                                                                  .AccountWallVideos[
                                                                              index]
                                                                              ['user_id']
                                                                                  .toString()
                                                                              ? Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                _con
                                                                                    .deleteTimelineWall(
                                                                                    userid
                                                                                        .toString(),
                                                                                    _con
                                                                                        .AccountWallVideos[
                                                                                    index]
                                                                                    ['id']
                                                                                        .toString());

                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Container(
                                                                                height: 35,
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Icon(
                                                                                      Icons
                                                                                          .delete_outline,
                                                                                      size: 26,
                                                                                      color: Colors
                                                                                          .white,),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Delete Post",
                                                                                          style:
                                                                                          f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,),
                                                                                        Text(
                                                                                          "Delete the entire post",
                                                                                          style:
                                                                                          f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : Container(
                                                                            height: 0,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  postid =
                                                                                      _con
                                                                                          .AccountWallVideos[index]["id"]
                                                                                          .toString();
                                                                                });
                                                                                _con
                                                                                    .saveTimelinePost(
                                                                                    postid
                                                                                        .toString(),
                                                                                    userid
                                                                                        .toString());
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Container(
                                                                                height: 35,
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Icon(
                                                                                      Icons
                                                                                          .bookmark_border,
                                                                                      size: 26,
                                                                                      color: Colors
                                                                                          .white,),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Save Post",
                                                                                          style:
                                                                                          f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,),
                                                                                        Text(
                                                                                          "Add this to your saved post",
                                                                                          style:
                                                                                          f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          userid
                                                                              .toString() !=
                                                                              _con
                                                                                  .AccountWallVideos[
                                                                              index]
                                                                              ['user_id']
                                                                                  .toString()
                                                                              ? Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                _con
                                                                                    .reportTimeWall(
                                                                                    userid,
                                                                                    _con
                                                                                        .AccountWallVideos[
                                                                                    index]
                                                                                    ['id']);

                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Container(
                                                                                height: 35,
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Icon(
                                                                                      Icons
                                                                                          .block,
                                                                                      size: 26,
                                                                                      color: Colors
                                                                                          .white,),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Report & Support",
                                                                                          style:
                                                                                          f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,),
                                                                                        Text(
                                                                                          "I'am concerned about this post",
                                                                                          style:
                                                                                          f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : Container(
                                                                            height: 0,
                                                                          ),
                                                                          userid
                                                                              .toString() !=
                                                                              _con
                                                                                  .AccountWallVideos[
                                                                              index]
                                                                              ['user_id']
                                                                                  .toString()
                                                                              ? Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                _con
                                                                                    .followerController(
                                                                                    userid
                                                                                        .toString(),
                                                                                    _con
                                                                                        .AccountWallVideos[index]['user_id']
                                                                                        .toString());
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Container(
                                                                                height: 35,
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Image
                                                                                        .asset(
                                                                                      "assets/Template1/image/Foodie/icons/person.png",
                                                                                      height:
                                                                                      21,
                                                                                      width: 21,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 16,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        _con
                                                                                            .AccountWallVideos[index]["follow_status"] ==
                                                                                            true
                                                                                            ? Text(
                                                                                          "Unfollow",
                                                                                          style:
                                                                                          f15wB,
                                                                                        )
                                                                                            : Text(
                                                                                          "Follow",
                                                                                          style:
                                                                                          f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,),
                                                                                        _con
                                                                                            .AccountWallVideos[index]["follow_status"] ==
                                                                                            true
                                                                                            ? Text(
                                                                                          "Unfollow  " +
                                                                                              _con
                                                                                                  .AccountWallVideos[index]["name"],
                                                                                          style:
                                                                                          f13w,
                                                                                        )
                                                                                            : Text(
                                                                                          "Follow  " +
                                                                                              _con
                                                                                                  .AccountWallVideos[index]["name"],
                                                                                          style:
                                                                                          f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : Container(
                                                                            height: 0,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  postid =
                                                                                      _con
                                                                                          .AccountWallVideos[index]['id']
                                                                                          .toString();
                                                                                  sharePost =
                                                                                      "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                                                          postid
                                                                                              .toString();
                                                                                });

                                                                                Clipboard
                                                                                    .setData(
                                                                                    new ClipboardData(
                                                                                        text: sharePost
                                                                                            .toString()));
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                                Fluttertoast
                                                                                    .showToast(
                                                                                    msg: "Link Copied",
                                                                                    toastLength: Toast
                                                                                        .LENGTH_LONG,
                                                                                    gravity: ToastGravity
                                                                                        .TOP,
                                                                                    timeInSecForIosWeb: 10,
                                                                                    backgroundColor: Color(
                                                                                        0xFF48c0d8),
                                                                                    textColor: Colors
                                                                                        .white,
                                                                                    fontSize: 16.0);
                                                                              },
                                                                              child: Container(
                                                                                height: 35,
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Icon(
                                                                                      Icons
                                                                                          .link,
                                                                                      size: 26,
                                                                                      color: Colors
                                                                                          .white,),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Copy Link",
                                                                                          style:
                                                                                          f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,),
                                                                                        Text(
                                                                                          "Copy Post link",
                                                                                          style:
                                                                                          f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                6.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  postid =
                                                                                      _con
                                                                                          .AccountWallVideos[index]['id']
                                                                                          .toString();
                                                                                  sharePost =
                                                                                      "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                                                          postid
                                                                                              .toString();
                                                                                });
                                                                                _shareText();
                                                                              },
                                                                              child: Container(
                                                                                height: 35,
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    Image
                                                                                        .asset(
                                                                                      "assets/Template1/image/Foodie/icons/share.png",
                                                                                      height:
                                                                                      21,
                                                                                      width: 21,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 16,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                          .start,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Text(
                                                                                          "Share Post",
                                                                                          style:
                                                                                          f15wB,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,),
                                                                                        Text(
                                                                                          "Share post externally",
                                                                                          style:
                                                                                          f13w,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  });
                                                            });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .more_vert,
                                                        color: Colors
                                                            .white,
                                                        size: 14,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                        Divider(
                                          color: Colors
                                              .black87,
                                          thickness: 1,
                                        ),
                                      ],
                                    )
                                        : Container(
                                      height: 0,);
                                  })
                              : Center(
                                  child: Text(
                                  "No videos",
                                  style: f15wB,
                                )),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

getAvatar(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

getNames(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
