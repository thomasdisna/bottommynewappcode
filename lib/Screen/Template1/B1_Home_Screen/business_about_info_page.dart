import 'package:Butomy/Components/global_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Repository/Home_kitchen_Repository/homekitchen_repository.dart' as Repo;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'homekitchen_account_editPage.dart';
import 'package:intl/intl.dart';
class BusinessAboutInfo extends StatefulWidget {

  String typ,pagid,timid;
  BusinessAboutInfo({this.typ,this.pagid,this.timid});



  @override
  _BusinessAboutInfoState createState() => _BusinessAboutInfoState();
}
List<String> specialized_Cat=[];
List<String> signature_Dish=[];
class _BusinessAboutInfoState extends StateMVC<BusinessAboutInfo> {

  HomeKitchenRegistration _con;
  _BusinessAboutInfoState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  @override
  void initState() {
    widget.typ=="1" ?_con.HomekitchenGetProfile(widget.pagid) : widget.typ=="2" ? _con.LocalStoreGetProfile(widget.pagid) : _con.RestaurantGetProfile(widget.pagid);
    // TODO: implement initState
    super.initState();
  }

  var spclLength;
  var signLength;

  @override
  Widget build(BuildContext context) {
    widget.typ=="1" ?_con.HomekitchenGetProfile(widget.pagid) : widget.typ=="2" ? _con.LocalStoreGetProfile(widget.pagid) : _con.RestaurantGetProfile(widget.pagid);
    _con.homeKitchenProfileData!=null ? setState((){
      specialized_Cat =
      _con.homeKitchenProfileData["data"][0]["specialised_categories"]!= null &&
          _con.homeKitchenProfileData["data"][0]["specialised_categories"]!= "" ?
      _con.homeKitchenProfileData["data"][0]["specialised_categories"].split(",") : [];
      spclLength= ( (specialized_Cat.length)/3);
print("################### "+spclLength.toString());
      signature_Dish =
      _con.homeKitchenProfileData["data"][0]["signature_dishes"]!= null &&
          _con.homeKitchenProfileData["data"][0]["signature_dishes"]!= "" ?
      _con.homeKitchenProfileData["data"][0]["signature_dishes"].split(",") : [];
      signLength= ( (signature_Dish.length)/3);
    }) : null;
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
      body: _con.homeKitchenProfileData!=null ?  SingleChildScrollView(
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
                                    content:    CachedNetworkImage(

                                      imageUrl: _con.homeKitchenProfileData["data"][0]["profile_image"]!=null ?
                                      "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.homeKitchenProfileData["data"][0]["profile_image"]+
                                      "?alt=media": "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media" ,
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
                              _con.homeKitchenProfileData["data"][0]["profile_image"]!=null ?
                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con.homeKitchenProfileData["data"][0]["profile_image"]+
                                  "?alt=media": "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              _con.homeKitchenProfileData["data"][0]["name"],
                              style: f14w
                          ),SizedBox(height: 4,),
                          Text("From " +_con.homeKitchenProfileData["data"][0]["district"]+", "+_con.homeKitchenProfileData["data"][0]["state"].toString().split(" ")[0],style: f13w,),
                          Text("Member since "+DateFormat.yMMMd().format(DateTime.
                          parse(_con.homeKitchenProfileData["data"][0]["created_at"]["date"])),style: f13w)
                        ],
                      )
                    ],
                  ),
                 userid.toString() ==_con.homeKitchenProfileData["data"][0]["account_id"].toString() ?  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HKAccountEditPage(typ: widget.typ,pagid: widget.pagid,
                                timid: widget.timid,
                              specialised: _con.homeKitchenProfileData["data"][0]["specialised_categories"] != null ? _con.homeKitchenProfileData["data"][0]["specialised_categories"].split(",") : [],
                                signature: _con.homeKitchenProfileData["data"][0]["signature_dishes"] !=null ? _con.homeKitchenProfileData["data"][0]["signature_dishes"].split(",") : [],
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset("assets/Template1/image/Foodie/icons/pencil.png",height: 25,width: 25,color: Colors.white,)
                        ],
                      ),
                    ),
                  ) : Container(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1,
                color: Colors.black87,
              ),
              _con.homeKitchenProfileData["data"][0]["known_as"]!=null ?  SizedBox(
                height: 30,
              ) : Container(),
              _con.homeKitchenProfileData["data"][0]["known_as"]!=null ? Center(child: Text(_con.homeKitchenProfileData["data"][0]["known_as"],style: f15wB,)) :
                  Container(),
              _con.homeKitchenProfileData["data"][0]["known_as"]!=null ?  SizedBox(
                height: 30,
              ) : Container(),
              _con.homeKitchenProfileData["data"][0]["known_as"]!=null ?    Divider(
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
                      Text(
                          "Business Email",
                          style: f14wB
                      ),SizedBox(height: 10,),
                      /* Text(
                        "Mobile",
                        style: f14wB
                      ),SizedBox(height: 10,),*/
                      Text(
                          "Address",
                          style: f14wB
                      ),SizedBox(height: 10,),
                      Text(
                          "Website",
                          style: f14wB
                      ),SizedBox(height: 10,),
                      Text(
                          "Location",
                          style: f14wB
                      ),
                      specialized_Cat.length==0 ? SizedBox(height: 10,) : Container(),
                      specialized_Cat.length==0 ? Text(
                          "My Specialised Categories",
                          overflow: TextOverflow.ellipsis,maxLines: 1, style: f14w
                      ) : Container(),
                      signature_Dish.length==0 ? SizedBox(height: 10,) : Container(),
                      signature_Dish.length==0 ? Text(
                          "Signature Dishes",
                          overflow: TextOverflow.ellipsis,maxLines: 1, style: f14w
                      ) : Container(),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[


                      Text(
                          _con.homeKitchenProfileData["data"][0]["email"],
                          style: f14w,overflow: TextOverflow.ellipsis,maxLines: 1,
                      ),SizedBox(height: 10,),
                      Text(
                          _con.homeKitchenProfileData["data"][0]["address"],overflow: TextOverflow.ellipsis,maxLines: 1,
                          style: f14w
                      ),SizedBox(height: 10,),
                      // Text(
                      //   widget.Mobile,
                      //   style:f14w
                      // ),SizedBox(height: 10,),
                      Text(
                          _con.homeKitchenProfileData["data"][0]["website"]!=null?
                          _con.homeKitchenProfileData["data"][0]["website"].toString() : "No Data",
                          style: f14w,overflow: TextOverflow.ellipsis,maxLines: 1,
                      ),SizedBox(height: 10,),
                      Text(_con.homeKitchenProfileData["data"][0]["current_location"]!=null ?
                          _con.homeKitchenProfileData["data"][0]["current_location"].toString() : "No Data",overflow: TextOverflow.ellipsis,maxLines: 1,
                          style: f14w
                      ),
                      _con.homeKitchenProfileData["data"][0]["specialised_categories"] ==null ? SizedBox(height: 10,) : Container(),
                      _con.homeKitchenProfileData["data"][0]["specialised_categories"] ==null ? Text(
                          "No Data",
                          overflow: TextOverflow.ellipsis,maxLines: 1, style: f14w
                      ) : Container(),
                      _con.homeKitchenProfileData["data"][0]["signature_dishes"] ==null ? SizedBox(height: 10,) : Container(),
                      _con.homeKitchenProfileData["data"][0]["signature_dishes"] ==null ? Text(
                          "No Data",
                          overflow: TextOverflow.ellipsis,maxLines: 1, style: f14w
                      ) : Container(),
                    ],
                  ),

                ],
              ),
              _con.homeKitchenProfileData["data"][0]["specialised_categories"] !=null ?  SizedBox(height: 30,) : Container(),
              _con.homeKitchenProfileData["data"][0]["specialised_categories"] !=null ? Center(child: Text("My Specialised Categories",style: f16wB,)) : Container(),

              _con.homeKitchenProfileData["data"][0]["specialised_categories"] !=null ?  Divider(
                thickness: .2,
                color: Colors.grey[400],
              ) : Container(),
              _con.homeKitchenProfileData["data"][0]["specialised_categories"] !=null ?  SizedBox(height: 5,): Container(),
              _con.homeKitchenProfileData["data"][0]["specialised_categories"] !=null ?  Container(height: spclLength.toInt()!=0&&  spclLength.toString().contains(".")? int.parse(spclLength.toString().split(".")[1].toString()) > 5 && spclLength.toInt()!=0? spclLength.toDouble()  * 70  : spclLength.toDouble()*60: spclLength.toString().split(".")[1].toString().startsWith("0") ? 0 : 1.toDouble()*60 ,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3.3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6),
                    itemCount: specialized_Cat.length,
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
                              child: Text(specialized_Cat[ind], style: f13bb,overflow: TextOverflow.ellipsis,maxLines: 1,),
                            ),
                          ));
                    }),
              ) : Container(),

              _con.homeKitchenProfileData["data"][0]["signature_dishes"] !=null ?  Center(child: Text("Signature Dishes",style: f16wB,)) : Container(),

              _con.homeKitchenProfileData["data"][0]["signature_dishes"] !=null ?   Divider(
                thickness: .2,
                color: Colors.grey[400],
              ) : Container(),
              _con.homeKitchenProfileData["data"][0]["signature_dishes"] !=null ?  SizedBox(height: 5,) : Container(),
              _con.homeKitchenProfileData["data"][0]["signature_dishes"] !=null ?  Container(height: signLength.toInt()!=0&&  signLength.toString().contains(".")? int.parse(signLength.toString().split(".")[1].toString()) > 5 && signLength.toInt()!=0? signLength.toDouble()  * 70  : signLength.toDouble()*60: signLength.toString().split(".")[1].toString().startsWith("0") ? 0 : 1.toDouble()*60 ,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3.3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6),
                    itemCount: signature_Dish.length,
                    itemBuilder: (context,ind){
                      print("srdxctfviygbouhnjmkl "+signature_Dish.length.toString());
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
                              child: Text(signature_Dish[ind], style: f13bb,overflow: TextOverflow.ellipsis,maxLines: 1,),
                            ),
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