import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
as repoo;
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
var img;
var cat;
String str = '';
List<String> coments = [], words = [];
class EditPost extends StatefulWidget {

  EditPost({Key key,this.postid,this.desc}) : super(key: key);
  String postid,desc;

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends StateMVC<EditPost> {

  TimelineWallController _con;

  _EditPostState() : super(TimelineWallController()) {
    _con = controller;
  }

  TextEditingController _desc = TextEditingController();
  TextEditingController _utube = TextEditingController();
  @override
  void initState() {
    _con.getUsers();
    // TODO: implement initState
    setState(() {cat="";
    _desc.text=widget.desc;});
  }
  _setCursor(){
    setState(() {str="";});
    _desc.selection =TextSelection.fromPosition(TextPosition(offset: _desc.text.length),);
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
        centerTitle: true,
        title: Text("Edit Post",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage:
                    NetworkImage(repoo.AbtInfo["data"][0]["picture"]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    repoo.AbtInfo["data"][0]["name"].toString(),
                    style: f15wB,
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only( left: 12, right: 12),
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius: BorderRadius.circular(8)),
                    child: HashTagTextField( onChanged: (val) {

                      setState(() {
                        words = val.split(' ');
                        str = words.length > 0 &&
                            words[words.length - 1].startsWith('@')
                            ? words[words.length - 1]
                            : '';
                      });
                     /* _desc.addListener(() {
                        final text = _desc.text;
                        _desc.value = _desc.value.copyWith(
                          text: text,
                          selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
                          composing: TextRange.empty,
                        );
                      });*/
                    },
                      controller: _desc,maxLines: null,minLines: null,expands: true,
                      // controller: _loc,
                      basicStyle: TextStyle(color: Colors.white,fontSize: 14),
                      keyboardType: TextInputType.text,
                      decoratedStyle: TextStyle(color: Colors.blue,fontSize: 14),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:"Write Something Here !!! ",
                          hintStyle: f14g),
                    ),
                  ),
                ),
                str.length > 1
                    ? Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Container(
                    color: Color(0xFF1E2026),
                    child: /*ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: _con.userListNamespace.map((s) {
                          var sendUrl =_con.userListNamespace['picture'];
                          if (('@' + _con.userListNamespace['username']).contains(str))
                            return ListTile(
                                leading: Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          _con.userListNamespace['picture']!="" && _con.userListNamespace['picture']!=null?  CachedNetworkImageProvider(sendUrl.toString().replaceAll(" ", "%20")+"?alt=media") : CachedNetworkImageProvider( "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV"),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(180.0))),
                                ),
                                title: Text(
                                  _con.userListNamespace['username'],
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: () {
                                  String tmp = str.substring(1, str.length);
                                  setState(() {
                                    //idPass = name[2];
                                    str = '';
                                    _desc.text=_desc.text+ _con.userListNamespace['username'].substring(
                                        _con.userListNamespace['username'].indexOf(tmp) + tmp.length,
                                        _con.userListNamespace['username'].length);

                                    *//* coments.add(_desc.text);*//*
                                  });
                                  myFocusNode.requestFocus();

                                });
                          else
                            return SizedBox();
                        }).toList())*/
                    Container(height: 200,
                      child: ListView.builder(
                          itemCount: _con.userListNamespace.length,
                          itemBuilder: (context,ind){
                            return ('@' + _con.userListNamespace[ind]['username']).contains(str) ? ListTile(
                                leading: Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          _con.userListNamespace[ind]['picture']!="" && _con.userListNamespace[ind]['picture']!=null?
                                          CachedNetworkImageProvider(_con.userListNamespace[ind]['picture'].toString().replaceAll(" ", "%20")+"?alt=media")
                                              : CachedNetworkImageProvider( "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV"),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(180.0))),
                                ),
                                title: Text(
                                  _con.userListNamespace[ind]['username'],
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: () {
                                  String tmp = str.substring(1, str.length);
                                  setState(() {
                                    str = '';
                                    _desc.text=_desc.text+ _con.userListNamespace[ind]['username'].substring(
                                        _con.userListNamespace[ind]['username'].indexOf(tmp) + tmp.length,
                                        _con.userListNamespace[ind]['username'].length);

                                  });
                                  // myFocusNode.requestFocus();
                                  _setCursor();
                                }) : Container();}),
                    ),
                  ),
                )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            if(widget.desc!=_desc.text)
              {
                _con.editPostTimelineDesc(context,
                    _desc.text,widget.postid
                );
                setState(() { _desc.text = "";});
                Fluttertoast.showToast(msg: "  Updating Post  ",
                    backgroundColor: Color(0xFF48c0d8,),
                    textColor: Colors.white,
                    gravity: ToastGravity.TOP,
                    toastLength: Toast.LENGTH_SHORT);
              }
            else
              {
                Fluttertoast.showToast(msg: "  Nothing Edited  ",
                    backgroundColor: Color(0xFF48c0d8,),
                    textColor: Colors.white,
                    gravity: ToastGravity.TOP,
                    toastLength: Toast.LENGTH_SHORT);
                setState(() { _desc.text = "";});
              }
           /* widget.desc!=_desc.text ? _con.editPostTimelineDesc(
                _desc.text,widget.postid
            )  : Fluttertoast.showToast(msg: "  Nothing Edited  ",
                backgroundColor: Color(0xFF48c0d8,),
                textColor: Colors.white,
                gravity: ToastGravity.TOP,
                toastLength: Toast.LENGTH_LONG);
            setState(() { _desc.text = "";});*/
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Color(0xFF48c0d8),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: Text(
                  "Edit / Update",
                  style: f16B,
                )),
          ),
        ),
      ),
    );
  }
}
