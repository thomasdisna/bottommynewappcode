import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

List<String> split=[];
class OtherAboutInfo extends StatefulWidget {

  OtherAboutInfo({Key key, this.id}) : super(key: key);
  String id;

  @override
  _OtherAboutInfoState createState() => _OtherAboutInfoState();
}

class _OtherAboutInfoState extends StateMVC<OtherAboutInfo> {
  TimelineWallController _con;

  _OtherAboutInfoState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _con.getOtherAbout1(widget.id);
    setState(() {_con.saveOtherUserInfo!= null? split =  _con.saveOtherUserInfo["data"][0]["favourite_dishes"]!= "" && _con.saveOtherUserInfo["data"][0]["favourite_dishes"]!= null ?  _con.saveOtherUserInfo["data"][0]["favourite_dishes"].split(",") : [] : null;});
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          "About Info",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1E2026),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color(0xFF1E2026),
      body:  _con.saveOtherUserInfo != null ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                    backgroundColor: Color(
                                        0xFF1E2026),
                                    content: CachedNetworkImage(
                                      imageUrl: _con.saveOtherUserInfo["data"][0]["picture"]
                                          .toString().replaceAll(" ", "%20")+"?alt=media",
                                      height: 250,
                                      fit: BoxFit
                                          .fitWidth,
                                    ),
                                  ));
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Color(0xFF23252E),
                          backgroundImage: CachedNetworkImageProvider(
                              _con.saveOtherUserInfo["data"][0]["picture"].toString().replaceAll(" ", "%20")+"?alt=media"),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_con.saveOtherUserInfo["data"][0]["name"],style: f16wB,),
                          SizedBox(height: 4,),
                          Text("From "+_con.saveOtherUserInfo["data"][0]["district"]+", "
                              +_con.saveOtherUserInfo["data"][0]["state"].toString().split(" ")[0],style: f13w,),
                          Text("Member since "+DateFormat.yMMMd().format(DateTime.
                          parse(_con.saveOtherUserInfo["data"][0]["created_at"]["date"])),style: f13w)
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                color: Colors.black87,
              ),
              _con.saveOtherUserInfo["data"][0]["bio"]!=null ?  SizedBox(
                height: 20,
              ) : Container(),
              _con.saveOtherUserInfo["data"][0]["bio"]!=null ?
              Center(child: Text( _con.saveOtherUserInfo["data"][0]["bio"],style: f15wB,)) :
              Container(),
              _con.saveOtherUserInfo["data"][0]["bio"]!=null ?  SizedBox(
                height: 5,
              ) : Container(),
              _con.saveOtherUserInfo["data"][0]["bio"]!=null ?    Divider(
                thickness: 1,
                color: Colors.black87,
              ) : Container(),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Last Name", style: f14wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Username", style: f14wB),
                      _con.saveOtherUserInfo["data"][0]["email_show"]==1 ?  SizedBox(
                        height: 10,
                      ) : Container(),
                      _con.saveOtherUserInfo["data"][0]["email_show"]==1 ? Text("Email", style: f14wB) : Container(),
                      _con.saveOtherUserInfo["data"][0]["mobile_show"]==1 ?  SizedBox(
                        height: 10,
                      ) : Container(),
                      _con.saveOtherUserInfo["data"][0]["mobile_show"]==1 ? Text("Mobile", style: f14wB) : Container(),
                      _con.saveOtherUserInfo["data"][0]["state_show"]==1 ?  SizedBox(
                        height: 10,
                      ) : Container(),
                      _con.saveOtherUserInfo["data"][0]["state_show"]==1 ? Text("State", style: f14wB) : Container(),
                      _con.saveOtherUserInfo["data"][0]["district_show"]==1 ? SizedBox(
                        height: 10,
                      ) : Container(),
                      _con.saveOtherUserInfo["data"][0]["district_show"]==1 ?  Text("District", style: f14wB) : Container(),
                      _con.saveOtherUserInfo["data"][0]["location_show"]==1 ? SizedBox(
                        height: 10,
                      ) : Container(),
                      _con.saveOtherUserInfo["data"][0]["location_show"]==1 ? Text("Location", style: f14wB) : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Gender", style: f14wB),
                      _con.saveOtherUserInfo["data"][0]["dob_show"]==1 ?  SizedBox(
                        height: 10,
                      ) : Container(),
                      _con.saveOtherUserInfo["data"][0]["dob_show"]==1 ? Text("Date Of Birth", style: f14wB) : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Food Preferences", style: f14wB),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(width: MediaQuery.of(context).size.width-191,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(_con.saveOtherUserInfo["data"][0]["lastname"]!= null ?
                        _con.saveOtherUserInfo["data"][0]["lastname"].toString() : "No Data",maxLines: 1,overflow: TextOverflow.ellipsis,
                            style: f14w),
                        SizedBox(
                          height: 10,
                        ),
                        Text(_con.saveOtherUserInfo["data"][0]["username"].toString(),maxLines: 1,overflow: TextOverflow.ellipsis,
                            style: f14w),
                        _con.saveOtherUserInfo["data"][0]["email_show"]==1 ? SizedBox(
                          height: 10,
                        ) : Container(),
                        _con.saveOtherUserInfo["data"][0]["email_show"]==1 ? Text(_con.saveOtherUserInfo["data"][0]["email"].toString(),
                            maxLines: 1,overflow: TextOverflow.ellipsis,
                            style: f14w) : Container(),
                        _con.saveOtherUserInfo["data"][0]["mobile_show"]==1 ? SizedBox(
                          height: 10,
                        ) : Container(),
                        _con.saveOtherUserInfo["data"][0]["mobile_show"]==1 ? Text(_con.saveOtherUserInfo["data"][0]["mobile"].toString(),maxLines: 1,overflow: TextOverflow.ellipsis,
                            style: f14w) : Container(),
                        _con.saveOtherUserInfo["data"][0]["state_show"]==1 ? SizedBox(
                          height: 10,
                        ) : Container(),
                        _con.saveOtherUserInfo["data"][0]["state_show"]==1 ?   Text(_con.saveOtherUserInfo["data"][0]["state"]!= null ?
                        _con.saveOtherUserInfo["data"][0]["state"].toString() :
                        "No Data",
                            style: f14w,maxLines: 1,overflow: TextOverflow.ellipsis,) : Container(),
                        _con.saveOtherUserInfo["data"][0]["district_show"]==1 ? SizedBox(
                          height: 10,
                        ) : Container(),
                        _con.saveOtherUserInfo["data"][0]["district_show"]==1 ? Text(_con.saveOtherUserInfo["data"][0]["district"]!=null ?
                        _con.saveOtherUserInfo["data"][0]["district"].toString() : "No Data",maxLines: 1,overflow: TextOverflow.ellipsis,
                            style: f14w) : Container(),
                        _con.saveOtherUserInfo["data"][0]["location_show"]==1 ? SizedBox(
                          height: 10,
                        ) : Container(),
                        _con.saveOtherUserInfo["data"][0]["location_show"]==1 ? Container(
                           child: _con.saveOtherUserInfo["data"][0]["current_location"]!=null &&_con.saveOtherUserInfo["data"][0]["current_location"]!="" ?  Text(_con.saveOtherUserInfo["data"][0]["current_location"].toString(),
                              style: f14w,maxLines: 1,overflow: TextOverflow.ellipsis,)  :Text("No Data",style: f14w,),
                         ) : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(_con.saveOtherUserInfo["data"][0]["gender"].toString(),
                            style: f14w),
                        _con.saveOtherUserInfo["data"][0]["dob_show"]==1 ? SizedBox(
                          height: 10,
                        ) : Container(),
                        _con.saveOtherUserInfo["data"][0]["dob_show"]==1 ?  Text(_con.saveOtherUserInfo["data"][0]["dob"].toString(),
                            style: f14w) : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        _con.saveOtherUserInfo["data"][0]["food_preference"]!=null && _con.saveOtherUserInfo["data"][0]["food_preference"]!=""? Text(
                          _con.saveOtherUserInfo["data"][0]["food_preference"].toString(),
                          style: f14w,maxLines: 1,overflow: TextOverflow.ellipsis,
                        ) : Text("No Data",style: f14w,),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Favourite Dishes", style: f14wB),
                  SizedBox(width: 35,),
                  split.length==0 ? Text("No Fav Dishes",style: f14w,) : Container(height: 0,)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              split.length>0 ?  Container(height: split.length<=3 ? 80 : split.length>3 && split.length<=6 ? 160 : 0,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3.3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6),
                    itemCount: split.length,
                    itemBuilder: (context,ind){

                      return Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 3.7,
                          decoration: BoxDecoration(
                            color: Color(0xFFffd55e),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Center(
                            child:split[ind].length>14 ?Text(split[ind].substring(0, 14)+ "...", style: f13bb)
                                : Text(split[ind], style: f13bb),
                          ));
                    }),
              ) : Container(),
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}

//Color(0xFF23252E),
