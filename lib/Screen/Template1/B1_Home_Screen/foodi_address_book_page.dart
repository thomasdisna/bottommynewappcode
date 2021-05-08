import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_edit_location_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_location_add_page.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class  FoodiAddressBookPage extends StatefulWidget {
  @override
  _FoodiAddressBookPageState createState() => _FoodiAddressBookPageState();
}

class _FoodiAddressBookPageState extends StateMVC<FoodiAddressBookPage> {

  TimelineWallController _con;

  _FoodiAddressBookPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  String apiKey = 'AIzaSyAm22_7Hj0aHN09DvP-VmaXSk64dm1WSfg';

  @override
  void initState() {
    _con.getAddressList(context,"1");
    // TODO: implement initState
    super.initState();
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
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[800],
              child: Padding(
                padding: const EdgeInsets.only(left:12.0),
                child: Text("SAVED ADDRESSES",style: f16wB,),
              )),
          SizedBox(height: 15,),
          _con.addressLIST.length>0 && _con.addressStatus==false ?  Expanded(
            child: ListView.builder(
                itemCount: _con.addressLIST.length,
                itemBuilder: (context, index){
                  // _con.addressLIST[index]["location_name"]=="Work" ? work_save=true : work_save=false;
                  // _con.addressLIST[index]["location_name"]=="Home" ? home_save=true : home_save=false;
                  print("sssssssssssssssssssssssss "+home_save.toString());
              return Padding(
                padding: const EdgeInsets.only(left:12,right: 12,bottom: 15),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      timeLineLocation.text = _con.addressLIST[index]["location"].toString().length>32 ?
                      _con.addressLIST[index]["location"].toString().substring(0,32)+"..." : _con.addressLIST[index]["location"].toString();
                    });
                    Navigator.pop(context);
                  },
                  child: Container(child: Column(
                    children: [
                      Row(
                        children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width:30,
                                child: _con.addressLIST[index]["location_name"]=="Home" ?
                                Image.asset("assets/Template1/image/Foodie/icons/home.png",height: 16,width: 16,color: Colors.grey,) :
                                _con.addressLIST[index]["location_name"]=="Work" ?  Icon(Icons.work,color: Colors.grey,size: 18,) :
                                Icon(Icons.location_on,color: Colors.grey,size: 18,),
                              ),
                              SizedBox(width: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width-70,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_con.addressLIST[index]["location_name"],style: f15wB,),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap:(){
                                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                                    builder: (context) => EditLocationPage(
                                                      loc_id: _con.addressLIST[index]["savedaddress_id"].toString(),
                                                      house: _con.addressLIST[index]["house_number"].toString(),
                                                    landmark: _con.addressLIST[index]["landmark"].toString(),
                                                    loc_name: _con.addressLIST[index]["location_main"].toString(),
                                                    long: _con.addressLIST[index]["location_long"].toString(),
                                                    lat: _con.addressLIST[index]["location_lat"].toString(),
                                                    location: _con.addressLIST[index]["location"].toString(),
                                                    saved_name: _con.addressLIST[index]["location_name"].toString(),)
                                                  ));
                                                },
                                                child: Image.asset(
                                                  "assets/Template1/image/Foodie/icons/pencil.png",
                                                  height: 17,
                                                  width: 17,
                                                  color: Color(0xFF48c0d8),
                                                )),
                                            SizedBox(width: 25,),
                                            GestureDetector(
                                                onTap: (){
                                                  showDialog(
                                                      context: context,
                                                      builder: (
                                                          BuildContext context) {
                                                        return AlertDialog(
                                                          backgroundColor: Color(
                                                              0xFF1E2026),
                                                          title: new Text(
                                                            "Delete Address?",
                                                            style: f16wB,
                                                          ),
                                                          content: new Text(
                                                            "Do you want to delete "+_con.addressLIST[index]["location_name"].toString()+" address",
                                                            style: f14w,
                                                          ),
                                                          actions: <
                                                              Widget>[
                                                            MaterialButton(
                                                              height: 28,
                                                              color: Color(
                                                                  0xFFffd55e),
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
                                                              color: Color(
                                                                  0xFF48c0d8),
                                                              child: new Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              onPressed: () {
                                                                _con.deleteAddress(context,_con.addressLIST[index]["savedaddress_id"].toString());
                                                                Navigator
                                                                    .pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Icon(Icons.delete_outline,color: Color(0xFF48c0d8),
                                                size: 23,))
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text(_con.addressLIST[index]["location"],style: f14g,),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child: Divider(color: Colors.grey[700],),
                      )
                    ],
                  )),
                ),
              );
            }),
          ) :
          _con.addressStatus == true ? Padding(
            padding: const EdgeInsets.only(top:250.0),
            child: Center(child: CircularProgressIndicator()),
          ) : Center(child: Padding(
            padding: const EdgeInsets.only(top:250.0),
            child: Text("No Saved Addresses",style: f16wB,),
          )),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () async {
            LocationResult result = await showLocationPicker(
              context, apiKey,
              // initialCenter: LatLng(10.023286, 76.311371),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
              myLocationButtonEnabled: true,
              // requiredGPS: true,
              layersButtonEnabled: true,
              // countries: ['AE', 'NG']
//                      resultCardAlignment: Alignment.bottomCenter,
              // desiredAccuracy: LocationAccuracy.best,
            );
            setState(() {
              // print("%%%%%%%%%%%%%%%%%%%%%%%%%%%5 "+result.address_name);
              location = result.address;
              location_lat = result.latLng.latitude;
              location_long = result.latLng.longitude;
            });
            print("location ##################### "+location);
            print("location lattttt ##################### "+location_lat.toString());
            print("location longggg ##################### "+location_long.toString());
            // Navigator.pushReplacement(context, MaterialPageRoute(
            //     builder: (context) => LocationAddPage(location: location,lat: location_lat.toString(),
            //       long: location_long.toString(),loc_name: result.address_name,address: _con.addressLIST,)
            // )
            // );
          },
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF0dc89e)),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/Template1/image/Foodie/icons/add-item-plus.png",
                  height: 16,width: 16,color: Colors.white,),
                SizedBox(width: 10,),
                Text("Add New Address",style: f16wB,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
