import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/VIMEO/trimming.dart';
import 'package:path/path.dart' as ppp;
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/FIREBASE/chatlist.dart';
import 'package:Butomy/Link_Page/helper/fetch_preview.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_food_bank_form.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_foodi_market_form.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';

const kGoogleApiKey = "AIzaSyAm22_7Hj0aHN09DvP-VmaXSk64dm1WSfg";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
enum AppState {
  free,
  picked,
  cropped,
}
var link_url='';
var lng, lat;
var _location;
bool uploadownvideoStatus;

String str = '';
List<String> coments = [], words = [];
String typ;
int selectradio;
bool videoo = false;
var blogtype;
var video_type;


class AddNewEntries extends StatefulWidget {

  String videooo;
  bool vid_show;
  String typpp;

  AddNewEntries({this.vid_show,this.videooo,this.typpp});

  @override
  _AddNewEntriesState createState() => _AddNewEntriesState();
}

class _AddNewEntriesState extends StateMVC<AddNewEntries>  with SingleTickerProviderStateMixin {

  AnimationController _progress;
  Animation<double> animation;
  TimelineWallController _con;

  _AddNewEntriesState() : super(TimelineWallController()) {
    _con = controller;
  }

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _desc = TextEditingController();
  TextEditingController _blogTitle = TextEditingController();
  TextEditingController _utube = TextEditingController();
  TextEditingController _itemtitle = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _loc = TextEditingController();
  TextEditingController _description = TextEditingController();

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      setState(() {
        lat = detail.result.geometry.location.lat;
        lng = detail.result.geometry.location.lng;
      });
      print("llllllaaaaaaaaattttttt "+lat.toString());
      print("llllllongggg "+lng.toString());
    }
  }

  AppState state;
  File imageFile;
  int selectedRadio;


  videooooWidooo(){
    print("VIDEOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO -> "+widget.videooo);

    setState(() {
      typ = widget.typpp;
      video_type = typ =="video" ? "own video" : "video";
      videoo = true;
      videoooooooooooo = VideoPlayerController.file(File(widget.videooo))
        ..initialize().then((_) {
          setState(() {
            videoooooooooooo.pause();
          });
        });
      _isPlaying = false;
    });
  }
bool _isPlaying;


  @override
  void initState() {
   /* videoooooooooooo = VideoPlayerController.file(videooooWid)
      ..initialize().then((_) {
        setState(() {
          videoooooooooooo.pause();
        });
      });*/
    setState(() {
      typ = "";
      daaaaaaaaaaaaa = false;

      _isPlaying = false;
      videooooWid = null;
    });
    _con.getUsers();
    _con.getMarketCategories("2");
    myFocusNode = FocusNode();
    myFocusNode2 = FocusNode();
    widget.vid_show ? videooooWidooo() : null;
    // TODO: implement initState
    super.initState();
    setState(() {
      blogVideoSet = "0";
      _con.MarketKitchenCategories=MKitCat;
      link_url='';
      imageList = [];
      _location = "";
      IMAGELISTS = [];
      _location = "";
      lng = "";
      lng = "";
      images = [];
      uploadownvideoStatus = false;
    });

    _progress = AnimationController(
        duration: const Duration(milliseconds: 2000), );
    animation = Tween(begin: 0.0, end: 1.0).animate(_progress)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    _progress.repeat();
    state = AppState.free;
    selectedRadio = 1;
  }
  var selected_category;
  var selected_sub_category;
  var selected_category_id;
  var selected_sub_category_id;

  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      imageFile = File(file.path);

      state = AppState.picked;
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

  bool autofo;
  FocusNode myFocusNode2;

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

  final Trimmer _trimmer = Trimmer();


  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    // setState(() {
    //   videooooWid = video;
    // });

    if(video!=null)
   { await _trimmer.loadVideo(videoFile: video);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return TrimmerView(_trimmer,typ);
        }));}
    // videoooooooooooo = VideoPlayerController.file(videooooWid)
    //   ..initialize().then((_) {
    //     setState(() {});
    //     videoooooooooooo.play();
    //   });
  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.camera);
    if(video!=null)
    { await _trimmer.loadVideo(videoFile: video);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return TrimmerView(_trimmer,typ);
        }));}
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
        state = AppState.cropped;
        imageFile = null;
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
      widget.videooo = null;
      videooooWid = null;
      videoooooooooooo.pause();
      widget.vid_show = false;
    });
  }

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startBlogImageUpload() {
    print("imageeee listtttt "+imageList.toString());
    setState(() {
      IMAGELISTS=[];
    });
    if(imageList.length>0)
    {
    for (var i = 0; i < imageList.length; i++) {
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELISTS.add(filePath);
      });
    }}
    _imagBlogUpload();
  }

  _imagBlogUpload() {
      _con.foodieBlog(context,userid.toString(),_blogTitle.text,_desc.text,IMAGELISTS.length>0 ? "image" : "",
        IMAGELISTS.join(",").toString(),_utube.text,_location,lat,lng);

    /*_location.toString().length > 5 && _utube.text == null && _utube.text.isEmpty
        ? _con.postBlogPost1(userid.toString(), _desc.text, IMAGELISTS.join(",").toString(), "image", _location, lat, lng,_blogTitle.text)
        :  _location.toString().length > 5 && _utube.text != null && _utube.text.isNotEmpty  && video_type == "utube"?
    _con.postBlogPost4(userid.toString(), _desc.text, IMAGELISTS.join(",").toString(), "image", _location, lat, lng,_blogTitle.text,_utube.text)
        : _location.toString().isEmpty && _utube.text != null && _utube.text.isNotEmpty && video_type == "utube" ?
    _con.postBlogPost3(userid.toString(), _desc.text, IMAGELISTS.join(",").toString(), "image",_blogTitle.text,_utube.text)
        :_con.postBlogPost2(userid.toString(), _desc.text, IMAGELISTS.join(",").toString(), "image",_blogTitle.text);
        */
    return Container();
  }

  _blogImageWithVideoUpload() {
    setState(() {
      daaaaaaaaaaaaa = true;
    });
    print("imageeee listtttt "+imageList.toString());
    setState(() {
      IMAGELISTS=[];
    });
    if(imageList.length>0)
    {for (var i = 0; i < imageList.length; i++) {
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELISTS.add(filePath);
        _uploadTask = _storage.ref().child(filePath).putFile(imageList[i]);
      });
    }}
    _imagBlogVideoUpload();
  }

  _imagBlogVideoUpload() {
    _con.foodieBlogVideo(context,userid.toString(),_blogTitle.text,_desc.text,IMAGELISTS.length>0 ? "image" : "",
        IMAGELISTS.join(",").toString(),videooooWid.path,_location,lat,lng);
    return Container();
  }



  _BlogVideoUpload() {
    setState(() {
      daaaaaaaaaaaaa = true;
    });
    _location.toString().length > 5  && widget.vid_show
        ? _con.postBlogwithvideo(context,
        userid.toString(),
        _desc.text,
        "video",_blogTitle.text,widget.videooo,
        _location,
        lat,
        lng)
        :   _con.postBlogwithvideo2(context,
        userid.toString(),
        _desc.text,
        "video",_blogTitle.text,widget.videooo,"") ;
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
        // _uploadTask = _storage.ref().child(filePath).putFile(imageList[i]);
      });
    }
    _imagUpload();
  }

  _startOwnVideoUpload() {
    setState(() {
      daaaaaaaaaaaaa = true;
    });
    _con.foodieVideoPost(context,
        userid.toString(), _desc.text, videooooWid.path, _location, lat, lng);
  }

  _imagUpload() {
    print("lllllllllllllllllllllll "+lat.toString()+" "+lng.toString()+" lo "+_location.toString());
    _location.toString().length > 5
        ? _con.posttimelineWallPost1(context,userid.toString(), _desc.text,
            IMAGELISTS.join(",").toString(), "image", _location, lat, lng)
        : _con.posttimelineWallPost2(context,
            userid.toString(),
            _desc.text,
            IMAGELISTS.join(",").toString(),
            "image",
          );

    typ = "";
    videooooWid = null;

    // _uploadTask=null;
    return Container();
  }

  setUpdate() {
    return Container();
  }

  final _linkRegex = RegExp(
      r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)",
      caseSensitive: false);

  _startVideoUpload() {
    var nows = DateTime.now();
    String filePath = '${nows.microsecondsSinceEpoch.toString()}.mp4';
    setState(() {
      VIDEODATA = filePath;
      _uploadTask = _storage
          .ref()
          .child(filePath)
          .putFile(videooooWid, StorageMetadata(contentType: 'video/mp4'));
    });
  }



  FocusNode myFocusNode;

  _setCursor() {
    setState(() {
      str = "";
    });
    _desc.selection = TextSelection.fromPosition(
      TextPosition(offset: _desc.text.length),
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    _progress.stop();
    super.dispose();
  }

  String blogVideoSet = "0";


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        if(daaaaaaaaaaaaa ==true){
          return  (await showDialog(
            context: context,
            builder: (context) =>
            new AlertDialog(backgroundColor: Color(0xFF1E2026),
              contentPadding: EdgeInsets.only(top: 10, left: 10),
              title: Image.asset(
                "assets/Template1/image/Foodie/logo.png",height: 18,alignment: Alignment.topLeft,
              ),
              titlePadding: EdgeInsets.all(10),
              content: new Text("Your Video Post is uploading...\nAre you sure to go back?\n\nwarning: Your Video will be Cancelled!!!",
                  style: f15w),
              actions:
              <Widget>[
                MaterialButton(
                  height: 28,
                  color: Color(0xFFffd55e),
                  child: new Text(
                    "No",
                    style: TextStyle(
                        color: Colors
                            .black),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),

                ),
                SizedBox(width: 15,),
                MaterialButton(
                  height: 28,
                  color: Color(0xFF48c0d8),
                  child: new Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors
                            .black),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],

            ),
          ));}
        else{
          return new Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
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
              daaaaaaaaaaaaa ? LinearProgressIndicator(
                backgroundColor: Color(0xFFffd55e),
                valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF48c0d8)),
                value: animation.value,
              ) : Container(),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              NAME.toString(),
                              style: f15wB,
                            ),
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
                                msg: "plz wait Generating thumb",
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
                                        print("uuuuuuuuuuurrrrrrrrrrrllllllll %%%%%%%%%%%%%%%%%%%%"+urlPost.toString());
                                        print("urlll 1111111111111111 : "+urlPost.toString());
                                        _location.toString().length > 5
                                            ? _con.posttimelineDescPost2(context,
                                                userid.toString(),
                                                _desc.text,
                                                _location,
                                                lat,
                                                lng,
                                                urlPost.toString(),
                                                data['title'].toString(),
                                                data['description'].toString(),data['site'].toString(),url,)
                                            : _con.posttimelineDescPost1(context,
                                                userid.toString(),
                                                _desc.text,
                                                urlPost.toString(),
                                                data['title'].toString(),
                                                data['description'].toString(),data['site'].toString(),url,);
                                      });
                                    });
                                  });
                                }
                              });
                            });
                          } else {
                            _location.toString().length > 5
                                ? _con.posttimelineDescPost2(context,userid.toString(),
                                    _desc.text, _location, lat, lng, "", "", "","","",)
                                : _con.posttimelineDescPost1(context,
                                    userid.toString(), _desc.text, "", "", "","","",);
                          }
                        }
                        else if (imageList.length > 0 && typ == "img") {
                          _startUpload();
                        }
                        else if (typ == "video") {
                          if (video_type == "own video" && videooooWid!=null) {
                            _startOwnVideoUpload();
                          }
                          if (video_type == "utube" && videooooWid==null) {
                            _con.foodieYoutubePost(context,userid.toString(), _desc.text, _utube.text, _location, lat, lng);
                          }
                        }
                        else if (typ == "blog" ) {
                          if(videooooWid ==null)
                           { _startBlogImageUpload();}
                          if(videooooWid !=null)
                            {
                              _blogImageWithVideoUpload();
                            }
                         /* if(imageList.length >0 && blogtype == "img" &&video_type!="video")
                           {_startBlogImageUpload();}
                           if(imageList.length >0 && video_type=="video" && widget.vid_show==true)
                             {
                               _blogImageWithVideoUpload();
                             }
                           if(imageList.length ==0 &&  widget.vid_show==true)
                             {
                               _BlogVideoUpload();
                             }*/
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
                          color: Color(0xFF23252E),
                          border: Border.all(color: Colors.grey[800],
                            width: 1,),
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
                        // keyboardType: TextInputType.streetAddress,
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
                  :  typ == "video"
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 12, right: 12, top: 15),
                          child: Column(
                            children: <Widget>[
                             /*videooooWid !=null  && typ == "video"
                                  ? Stack(
                                      children: [
                                        Stack(alignment: Alignment.center,
                                          children: [
                                            AspectRatio(
                                              aspectRatio: videoooooooooooo
                                                  .value.aspectRatio,
                                              child:
                                                  VideoPlayer(videoooooooooooo),
                                            ),
                                            FlatButton(
                                              child: _isPlaying
                                                  ? Icon(
                                                Icons.pause,
                                                size: 80.0,
                                                color: Colors.white,
                                              )
                                                  : Icon(
                                                Icons.play_arrow,
                                                size: 80.0,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isPlaying = !_isPlaying;
                                                  if(_isPlaying)
                                                  {  videoooooooooooo.play();}
                                                  else
                                                  {
                                                    videoooooooooooo.pause();
                                                  }
                                                });

                                              },
                                            )
                                          ],
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
                                        ),

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
                              ),*/
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
                                      color: Color(0xFF23252E),
                                      border: Border.all(color: Colors.grey[800],
                                        width: 1,),
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
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            blogtype = "img";
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
                                          height: 55,
                                          width:
                                              MediaQuery.of(context).size.width-24,
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
                                     /* blogVideoSet == "0" ? SizedBox(width: 3,) : Container(),
                                      blogVideoSet == "0" ? GestureDetector(
                                        onTap: () {

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SimpleDialog(
                                                  backgroundColor:
                                                      Color(0xFF1E2026),
                                                  title: Text('Video / Youtube',
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
                                                        setState(() {
                                                          videoo = true;
                                                          video_type = "video";
                                                        });
                                                        _pickVideo();
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Video From Gallery',
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
                                                        setState(() {
                                                          myFocusNode2.requestFocus();
                                                          blogVideoSet = "1";
                                                          video_type = "utube";
                                                        });
                                                        // _pickVideoFromCamera();
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          'Youtube Video',
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
                                      ) : Container(),*/
                                    ],
                                  ),
                                ),
                               /* blogVideoSet == "1" ?*/
                                Padding(
                                  padding: const EdgeInsets.only(
                                       bottom: 10, left: 12, right: 12),
                                  child: Container(
                                    height: 62,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF23252E),
                                        border: Border.all(color: Colors.grey[800],
                                          width: 1,),
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
                                              focusNode: myFocusNode2,
                                              style: TextStyle(color: Colors.white),
                                              decoration: InputDecoration(

                                                contentPadding: EdgeInsets.symmetric(vertical: 10),
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
                                ) /*: Container()*/,
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
                                ),
                                video_type == "video" &&
                                        typ == "blog" &&
                                    videooooWid !=null
                                    ? Stack(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              AspectRatio(
                                                aspectRatio: videoooooooooooo
                                                    .value.aspectRatio,
                                                child: VideoPlayer(
                                                    videoooooooooooo),
                                              ),
                                              FlatButton(
                                                child: _isPlaying
                                                    ? Icon(
                                                  Icons.pause,
                                                  size: 80.0,
                                                  color: Colors.white,
                                                )
                                                    : Icon(
                                                  Icons.play_arrow,
                                                  size: 80.0,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isPlaying = !_isPlaying;
                                                    if(_isPlaying)
                                                    {  videoooooooooooo.play();}
                                                    else
                                                    {
                                                      videoooooooooooo.pause();
                                                    }
                                                  });

                                                },
                                              )
                                            ],
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
                                    : Container()

                              ],
                            )
                          : Container(
                              height: 0,
                            ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height:  typ=="" ? 245 : 131,
          child: Column(
            children: [
              typ=="" ?   Container(
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
                            onTap: () {
                              /*setState(() {
                                typ="market";
                              });*/
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => FoodiMarketForm()
                              ));
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
                            onTap: () {
                             /* setState(() {
                                typ="bank";
                              });*/
                             Navigator.push(context, MaterialPageRoute(
                               builder: (context) => FoodBankForm()
                             ));
                            },
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
                                  "Foodi Blog",
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
                                onError: (error){
                                  print("errrooorrr "+error.status);
                                  print("errrooorrr msg"+error.errorMessage);
                                },
                                mode: Mode.overlay,
                                // Mode.fullscreen
                                language: "IN",
                                components: [
                                  new Component(Component.country, "IN")
                                ],

                              );
                              displayPrediction(p, homeScaffoldKey.currentState);
                              _location = p.description.toString();
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
                      )
                    ],
                  ),
                ),
              ) :
              InkWell(
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
                  height: 75,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.redAccent[100],
                        radius: 20,
                        child: Image.asset(
                          "assets/Template1/image/Foodie/icons/image.png",
                          height: 19,
                          width: 19,
                          color: Colors.black,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red[900],
                        radius: 20,
                        child: Image.asset(
                          "assets/Template1/image/Foodie/icons/Videos.png",
                          height: 18,
                          width: 18,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.yellowAccent[400],
                        radius: 20,
                        child: Image.asset(
                          "assets/Template1/image/Foodie/icons/blog.png",
                          height: 17,
                          width: 17,
                          color: Colors.black,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.teal[300],
                        radius: 20,
                        child: Image.asset(
                          "assets/Template1/image/Foodie/icons/market.png",
                          height: 19,
                          width: 19,
                          color: Colors.black,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.orange[400],
                        radius: 20,
                        child: Image.asset(
                          "assets/Template1/image/Foodie/icons/Food-Bank-1.png",
                          height: 18,
                          width: 18,
                          color: Colors.black,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        radius: 20,
                        child: Image.asset(
                          "assets/Template1/image/Foodie/icons/location.png",
                          height: 20,
                          width: 20,
                          color: Colors.black,
                        ),
                      ),
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
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeLine(false)), (route) => false);
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
                                  builder: (context) =>
                                      ChatList(timelineIdFoodi.toString(), NAME)));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(alignment: Alignment.topRight,
                              children: [
                                Container(width: 38,
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/chat.png",
                                    height: 21,
                                    color: Colors.white54,
                                    width: 21,
                                  ),
                                ),
                                chatmsgcount>0 ?  Container(
                                  height: 14,width: 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0dc89e),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(child: Text(chatmsgcount.toString(),style: f10B,textAlign: TextAlign.center,)),
                                ) : Container()
                              ],
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
                            Stack(alignment: Alignment.topRight,
                              children: [
                                Container(width: 40,
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/shopping-basket.png",
                                    height: 23,
                                    color: Colors.white54,
                                    width: 23,
                                  ),
                                ),
                                purchasecount>0 ? Container(
                                  height: 14,width: 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0dc89e),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(child: Text(purchasecount.toString(),style: f10B,textAlign: TextAlign.center,)),
                                ) : Container()
                              ],
                            ),
                            Text(
                              "Bucket list",
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
                                  builder: (context) => CartScreenT1(null,null,false)));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(alignment: Alignment.topRight,
                              children: [
                                Container(width: 38,
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/icons/cart.png",
                                    height: 23,
                                    color: Colors.white54,
                                    width: 23,
                                  ),
                                ),
                                cartCount > 0 ? Container(
                                  height: 14, width: 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0dc89e),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(child: Text(
                                    cartCount.toString(), style: f10B,
                                    textAlign: TextAlign.center,)),
                                ) : Container()
                              ],
                            ),
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
      ),
    );
  }
}


var VIDEODATA;


