import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_foodi_market_form.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:geolocator/geolocator.dart';

class FoodBankForm extends StatefulWidget {
  @override
  _FoodBankFormState createState() => _FoodBankFormState();
}

class DashPathBorder extends Border {
  DashPathBorder({
    @required this.dashArray,
    BorderSide top = BorderSide.none,
    BorderSide left = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
  }) : super(
    top: top,
    left: left,
    right: right,
    bottom: bottom,
  );

  factory DashPathBorder.all({
    BorderSide borderSide = const BorderSide(color: Colors.grey),
    @required CircularIntervalList<double> dashArray,
  }) {
    return DashPathBorder(
      dashArray: dashArray,
      top: borderSide,
      right: borderSide,
      left: borderSide,
      bottom: borderSide,
    );
  }

  final CircularIntervalList<double> dashArray;

  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        TextDirection textDirection,
        BoxShape shape = BoxShape.rectangle,
        BorderRadius borderRadius,
      }) {
    if (isUniform) {
      switch (top.style) {
        case BorderStyle.none:
          return;
        case BorderStyle.solid:
          switch (shape) {
            case BoxShape.circle:
              assert(borderRadius == null,
              'A borderRadius can only be given for rectangular boxes.');
              canvas.drawPath(
                dashPath(Path()..addOval(rect), dashArray: dashArray),
                top.toPaint(),
              );
              break;
            case BoxShape.rectangle:
              if (borderRadius != null) {
                final RRect rrect =
                RRect.fromRectAndRadius(rect, borderRadius.topLeft);
                canvas.drawPath(
                  dashPath(Path()..addRRect(rrect), dashArray: dashArray),
                  top.toPaint(),
                );
                return;
              }
              canvas.drawPath(
                dashPath(Path()..addRect(rect), dashArray: dashArray),
                top.toPaint(),
              );

              break;
          }
          return;
      }
    }

    assert(borderRadius == null,
    'A borderRadius can only be given for uniform borders.');
    assert(shape == BoxShape.rectangle,
    'A border can only be drawn as a circle if it is uniform.');

    // TODO(dnfield): implement when borders are not uniform.
  }
}
Position currentLocation;
const kGoogleApiKey = "AIzaSyABBH07rVnsmRDsmIjtpfHiBuwczmyVyLk";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
var loc_lat = userLocation.latitude;
var  loc_long = userLocation.longitude;
class _FoodBankFormState extends StateMVC<FoodBankForm> {

  TimelineWallController _con;

  _FoodBankFormState() : super(TimelineWallController()) {
    _con = controller;
  }

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startUpload() {
    setState(() {
      IMAGELISTS=[];
    });
    for (var i = 0; i < imageList.length; i++) {
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELISTS.add(filePath);
        _uploadTask = _storage.ref().child(filePath).putFile(imageList[i]);
      });
    }
    _imagUpload();
  }

  _imagUpload() {
    _con.addFoodBankProduct(context,
        IMAGELISTS.join(",").toString(),_desc.text,_title.text,crntindex==6 ? _other.text : crntindex.toString(),_pickup.text,
        _loc.text,loc_lat.toString(),loc_long.toString(),days_value.toString(),showuser_value.toString());
    // _uploadTask=null;
    Fluttertoast.showToast(msg: "Adding Product",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return Container();
  }

  var latt,longg;
  var days_value;
  var showuser_value;
  int crntindex;
  bool showOthers;
  Completer<GoogleMapController> _controller = Completer();
  File imageFile;

  var location ;
  Position LocationData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      showOthers=false;
      IMAGELISTS = [];
      imageList = [];
      crntindex=2;
      _loc.text = location_address;
    });
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        compressQuality: 20,
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
            toolbarColor: Color(0xFF1E2026),
            activeControlsWidgetColor: Color(0xFF48c0d8),
            toolbarWidgetColor: Color(0xFF48c0d8),
            cropGridColor: Color(0xFFffd55e),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        imageList=[];
        imageList.add(imageFile);
        imageFile = null;
      });
    }
  }

  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      imageFile = File(file.path);

    });
    _cropImage();
  }

  List<Asset> images = List<Asset>();
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarTitleColor: "#48c0d8",
          actionBarColor: "#1E2026",
          actionBarTitle: "Choose Photos ",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      //print("errrooorrrr "+e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      getFileList();
    });
  }

  void getFileList() async {
    imageList.clear();
    for (int i = 0; i < images.length; i++) {
      var path2 =
      await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      //var path = await images[i].filePath;
      var file = await getImageFileFromAsset(path2);
      imageList.add(file);
    }
  }

  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }


  Set<Circle> circles = Set.from([Circle(
    circleId: CircleId("1"),
    center:/*currentLocation!=null ?  LatLng(currentLocation.latitude  ,  currentLocation.longitude) :*/
    LatLng(loc_lat, loc_long),
    radius: 90,strokeColor: Color(0xFF48c0d8),
    strokeWidth: 3
  )]);

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);
      print("llllllaaaaaaaaattttttt "+loc_lat.toString());
      print("llllllongggg "+loc_long.toString());
      setState(() {
        loc_lat = detail.result.geometry.location.lat;
        loc_long = detail.result.geometry.location.lng;
      });
      print("llllllaaaaaaaaattttttt "+loc_lat.toString());
      print("llllllongggg "+loc_long.toString());
    }
  }

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _other = TextEditingController();
  TextEditingController _loc = TextEditingController();
  TextEditingController _pickup = TextEditingController();

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
        title: Text("Food Bank (Share Food)",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:10, right: 12,left: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageList.length>0 ? Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: imageList.length,
                    itemBuilder: (context, ind) {
                      return Stack(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              height: 80,
                              width: 110,
                              clipBehavior: Clip.antiAlias,
                              child: Image.file(
                                imageList[ind],
                                fit: BoxFit.cover,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 93.0, top: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imageList.removeAt(ind);
                                      images.removeAt(ind);
                                    });
                                  },
                                  child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFffd55e),
                                          borderRadius:
                                          BorderRadius.circular(100)),
                                      child: Center(
                                          child: Icon(
                                            Icons.clear,
                                            size: 18,
                                          ))),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
              ) : GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          backgroundColor: Color(0xFF1E2026),
                          title: Text('Camera / Gallery',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                loadAssets();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Choose From Gallery',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                getImageFromCamera(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Take New Photo',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        );
                      });
                },
                child: Row(
                  children: [
                    Container(
                      height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: DashPathBorder.all(
                            dashArray: CircularIntervalList<double>(
                                <double>[6.0, 2.0]),
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(Icons.camera_alt,color: Colors.grey,size: 40,)),
                    SizedBox(width: 15,),
                    Text("Add Upto 10 Photos",style: f15wB,),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Text("Title",style: f15wB,),
              SizedBox(height: 3,),
              Container(height: 45,
                child: TextField(
                  controller: _title,
                  style: f14w,
                  decoration: InputDecoration(
                    filled: true,
                      contentPadding: EdgeInsets.only(top: 0,left: 10),
                    fillColor: Color(0xFF23252E),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12
                    ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF48C0d8))
                    )
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Description",style: f15wB,),
              SizedBox(height: 3,),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border : Border.all(color: Colors.white12),
                    borderRadius: BorderRadius.circular(8),
                    color:  Color(0xFF23252E)
                ),
                child: TextField(
                  controller: _desc,
                  minLines: null,
                  expands: true,
                  maxLines: null,
                  style: f14w,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 10,right: 8),
                      hintStyle: f14g,
                      hintText: "e.g 2x pack of rice BB DESC 30 2020",
                      border: InputBorder.none

                    /*  enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48C0d8))
                      )*/
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Quantity",style: f15wB,),
              SizedBox(height: 3,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        showOthers=false;
                        crntindex=1;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: crntindex==1 ? Color(0xFfffd55e) : Colors.grey[600],
                        border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                          child: Text("1",style: crntindex==1 ? f14B : f14w,)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        showOthers=false;
                        crntindex=2;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: crntindex==2 ? Color(0xFfffd55e) : Colors.grey[600],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                          child: Text("2",style: crntindex==2 ? f14B : f14w,)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        showOthers=false;
                        crntindex=3;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: crntindex==3 ? Color(0xFfffd55e) : Colors.grey[600],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                          child: Text("3",style: crntindex==3 ? f14B : f14w,)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        showOthers=false;
                        crntindex=4;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: crntindex==4 ? Color(0xFfffd55e) : Colors.grey[600],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                          child: Text("4",style: crntindex==4 ? f14B : f14w,)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        showOthers=false;
                        crntindex=5;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: crntindex==5 ? Color(0xFfffd55e) : Colors.grey[600],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                          child: Text("5",style: crntindex==5 ? f14B : f14w,)),
                    ),
                  ),
                  InkWell(
                      onTap: (){
                        setState(() {
                          crntindex=6;
                          showOthers=true;
                        });
                      },
                      child: Text("Others",style: f14w,))
                ],
              ),
              showOthers==true ? SizedBox(height: 15,) : Container(height: 0,),
              showOthers==true ? Text("Others",style: f15wB,) : Container(height: 0,),
              showOthers==true ? SizedBox(height: 3,) : Container(height: 0,),
              showOthers==true ? Container(
                height: 45,
                child: TextField(
                  controller: _other,
                  style: f14w,keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 0,left: 10),
                      fillColor: Color(0xFF23252E),
                      hintText: "Quantity",
                      hintStyle: f14g,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48C0d8))
                      )
                  ),
                ),
              ) : Container(height: 0,),
              SizedBox(height: 15,),
              Text("Pickup Times",style: f15wB,),
              SizedBox(height: 3,),
              Container(height: 45,
                child: TextField(
                  controller: _pickup,
                  style: f14w,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 0,left: 10),
                      hintStyle: f14g,
                      hintText: "e.g Today from 4 to 6 PM or I can Leave it",
                      fillColor: Color(0xFF23252E),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48C0d8))
                      )
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Location",style: f15wB,),
              SizedBox(height: 3,),
              Container(
                height: 45,
                child: TextField(
                  onTap: () async {
                    Prediction p = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: kGoogleApiKey,
                      mode: Mode.overlay,
                      // Mode.fullscreen
                      language: "IN",
                      components: [
                        new Component(Component.country, "IN")
                      ],
                    );
                    displayPrediction(p, homeScaffoldKey.currentState);
                    _loc.text = p.description.toString();
                    var a = p.types;
                    var b = a[2];
                  },
                  keyboardType: TextInputType.number,
                  controller: _loc,
                  style: f14w,
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 0,left: 10),
                      fillColor: Color(0xFF23252E),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF48C0d8))
                      )
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Your Location (approx)",style: f15wB,),
              SizedBox(height: 4,),
              Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[800],
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 10.4746,
                  ),zoomControlsEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: null,
                  circles: circles,
                )),
              SizedBox(height: 15,),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white12),
                  color: Color(0xFF23252E)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:8,right: 8),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("List for",style: f15wB,),
                      Container(
                        width: 80,
                        child: DropdownButton(
                          value: days_value,
                          hint: Text("Select",style: f14g,),
                          dropdownColor: Color(0xFF1E2026),
                          iconEnabledColor: Colors.grey,
                          iconSize: 25,
                          elevation: 16,isExpanded: true,
                          style: f14w,
                          underline: Container(height: 0,),
                          onChanged: (newValue) {
                            setState(() {
                              days_value = newValue;
                            });
                          },
                          items: Days.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text("Food with a 'Use By' date must be unlisted by midnight of the date.",
                style: f15w,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Divider(color: Colors.grey,),
              SizedBox(height: 10,),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left:8,right: 8),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Show to all Users",style: f15wB,),
                      Container(
                        width: 120,
                        child: DropdownButton(
                          value: showuser_value,
                          hint: Text("Select",style: f14g,),
                          dropdownColor: Color(0xFF1E2026),
                          iconEnabledColor: Colors.grey,
                          iconSize: 25,
                          elevation: 16,isExpanded: true,
                          style: f14w,
                          underline: Container(height: 0,),
                          onChanged: (newValue) {
                            setState(() {
                              showuser_value = newValue;
                            });
                          },
                          items: ShowUsers.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: (){
            _startUpload();
          },
          child: Container(
            height: 42,
            width: MediaQuery.of(context).size.width/1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFffd55e),
            ),
            child: Center(child: Text("Submit",style: f16B,)),
          ),
        ),
      ),
    );
  }
}
