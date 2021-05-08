import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Butomy/Components/widget_style.dart';
class DrawerAccountRequestVerification extends StatefulWidget {

  DrawerAccountRequestVerification({this.stat,this.showw});

  String stat,showw;

  @override
  _DrawerAccountRequestVerificationState createState() => _DrawerAccountRequestVerificationState();
}

class _DrawerAccountRequestVerificationState extends StateMVC<DrawerAccountRequestVerification> {

  TimelineWallController _con;

  _DrawerAccountRequestVerificationState() : super(TimelineWallController()) {
    _con = controller;
  }

  var known_value;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _username.text = userNAME;
      _name.text = NAME;
    });
    super.initState();
  }

  File imageFile;

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 20);
    if (imageFile != null) {
      setState(() {
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
      setState(() {
        imageFile = croppedFile;
      });
    }
  }

  var _image;

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
    _imagUpload();
  }

  _imagUpload(){
    _con.requestVerification(context,_image,_knownAs.text,known_value);
    // imageFile=null;
    return Container();
  }


  TextEditingController _knownAs = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _name = TextEditingController();

  Future<String> setStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('homekit');
    prefs.setString('homekit', "4");
  }

  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker().getImage(
        source: ImageSource.camera,imageQuality: 20);
    this.setState(() {
      imageFile = File(file.path);
    });
    _cropImage();
  }

  Future<bool> _onWillPop() async {
    imageCache.clear();
    _con.getAbout(userid.toString());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xFF1E2026),iconTheme: IconThemeData(color: Colors.white),titleSpacing: 0,
          elevation: 4,brightness: Brightness.dark,
          title: Text("Request Verification",style:TextStyle(color:Colors.white,),),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFF1E2026),
        body: widget.stat=="0" && widget.showw == "0" ? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 10,top: 20),
                child: Text(
                  "Apply for Account Verification",
                  textAlign: TextAlign.center,
                  style: f18WB,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15,left: 40,right: 40),
                child: Text("A verified badge is a check that appears next an foodiz account's name to indicate that the"
                    " account is the authentic presence ... ",style: f14g,textAlign: TextAlign.center,),
              ),
//            SizedBox(
//              height: MediaQuery.of(context).size.height/5,
//            ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Username",style: f13g),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                child: Container(
                  height: 25,
                  child: TextField(readOnly: true,controller: _username,
                      style: TextStyle(color: Colors.white),
                      // controller: controller,
                      decoration: InputDecoration(border:UnderlineInputBorder(borderSide:BorderSide(color: Colors.grey)),enabledBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.grey),),hintText:"John",hintStyle:TextStyle(color: Colors.grey,fontSize: 13),labelStyle:TextStyle(color: Colors.white),)
                  ),
                ),
              ),
              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Full Name",style: f13g),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                child: Container(
                  height: 25,
                  child: TextField(controller: _name,
                      style: TextStyle(color: Colors.white),
                      // controller: controller,
                      decoration: InputDecoration(border:UnderlineInputBorder(borderSide:BorderSide(color: Colors.grey)),enabledBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.grey),),hintStyle:TextStyle(color: Colors.grey,fontSize: 12),labelStyle:TextStyle(color: Colors.white),)
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Known As",style: f13g),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Container(
                  height: 25,
                  child: TextField(controller: _knownAs,
                      style: TextStyle(color: Colors.white),
                      // controller: controller,
                      decoration: InputDecoration(
                        enabledBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.grey,),),
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Color(0xFF48c0d8),width: 2),),
                        )
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Category",style: f13g),
              ),
              Padding(
                padding: const EdgeInsets.only(left:15,right: 15,top: 5),
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFF23252E),
                  borderRadius: BorderRadius.circular(10)),
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10,right: 10),
                    child: DropdownButton(
                      value: known_value,
                      hint: Text("Select",style: f14g,),
                      dropdownColor: Color(0xFF1E2026),
                      iconEnabledColor: Colors.grey,
                      iconSize: 25,
                      elevation: 16,isExpanded: true,
                      style: f14w,
                      underline: Container(height: 0,),
                      onChanged: (newValue) {
                        setState(() {
                          known_value = newValue;
                        });
                      },
                      items: requestVerify.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Please attach a photo of your ID",
                      textAlign: TextAlign.center,
                      style: f14w,
                    ),
                    FlatButton(splashColor: Color(0xFFffd55e),
                      onPressed: (){
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(
                        "Choose File",
                        textAlign: TextAlign.center,
                        style: f15bB,
                      ),
                    ),

                  ],
                ),
              ),
              imageFile != null ? Container(height: 80,
                width: 140,
                child: Stack(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 80,
                        width: 110,
                        clipBehavior: Clip.antiAlias,
                        child: Image.file(imageFile,
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
                              right: 20, top: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                imageFile=null;
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
                ),
              ) : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
                child: Container(
                  child: Text("We require a government- issued photo ID that shows your name and date of birth(e.g driver's license,passport or"
                      " national Identification card) or official business documents "
                      "(tax filing,recent utility bill,article of Incorporation) in order "
                      "to review your request.",style: f14g,textAlign: TextAlign.justify,),
                ),
              ),
            ],
          ),
        ) :
        widget.stat=="0" && widget.showw == "1" ? Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/Template1/image/Foodie/wait.png",height: 100,),
          SizedBox(height: 50,),
          Text("Please wait until\ndocument verification",style: f21BB,textAlign: TextAlign.center,)
        ],
      ),
      ) : widget.stat=="1" && widget.showw == "1" ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/Template1/image/Foodie/icons/verified_user.png",height: 100,color: Colors.white,),
              SizedBox(height: 50,),
              Text("Verified",style: f21BB,textAlign: TextAlign.center,)
            ],
          ),
        ) : Container(),
        bottomNavigationBar: widget.stat=="0" && widget.showw == "0" ? GestureDetector(
          onTap: (){
            _startUpload();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFF48c0d8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                      "Send",
                      style: f16wB,
                    )),
              ),
            ),
          ),
        ) : Container(height: 0,),
      ),
    );
  }
}
