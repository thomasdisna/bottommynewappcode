import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Link_Page/helper/fetch_preview.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_LocalShop_Add_Product_Page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_orders.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:video_player/video_player.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'Business_LocalShop_Product_List_Page.dart';
import 'business_home_kitchen_timeline.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'business_localshop_chat.dart';
import 'business_localshop_timeline.dart';
const kGoogleApiKey = "AIzaSyABBH07rVnsmRDsmIjtpfHiBuwczmyVyLk";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
var link_url='';
var lng, lat;
var _location;
bool uploadownvideoStatus;
File _video;
String str = '';
List<String> coments = [], words = [];
String typ;
int selectradio;
bool videoo = false;
var blogtype;
var video_type;


class LocalShopNewEntryForm extends StatefulWidget {

  LocalShopNewEntryForm({this.pagid,this.timid,this.memberdate});
  String pagid,timid,memberdate;

  @override
  _LocalShopNewEntryFormState createState() => _LocalShopNewEntryFormState();
}

class _LocalShopNewEntryFormState extends StateMVC<LocalShopNewEntryForm> {
  bool switchControlAll = false;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  int selectedRadio;
  bool switchControlActInact = false;
  var textHolder = 'Switch is OFF';
  File imageFile;
  TextEditingController _desc = TextEditingController();
  TextEditingController _blogTitle = TextEditingController();
  TextEditingController _utube = TextEditingController();
  HomeKitchenRegistration _con;
  _LocalShopNewEntryFormState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

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

  _pickVideoFromCamera() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.camera);
    setState(() {
      _video = video;
    });
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController.play();
        });
      });
  }

  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      imageFile = File(file.path);

    });
    _cropImage();
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
      //print("image list : "+images.length.toString());
    });
  }
  _setCursor() {
    setState(() {
      str = "";
    });
    _desc.selection = TextSelection.fromPosition(
      TextPosition(offset: _desc.text.length),
    );
  }

  void getFileList() async {
    imageList.clear();
    for (int i = 0; i < images.length; i++) {
      var path2 =
      await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var file = await getImageFileFromAsset(path2);
      imageList.add(file);
    }
  }

  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }


  void toggleActiveInactive(bool value) {
    if (switchControlActInact == false) {
      setState(() {
        switchControlActInact = true;
        textHolder = 'Switch is ON';
      });
    } else {
      setState(() {
        switchControlActInact = false;
        textHolder = 'Switch is OFF';
      });
    }
  }

  @override
  void initState() {
     _con.getUsers();
    // TODO: implement initState
    super.initState();
    // _con.LocalStoreGetProfile(widget.pagid);
    setState(() {
      link_url='';
      imageList = [];
      _location = "";
      IMAGELISTS = [];
      _location = "";
      lng = "";
      lng = "";
      images = [];
      uploadownvideoStatus = false;
      typ = "";
    });
    selectedRadio = 1;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void toggleActivateAll(bool value) {
    if (switchControlAll == false) {
      setState(() {
        switchControlAll = true;
        textHolder = 'Switch is ON';
      });
    } else {
      setState(() {
        switchControlAll = false;
        textHolder = 'Switch is OFF';
      });
    }
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);
      setState(() {
        lat = detail.result.geometry.location.lat;
        lng = detail.result.geometry.location.lng;
      });
    }
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
    print("BBBBBBBBBBBBBBBBBBBBBBB 1111111111111111111111111");
    setState(() {
      IMAGELISTS=[];
    });
    for (var i = 0; i < imageList.length; i++) {
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELISTS.add(filePath);
        // _uploadTask = _storage.ref().child(filePath).putFile(IMAGELISTS[i]);
      });
    }
    _imagBlogUpload();
  }

  _imagBlogUpload() {
    _location.toString().length > 5 && _utube.text == null && _utube.text.isEmpty
        ? _con.postBlogPost1(context,widget.pagid, _desc.text,_blogTitle.text, IMAGELISTS.join(",").toString(), "image", "blog",
        _location, lat, lng,widget.timid,widget.memberdate,"2")
        :  _location.toString().length > 5 && _utube.text != null && _utube.text.isNotEmpty ? _con.postBlogPost4(context,widget.pagid,
        _desc.text,_blogTitle.text, IMAGELISTS.join(",").toString(), "image", "blog",
        _location, lat, lng,widget.timid,widget.memberdate,"2",_utube.text) :  _location.toString().isEmpty && _utube.text != null &&
        _utube.text.isNotEmpty ? _con.postBlogPost3(context,widget.pagid.toString(), _desc.text,_blogTitle.text,
        IMAGELISTS.join(",").toString(), "image", "blog",widget.timid,widget.memberdate,"2",_utube.text) : _con.postBlogPost2(context,widget.pagid.toString(),
        _desc.text,_blogTitle.text, IMAGELISTS.join(",").toString(), "image", "blog",widget.timid,widget.memberdate,"2");
    typ = "";
    _video = null;
    // _uploadTask=null;
    return Container();
  }

  _startUpload() {
    setState(() {
      IMAGELISTS=[];
    });
    for (var i = 0; i < imageList.length; i++) {
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELISTS.add(filePath);
        // _uploadTask = _storage.ref().child(filePath).putFile(IMAGELISTS[i]);
      });
    }
    _imagUpload();
  }

  _imagUpload() {

    _location.toString().length > 5
        ? _con.posttimelineWallPost1(context,widget.pagid, _desc.text,
        IMAGELISTS.join(",").toString(), "image", _location, lat, lng,widget.timid,widget.memberdate,"2")
        : _con.posttimelineWallPost2(context,
      widget.pagid,
      _desc.text,
      IMAGELISTS.join(",").toString(),
      "image",widget.timid,widget.memberdate,"2"
    );

    typ = "";
    _video = null;

    // _uploadTask=null;
    return Container();
  }

  setUpdate() {
    return Container();
  }

  VideoPlayerController _videoPlayerController;

  final _linkRegex = RegExp(
      r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)",
      caseSensitive: false);
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                            backgroundImage: CachedNetworkImageProvider(
                              Bus_Profile.toString()
                            ),
                          ) ,
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text(
                                Bus_NAME.toString(),
                                style: f15wB,
                              ) ,
                              _location != ""
                                  ? Container(
                                width:
                                MediaQuery.of(context).size.width - 156,
                                child: Text(
                                  "In " + _location.toString(),
                                  style: f13g,
                                ),
                              )
                                  : Container(),
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_desc.text.length > 0 && typ == "") {

                            final sentences = _desc.text.split('\n');
                            if (_desc.text.contains("https") == true ||
                                _desc.text.contains("http") == true) {
                              Fluttertoast.showToast(
                                  msg: "plz w8.Generating thumb... ",
                                  backgroundColor: Color(0xFF48c0d8),
                                  gravity: ToastGravity.TOP,
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: Colors.white);
                              sentences.forEach((sentence) {
                                final words = sentence.split(' ');
                                words.forEach((word) {
                                  if (_linkRegex.hasMatch(word)) {
                                    setState(() {
                                      var url = word.toString();
                                      FetchPreview().fetch(url).then((res) {
                                        setState(() {
                                          var data = res;
                                          Fluttertoast.showToast(
                                            msg: "Uploading Post",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 35,
                                            backgroundColor: Color(0xFF48c0d8),
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          _location.toString().length > 5
                                              ? _con.posttimelineDescPost2(context,
                                              widget.pagid,
                                              _desc.text,
                                              _location,
                                              lat,
                                              lng,
                                              data['image'].toString(),
                                              data['title'].toString(),
                                              data['description'].toString(),data['site'].toString(),url,widget.timid,widget.memberdate,"2")
                                              : _con.posttimelineDescPost1(context,
                                             widget.pagid,
                                              _desc.text,
                                              data['image'].toString(),
                                              data['title'].toString(),
                                              data['description'].toString(),data['site'].toString(),url,widget.timid,widget.memberdate,"2");
                                        });
                                      });
                                    });
                                  }
                                });
                              });
                            } else {

                              _location.toString().length > 5
                                  ? _con.posttimelineDescPost2(context,widget.pagid,
                                  _desc.text, _location, lat, lng, "", "", "","","",widget.timid,widget.memberdate,"2")
                                  : _con.posttimelineDescPost1(context,
                                  widget.pagid, _desc.text, "", "", "","","",widget.timid,widget.memberdate,"2");
                            }
                          } else if (imageList.length > 0 && typ == "img") {
                            _startUpload();
                          } else if (typ == "video") {
                            if (video_type == "own video" && _video != null) {
                              setState(() {
                                uploadownvideoStatus = true;
                              });
                            }
                            if (video_type == "utube") {
                              _location.toString().length > 5
                                  ? _con.posttimelineUTubeVideoPost1(context,
                                  widget.pagid,
                                  _desc.text,
                                  _utube.text,
                                  _location,
                                  lat,
                                  lng,widget.timid,widget.memberdate,"2")
                                  : _con.posttimelineUTubeVideoPost2(context,
                               widget.pagid,
                                _desc.text,
                                _utube.text,widget.timid,widget.memberdate,"2"
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
                          } else if (typ == "blog" && blogtype == "img") {
                            _startBlogImageUpload();
                          } else if (typ == "blog" &&
                              blogtype == "video" &&
                              _video != null) {
                            setState(() {
                              uploadownvideoStatus = true;
                            });
                          } else
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
                uploadownvideoStatus == true
                    ? VideoUploader(
                  file: _video,
                  desc: _desc.text,pag: widget.pagid,
                )
                    : Container(),
                typ == "blog"
                    ? Padding(
                  padding:
                  const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[800],
                          width: 1,),
                        color: Color(0xFF23252E),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: TextField(
                        controller: _blogTitle,
                        maxLines: 5,
                        // controller: _loc,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                            border: InputBorder.none,
                            hintText: "Write Blog Title... ",
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
                            border: Border.all(color: Colors.grey[800],
                              width: 1,),
                            color: Color(0xFF23252E),
                            borderRadius: BorderRadius.circular(8)),
                        child: HashTagTextField(
                          showCursor: true,
                          // focusNode: myFocusNode,
                          controller: _desc,
                          expands: true,
                          onChanged: (val) {
                            final sentences = val.split('\n');
                            sentences.forEach((sentence) {
                              final words = sentence.split(' ');
                              words.forEach((word) {
                                if (_linkRegex.hasMatch(word)) {
                                  setState(() {
                                    link_url = word;

                                  });
                                }
                              });
                            });
                            setState(() {

                              words = val.split(' ');
                              str = words.length > 0 &&
                                  words[words.length - 1].startsWith('@')
                                  ? words[words.length - 1]
                                  : '';

                            });

                          },
                          maxLines: null,
                          minLines: null,
                          autocorrect: true,
                          // controller: _loc,
                          basicStyle: TextStyle(color: Colors.white, fontSize: 14),
                          decoratedStyle:
                          TextStyle(color: Colors.blue, fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            border: InputBorder.none,
                            hintText: "Write Something Here !!! ? ",
                            hintStyle: f14g,
                          ),
                        ),
                      ),
                    ),
                    str.length > 1
                        ? Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        color: Color(0xFF1E2026),
                        child:
                        /*ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: _con.userListNamespace.map((s) {
                              var sendUrl =_con.userListNamespace['picture'];
                              if (('@' + _con.userListNamespace['username']).contains(str))
                                return ListTile(
                                    leading: Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                              _con.userListNamespace['picture']!="" && _con.userListNamespace['picture']!=null?  CachedNetworkImageProvider(sendUrl.toString().replaceAll(" ", "%20")+"?alt=media") : CachedNetworkImageProvider( "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV"),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(180.0))),
                                    ),
                                    title: Text(
                                      _con.userListNamespace['username'],
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () {
                                      String tmp = str.substring(1, str.length);
                                      setState(() {
                                        //idPass = name[2];
                                        str = '';
                                        _desc.text=_desc.text+ _con.userListNamespace['username'].substring(
                                            _con.userListNamespace['username'].indexOf(tmp) + tmp.length,
                                            _con.userListNamespace['username'].length);

                                        */ /* coments.add(_desc.text);*/ /*
                                      });
                                      myFocusNode.requestFocus();

                                    });
                              else
                                return SizedBox();
                            }).toList())*/
                        Container(
                          height: 200,
                          child: ListView.builder(
                              itemCount: _con.userListNamespace.length,
                              itemBuilder: (context, ind) {
                                return ('@' +
                                    _con.userListNamespace[ind]
                                    ['username'])
                                    .contains(str)
                                    ? ListTile(
                                    leading: Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: _con.userListNamespace[ind]['picture'] !=
                                                  "" &&
                                                  _con.userListNamespace[ind]['picture'] !=
                                                      null
                                                  ? CachedNetworkImageProvider(_con
                                                  .userListNamespace[ind]
                                              ['picture']
                                                  .toString()
                                                  .replaceAll(
                                                  " ", "%20") +
                                                  "?alt=media")
                                                  : CachedNetworkImageProvider(
                                                  "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV"),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(180.0))),
                                    ),
                                    title: Text(
                                      _con.userListNamespace[ind]
                                      ['username'],
                                      style:
                                      TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () {
                                      String tmp =
                                      str.substring(1, str.length);
                                      setState(() {
                                        str = '';
                                        _desc.text = _desc.text +
                                            _con.userListNamespace[ind]
                                            ['username']
                                                .substring(
                                                _con.userListNamespace[
                                                ind][
                                                'username']
                                                    .indexOf(
                                                    tmp) +
                                                    tmp.length,
                                                _con
                                                    .userListNamespace[
                                                ind]
                                                ['username']
                                                    .length);
                                      });
                                      _setCursor();
                                      // myFocusNode.requestFocus();
                                    })
                                    : Container();
                              }),
                        ),
                      ),
                    )
                        : SizedBox(),
                  ],
                ),
                SimpleUrlPreview(
                  url: link_url,
                  textColor: Colors.white,
                  bgColor: Colors.grey[800],
                  isClosable: true,
                  titleLines: 2,
                  descriptionLines: 3,
                  imageLoaderColor: Colors.white,
                  previewHeight: 156,
                  previewContainerPadding: EdgeInsets.all(10),
                  onTap: () => print('Hello Flutter URL Preview'),
                ),
                SizedBox(height: 15),
                (imageList.length > 0 && typ == "img")
                    ? Container(
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
                          setState(() {
                            video_type = "own video";
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
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[800],
                                width: 1,),
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
                        onTap: () {
                          setState(() {
                            video_type = "utube";
                          });
                        },
                        child: Container(
                          height: 62,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[800],
                                width: 1,),
                              color: Color(0xFF23252E),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0),
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
                                  width:
                                  MediaQuery.of(context).size.width -
                                      78,
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        video_type = "utube";
                                      });
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
                            setState(() {  blogtype = "img";});
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
                              width:
                              MediaQuery.of(context).size.width /
                                  2.15,
                              decoration: BoxDecoration(
                                  color: Color(0xFF23252E),
                                  border: Border.all(color: Colors.grey[800],
                                    width: 1,),
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
                              setState(() {
                                blogtype = "video";
                                videoo = true;
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
                                  border: Border.all(color: Colors.grey[800],
                                    width: 1,),
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
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 12, right: 12),
                      child: Container(
                        height: 62,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[800],
                              width: 1,),
                            color: Color(0xFF23252E),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 8.0),
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
                                width:
                                MediaQuery.of(context).size.width -
                                    78,
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      video_type = "utube";
                                    });
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
                    blogtype == "video" &&
                        typ == "blog" &&
                        _video != null
                        ? Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: _videoPlayerController
                              .value.aspectRatio,
                          child: VideoPlayer(
                              _videoPlayerController),
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
                                        color:
                                        Color(0xFFffd55e),
                                        borderRadius:
                                        BorderRadius
                                            .circular(100)),
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
                        imageList.length > 0
                        ? Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageList.length,
                          itemBuilder: (context, ind) {
                            return Stack(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 15,
                                      right: 15),
                                  child: Container(
                                    height: 80,
                                    width: 110,
                                    clipBehavior:
                                    Clip.antiAlias,
                                    child: Image.file(
                                      imageList[ind],
                                      fit: BoxFit.cover,
                                    ),
                                    decoration:
                                    BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius
                                              .circular(
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
                                      const EdgeInsets
                                          .only(
                                          left: 93.0,
                                          top: 5),
                                      child:
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            imageList
                                                .removeAt(
                                                ind);
                                          });
                                        },
                                        child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                color: Color(
                                                    0xFFffd55e),
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
            typ=="" ?    Padding(
              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height- 330),
              child: Container(
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
                                types: ["(cities)"],
                              );
                              displayPrediction(p, homeScaffoldKey.currentState);
                              _location = p.description.toString();
                              // displayPrediction(p);
                              var a = p.types;
                              var b = a[2];
                            },
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  radius: 25,
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/location.png",
                                    height: 26,
                                    width: 26,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Check in",
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
                          SizedBox(height: 15,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>BusinessLocalShopAddProductPage(timid: widget.timid,pagid: widget.pagid,memberdate: widget.memberdate,)
                              ));
                            },
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.teal[300],
                                  radius: 25,
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/add-item.png",
                                    height: 23,
                                    width: 23,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Add Product",
                                  style: f15w,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
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
                                  "Blog",
                                  style: f15w,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ) : Padding(
              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height- 208),
              child: InkWell(
                onTap: (){
                  setState(() {
                    typ="";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1E2026),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14, top: 14),
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.redAccent[100],
                          radius: 21,
                          child: Image.asset(
                            "assets/Template1/image/Foodie/icons/image.png",
                            height: 21,
                            width: 21,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red[900],
                          radius: 21,
                          child: Image.asset(
                            "assets/Template1/image/Foodie/icons/Videos.png",
                            height: 21,
                            width: 21,
                            color: Colors.white,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.yellowAccent[400],
                          radius: 21,
                          child: Image.asset(
                            "assets/Template1/image/Foodie/icons/blog.png",
                            height: 21,
                            width: 21,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          radius: 21,
                          child: Image.asset(
                            "assets/Template1/image/Foodie/icons/location.png",
                            height: 21,
                            width: 21,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.teal[300],
                          radius: 21,
                          child: Image.asset(
                            "assets/Template1/image/Foodie/icons/add-item.png",
                            height: 19,
                            width: 19,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



var VIDEODATA;

class VideoUploader extends StatefulWidget {
  final File file;
  final String desc,pag;

  VideoUploader({Key key, this.file, this.desc,this.pag}) : super(key: key);

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
    getHomeKitpageTime();
    _startVideoUpload();
  }
  getHomeKitpageTime() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pageid_LocalStore = prefs.getString('LS_page_id');
  }
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startVideoUpload() {
    var nows = DateTime.now();
    String filePath = '${nows.microsecondsSinceEpoch.toString()}.mp4';
    setState(() {
      VIDEODATA = filePath;
      _uploadTask = _storage
          .ref()
          .child(filePath)
          .putFile(widget.file, StorageMetadata(contentType: 'video/mp4'));
    });
  }

  _setVal() {
    uploadownvideoStatus = false;
    Fluttertoast.showToast(
      msg: "Uploading Post",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    _location.toString().length > 5
        ? _con.foodieVideoPost(context,
        widget.pag, widget.desc, VIDEODATA, _location, lat, lng)
        : _con.posttimelineOwnVideoPost2(context,
     widget.pag,
      widget.desc,
      VIDEODATA,""
    );

    typ = "";
    _video = null;
    // _uploadTask=null;
    return Container();
  }

  _setBlogVal() {
    uploadownvideoStatus = false;
    _location.toString().length > 5
        ? _con.postBlogVideoPost1(context,widget.pag, widget.desc, VIDEODATA,
        "blog", _location, lat, lng)
        : _con.postBlogVideoPost2(context,
      widget.pag,
      widget.desc,
      VIDEODATA,
      "blog",
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

    typ = "";
    _video = null;
    // _uploadTask=null;
    return Container();
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
                    typ == "video"
                        ? _setVal()
                        : typ == "blog" ? _setBlogVal() : Container()
                  else
                    Column(
                      children: [
                        Text(
                          "Uploading Video",
                          style: f15yB,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        LinearProgressIndicator(
                          value: progressPercent,
                          backgroundColor: Colors.grey,
                          minHeight: 4,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                ]);
          });
    }
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black87))),
        child: InkWell(
          splashColor: Colors.black45,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: f14w,
                      ),
                    ),
                  ],
                ),
                //Icon(Icons.arrow_right, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}