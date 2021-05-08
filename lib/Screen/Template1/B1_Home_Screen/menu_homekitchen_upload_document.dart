import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/validations.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:path/path.dart' as pp;

enum AppState {
  free,
  picked,
  cropped,
}

List IMGLIST = [];
List<File> PICKEDIMG = [];
var upld="0";

class HomekitbusinessUpload extends StatefulWidget {
  HomekitbusinessUpload({this.pagid, this.timid,this.name,this.indexx,this.place,this.username});

  String pagid, timid,name,place,username;
  int indexx;

  @override
  _HomekitbusinessUploadState createState() => _HomekitbusinessUploadState();
}

class _HomekitbusinessUploadState extends StateMVC<HomekitbusinessUpload> {

  String prof_img;
  Validations validations = new Validations();
  HomeKitchenRegistration _con;

  _HomekitbusinessUploadState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  AppState state;
  File profileImage;
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');
  StorageUploadTask _uploadTask;

  @override
  void initState() {
    print("uuuuuuuuuuuussssssssssssssseeeeeeeee "+widget.username);
    // TODO: implement initState
    super.initState();
    setState(() {
      prof_img="";
      upld="0";
      IMGLIST=[];
      PICKEDIMG=[];
    });

  }

  Future<Null> _pickImageProfile() async {
    profileImage = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    if (profileImage != null) {
      setState(() {
        state = AppState.picked;
      });
      _cropImageProfile();
    }
  }

  Future<Null> _cropImageProfile() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: profileImage.path,
        compressQuality: 40,
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
      profileImage = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
    var nows = DateTime.now();
    String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
    setState(() {
      prof_img=filePath;

      // _uploadTask = _storage.ref().child(filePath).putFile(profileImage);
    });
  }

  bool autovalidate = false;

  submit() {
    final FormState form = _con.RegFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      // if(pan_img.toString().length>0 && fssai_img.toString().length>0 && prof_img.toString().length>0)
      if(pan!=null && fssai!=null && prof_img!=null)
         {
           setState(() {
            IMGLIST.add(pan);
            IMGLIST.add(fssai);
            IMGLIST.add(prof_img);
            PICKEDIMG.add(panDoc);
            PICKEDIMG.add(fssaiDoc);
            PICKEDIMG.add(profileImage);
            upld="1";
          });
         }
      else if(pan==null && fssai!=null && prof_img!=null)
      {
        Fluttertoast.showToast(
          msg: " Please upload PAN Card !!! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      else if(pan!=null && fssai==null && prof_img!=null)
      {
        Fluttertoast.showToast(
          msg: " Please upload FSSAI Certificate !!! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      else if(pan!=null && pan!=null && prof_img==null)
      {
        Fluttertoast.showToast(
          msg: " Please upload Profile Photo !!! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      else
        Fluttertoast.showToast(
          msg: " Please upload Certificates !!! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );

    }
  }

  Future getImageFromCameraProfile(BuildContext context) async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      profileImage = File(file.path);
      state = AppState.picked;
    });
    _cropImageProfile();
  }

  final TextEditingController _accountname = TextEditingController();
  final TextEditingController _bankname = TextEditingController();
  final TextEditingController _accountnum = TextEditingController();
  final TextEditingController _ifsc = TextEditingController();
  final TextEditingController _branchname = TextEditingController();

  String fssai;
  String pan;
  File fssaiDoc;
  File panDoc;

  _pickDocument1() async {
    String result;
    try {
      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
          allowedFileExtensions: ['pdf','png','jpg','jpeg'],
          allowedMimeTypes: ['application/pdf','image/jpg','image/png','image/jpeg']
      );
      result = await FlutterDocumentPicker.openDocument(params: params);
    } catch (e) {
      print(e);
    }
    setState(() {
      fssaiDoc = File(result);
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}'+pp.extension(fssaiDoc.path);
      fssai = filePath;
       print("ppppppppppppppppaaaaaaaaathhhhhhhhhhh 11111111111111111"+
          fssai.toString()+" %%% name : "+fssaiDoc.path.split("/").last.toString());
    });
  }

  _pickDocument2() async {
    String result;
    try {
      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
          allowedFileExtensions: ['pdf','png','jpg','jpeg'],
          allowedMimeTypes: ['application/pdf','image/jpg','image/png','image/jpeg']
      );
      result = await FlutterDocumentPicker.openDocument(params: params);
    } catch (e) {
      print(e);
    }
    setState(() {
      panDoc = File(result);
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}'+pp.extension(panDoc.path);
       pan = filePath;
      print("ppppppppppppppppaaaaaaaaathhhhhhhhhhh 11111111111111111"+
          pan.toString()+" %%% name : "+panDoc.path.split("/").last.toString()) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E2026),
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        elevation: 4,
        centerTitle: true,
        brightness: Brightness.dark,
        title: Text(
          "Upload Documents",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child:  upld=="1" ? ImageUploadProgress(
            bankname: _bankname.text,
            username: widget.username,
            place: widget.place,
            name: widget.name,
            accname: _accountname.text,accnum: _accountnum.text,
            branchh: _branchname.text,fssaiimg: fssaiDoc.path,ifsccc: _ifsc.text,
            panimg: panDoc.path,proimg: prof_img,pagee: widget.pagid,timm: widget.timid,busname: widget.name,index: widget.indexx,) : Container(height: 0,),

        ),
      ),
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Form(
                key: _con.RegFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "FSSAI License Certificate",
                          style: f15wB,
                        ),
                        fssaiDoc==null ? MaterialButton(color: Color(0xFFffd55e),
                          onPressed: (){_pickDocument1();},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.file_upload,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text("Upload"),
                            ],
                          ),
                        ) : Container()
                      ],
                    ),
                    fssaiDoc!=null ?  SizedBox(height: 10,) : Container(),
                    fssaiDoc!=null ?  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.15,
                        ),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:15),
                            child: Text(fssaiDoc.path.toString().split("/").last,style: f14w,),
                          ),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                fssai=null;
                                fssaiDoc=null;
                              });
                            },
                            icon: Icon(Icons.close,color: Colors.white,),
                          )
                        ],
                      ),
                    ) : Container(),
                   /* Center(
                      child: imageFileBusinessCert != null
                          ? Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "FSSAI License Certificate",
                              style: f16wB,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
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
                                            _pickImageBusCert();
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
                                            getImageFromCameraBusCert(
                                                context);
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
                            child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1d1d1d),
                                  border: DashPathBorder.all(
                                    dashArray: CircularIntervalList<double>(
                                        <double>[6.0, 2.0]),
                                  ),
                                ),
                                child: Image.file(
                                  imageFileBusinessCert,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ],
                      )
                          : GestureDetector(
                        onTap: () {
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
                                        _pickImageBusCert();
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
                                        getImageFromCameraBusCert(context);
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                border: DashPathBorder.all(
                                  dashArray: CircularIntervalList<double>(
                                      <double>[6.0, 2.0]),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Upload FSSAI License Certificate",
                                        style: f15wB),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Click here to Upload Photo",
                                      style: f13g,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                   /* Center(
                      child: imageFilePanCard != null
                          ? GestureDetector(
                        onTap: () {
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
                                        _pickImage();
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
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "PAN Card",
                                style: f16wB,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1d1d1d),
                                  border: DashPathBorder.all(
                                    dashArray: CircularIntervalList<double>(
                                        <double>[6.0, 2.0]),
                                  ),
                                ),
                                child: Image.file(
                                  imageFilePanCard,
                                  fit: BoxFit.cover,
                                )),
                          ],
                        ),
                      )
                          : GestureDetector(
                        onTap: () {
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
                                        _pickImage();
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
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            border: DashPathBorder.all(
                              dashArray: CircularIntervalList<double>(
                                  <double>[6.0, 2.0]),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Upload PAN Card",
                                  style: f14wB,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Click here to Upload Photo",
                                  style: f13g,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PAN Card",
                          style: f15wB,
                        ),
                        panDoc==null ? MaterialButton(color: Color(0xFFffd55e),
                          onPressed: (){_pickDocument2();},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.file_upload,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text("Upload"),
                            ],
                          ),
                        ) : Container()
                      ],
                    ),
                    panDoc!=null ?  SizedBox(height: 10,) : Container(),
                    panDoc!=null ?  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.15,
                        ),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:15),
                            child: Text(panDoc.path.toString().split("/").last,style: f14w,),
                          ),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                pan=null;
                                panDoc=null;
                              });
                            },
                            icon: Icon(Icons.close,color: Colors.white,),
                          )
                        ],
                      ),
                    ) : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bank Details",
                      style: f15wB,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF23252E),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.15,
                          ),
                        ),
                        child: Theme(
                          data: ThemeData(hintColor: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              validator: validations.validateAccountname,
                              controller: _accountname,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.start,
                              autocorrect: false,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "Beneficiary Account Name\u002A",
                                  hintStyle: f14g),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF23252E),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.15,
                          ),
                        ),
                        child: Theme(
                          data: ThemeData(hintColor: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              validator: validations.validateBankname,
                              controller: _bankname,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.start,
                              autocorrect: false,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "Bank Name\u002A",
                                  hintStyle: f14g),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF23252E),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.15,
                          ),
                        ),
                        child: Theme(
                          data: ThemeData(hintColor: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              validator: validations.validateaccountnum,
                              controller: _accountnum,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.start,
                              autocorrect: false,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "Account Number\u002A",
                                  hintStyle: f14g),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF23252E),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.15,
                          ),
                        ),
                        child: Theme(
                          data: ThemeData(hintColor: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              validator: validations.validateifsccode,
                              controller: _ifsc,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.start,
                              autocorrect: false,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "IFSC Code\u002A",
                                  hintStyle: f14g),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF23252E),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.15,
                          ),
                        ),
                        child: Theme(
                          data: ThemeData(hintColor: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              validator: validations.validatebranchname,
                              controller: _branchname,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.start,
                              autocorrect: false,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "Branch Name\u002A",
                                  hintStyle: f14g),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Business Profile Photo",
                          style: f15wB,
                        ),
                        profileImage==null ? MaterialButton(color: Color(0xFFffd55e),
                          onPressed: (){ showDialog(
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
                                        _pickImageProfile();
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
                                        getImageFromCameraProfile(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Take New Photo',
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                );
                              });},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.person_add,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text("Photo"),
                            ],
                          ),
                        ) : Stack(alignment: Alignment.topRight,
                          children: [
                            Container(
                                height: 100,
                                width: 100,clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Color(0xFF1d1d1d),
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Image.file(
                                  profileImage,
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    prof_img=null;
                                    profileImage=null;
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(height: 45,
          child: MaterialButton(  height: 45,
            splashColor: Color(0xFFffd55e),
            color: Color(0xFF48c0d8),
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10),),
            onPressed: () {
              submit();
              // _startUploadPanCard();
            },
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Color(0xFF48c0d8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )),
            ),
          ),
        ),
      ),
    );
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

class ImageUploadProgress extends StatefulWidget {

  ImageUploadProgress({this.accnum,this.accname,this.branchh,this.fssaiimg,
    this.ifsccc,this.panimg,this.proimg,this.pagee,this.timm,this.busname,
    this.index,this.username,this.place,this.name,this.bankname});

  String panimg,fssaiimg,proimg,accname,accnum,ifsccc,branchh,pagee,timm,busname,name,place,username,bankname;
  int index;

  @override
  _ImageUploadProgressState createState() => _ImageUploadProgressState();
}

class _ImageUploadProgressState extends StateMVC<ImageUploadProgress> {

  HomeKitchenRegistration _con;



  _ImageUploadProgressState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startUpload();
  }

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startUpload() {
    for (var i = 0; i < PICKEDIMG.length; i++) {
      // var nows = DateTime.now();
      // String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        // IMAGELISTS.add(filePath);
        _uploadTask = _storage.ref().child(IMGLIST[i]).putFile(PICKEDIMG[i]);
      });
    }
  }



  _setval(){
    _con.LocalStoDocumentUpload(context,widget.panimg,
        widget.fssaiimg, "1", widget.pagee, widget.timm,widget.accname,widget.accnum,
        widget.ifsccc,widget.branchh,widget.proimg,widget.busname,widget.index,widget.name,widget.username,widget.place,widget.bankname);
    _uploadTask=null;
    upld="2";
    IMGLIST=[];
    PICKEDIMG=[];
    return Container(height: 0,);
  }




  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_uploadTask.isComplete)
                    _setval()
                  else
                    LinearProgressIndicator(
                      value: progressPercent,
                      backgroundColor: Colors.grey,
                      minHeight: 4,
                    )
                ]);
          });
    }
    else
    {
      return Container(height: 0,);
    }
  }
}