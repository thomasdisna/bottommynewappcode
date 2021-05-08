import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Data_Model/breakFast.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/blog_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/comments.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/like_comment_share_count_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/share_post_page.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:intl/intl.dart';
import 'package:smart_text_view/smart_text_view.dart';

import 'ANOTHERPERSON/wall_web_view_page.dart';
import 'Search_Screen/video_widget.dart';
import 'hashtag_search_page.dart';
var s = "unlike";
var b = "unmark";
var details="Maggi salad with peanuts to give your meal extra taste. Maggi with peanuts to give your meal extra taste."
    "Try this delicious flavour of hot Maggi salad with peanut. I tried this one to relax and change my mood and"
    " its awesome. I gave this unique name to my maggi as i always gf do with my all recipes"
    " of home maggi salad with peanut recipe. ";
class AccountBlog extends StatefulWidget {

  AccountBlog({this.blogContro});

  ScrollController blogContro;


  @override
  _AccountBlogState createState() => _AccountBlogState();
}

class _AccountBlogState extends StateMVC<AccountBlog> {

  TimelineWallController _con;

  _AccountBlogState() : super(TimelineWallController()) {
    _con = controller;
  }

  _postUpdate() async{
    Timer(Duration(seconds: 2),(){
      _con.getAccountBlog(timelineIdFoodi.toString());
    });
  }

  @override
  void initState() {
    print("ttttttttttttttttt "+timelineIdFoodi.toString());
    _con.getAccountBlog(timelineIdFoodi.toString());
    super.initState();
    setState(() {
      sel=1;
    });
  }
  var d;
  DateTime _date;
  int sel;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {
      });
    _refreshController.loadComplete();
  }

  Future<void> _getData() async {
    setState(() {
      _con.getAccountBlog(timelineIdFoodi.toString());
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  List<bool> _likes = List.filled(1000, false);
  List<bool> _save = List.filled(1000, false);
  List<bool> _showml = List.filled(1000, false);
  List<bool> _showutube = List.filled(1000, false);

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
        body: Column(
          children: [
            Container(height: 40,
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(right:8, left: 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 36,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:10,right: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      sel=1;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color:sel==1 ? Colors.black : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("Latest",style: f14w ,)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      sel=2;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color:sel==2 ? Colors.black : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("Popular",style: f14w ,)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),),
            Center(
              child: Visibility(
                  visible: _con.statusBlog,
                  child: Container(
                      margin: EdgeInsets.only(top: 100, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),

            _con.BlogList.length>0 &&_con.statusBlog == false ?  Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropMaterialHeader(color: Colors.black,backgroundColor: Color(0xFF0dc89e),),
                onRefresh: _getData,
                controller: _refreshController,
                onLoading: _onLoading,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, left: 5, right: 5,),
                  child: ListView.builder(
                      controller: widget.blogContro,
                      itemCount: _con.BlogList.length,
                      itemBuilder: (BuildContext context, int index) {
                        _date = DateTime.parse(
                            _con.BlogList[index]['created_at']
                            ['date']);
                        _con.BlogList[index]['like_status'] == true ?
                        _likes[index] = true : _likes[index] = false;
                        _con.BlogList[index]['save_status'] == true ?
                        _save[index] = true : _save[index] = false;
                        var c =
                            DateTime
                                .now()
                                .difference(_date)
                                .inHours;
                        // d =DateFormat('dd/MM/yyyy').format(_date);
                        c > 24 && c <= 48
                            ? d = "1 Day Ago" : c > 48 ?
                        d = DateFormat.yMMMd().format(_date)
                        : c == 0
                        ? d = DateTime
                            .now()
                            .difference(_date)
                            .inMinutes
                            .toString() +
                        " Mints Ago"
                            : d = DateTime
                            .now()
                            .difference(_date)
                            .inHours
                            .toString() +
                        " Hrs Ago";
                        return Padding(
                          padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3, top: 3),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>BlogDetailPage(
                                    video_id: _con.BlogList[index]["youtube_video_id"],
                                    video_title: _con.BlogList[index]["youtube_title"],
                                    id: _con.BlogList[index]["id"].toString(),
                                    blogList: _con.BlogList,
                                    imageList: _con.BlogList[index]["post_images"],
                                    title: _con.BlogList[index]["post_title"],
                                    desc: _con.BlogList[index]['description'],
                                    date: _con.BlogList[index]['created_at']['date'].toString(),
                                    views: _con.BlogList[index]['view_count'].toString(),
                                    comments: _con.BlogList[index]["comments_count"].toString(),
                                    likes: _con.BlogList[index]["likes_count"],
                                    shares: _con.BlogList[index]["share_count"].toString(),
                                    saveStatus: _con.BlogList[index]["save_status"],
                                    likeStatus: _con.BlogList[index]["like_status"],
                                    // comments: ,
                                  )
                              ));
                            },
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width-165,
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _con.BlogList[index]["post_title"],maxLines: 2,overflow: TextOverflow.ellipsis,
                                              style: f16wB,
                                            ),

                                            Text(_con
                                                .BlogList[index]['description'],
                                              style: f13w,maxLines: 3,
                                            overflow: TextOverflow.ellipsis,),

                                            /*_con.BlogList[index]
                                            ['description'] !=
                                                "" && _con.BlogList[index]
                                            ['description'] != null && _con.BlogList[index]
                                            ['description'].length > 85 && textSpan==false && _showml[index]==false ?
                                            SmartText(
                                              text:
                                              _con
                                                  .BlogList[index]['description'].substring(0, 85,) + " .....",
                                              style: f13w,
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
                                            ) : _con.BlogList[index]
                                            ['description'].length > 85 &&
                                           textSpan == true && _showml[index]==true?
                                            SmartText(
                                              text:
                                              _con
                                                  .BlogList[index]['description'],
                                              style: f13w,
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
                                            ) : _con.BlogList[index]
                                            ['description'].length <= 85 ?  SmartText(
                                              text:
                                              _con
                                                  .BlogList[index]['description'],
                                              style: f13w,
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
                                            ) : Container(),*/

                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Posted "+d.toString(),style: f13w,),
                                                Row(
                                                  children: [
                                                    Image.asset("assets/Template1/image/Foodie/icons/eye.png",height: 15,width: 15,),
                                                    SizedBox(width: 4,),
                                                    Text(_con.BlogList[index]['view_count'].toString()+" Views",style: f13b,)
                                                  ],
                                                )
                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(right:4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        postid = _con
                                                            .BlogList[
                                                        index]
                                                        ['id']
                                                            .toString();
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  LikeCommentSharePage(
                                                                    statusIndex:
                                                                    0,
                                                                  )));
                                                    },
                                                    child: Text(
                                                        _con.BlogList[
                                                        index]
                                                        [
                                                        'likes_count']
                                                            .toString() +
                                                            " Likes",
                                                        style: f13y),
                                                  ),
                                                  SizedBox(
                                                    width: 13,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        postid = _con
                                                            .BlogList[
                                                        index]
                                                        ['id']
                                                            .toString();
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  LikeCommentSharePage(
                                                                    statusIndex:
                                                                    1,
                                                                  )));
                                                      _con.getTimelineWall(
                                                          userid
                                                              .toString());
                                                    },
                                                    child: Text(
                                                        _con.BlogList[
                                                        index]
                                                        [
                                                        'comments_count']
                                                            .toString() +
                                                            " Comments",
                                                        style: f13y),
                                                  ),
                                                  SizedBox(
                                                    width: 13,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        postid = _con
                                                            .BlogList[
                                                        index]
                                                        ['id']
                                                            .toString();
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  LikeCommentSharePage(
                                                                    statusIndex:
                                                                    2,
                                                                  )));
                                                    },
                                                    child: Text(
                                                        _con.BlogList[
                                                        index]
                                                        [
                                                        'share_count']
                                                            .toString() +
                                                            " Shares",
                                                        style: f13y),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      _con
                                          .BlogList[index]
                                      ['post_images']
                                          .length >
                                          0 ? Stack(alignment: Alignment.bottomRight,
                                            children: [
                                              Container(clipBehavior: Clip.antiAlias,
                                        width: 120,
                                        height: 132,
                                        decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2)
                                        ),
                                        child: CachedNetworkImage(
                                                imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                    _con.BlogList[
                                                    index][
                                                    "post_images"]
                                                    [0]['source']
                                                        .toString()
                                                        .replaceAll(" ", "%20") +
                                                    "?alt=media",
                                                fit: BoxFit.cover,placeholder: (context, ind) => Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,)
                                        ),
                                      ),
                                              userid.toString() == _con.BlogList[
                                              index]["user_id"].toString() ?  Container(
                                                height: 50,
                                                width: 50,
                                                child: Center(
                                                  child: Container(
                                                    height: 33,
                                                    width: 33,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius: BorderRadius.circular(100)
                                                    ),
                                                    child: Center(child: Image.asset("assets/Template1/image/Foodie/icons/edit.png",color: Colors.white,height:15,width: 15,)),
                                                  ),
                                                ),
                                              ) : Container(height: 0,)
                                            ],
                                          ) : Container(height: 0,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            )  :_con.statusBlog == false ? Center(child: Padding(
              padding: const EdgeInsets.only(top:100.0),
              child: Text("No Blogs",style: f16wB,),
            )):Container(height: 0,),
          ],
        )
    );
  }
}

class cardBreakfast extends StatefulWidget {
  cardBreakfast(this._breakFast);

  breakFast _breakFast;

  @override
  _cardBreakfastState createState() => _cardBreakfastState();
}

class _cardBreakfastState extends State<cardBreakfast> {
  bool textspan=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3, top: 3),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>BlogDetailPage()
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  "Posted on 25/04/2020",
                                  style: f15wB
                              ),
                              SizedBox(height: 3,),
                              Text("by Alexander",
                                  style: f14w),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child:
                    Icon(Icons.more_vert, size: 18, color: Colors.white),
                  )
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              color: Color(0xFF20261E),
              child: Container(
                height: 240,
                child: Hero(
                  tag: 'hero-tag-${widget._breakFast.id}',
                  child: Container(
                    child: Image.asset(
                      widget._breakFast.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 7.0, right: 7, top: 5, bottom: 5),
              child: Text(
                "Maggi salad with Peanut to give your meal extra taste.",
                style: f16wB,
              ),
            ),
            Padding(
                padding:
                const EdgeInsets.only(left: 7.0, right: 7, top: 5, bottom: 5),
                child: textspan==false ? RichText(text: TextSpan(
                    text: details.substring(0,115)+"...",
                    style: f14w,
                    children: [
                      TextSpan(recognizer: TapGestureRecognizer()..onTap=(){
                        setState(() {
                          textspan=true;
                        });
                      },
                          text: " Read more",
                          style:f14b
                      )
                    ]
                ),) : GestureDetector(
                  onTap: (){
                    setState(() {
                      textspan=false;
                    });
                  },
                  child: Text(details,style: f14w,),
                )


            ),
            Padding(
              padding: const EdgeInsets.only(top: 8,
                  left: 7.0, right: 7, bottom: 5),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LikeCommentSharePage()));
                  },
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        child: Text("150 Likes", style: f14y),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Text("500 Comments", style: f14y),
                      SizedBox(
                        width: 13,
                      ),
                      Text("25 Shares", style: f14y)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 7.0, right: 7, top: 5,bottom: 8),
              child: Container(
                child: InkWell(
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (s == "unlike") {
                                s = "like";
                              } else {
                                s = "unlike";
                              }
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              s == "unlike"
                                  ? Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 18,
                              )
                                  : Icon(
                                Icons.favorite,
                                color: Color(0xFFffd55e),
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              s == "unlike"
                                  ? Text(
                                "Like",
                                style: f14w,
                              )
                                  : Text(
                                "Liked",
                                style: f14w,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CommentPage()));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.chat_bubble_outline,
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
                            showModalBottomSheet(
                                backgroundColor: Color(0xFF1E2026),
                                context: context,
                                clipBehavior: Clip.antiAlias,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: StatefulBuilder(builder:
                                        (BuildContext context,
                                        sss.StateSetter state) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            bottom: 12.0,
                                            top: 5,
                                            right: 10,
                                            left: 10),
                                        child: Container(
                                          height:
                                          MediaQuery.of(context)
                                              .size
                                              .height /
                                              1.2,
                                          child: Wrap(
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Container(
                                                    height: 35.0,
                                                    width: 35.0,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: CachedNetworkImageProvider(
                                                              "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                              errorListener: () =>
                                                              new Icon(Icons.error),
                                                            ),
                                                            fit: BoxFit.cover),
                                                        borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <
                                                          Widget>[
                                                        Text(
                                                          "Varun Mohan Chempankulam",
                                                          style:
                                                          f15wB,
                                                        ),
                                                        /*SizedBox(
                                                                  height:
                                                                      3,
                                                                ),
                                                                Text(
                                                                    "Changanassery,Kottayam",
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 12)),*/
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(14.0),
                                                child: Container(
                                                  height: 50,
                                                  width:
                                                  MediaQuery.of(
                                                      context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Color(
                                                          0xFF23252E),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8)),
                                                  child: Center(
                                                    child:
                                                    TextField(
                                                      // controller: _loc,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white),
                                                      decoration: InputDecoration(
                                                          border: InputBorder
                                                              .none,
                                                          hintText:
                                                          "    Write a Message....",
                                                          hintStyle:
                                                          f14g),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    bottom:
                                                    10.0),
                                                child: Row(
                                                  children: <
                                                      Widget>[
                                                    Container(
                                                      height: 35.0,
                                                      width: 35.0,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: CachedNetworkImageProvider(
                                                                "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                errorListener: () =>
                                                                new Icon(Icons.error),
                                                              ),
                                                              fit: BoxFit.cover),
                                                          borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Add to your Timeline",
                                                      style: f14b,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                  bottom: 10.0,
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    Share.share(
                                                        'check out my website https://protocoderspoint.com/');
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    child: Row(
                                                      children: <
                                                          Widget>[
                                                        Image.asset(
                                                          "assets/Template1/image/Foodie/icons/share.png",
                                                          height:
                                                          18,
                                                          width: 18,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "More Options...",
                                                          style:
                                                          f14w,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(5.0),
                                                child: Container(
                                                  height: 43,
                                                  width:
                                                  MediaQuery.of(
                                                      context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Color(
                                                          0xFF23252E),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8)),
                                                  child: TextField(
                                                    // controller: _loc,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white),
                                                    decoration:
                                                    InputDecoration(
                                                        prefixIcon:
                                                        Icon(
                                                          Icons
                                                              .search,
                                                          color:
                                                          Colors.white54,
                                                          size:
                                                          20,
                                                        ),
                                                        border: InputBorder
                                                            .none,
                                                        hintText:
                                                        "Search",
                                                        hintStyle:
                                                        f14g),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 15,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <
                                                      Widget>[
                                                    Row(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          height:
                                                          35.0,
                                                          width:
                                                          35.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                    errorListener: () => new Icon(Icons.error),
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                              borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14w,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              5,
                                                            ),
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14g,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF48c0d9),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                      child: Center(
                                                          child:
                                                          Text(
                                                            "Send",
                                                            style:
                                                            f14wB,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 5,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <
                                                      Widget>[
                                                    Row(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          height:
                                                          35.0,
                                                          width:
                                                          35.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                    errorListener: () => new Icon(Icons.error),
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                              borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14w,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              5,
                                                            ),
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14g,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF48c0d9),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                      child: Center(
                                                          child:
                                                          Text(
                                                            "Send",
                                                            style:
                                                            f14wB,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 5,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <
                                                      Widget>[
                                                    Row(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          height:
                                                          35.0,
                                                          width:
                                                          35.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                    errorListener: () => new Icon(Icons.error),
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                              borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14w,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              5,
                                                            ),
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14g,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF48c0d9),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                      child: Center(
                                                          child:
                                                          Text(
                                                            "Send",
                                                            style:
                                                            f14wB,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 5,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <
                                                      Widget>[
                                                    Row(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          height:
                                                          35.0,
                                                          width:
                                                          35.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                    errorListener: () => new Icon(Icons.error),
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                              borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14w,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              5,
                                                            ),
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14g,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF48c0d9),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                      child: Center(
                                                          child:
                                                          Text(
                                                            "Send",
                                                            style:
                                                            f14wB,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 5,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <
                                                      Widget>[
                                                    Row(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          height:
                                                          35.0,
                                                          width:
                                                          35.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                    errorListener: () => new Icon(Icons.error),
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                              borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14w,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              5,
                                                            ),
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14g,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF48c0d9),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                      child: Center(
                                                          child:
                                                          Text(
                                                            "Send",
                                                            style:
                                                            f14wB,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 5,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <
                                                      Widget>[
                                                    Row(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          height:
                                                          35.0,
                                                          width:
                                                          35.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                    errorListener: () => new Icon(Icons.error),
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                              borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14w,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              5,
                                                            ),
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14g,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF48c0d9),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                      child: Center(
                                                          child:
                                                          Text(
                                                            "Send",
                                                            style:
                                                            f14wB,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 5,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <
                                                      Widget>[
                                                    Row(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          height:
                                                          35.0,
                                                          width:
                                                          35.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                    errorListener: () => new Icon(Icons.error),
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                              borderRadius: BorderRadius.all(Radius.circular(180.0))),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14w,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              5,
                                                            ),
                                                            Text(
                                                              "aishwaraya_madhav",
                                                              style:
                                                              f14g,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF48c0d9),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                      child: Center(
                                                          child:
                                                          Text(
                                                            "Send",
                                                            style:
                                                            f14wB,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                });
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
                              Text(
                                "Share",
                                style: f14w,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (b == "unmark") {
                                b = "mark";
                              } else {
                                b = "unmark";
                              }
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              b == "unmark"
                                  ? Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 18,
                              )
                                  : Icon(
                                Icons.bookmark,
                                color: Color(0xFF48c0d8),
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black87,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
