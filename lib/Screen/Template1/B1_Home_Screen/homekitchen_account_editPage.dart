import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart' as repo;
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Components/global_data.dart';
var _image;
String apiKey='AIzaSyAm22_7Hj0aHN09DvP-VmaXSk64dm1WSfg';
enum AppState {
  free,
  picked,
  cropped,
}


class HKAccountEditPage extends StatefulWidget {
  String typ,pagid,timid;
  List<String> signature,specialised;
  HKAccountEditPage({this.typ,this.pagid,this.timid,this.signature,this.specialised});
  @override
  _HKAccountEditPageState createState() => _HKAccountEditPageState();
}

class _HKAccountEditPageState extends StateMVC<HKAccountEditPage> {
  HomeKitchenRegistration _con;
  _HKAccountEditPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }
  TextEditingController _name = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _busname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _website = TextEditingController();
  TextEditingController _address = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController location_lat = TextEditingController();
  final TextEditingController location_long = TextEditingController();
  final TextEditingController _specialised = TextEditingController();
  final TextEditingController _signature = TextEditingController();

  AppState state;
  File imageFile;
  String sex;
  int selectedRadio;

  List<String> specialised = [];
  List<String> signature = [];

  getHomeKitpageTime() async {
    return Timer(Duration(seconds: 4), _Navigator);}
  _Navigator(){
    setState(() {
      _name.text =
          _con.homeKitchenProfileData["data"][0]["username"].toString();
      _address.text =
          _con.homeKitchenProfileData["data"][0]["address"].toString();
      _busname.text =
          _con.homeKitchenProfileData["data"][0]["name"].toString();
          _about.text= _con.homeKitchenProfileData["data"][0]["known_as"] != null ?
          _con.homeKitchenProfileData["data"][0]["known_as"].toString() : "";
      _email.text =
          _con.homeKitchenProfileData["data"][0]["email"].toString();
      _location.text =_con.homeKitchenProfileData["data"][0]["current_location"]!=null ?
          _con.homeKitchenProfileData["data"][0]["current_location"]
              .toString() : "";
      _website.text = _con.homeKitchenProfileData["data"][0]["website"]!=null ?
          _con.homeKitchenProfileData["data"][0]["website"].toString() : "";

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      specialised = widget.specialised;
      signature = widget.signature;
    });
    widget.typ=="1" ? _con.HomekitchenGetProfile(widget.pagid) : widget.typ=="2" ? _con.LocalStoreGetProfile(widget.pagid) : _con.RestaurantGetProfile(widget.pagid);
    state = AppState.free;
    getHomeKitpageTime();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker().getImage(
        source: ImageSource.camera,imageQuality: 20);
    this.setState(() {
      imageFile = File(file.path);
      state = AppState.picked;
    });
    _cropImage();

  }
  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 20);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
      _cropImage();
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        compressQuality: 40,
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color(0xFF1E2026),activeControlsWidgetColor: Color(0xFF48c0d8),
            toolbarWidgetColor: Color(0xFF48c0d8),cropGridColor: Color(0xFFffd55e),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        imageFile = croppedFile;
        state = AppState.cropped;
      });

    }

  }

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;
  _startUpload() {
    var nows = DateTime.now();
    String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
    setState(() {
      _image=filePath;

      _uploadTask = _storage.ref().child(filePath).putFile(imageFile);
    });
    getpagetimId();
  }

  getpagetimId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var timId= prefs.getString('HK_tim_id');
    _con.BusaddProfileImage(_image.toString(), timId.toString());
    imageFile=null;
    // _uploadTask=null;
    return Container();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          brightness: Brightness.dark,
          elevation: 5,centerTitle: true,
          title: Text("Edit profile",style: TextStyle(color: Colors.white),)
      ),
      backgroundColor: Color(0xFF1E2026),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: (){
            imageFile!=null ? _startUpload() : null;
             _con.BusinessKitchenProfileEdit(context,_email.text.toString(),_address.text.toString(),
                _website.text.toString(),_location.text.toString(),location_lat.text.toString(),
                 location_long.text.toString(),widget.pagid,specialised.join(",").toString(),signature.join(",").toLowerCase(),_about.text);
           },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF48c0d8)
            ),
            child: Center(child: Text("Update",style: f15wB,)),
          ),
        ),
      ),
      body:_con.homeKitchenProfileData!=null ?  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:20,right: 20),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap:(){
                  //newwww
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(backgroundColor: Color(0xFF1E2026),
                          title: Text('Camera / Gallery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
                          children: <Widget>[
                            SizedBox(height: 10,),
                            SimpleDialogOption(
                              onPressed: () {_pickImage();
                              Navigator.pop(context);
                              },
                              child: const Text('Choose From Gallery',style: TextStyle(color: Colors.white,),),
                            ),
                            SizedBox(height: 5,),
                            SimpleDialogOption(
                              onPressed: () {getImageFromCamera(context);
                              Navigator.pop(context);
                              },
                              child: const Text('Take New Photo',style: TextStyle(color: Colors.white,)),
                            ),
                          ],
                        );
                      });

                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:14.0),
                    child: Stack(alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(radius: 60,
                          backgroundImage: imageFile != null ? FileImage(imageFile,) : CachedNetworkImageProvider(_con.homeKitchenProfileData["data"][0]["profile_image"]!=null ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"
                              +_con.homeKitchenProfileData["data"][0]["profile_image"].toString().replaceAll(" ", "%20")+"?alt=media" : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12,right:8.0),
                          child: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                color: Color(0xFF1E2026)
                            ),
                            child: Center(
                              child: Container(height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(150),
                                    color: Color(0xFF48c0d8)
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/pencil.png",
                                    height: 15,
                                    width: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1,
                color: Colors.black87,
              ),
              SizedBox(
                height: 5,
              ),
              Container(height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey[800],width: 1)
                ),
                child: TextField(
                  controller: _about,
                  style: f14w,expands: true,
                  maxLines: null,
                  minLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write something about you !!!",hintStyle: f14g,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5)
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Name",
                    style: f14wB,
                  ),
                  Container(width: MediaQuery.of(context).size.width-195,
                    child: TextField(controller: _name,
                        style: f14w,
                        readOnly: true,
                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText: _con.homeKitchenProfileData["data"][0]["account_name"].toString(),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14w,

                        )),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "BusinessName",
                      style: f14wB
                  ),
                  Container(width: MediaQuery.of(context).size.width-195,
                    child: TextField(controller: _busname,
                        style: f14w,
                        // controller: controller,
                        readOnly: true,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText:_con.homeKitchenProfileData["data"][0]["name"].toString(),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14w,

                        )),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "Address",
                      style: f14wB
                  ),
                  Container(width: MediaQuery.of(context).size.width-195,
                    child: TextField(controller: _address,
                        style: f14w,
                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText:"address",//_con.homeKitchenProfileData["data"][0]["name"].toString(),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14w,

                        )),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Business Email",
                    style: f14wB,
                  ),
                  Container(width: MediaQuery.of(context).size.width-195,
                    child: TextField(controller: _email,
                        readOnly: true,
                        style: f14w,                        // controller: controller,
                        decoration: InputDecoration(
                          hintText: _con.homeKitchenProfileData["data"][0]["email"].length<20 ?_con.homeKitchenProfileData["data"][0]["email"].toString() : _con.homeKitchenProfileData["data"][0]["email"].toString().substring(0,20)+"...",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14w,

                        )),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Website",
                    style: f14wB,
                  ),
                  Container(width: MediaQuery.of(context).size.width-195,
                    child: TextField(controller: _website,
                        style: f14w,                        // controller: controller,
                        decoration: InputDecoration(
                          hintText: _con.homeKitchenProfileData["data"][0]["website"] != null ?
                          _con.homeKitchenProfileData["data"][0]["website"].toString() : "Add your Website",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14g,

                        )),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "Location",
                      style: f14wB
                  ),
                  Container(width: MediaQuery.of(context).size.width-195,
                    child: TextField(controller: _location,
                        // readOnly: true,
                        onTap: () async {
                          LocationResult result =
                          await showLocationPicker(
                            context, apiKey,
                            initialCenter:
                            LatLng(10.023286, 76.311371),
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
                            _location.text = result.address;
                            location_lat.text = result
                                .latLng.latitude
                                .toString();
                            location_long.text = result
                                .latLng.longitude
                                .toString();
                          });
                        },
                        style: f14w,                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText:  "Add your Location",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14g,

                        )),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Specialised Categories",
                    style: f14wB,
                  ),
                  Row(
                    children: [
                      Container(width: MediaQuery.of(context).size.width-230,
                        child: TextField(controller: _specialised,

                            style: f14w,                            // controller: controller,
                            decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            ),
                              hintText: "Add your Categories",
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Color(0xFF48c0d8))),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF48c0d8)),
                              ),
                              hintStyle: f14g,
                            )),
                      ),
                      GestureDetector(
                          onTap: (){
                            _specialised.text.length>0 ?  specialised.add(_specialised.text) : null;
                            setState(() {
                              _specialised.text="";
                            });
                          },
                          child: Container(height: 25,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(  color: Color(0xFF48c0d8),)
                              ),
                              child: Center(child: Text("Add",style: f14yB,))))
                    ],
                  )
                ],
              ),
              specialised.length>0? Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: specialised.map((s) {
                    return Chip(
                        backgroundColor: Color(0xFFffd55e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        label: Text(s,
                            style:f14B
                        ),
                        onDeleted: () {
                          setState(() {
                            specialised.remove(s);
                          });
                        });
                  }).toList()) : Container(),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Signature Dishes",
                    style: f14wB,
                  ),
                  Row(
                    children: [
                      Container(width: MediaQuery.of(context).size.width-230,
                        child: TextField(controller: _signature,

                            style: f14w,                            // controller: controller,
                            decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            ),
                              hintText: "Add your dishes",
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Color(0xFF48c0d8))),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF48c0d8)),
                              ),
                              hintStyle: f14g,
                            )),
                      ),
                      GestureDetector(
                          onTap: (){
                            _signature.text.length>0 ?  signature.add(_signature.text) : null;
                            setState(() {
                              _signature.text="";
                            });
                          },
                          child: Container(height: 25,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(  color: Color(0xFF48c0d8),)
                              ),
                              child: Center(child: Text("Add",style: f14yB,))))
                    ],
                  )
                ],
              ),
              signature.length>0? Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: signature.map((s) {
                    return Chip(
                        backgroundColor: Color(0xFFffd55e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        label: Text(s,
                            style:f14B
                        ),
                        onDeleted: () {
                          setState(() {
                            signature.remove(s);
                          });
                        });
                  }).toList()) : Container(),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}