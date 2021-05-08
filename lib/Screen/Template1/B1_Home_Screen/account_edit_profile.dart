import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart' as repo;
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Components/global_data.dart';
import '../../../Controllers/TimelineController/timelineWallController.dart';
var _image;
String apiKey='AIzaSyAm22_7Hj0aHN09DvP-VmaXSk64dm1WSfg';
enum AppState {
  free,
  picked,
  cropped,
}
List<String> selected = repo.AbtInfo["data"][0]["favourite_dishes"].toString().length>0  && repo.AbtInfo["data"][0]["favourite_dishes"]!="" && repo.AbtInfo["data"][0]["favourite_dishes"]!=null? repo.AbtInfo["data"][0]["favourite_dishes"].split(",") : [];

class AccountEditPage extends StatefulWidget {
  @override
  _AccountEditPageState createState() => _AccountEditPageState();
}

class _AccountEditPageState extends StateMVC<AccountEditPage> {

  TextEditingController _name = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _foodpref = TextEditingController();
  TextEditingController _favdish = TextEditingController();
  TextEditingController _dob = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController location_lat = TextEditingController();
  final TextEditingController location_long = TextEditingController();
  String _date =repo.AbtInfo["data"][0]["dob"].toString();
  AppState state;
  File imageFile;
  String sex;
  int selectedRadio;
  int emailShow;
  int mobileShow;
  int locationShow;
  int stateShow;
  int districtShow;
  int dobShow;

  TimelineWallController _con;

  _AccountEditPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.stateList();
    state = AppState.free;
    setState(() {
      repo.AbtInfo["data"][0]["gender"].toString()=="female" ? selectedRadio = 1 : repo.AbtInfo["data"][0]["gender"].toString()=="male" ? selectedRadio = 0 :selectedRadio = 2;
      repo.AbtInfo["data"][0]["gender"].toString()=="female" ? sex = "1" : repo.AbtInfo["data"][0]["gender"].toString()=="male" ? sex = "0" :sex = "2";
      _email.text=repo.AbtInfo["data"][0]["email"].toString();
      _mobile.text=repo.AbtInfo["data"][0]["mobile"].toString();
      _dob.text=repo.AbtInfo["data"][0]["dob"].toString();
      selected_State=repo.AbtInfo["data"][0]["state"].toString();
      selected_district=repo.AbtInfo["data"][0]["district"].toString();
      emailShow=repo.AbtInfo["data"][0]["email_show"];
      mobileShow=repo.AbtInfo["data"][0]["mobile_show"];
      locationShow=repo.AbtInfo["data"][0]["location_show"];
      stateShow=repo.AbtInfo["data"][0]["state_show"];
      districtShow=repo.AbtInfo["data"][0]["district_show"];
      dobShow=repo.AbtInfo["data"][0]["dob_show"];
      _foodpref.text= repo.AbtInfo["data"][0]["food_preference"].toString()!=null&& repo.AbtInfo["data"][0]["food_preference"].toString()!="null"&& repo.AbtInfo["data"][0]["food_preference"].toString()!=""?repo.AbtInfo["data"][0]["food_preference"].toString():"";
      _bio.text= repo.AbtInfo["data"][0]["bio"]!=null&& repo.AbtInfo["data"][0]["bio"].toString()!="null"&& repo.AbtInfo["data"][0]["bio"].toString()!=""?repo.AbtInfo["data"][0]["bio"].toString():"";
      _name.text=repo.AbtInfo["data"][0]["name"].toString();
      _lastname.text=repo.AbtInfo["data"][0]["lastname"].toString();
      _location.text=repo.AbtInfo["data"][0]["current_location"].toString();
      _username.text=repo.AbtInfo["data"][0]["username"].toString();});
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

  var selected_State;
  var selected_district;
  var selected_State_id;

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
    FirebaseController.instanace.updateprofilepicture(timelineIdFoodi.toString(), _image.toString().replaceAll(".png", "_512x512.png"));
    _imagUpload();
  }

  _imagUpload(){
    _con.adduserProfileImage(_image.toString(), userid.toString());
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
            _con.editProfile(context,userid.toString(), _email.text, _mobile.text, sex == "0"
                ? "male"
                : sex == "1"
                ? "female"
                : sex == "2"
                ? "other"
                : "male", _dob.text, _foodpref.text,_name.text,
                _username.text,selected.join(",").toString(),_location.text,
                location_lat.text,location_long.text,_lastname.text,_bio.text,
                emailShow,mobileShow,locationShow,stateShow,districtShow,dobShow);
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
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:20,right: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(radius: 60,
                          backgroundImage: imageFile != null ? FileImage(imageFile,) : CachedNetworkImageProvider(repo.AbtInfo["data"][0]["picture"].toString().replaceAll(" ", "%20")+"?alt=media"),
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
              SizedBox(height: 10,),
              Text("About Us",style: f14wB,),
              SizedBox(height: 10,),
              Container(height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF23252E),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Color(0xFF48c0d8))
                ),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  controller: _bio,
                  style: f14w,
                  decoration: InputDecoration(
                      hintText: "Write something about you !!!",hintStyle: f14g,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  border: InputBorder.none
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
                  Container(width: MediaQuery.of(context).size.width-165,
                    child: TextField(controller: _name,
                        style: f14w,
                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText: repo.AbtInfo["data"][0]["name"].toString(),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14w,

                        )),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "Last Name",
                      style: f14wB
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child: TextField(controller: _lastname,
                        style: f14w,
                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText: repo.AbtInfo["data"][0]["lastname"].toString(),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14w,

                        )),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "Username",
                      style: f14wB
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child: TextField(controller: _username,readOnly: true,
                        style: f14w,
                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText: repo.AbtInfo["data"][0]["username"].toString(),
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
                    "Email",
                    style: f14wB,
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child: TextField(readOnly: true,controller: _email,
                        style: f14w,                        // controller: controller,
                        decoration: InputDecoration(
                          hintText: repo.AbtInfo["data"][0]["email"].length<20 ? repo.AbtInfo["data"][0]["email"].toString() : repo.AbtInfo["data"][0]["email"].toString().substring(0,20)+"...",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14w,

                          suffix: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(height: 25,width: 53,
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                   if(emailShow==0)
                                      emailShow = 1;
                                   else
                                     emailShow =0;
                                  });
                                },
                                splashColor: Color(0xFFffd55e),
                                padding: EdgeInsets.all(0),
                                color: Color(0xFF48c0d8),
                                height: 25,minWidth: 53,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                               ),
                                child: Center(child: Text(emailShow==0 ?
                                "Unhide" : "Hide",style: f13BB,)),
                              ),
                            ),
                          ),

                        )),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "Mobile",
                      style: f14wB
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child: TextField(controller: _mobile,readOnly: true,
                        style: f14w,                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText: repo.AbtInfo["data"][0]["mobile"].toString(),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF48c0d8)),
                          ),
                          hintStyle: f14w,
                          suffix: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(height: 25,width: 53,
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    if(mobileShow==0)
                                      mobileShow = 1;
                                    else
                                      mobileShow =0;
                                  });
                                },
                                splashColor: Color(0xFFffd55e),
                                padding: EdgeInsets.all(0),
                                color: Color(0xFF48c0d8),
                                height: 25,minWidth: 53,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text(mobileShow==0 ?
                                "Unhide" : "Hide",style: f13BB,)),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "Location",
                      style: f14wB
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child: TextField(controller: _location,readOnly: true,
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
                          suffix: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(height: 25,width: 53,
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    if(locationShow==0)
                                      locationShow = 1;
                                    else
                                      locationShow =0;
                                  });
                                },
                                splashColor: Color(0xFFffd55e),
                                padding: EdgeInsets.all(0),
                                color: Color(0xFF48c0d8),
                                height: 25,minWidth: 53,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text(locationShow==0 ?
                                "Unhide" : "Hide",style: f13BB,)),
                              ),
                            ),
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
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "State",
                    style: f14wB,
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child:  Row(
                      children: [
                        Container(width: MediaQuery.of(context).size.width-226,
                          child: DropdownButton(isExpanded: true,
                            value: selected_State,
                            hint: Text("State\u002A",style: TextStyle(color: Colors.white70),),
                            dropdownColor: Color(0xFF1E2026),
                            iconEnabledColor: Color(0xFF48c0d8),
                            iconSize: 35,
                            elevation: 16,
                            style: f14w,
                            underline: Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Container(height: 1,color: Color(0xFF48c0d8),),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                selected_State = newValue;
                              });
                            },
                            items: STATES.map((item) {
                              return DropdownMenuItem(
                                value: item["name"],
                                onTap: (){
                                  setState(() {selected_State_id=item["id"].toString();});
                                  _con.DistrictList(selected_State_id.toString());
                                },
                                child: Text(item["name"]),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Container(height: 25,width: 53,
                            child: MaterialButton(
                              onPressed: (){
                                setState(() {
                                  if(stateShow==0)
                                    stateShow = 1;
                                  else
                                    stateShow =0;
                                });
                              },
                              splashColor: Color(0xFFffd55e),
                              padding: EdgeInsets.all(0),
                              color: Color(0xFF48c0d8),
                              height: 25,minWidth: 53,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(stateShow==0 ?
                              "Unhide" : "Hide",style: f13BB,)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "District",
                    style: f14wB,
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child:  Row(
                      children: [
                        Container(width: MediaQuery.of(context).size.width-226,
                          child: DropdownButton(isExpanded: true,
                            value: selected_district,
                            hint: Text("District\u002A",style: TextStyle(color: Colors.white70),),
                            dropdownColor: Color(0xFF1E2026),
                            iconEnabledColor: Color(0xFF48c0d8),
                            iconSize: 35,
                            elevation: 16,
                            style: f14w,
                            underline: Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Container(height: 1,color: Color(0xFF48c0d8),),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                selected_district = newValue;
                              });
                            },
                            items: DISTRICTS.map((item) {
                              return DropdownMenuItem(
                                value: item["name"],
                                child: Text(item["name"]),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Container(height: 25,width: 53,
                            child: MaterialButton(
                              onPressed: (){
                                setState(() {
                                  if(districtShow==0)
                                    districtShow = 1;
                                  else
                                    districtShow =0;
                                });
                              },
                              splashColor: Color(0xFFffd55e),
                              padding: EdgeInsets.all(0),
                              color: Color(0xFF48c0d8),
                              height: 25,minWidth: 53,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(districtShow==0 ?
                              "Unhide" : "Hide",style: f13BB,)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "DOB",
                    style: f14wB,
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child: TextField(controller: _dob,readOnly: true,
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                  itemStyle: TextStyle(color: Colors.white),
                                  backgroundColor: Color(0xFF23252E)),
                              showTitleActions: true,
                              minTime: DateTime(1950, 1, 1),
                              maxTime: DateTime.now().subtract(Duration(days: 6570)),
                              onConfirm: (date) {
                                setState(() {
                                  _date =
                                  '${date.day} - ${date.month} - ${date.year}';
                                  _dob.text=_date.toString();
                                });
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        style: f14w,                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),
                          hintText:  "Choose your DOB",
                          suffix: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(height: 25,width: 53,
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    if(dobShow==0)
                                      dobShow = 1;
                                    else
                                      dobShow =0;
                                  });
                                },
                                splashColor: Color(0xFFffd55e),
                                padding: EdgeInsets.all(0),
                                color: Color(0xFF48c0d8),
                                height: 25,minWidth: 53,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text(dobShow==0 ?
                                "Unhide" : "Hide",style: f13BB,)),
                              ),
                            ),
                          ),
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
                    "Gender",
                    style: f14wB,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Radio(
                          value: 0,
                          groupValue: selectedRadio,
                          activeColor: Color(0xFFffd55e),
                          onChanged: (val) {
                            setSelectedRadio(val);
                            sex = val.toString();
                          },
                        ),
                        Text(
                          "Male",
                          style: f14w,
                        ),
                        Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          activeColor: Color(0xFFffd55e),
                          onChanged: (val) {
                            setSelectedRadio(val);
                            sex = val.toString();
                          },
                        ),
                        Text(
                          "Female",
                          style: f14w,
                        ),
                        Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          activeColor: Color(0xFFffd55e),
                          onChanged: (val) {
                            setSelectedRadio(val);
                            sex = val.toString();
                          },
                        ),
                        Text(
                          "Other",
                          style: f14w,
                        ),
                      ],
                    ),
                  ),
                ],
              ), SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Food Preferences",
                    style: f14wB,
                  ),
                  Container(width: MediaQuery.of(context).size.width-165,
                    child: TextField(controller: _foodpref,
                        style: f14w,                        // controller: controller,
                        decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48c0d8)),
                        ),

                          hintText:"Veg, Non Veg, Cake....",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFF48c0d8))),
                          enabledBorder: UnderlineInputBorder(
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
                    "Favourite Dishes",
                    style: f14wB,
                  ),
                  Row(
                    children: [
                      Container(width: MediaQuery.of(context).size.width-200,
                        child: TextField(controller: _favdish,

                            style: f14w,                            // controller: controller,
                            decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            ),
                              hintText: "Add your Fav dishes",
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
                            _favdish.text.length>0 ?  selected.add(_favdish.text) : null;
                            setState(() {
                              _favdish.text="";
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
              selected.length>0? Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: selected.map((s) {
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
                            selected.remove(s);
                          });
                        });
                  }).toList()) : Container(),

              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}