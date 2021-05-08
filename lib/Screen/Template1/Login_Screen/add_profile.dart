import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Controllers/UserController/userController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/notificationController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/Confirm_OTP_Screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_drawing/path_drawing.dart';

var _image;
String lastSelectedValue;
enum AppState {
  free,
  picked,
  cropped,
}
class AddProfilePage extends StatefulWidget {
  AddProfilePage(
      {Key key, this.userid,this.otp,this.tim_id})
      : super(key: key);
  String userid,otp,tim_id;
  @override
  _AddProfilePageState createState() => _AddProfilePageState();
}

class _AddProfilePageState extends StateMVC<AddProfilePage> {

  AppState state;
  File imageFile;
  TimelineWallController _con;

  _AddProfilePageState() : super(TimelineWallController()) {
    _con = controller;
  }

  int selectedRadio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
    state = AppState.free;
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



  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: _height,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/Template1/image/loginBackground.jpeg"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: _height,
                width: double.infinity,
                decoration:
                BoxDecoration(color: Colors.black12.withOpacity(0.2)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: Container(
                  height: _height / 1.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: Color(0xFF1E2026)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Create Account",
                        style: TextStyle(
                            fontFamily: "Sofia",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 28.0),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Theme(
                        data: ThemeData(hintColor: Colors.transparent),
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
                              child: Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1d1d1d),
                                  border: DashPathBorder.all(
                                    dashArray:
                                    CircularIntervalList<double>(
                                        <double>[6.0, 2.0]),
                                  ),
                                ),
                                child: imageFile != null ? Image.file(imageFile,fit: BoxFit.cover,) : Image.asset("assets/Template1/image/Foodie/icu.png"),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Upload Profile Photo",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 64.0),
                        child: MaterialButton(
                          onPressed: () {
                           imageFile!=null ? _startUpload() :
                            Fluttertoast
                                .showToast(
                            msg: "Please upload a Profile Image",
                            toastLength: Toast
                                .LENGTH_LONG,
                            gravity: ToastGravity
                                .TOP,
                            timeInSecForIosWeb: 10,
                            backgroundColor: Color(
                            0xFF48c0d8),
                            textColor: Colors
                                .white,
                            fontSize: 16.0);
                          },
                          splashColor: Color(0xFF48c0d8),
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          height: 52,
                          color: Color(0xFFffd55e),
                          child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Sofia",
                                    letterSpacing: 0.9),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//newwww
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
        sourcePath: imageFile.path,compressQuality: 40,
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
      imageFile = croppedFile;
      setState(() {
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
    FirebaseController.instanace.savingdataofuser(widget.tim_id, _image.toString().replaceAll(".png", "_512x512.png"),fire_name.toString(),fire_username.toString(),fire_token.toString());
    _imagUpload();
  }

  _imagUpload(){
   _con.addProfileImage(context,_image.toString(), widget.userid,widget.otp);
   imageFile=null;
    // _uploadTask=null;
    return Container();
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
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