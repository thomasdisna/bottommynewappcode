import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart' as repo;

class LocationAddPageFromCart extends StatefulWidget {

  LocationAddPageFromCart({this.long,this.lat,this.location,this.loc_name,
    this.addressList,this.date,this.time,this.address,this.city,this.itemList,this.pincode,this.street});

  String location,lat,long,loc_name;
  List addressList;
  String street,address,city,pincode;
  List itemList;
  String date;
  String time;

  @override
  _LocationAddPageFromCartState createState() => _LocationAddPageFromCartState();
}

class _LocationAddPageFromCartState extends StateMVC<LocationAddPageFromCart> {

  TimelineWallController _con;

  _LocationAddPageFromCartState() : super(TimelineWallController()) {
    _con = controller;
  }

  int crtind;
  bool other;
  String save_name;
  TextEditingController _house_name = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _save_loc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _save_loc.text="";
      _house_name.text="";
      _landmark.text="";
      other=false;
    });
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
        title: Text("Add Location",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on,color: Colors.white,size: 25,),
                      SizedBox(width: 3),
                      Text(widget.loc_name.length>26 ? widget.loc_name.substring(0,26)+"..." : widget.loc_name,style: f16wB,),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      // Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFF48c0d8)
                      ),
                      child: Center(child: Text("Change",style: f15B,)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(widget.location.toString().replaceFirst(widget.location.substring(0,1), widget.location.substring(0,1).toUpperCase()),style: f14w,),
              ),
              SizedBox(height: 35,),
              Text("HOUSE / FLAT / BLOCK NO.",style: TextStyle(color: Colors.grey[300],fontSize: 14),),
              SizedBox(height: 3,),
              Container(height: 45,
                child: TextField(
                  controller: _house_name,
                  style: f14w,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 0,left: 10),
                      fillColor: Color(0xFF23252E),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48C0d8))
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("LANDMARK",style: TextStyle(color: Colors.grey[300],fontSize: 14),),
              SizedBox(height: 3,),
              Container(height: 45,
                child: TextField(
                  controller: _landmark,
                  style: f14w,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 0,left: 10),
                      fillColor: Color(0xFF23252E),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48C0d8))
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("SAVE AS",style: TextStyle(color: Colors.grey[300],fontSize: 14),),
              SizedBox(height: 8,),
              other==false ?   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      home_save==false ?  setState(() {
                        crtind=1;
                        save_name="Home";
                      }) : Fluttertoast.showToast(
                        msg: "You already have a Home Address",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 35,
                        backgroundColor: Color(0xFF48c0d8),
                        textColor: Colors.black,
                        fontSize: 16.0,
                      );
                    },
                    child: Opacity(
                      opacity: home_save==true ? .3 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: crtind==1 ? Color(0xFFffd55e) : Colors.grey))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset("assets/Template1/image/Foodie/icons/home.png",height: 16,width: 16,color: Colors.grey,),
                              SizedBox(width: 4,),
                              Text("Home",style: f14g,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      work_save==false ?   setState(() {
                        crtind=2;
                        save_name="Work";
                      }) : Fluttertoast.showToast(
                        msg: "You already have a Work Address",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 35,
                        backgroundColor: Color(0xFF48c0d8),
                        textColor: Colors.black,
                        fontSize: 16.0,
                      );
                    },
                    child: Opacity(
                      opacity: work_save==true ? .3 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: crtind==2 ? Color(0xFFffd55e) : Colors.grey))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.work,color: Colors.grey,size: 18,),
                              SizedBox(width: 4,),
                              Text("Work",style: f14g,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        crtind=3;
                        other=true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color:crtind==3 ? Color(0xFFffd55e) : Colors.grey))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.add_location,color: Colors.grey,size: 18,),
                            SizedBox(width: 4,),
                            Text("Other",style: f14g,)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ) :
              Container(height: 45,
                child: TextField(
                    controller: _save_loc,
                    onChanged: (val){
                      setState(() {
                        save_name=val;
                      });
                    },
                    style: f14w,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(top: 12,),
                      prefixIcon: Icon(Icons.location_on,size: 16,color: Colors.grey,),
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color(0xFFffd55e),
                              width: 1.5
                          )
                      ),
                      focusedBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color(0xFFffd55e),width: 1.5
                          )
                      ),
                      hintText: "e.g: Dad's Place, John's Home",
                      hintStyle: f14g,
                      suffix: GestureDetector(
                          onTap: (){
                            setState(() {
                              other=false;
                            });
                          },
                          child: Text("Cancel",style: f14bB,)),

                    )
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: (){
                    if( save_name.length>0 && _landmark.text.length>0 && _house_name.text.length>0 && _save_loc.text!="Home" && _save_loc.text!="home" && _save_loc.text!="Work" && _save_loc.text!="work")
                    {
                      _con.addLocationAddress2(context,save_name, widget.location, widget.lat, widget.long,
                          _landmark.text, _house_name.text,widget.loc_name,name,repo.AbtInfo["data"][0]
                          ["lastname"],repo.AbtInfo["data"][0]
                          ["email"],repo.AbtInfo["data"][0]
                          ["mobile"].toString(),widget.city,widget.pincode,widget.itemList,widget.date,widget.time);
                    }
                    else{
                      _save_loc.text=="Home" || _save_loc.text=="home" ?  Fluttertoast.showToast(
                        msg: "Tag can't be named 'Home'",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 35,
                        backgroundColor: Color(0xFF48c0d8),
                        textColor: Colors.black,
                        fontSize: 16.0,
                      ) : _save_loc.text=="work" || _save_loc.text=="Work" ? Fluttertoast.showToast(
                        msg: "Tag can't be named 'Work'",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 35,
                        backgroundColor: Color(0xFF48c0d8),
                        textColor: Colors.black,
                        fontSize: 16.0,
                      )  : Fluttertoast.showToast(
                        msg: "Fill the form !!!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 35,
                        backgroundColor: Color(0xFF48c0d8),
                        textColor: Colors.black,
                        fontSize: 16.0,
                      );
                    }

                  },
                  child: Container(
                    height: 40,width: 150,
                    child: Center(
                      child: Text("Submit",style: f16B,),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFF48c0d8),
                        // border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(6)
                    ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
