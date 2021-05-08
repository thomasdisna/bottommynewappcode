import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/date_time.dart';
import 'package:intl/intl.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
    as repo;
import 'package:Butomy/Screen/Template1/B1_Home_Screen/account_edit_profile.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Components/global_data.dart';

class AboutInfo extends StatefulWidget {
  @override
  _AboutInfoState createState() => _AboutInfoState();
}
List<String> split=[];
class _AboutInfoState extends StateMVC<AboutInfo> {
  TimelineWallController _con;

  _AboutInfoState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _con.getAbout(userid.toString());
   setState(() { split = repo.AbtInfo["data"][0]["favourite_dishes"]!= null && repo.AbtInfo["data"][0]["favourite_dishes"]!= "" ? repo.AbtInfo["data"][0]["favourite_dishes"].split(",") : [];});
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            SizedBox(height: 20,),
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
                                      imageUrl: userPIC,
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
                              userPIC),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(repo.AbtInfo["data"][0]["name"].toString(),
                              style: f16wB),
                          SizedBox(height: 4.0),
                          Text("From "+repo.AbtInfo["data"][0]["district"]+", "
                              +repo.AbtInfo["data"][0]["state"].toString().split(" ")[0],style: f13w,),
                          Text("Member since "+DateFormat.yMMMd().format(DateTime.
                          parse(repo.AbtInfo["data"][0]["created_at"]["date"])),style: f13w)
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountEditPage()));
                      },
                      child: Image.asset(
                        "assets/Template1/image/Foodie/icons/pencil.png",
                        height: 25,
                        width: 25,
                        color: Colors.white,
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1,
                color: Colors.black87,
              ),
              repo.AbtInfo["data"][0]["bio"]!=null ?  SizedBox(
                height: 20,
              ) : Container(),
              repo.AbtInfo["data"][0]["bio"]!=null ?
              Center(child: Text( repo.AbtInfo["data"][0]["bio"],style: f15wB,)) :
              Container(),
              repo.AbtInfo["data"][0]["bio"]!=null ?  SizedBox(
                height: 5,
              ) : Container(),
              repo.AbtInfo["data"][0]["bio"]!=null ?    Divider(
                thickness: 1,
                color: Colors.black87,
              ) : Container(),
             /* SizedBox(height: 30,),
              Center(child: Text(repo.AbtInfo["data"][0]["known_as"],style: f16wB,)),
              SizedBox(
                height: 30,
              ),
              Divider(
                thickness: 1,
                color: Colors.black87,
              ),*/
              SizedBox(height: 15,),
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
                      SizedBox(
                        height: 10,
                      ),
                      Text("Email", style: f14wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Mobile", style: f14wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text("State", style: f14wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text("District", style: f14wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Location", style: f14wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Gender", style: f14wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Date Of Birth", style: f14wB),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Food Preferences", style: f14wB),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text(repo.AbtInfo["data"][0]["lastname"]!= null ?
                      repo.AbtInfo["data"][0]["lastname"].toString() : "No Data",
                          style: f14w),
                      SizedBox(
                        height: 10,
                      ),
                      Text(repo.AbtInfo["data"][0]["username"].toString(),
                          style: f14w),
                      SizedBox(
                        height: 10,
                      ),
                      repo.AbtInfo["data"][0]["email"].length < 23
                          ? Text(repo.AbtInfo["data"][0]["email"].toString(),
                              style: f14w)
                          : Text(
                              repo.AbtInfo["data"][0]["email"]
                                      .toString()
                                      .substring(0, 22) +
                                  "...",
                              style: f14w),
                      SizedBox(
                        height: 10,
                      ),
                      Text(repo.AbtInfo["data"][0]["mobile"].toString(),
                          style: f14w),
                      SizedBox(
                        height: 10,
                      ),
                      Text(repo.AbtInfo["data"][0]["state"]!= null ?
                      repo.AbtInfo["data"][0]["state"].toString() :
                          "No Data",
                          style: f14w),
                      SizedBox(
                        height: 10,
                      ),
                      Text(repo.AbtInfo["data"][0]["district"]!=null ?
                      repo.AbtInfo["data"][0]["district"].toString() : "No Data",
                          style: f14w),
                      SizedBox(
                        height: 10,
                      ),
                      repo.AbtInfo["data"][0]["current_location"]!=null &&repo.AbtInfo["data"][0]["current_location"]!="" && repo.AbtInfo["data"][0]["current_location"].toString().length<22?  Text(repo.AbtInfo["data"][0]["current_location"].toString(),
                          style: f14w) :  repo.AbtInfo["data"][0]["current_location"]!=null &&repo.AbtInfo["data"][0]["current_location"]!="" && repo.AbtInfo["data"][0]["current_location"].toString().length>22?  Text(repo.AbtInfo["data"][0]["current_location"].toString().substring(0,22)+" ...",
                          style: f14w) :Text("No Data",style: f14w,),
                      SizedBox(
                        height: 10,
                      ),
                      Text(repo.AbtInfo["data"][0]["gender"].toString(),
                          style: f14w),
                      SizedBox(
                        height: 10,
                      ),
                      Text(repo.AbtInfo["data"][0]["dob"].toString(),
                          style: f14w),
                      SizedBox(
                        height: 10,
                      ),
                      repo.AbtInfo["data"][0]["food_preference"]!=null && repo.AbtInfo["data"][0]["food_preference"]!=""? Text(
                        repo.AbtInfo["data"][0]["food_preference"].toString(),
                        style: f14w,
                      ) : Text("No Data",style: f14w,),
                    ],
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
                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                         ),
                         child: Center(
                           child: Padding(
                             padding: const EdgeInsets.only(left:10,right: 10),
                             child: Text(split[ind], style: f13bb,overflow: TextOverflow.ellipsis,maxLines: 1,),
                           ),
                         ));
                   }),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

//Color(0xFF23252E),
