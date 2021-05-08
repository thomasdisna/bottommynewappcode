/*
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/bottom_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
as repoo;

import 'package:video_player/video_player.dart';


enum AppState {
  free,
  picked,
  cropped,
}
bool uploadownvideoStatus;
File _video;
String str = '';
List<String> coments = [], words = [];
String typ;
int selectradio;
bool videoo = false;
var blogtype;
var video_type;
List<File> imageList;

class Form22 extends StatefulWidget {
  @override
  _Form22State createState() => _Form22State();
}

class _Form22State extends StateMVC<Form22> {
  TimelineWallController _con;

  _Form22State() : super(TimelineWallController()) {
    _con = controller;
  }

  TextEditingController _desc = TextEditingController();
  TextEditingController _blogTitle = TextEditingController();
  TextEditingController _utube = TextEditingController();

  AppState state;
  File imageFile;

  int selectedRadio;
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {imageList=[];
    IMAGELIST=[];
    uploadownvideoStatus=false;
    typ = "";});
    _con.getUsers();
    state = AppState.free;
    selectedRadio = 1;
  }

  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      imageFile = File(file.path);

      state = AppState.picked;

    });
    _cropImage();
  }

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;


      });
      _cropImage();
    }
  }

  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = video;
    });
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }



  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.camera);
    setState(() { _video = video;
    });
    _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
      setState(() {  _videoPlayerController.play();
      });

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
        imageList.add(imageFile);
        state = AppState.cropped;
        imageFile=null;
      });
    }
  }

  void _clearImage() {
    setState(() {
      imageFile = null;
      state = AppState.free;
    });
  }

  void _clearVideo() {
    setState(() {
      _video = null;
    });
  }

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startBlogImageUpload() {
    for(var i = 0; i < imageList.length; i++){
      var nows = DateTime.now();
      String filePath = '${nows.millisecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELIST.add(filePath);
        _uploadTask = _storage.ref().child(filePath).putFile(imageList[i]);
      });
    }
    _imagBlogUpload();
  }

  _imagBlogUpload(){
    Fluttertoast.showToast(
      msg: "Uploading Post",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    _con.postBlogPost(
        userid.toString(),
        _desc.text,
        IMAGELIST.join(",").toString(),
        "image",
        "blog");

    IMAGELIST=[];
    typ="";
    _video=null;
    imageList=[];
    // _uploadTask=null;
    return Container();
  }



  _startUpload() {
    for(var i = 0; i < imageList.length; i++){
      var nows = DateTime.now();
      String filePath = '${nows.millisecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELIST.add(filePath);
        _uploadTask = _storage.ref().child(filePath).putFile(imageList[i]);
      });
    }
    _imagUpload();
  }

  _imagUpload(){
    Fluttertoast.showToast(
      msg: "Uploading Post",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    _con.posttimelineWallPost(
      userid.toString(),
      _desc.text,
      IMAGELIST.join(",").toString(),
      "image",
    );
    IMAGELIST=[];
    typ="";
    _video=null;
    imageList=[];
    // _uploadTask=null;
    return Container();
  }

  setUpdate(){
    return Container();
  }

  _startVideoUpload() {
    var nows = DateTime.now();
    String filePath = '${nows.millisecondsSinceEpoch.toString()}.mp4';
    setState(() {
      VIDEODATA=filePath;
      _uploadTask = _storage.ref().child(filePath).putFile(_video,StorageMetadata(contentType: 'video/mp4'));
    });

  }

  _videoUpload(){
    _con.posttimelineOwnVideoPost(
      userid.toString(),
      _desc.text,
      VIDEODATA,
    );
    Fluttertoast.showToast(
      msg: "Uploading Post",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    typ="";
    _video=null;
    imageList=[];
    // _uploadTask=null;
    return Container();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => TimeLine()));
            },
            child: Icon(
              Icons.arrow_back,
            )),
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        title: Text(
          "Create Post",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF1e2026),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(userPIC),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        NAME.toString(),
                        style: f15wB,
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      if( _desc.text.length > 0 && typ=="")
                      {
                        Fluttertoast.showToast(
                          msg: "Uploading Post",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 35,
                          backgroundColor: Color(0xFF48c0d8),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        _con.posttimelineDescPost(
                          userid.toString(),
                          _desc.text,
                        );
                      }
                      else if( imageList.length>0 && typ=="img")
                      {
                        _startUpload();
                      }
                      else if (typ == "video")
                      {
                        if(video_type=="own video" && _video!=null)
                        {
                          setState(() {uploadownvideoStatus=true;});
                        }
                        if(video_type=="utube")
                        {
                          _con.posttimelineUTubeVideoPost(
                            userid.toString(),
                            _desc.text,
                            _utube.text,
                          );
                          Fluttertoast.showToast(
                            msg: " Uploading Post ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 35,
                            backgroundColor: Color(0xFF48c0d8),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }

                      }
                      else if(typ == "blog" && blogtype == "img")
                      {
                        _startBlogImageUpload();
                      }
                      else if(typ == "blog" && blogtype == "video" && _video!=null)
                      {
                        setState(() {uploadownvideoStatus=true;});
                      }
                      else
                        setState(() {
                          _desc.text = "";
                          _utube.text = "";
                          _blogTitle.text = "";
                          imageFile = null;
                        });
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Color(0xFF48c0d8),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                            "Post",
                            style: f15B,
                          )),
                    ),
                  )
                ],
              ),
            ),
            // _video != null&& videoo==true?  VideoUploader(file: _video,) :  Container(),
            uploadownvideoStatus==true ? VideoUploader(file: _video,desc: _desc.text,) : Container(),
            typ == "blog"
                ? Padding(
              padding:
              const EdgeInsets.only(left: 12, right: 12, bottom: 10),
              child: Container(
                height: 52,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFF23252E),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: TextField(
                    controller: _blogTitle,
                    maxLines: 5,
                    // controller: _loc,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "    Write Blog Title... ",
                        hintStyle: f14g),
                  ),
                ),
              ),
            )
                : Container(
              height: 0,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius: BorderRadius.circular(8)),
                    child: HashTagTextField(
                      controller: _desc,expands: true,
                      onChanged: (val) {
                        setState(() {
                          words = val.split(' ');
                          str = words.length > 0 &&
                              words[words.length - 1].startsWith('@')
                              ? words[words.length - 1]
                              : '';
                        });
                        _desc.addListener(() {
                          final text = _desc.text.toLowerCase();
                          _desc.value = _desc.value.copyWith(
                            text: text,
                            selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
                            composing: TextRange.empty,
                          );
                        });
                      },
                      maxLines: null,minLines: null,autocorrect: true,
                      // controller: _loc,
                      basicStyle: TextStyle(color: Colors.white),
                      decoratedStyle: TextStyle(color: Colors.blue),

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "  Write Something Here !!! ? ",
                        hintStyle: f14g,
                      ),

                    ),
                  ),
                ),
                str.length > 1
                    ? Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Container(
                    color: Color(0xFF1E2026),
                    child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: repoo.appUsers.map((s) {
                          var name = s.split("_");
                          */
/* if(name.length==3)
                {
                  print("id checking 2222");
                  idPass = name[2];
                  print(idPass);
                }*//*

                          var baseUrl =
                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F";
                          var sendUrl = baseUrl + name[1];
                          if (('@' + name[0]).contains(str))
                            return ListTile(
                                leading: Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          CachedNetworkImageProvider(sendUrl.toString().replaceAll(" ", "%20")+"?alt=media"),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(180.0))),
                                ),
                                // leading:Text(name[1],style: TextStyle(color: Colors.blue),),
                                title: Text(
                                  name[0],
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: () {
                                  String tmp = str.substring(1, str.length);
                                  setState(() {
                                    //idPass = name[2];
                                    str = '';
                                    _desc.text=_desc.text+ name[0].substring(
                                        name[0].indexOf(tmp) + tmp.length,
                                        name[0].length);

                                    */
/* coments.add(_desc.text);*//*

                                  });
                                });
                          else
                            return SizedBox();
                        }).toList()),
                  ),
                )
                    : SizedBox(),
              ],
            ),

            SizedBox(height: 15),
            (imageList.length>0  && typ == "img" )
                ? Container(height: 100,
              child: ListView.builder(scrollDirection: Axis.horizontal,
                  itemCount: imageList.length,
                  itemBuilder: (context,ind){
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 80,width: 110,
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
                              padding: const EdgeInsets.only(left: 93.0, top: 5),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    imageList.removeAt(ind);
                                  });
                                },
                                child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFffd55e),
                                        borderRadius: BorderRadius.circular(100)),
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
            )
                : videoo == true && typ == "video"
                ? Padding(
              padding:
              const EdgeInsets.only(left: 12, right: 12, top: 15),
              child: Column(
                children: <Widget>[
                  _video != null
                      ? Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _videoPlayerController
                            .value.aspectRatio,
                        child:
                        VideoPlayer(_videoPlayerController),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, top: 5),
                            child: GestureDetector(
                              onTap: () {
                                _clearVideo();
                              },
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFffd55e),
                                      borderRadius:
                                      BorderRadius.circular(
                                          100)),
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
                  )
                      : GestureDetector(
                    onTap: () {
                      setState(() {video_type="own video";});
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              backgroundColor:
                              Color(0xFF1E2026),
                              title: Text('Camera / Gallery',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.w500)),
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    _pickVideo();
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
                                    _pickVideoFromCamera();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                      'Take New Video',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFF23252E),
                          borderRadius:
                          BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/video_upload.png",
                            height: 32,
                            width: 32,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Upload Video",
                            style: f15w,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {video_type="utube";});
                    },
                    child: Container(
                      height: 62,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFF23252E),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                "assets/Template1/image/Foodie/icons/youtube.png",
                                height: 28,
                                width: 28,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width -
                                  78,
                              child: TextField( onTap: (){
                                setState(() {video_type="utube";});
                              },
                                maxLines: 4,
                                controller: _utube,
                                // controller: _loc,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                    "Copy Youtube video Link...",
                                    hintStyle: f14g),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
                : typ == "blog"
                ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          blogtype = "img";
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  backgroundColor:
                                  Color(0xFF1E2026),
                                  title: Text('Camera / Gallery',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.w500)),
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
                                        getImageFromCamera(
                                            context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                          'Take New Photo',
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          height: 45,
                          width:
                          MediaQuery.of(context).size.width /
                              2.15,
                          decoration: BoxDecoration(
                              color: Color(0xFF23252E),
                              borderRadius:
                              BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Template1/image/Foodie/icons/image.png",
                                height: 24,
                                width: 24,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Upload Image",
                                style: f15w,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {blogtype = "video";
                          videoo=true;
                          });
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  backgroundColor:
                                  Color(0xFF1E2026),
                                  title: Text('Camera / Gallery',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.w500)),
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        _pickVideo();
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
                                        _pickVideoFromCamera();
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                          'Take New Video',
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          height: 45,
                          width:
                          MediaQuery.of(context).size.width /
                              2.15,
                          decoration: BoxDecoration(
                              color: Color(0xFF23252E),
                              borderRadius:
                              BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Template1/image/Foodie/icons/video_upload.png",
                                height: 23,
                                width: 23,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Upload Video",
                                style: f15w,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                blogtype == "video" && typ=="blog" &&
                    _video != null
                    ? Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _videoPlayerController
                          .value.aspectRatio,
                      child:
                      VideoPlayer(_videoPlayerController),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20.0, top: 5),
                          child: GestureDetector(
                            onTap: () {
                              _clearVideo();
                            },
                            child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Color(0xFFffd55e),
                                    borderRadius:
                                    BorderRadius.circular(
                                        100)),
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
                )
                    : blogtype == "img" &&
                    typ == "blog" &&
                    imageList.length>0
                    ? Container(height: 100,
                  child: ListView.builder(scrollDirection: Axis.horizontal,
                      itemCount: imageList.length,
                      itemBuilder: (context,ind){
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 80,width: 110,
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
                                  padding: const EdgeInsets.only(left: 93.0, top: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        imageList.removeAt(ind);
                                      });
                                    },
                                    child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFffd55e),
                                            borderRadius: BorderRadius.circular(100)),
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
                )
                    : Container(
                  height: 0,
                )
              ],
            )
                : Container(
              height: 0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 245,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E2026),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 2,
                  ),
                ],
              ),
              height: 187,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14, top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              typ = "img";
                              videoo = false;
                            });
                            //newwww
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
                              CircleAvatar(
                                backgroundColor: Colors.redAccent[100],
                                radius: 25,
                                child: Image.asset(
                                  "assets/Template1/image/Foodie/icons/image.png",
                                  height: 26,
                                  width: 26,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Image",
                                style: f15w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.teal[300],
                                radius: 25,
                                child: Image.asset(
                                  "assets/Template1/image/Foodie/icons/market.png",
                                  height: 26,
                                  width: 26,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Market",
                                style: f15w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              typ = "video";
                              videoo = true;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.red[900],
                                radius: 25,
                                child: Image.asset(
                                  "assets/Template1/image/Foodie/icons/Videos.png",
                                  height: 26,
                                  width: 26,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Video",
                                style: f15w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.orange[400],
                                radius: 25,
                                child: Image.asset(
                                  "assets/Template1/image/Foodie/icons/Food-Bank-1.png",
                                  height: 26,
                                  width: 26,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Food Bank",
                                style: f15w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          typ = "blog";
                          videoo = false;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.yellowAccent[400],
                            radius: 25,
                            child: Image.asset(
                              "assets/Template1/image/Foodie/icons/blog.png",
                              height: 26,
                              width: 26,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Foodi Blog",
                            style: f15w,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E2026),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 2,
                  ),
                ],
              ),
              height: 56,
              child: Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TimeLine()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/home.png",
                            height: 23,
                            color: Colors.white54,
                            width: 23,
                          ),
                          Text(
                            "Home",
                            style: f14w54,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomChat()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/chat.png",
                            height: 21,
                            color: Colors.white54,
                            width: 21,
                          ),
                          Text(
                            "Chat",
                            style: f14w54,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 42,
                      width: 42,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Form22()));
                        },
                        elevation: 5,
                        backgroundColor: Color(0xFF48c0d9),
                        child: Icon(
                          Icons.add,
                          size: 35,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => purchase()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/shopping-basket.png",
                            height: 23,
                            color: Colors.white54,
                            width: 23,
                          ),
                          Text(
                            "Purchase",
                            style: f14w54,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreenT1()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                              "assets/Template1/image/Foodie/icons/cart.png",
                              height: 23,
                              color: Colors.white54,
                              width: 23),
                          Text(
                            "Cart",
                            style: f14w54,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
List IMAGELIST=[];
var VIDEODATA;





class VideoUploader extends StatefulWidget {
  final File file;
  final String desc;

  VideoUploader({Key key, this.file,this.desc}) : super(key: key);

  createState() => _VideoUploaderState();
}

class _VideoUploaderState extends StateMVC<VideoUploader> {

  TimelineWallController _con;

  _VideoUploaderState() : super(TimelineWallController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startVideoUpload() {

    var nows = DateTime.now();
    String filePath = '${nows.millisecondsSinceEpoch.toString()}.mp4';
    setState(() {
      VIDEODATA=filePath;
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file,StorageMetadata(contentType: 'video/mp4'));
      _video=null;
    });
    if(_uploadTask.isComplete)
      typ=="video" ? _setVal() : typ=="blog" ?_setBlogVal() : Container();
    _showToast();
  }

  _setVal(){
    print("Callllllll 11111111111111111111111");
    uploadownvideoStatus=false;
    _video=null;
    _con.posttimelineOwnVideoPost(
      userid.toString(),
      widget.desc,
      VIDEODATA,
    );
    typ="";
    _video=null;
    // _uploadTask=null;
    return Container();
  }

  _setBlogVal(){
    uploadownvideoStatus=false;
    _con.postBlogVideoPost(
        userid.toString(),
        widget.desc,
        VIDEODATA,
        "blog");
    typ="";
    _video=null;
    // _uploadTask=null;
    return Container();
  }
  _showToast(){
    print("Calllllllll 2222222222222");
    Fluttertoast.showToast(
      msg: "Your video are being uploading. Keep the app open to upload faster. Will notify when uploaded.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.pop(context);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    _startVideoUpload();
    return Container();
  }
}

*/
