/*
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/bottom_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
as repoo;
import 'package:video_player/video_player.dart';
enum AppState {
  free,
  picked,
  cropped,
}
List<File>files=List<File>();
String str = '';
List<String> coments=[],words = [];
String typ = "";
int selectradio;
bool videoo = false;
var blogtype;


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
  List<Asset> images = List<Asset>();
  AppState state;
  File imageFile;
  File _video;
  int selectedRadio;
  VideoPlayerController _videoPlayerController;

  Widget buildGridView() {
    return images.length==2 ?  GridView.count(crossAxisSpacing: 6,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return  AssetThumb(
          asset: asset,
          width: 400,
          height: 400,
        );
      }),
    ) : images.length==1 ? GridView.count(
      crossAxisCount: 1,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return  Stack(
          children: [
            AssetThumb(
              asset: asset,
              width: 400,
              height: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {asset=null;});
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
    ) :
    GridView.count(crossAxisSpacing: 6,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return  AssetThumb(
          asset: asset,
          width: 400,
          height: 400,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(actionBarTitleColor: "#48c0d8",
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
      //print("image list : "+images.length.toString());
    });

  }
  void getFileList() async {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    files.clear();
    for (int i = 0; i < images.length; i++) {
      var path2 = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      //var path = await images[i].filePath;
      print("pppppppppppppppppppppppppppppppppp"+path2);
      var file = await getImageFileFromAsset(path2);
      print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ"+file.toString());
      files.add(file);
    }
  }
  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getUsers();
    state = AppState.free;
    selectedRadio = 1;
  }




  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(file.path);
      state = AppState.picked;
    });
    _cropImage();
  }





  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {_video = video;});
    _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
      setState(() { });
      _videoPlayerController.play();
    });
  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    PickedFile file = await ImagePicker().getVideo(source: ImageSource.camera,maxDuration: Duration(seconds: 50));
    setState(() {_video = File(file.path);});
    _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
      setState(() { });
      _videoPlayerController.play();

    });
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
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
            toolbarColor: Color(0xFF1E2026),
            activeControlsWidgetColor: Color(0xFF48c0d8),
            toolbarWidgetColor: Color(0xFF48c0d8),
            cropGridColor: Color(0xFFffd55e),
            initAspectRatio: CropAspectRatioPreset.original,
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>TimeLine()
              ));
            },
            child: Icon(Icons.arrow_back,)),
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
                        backgroundImage:
                        NetworkImage(userPIC),
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
                    onTap: () {
                      _desc.text.length>0 && typ == "" ? _con.posttimelineDescPost(
                        userid.toString(),
                        _desc.text,
                      ) :  typ == "img" && imageFile != null
                          ? _con.posttimelineWallPost(
                        userid.toString(),
                        _desc.text,
                        imageFile,
                        "image",
                      )
                          : typ == "video"
                          ? _con.posttimelineOwnVideoPost(
                        userid.toString(),
                        _desc.text,
                        _utube.text,
                      )
                          : typ == "blog" && blogtype == "img"
                          ? _con.postBlogPost(userid.toString(),
                          _desc.text, imageFile, "image", "blog")
                          : typ == "blog" && blogtype == "video"
                          ? _con.postBlogVideoPost(userid.toString(),
                          _desc.text, _utube.text, "blog")
                          : null;
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
            typ == "blog" ? Padding(
              padding: const EdgeInsets.only( left: 12, right: 12,bottom: 10),
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
            ) : Container(height: 0,),
            Padding(
              padding: const EdgeInsets.only( left: 12, right: 12),
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFF23252E),
                    borderRadius: BorderRadius.circular(8)),
                child: TextField(
                  controller: _desc,maxLines: 5,
                  // controller: _loc,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "    Write Something Here !!! ? ",
                    hintStyle: f14g,
                  ),
                  onChanged: (val) {
                    setState(() {
                      words = val.split(' ');
                      str = words.length > 0 &&
                          words[words.length - 1].startsWith('@')
                          ? words[words.length - 1]
                          : '';
                    });
                  },
                ),
              ),
            ),
            str.length > 1
                ? ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: repoo.appUsers.map((s){

                  var name= s.split("_");
                  */
/* if(name.length==3)
                {
                  print("id checking 2222");
                  idPass = name[2];
                  print(idPass);
                }*//*

                  var baseUrl = "https://saasinfomedia.com/foodiz/public/user/avatar/";
                  var sendUrl = baseUrl + name[1];
                  if(('@' + name[0]).contains(str))
                    return
                      ListTile(
                          leading: Container(
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    CachedNetworkImageProvider(
                                        sendUrl
                                    ) ,
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(180.0))),
                          ),
                          // leading:Text(name[1],style: TextStyle(color: Colors.blue),),
                          title:Text(name[0],style: TextStyle(color: Colors.white),),
                          onTap:(){
                            String tmp = str.substring(1,str.length);
                            setState((){
                              //idPass = name[2];
                              str ='';
                              _desc.text += name[0].substring(name[0].indexOf(tmp)+tmp.length,name[0].length);

                              */
/* coments.add(_desc.text);*//*


                            });
                          });
                  else return SizedBox();
                }).toList()
            ):SizedBox(),
            SizedBox(height:15),
            images.length>0
                ?
            Container(height: images.length==1 ? 350  :
            images.length==2  ? 170 : images.length==3 ? 100 : images.length>3 ? 200 : images.length>6 ? 300 : 300,
              child: buildGridView(),
            )
                : videoo == true && typ == "video"
                ? Padding(
              padding:
              const EdgeInsets.only( left: 12, right: 12,top: 15),
              child: Column(
                children: <Widget>[
                  _video != null

                      ? Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0, top: 5),
                            child: GestureDetector(
                              onTap: () {
                                _clearVideo();
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
                  )
                      : GestureDetector(
                    onTap: (){
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
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/video_upload.png",
                            height: 32,
                            width: 32,color: Colors.white,
                          ),
                          SizedBox(width: 10,),
                          Text("Upload Video",style: f15w,)

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
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
                            width: MediaQuery.of(context).size.width - 78,
                            child: TextField(
                              maxLines: 4,
                              controller: _utube,
                              // controller: _loc,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Copy Youtube video Link...",
                                  hintStyle: f14g),
                            ),
                          ),
                        ],
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
                  padding: const EdgeInsets.only(top:10,bottom: 10,left: 12,right: 12),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
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
                          width: MediaQuery.of(context).size.width/2.15,
                          decoration: BoxDecoration(
                              color: Color(0xFF23252E),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Template1/image/Foodie/icons/image.png",
                                height: 24,
                                width: 24,color: Colors.white,
                              ),
                              SizedBox(width: 10,),
                              Text("Upload Image",style: f15w,)

                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          blogtype = "video";
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width/2.15,
                          decoration: BoxDecoration(
                              color: Color(0xFF23252E),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Template1/image/Foodie/icons/video_upload.png",
                                height: 23,
                                width: 23,color: Colors.white,
                              ),
                              SizedBox(width: 10,),
                              Text("Upload Video",style: f15w,)

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                blogtype == "video"
                    ? Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 12, right: 12),
                  child: Container(
                    height: 62,
                    width:
                    MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius:
                        BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(
                                top: 8.0),
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
                            width: MediaQuery.of(context)
                                .size
                                .width -
                                78,
                            child: TextField(
                              maxLines: 4,
                              controller: _utube,
                              // controller: _loc,
                              style: TextStyle(
                                  color: Colors.white),
                              decoration: InputDecoration(
                                  border:
                                  InputBorder.none,
                                  hintText:
                                  "Copy Youtube video Link...",
                                  hintStyle: f14g),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : blogtype == "img" &&
                    typ == "blog" &&
                    imageFile != null
                    ? Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(
                            left: 15, right: 15),
                        child: Container(
                          height:
                          MediaQuery.of(context)
                              .size
                              .width,
                          clipBehavior:
                          Clip.antiAlias,
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(
                                    5.0)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(
                                right: 20.0,
                                top: 5),
                            child: GestureDetector(
                              onTap: () {
                                _clearImage();
                              },
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Color(
                                          0xFFffd55e),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
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
                  ),
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
                padding: const EdgeInsets.only(bottom:14,top: 14),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
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
                              SizedBox(height: 4,),
                              Text(
                                "Image",
                                style: f15w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: (){
                          },
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
                              SizedBox(height: 4,),
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
                          onTap: (){
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
                              SizedBox(height: 4,),
                              Text(
                                "Video",
                                style: f15w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: (){},
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
                              SizedBox(height: 4,),
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
                      onTap: (){
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
                          SizedBox(height: 4,),
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
              decoration: BoxDecoration(color: Color(0xFF1E2026),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 2,
                  ),
                ],
              ),
              height: 56,
              child: Padding(
                padding: const EdgeInsets.only(top: 7,bottom: 7),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>TimeLine()
                        ));
                      },
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/home.png",
                            height: 23,
                            color: Colors.white54,
                            width: 23,
                          ),
                          Text("Home",style: f14w54,)
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>BottomChat()
                        ));
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
                          Text("Chat",style: f14w54,)
                        ],
                      ),
                    ),
                    Container(
                      height: 42,
                      width: 42,
                      child: FloatingActionButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>Form22()
                          ));

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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>purchase()
                        ));
                      },
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/Template1/image/Foodie/icons/shopping-basket.png",
                            height: 23,
                            color: Colors.white54,
                            width: 23,
                          ),
                          Text("Purchase",style: f14w54,)
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>CartScreenT1()
                        ));
                      },
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/Template1/image/Foodie/icons/cart.png",
                              height: 23, color: Colors.white54, width: 23),
                          Text("Cart",style: f14w54,)
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

*/
