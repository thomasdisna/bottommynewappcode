import 'dart:async';
import 'dart:convert';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi%20videos.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/notificationController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/blog_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_food_bank_request_form.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/photos_view_page.dart';
import 'package:flutube/flutube.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatlist.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/restaurant_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/store_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_address_book_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_location_add_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/share_post_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_local_store.dart';
import 'package:intl/intl.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:location/location.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/CHAT/conversation_screen.dart';
import 'package:Butomy/CHAT/database.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
as repo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/B1_Home_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekitchen_bottom_bar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_homekitchen_upload_document.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_local_store_upload_document.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_restaurant_upload_document.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/notification.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_home_kitchen.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_food_market.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/menu_drawer_restaurant.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_bank.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_marcket.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_home_kitchen.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_restaurant.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
import 'ANOTHERPERSON/wall_web_view_page.dart';
import 'DETAILSBUSINESPROF/kitchen_prof.dart';
import 'New_Entry_Form.dart';
import 'Search_Screen/Search_Screen_T1.dart';
import 'Search_Screen/video_widget.dart';
import 'business_home_kitchen_timeline.dart';
import 'busness_pin_after_entry.dart';
import 'comments.dart';
import 'edit_post.dart';
import 'hashtag_search_page.dart';
import 'like_comment_share_count_page.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

HomeKitchenRegistration kit_contro;
String apiKey = 'AIzaSyAm22_7Hj0aHN09DvP-VmaXSk64dm1WSfg';
var Kdate, Sdate, Rdate;
var Kf, Sf, Rf;
var contheight = 50;
double lat;
double lng;
var postImage;
var postDesc;
var homekitstatus;
var restarantstatus;
var localstatus;
var hk;
var res;
var loc;
var pic_url;
var dataUser;
var UserIdprefs;
var timedata;
DateTime _date;
bool picStatus = false;
var dp;
var d;
DateTime _date2;
var d2;
var e;
var statusflag = 0;
var s = "unlike";
var b = "unmark";
var sharePost;

var datalength;
bool _fullscreen;

class ImageUploadProgress extends StatefulWidget {

  @override
  _ImageUploadProgressState createState() => _ImageUploadProgressState();
}

class _ImageUploadProgressState extends State<ImageUploadProgress> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("caliinggg ************************************ 2222222222222");
    _startUpload();
  }



  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startUpload() {
    for (var i = 0; i < imageList.length; i++) {
      // var nows = DateTime.now();
      // String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        // IMAGELISTS.add(filePath);
        _uploadTask = _storage.ref().child(IMAGELISTS[i]).putFile(imageList[i]);
      });
    }
    _uploadTask.isSuccessful ? Fluttertoast.showToast(
      msg: "Post Uploaded",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    ) : print("999999999999999999999999999999999999999999999999999999999999999999999999999999999");

    // _con.getTimelineWallStart(userid.toString());

  }

  _setval() {
    _uploadTask = null;
    timuloadinggg = false;
    IMAGELISTS = [];
    imageList = [];
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
  }
}

class DotWidget extends StatelessWidget {
  const DotWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.blue),
      height: 10,
      width: 10,
    );
  }
}

class TimeLine extends StatefulWidget {
  TimeLine(this.upld);
  bool upld;

  @override
  _TimeLineState createState() => _TimeLineState();
}

bool textSpan;
Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  return _TimeLineState()._showNotification(message);
}
class _TimeLineState extends StateMVC<TimeLine>
    with SingleTickerProviderStateMixin {

  bool show_location;
  var location_lat,location_long;
  ScrollController _timControoooo;
  ScrollController scrollController;
  List<bool> _likes = List.filled(1000, false);
  List<bool> splashcolor = List.filled(1000, false);
  List<bool> _save = List.filled(1000, false);
  List<bool> _showml = List.filled(1000, false);
  List<bool> _sharedshowml = List.filled(1000, false);
  List<bool> _showutube = List.filled(1000, false);
  List<bool> _showSharedutube = List.filled(1000, false);

  DateTime selectedDate;
  int sel;
  TimeOfDay selectedTime;
  var listDate=[];
  int quantity;
  int total;
  int sel_ind;

  Future<Null> _selectDate(BuildContext context,sss.StateSetter state) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      state(() {
        selectedDate = picked;
      });
    listDate = selectedDate.toString().split(" ");
    print("ddaaateeeeee "+selectedDate.toString());
    print("ddaaateeeeee listtttt"+listDate.toString());
    print("ddaaateeeeee 333333333"+DateFormat.yMMMEd().format(selectedDate).toString());
    _selectTime(context,state);
  }

  String timeF = "am";
  Future<Null> _selectTime(BuildContext context,sss.StateSetter state) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      state(() {
        selectedTime = picked;
        var a =selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString().split(":");
        print("dfgh "+a.toString());
        if(int.parse(a[0])<=12)
          timeF="am";
        else
          timeF="pm";
      });
    print("timmmmeewe -"+selectedTime.toString());
    print("timmmmeewe cuuutttt 11111 -"+selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", ""));
  }


  Future<void> _getData() async {
    setState(() {
      _con.getTimelineWallStart(userid.toString());
      _con.notification(userid.toString());
    });
  }

  bool isLoading = false;

  Future _loadData() async {
    // perform fetching data delay
    await new Future.delayed(new Duration(seconds: 3));
    setState(() {
      isLoading = false;
    });
  }


  Future<bool> _onWillPop() async {


  }

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserIdprefs = prefs.getString('userId');
  }


  TextEditingController _locatn = TextEditingController();
  TextEditingController _sharee = TextEditingController();
  TabController _tabContoller;
  TimelineWallController _con;
  VideoPlayerController _Videocontroller;

  _TimeLineState() : super(TimelineWallController()) {
    _con = controller;
  }

  static final _containerHeight = 61.0;
  var _fromTop = 0.toDouble();
  var _allowReverse = true,
      _allowForward = true;
  var _prevOffset = 0.0;
  var _prevForwardOffset = -_containerHeight;
  var _prevReverseOffset = 0.0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _scrollListener() {
    double offset12 = _timControoooo.offset;
    var direction = _timControoooo.position.userScrollDirection;

    if (direction == ScrollDirection.reverse) {
      _allowForward = true;
      if (_allowReverse) {
        _allowReverse = false;
        _prevOffset = offset12;
        _prevForwardOffset = _fromTop;
      }

      var difference = offset12 - _prevOffset;
      _fromTop = _prevForwardOffset + difference;
      if (_fromTop > 0) _fromTop = -_containerHeight;
    } else if (direction == ScrollDirection.forward) {
      _allowReverse = true;
      if (_allowForward) {
        _allowForward = false;
        _prevOffset = offset12;
        _prevReverseOffset = _fromTop;
      }
      var difference = offset12 - _prevOffset;
      _fromTop = _prevReverseOffset + difference;
      if (_fromTop < -_containerHeight) _fromTop = 0;
    }
    setState(() {});
    if (_timControoooo.offset >= _timControoooo.position.maxScrollExtent &&
        !_timControoooo.position.outOfRange) {
      // start loading data
      setState(() {
        starttim = _con.timelinePostData.length;
        isLoading = true;
      });
      _con.getTimelineWall(userid.toString());
      _loadData();
    }
    if (_timControoooo.offset <= _timControoooo.position.minScrollExtent &&
        !_timControoooo.position.outOfRange) {
      setState(() {

      });
    }
  }
  Future _showNotification(Map<String, dynamic> message) async {
    /*var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel desc',
      importance: Importance.max,
      priority: Priority.high,
    );*/

    /*var platformChannelSpecifics =
    new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'new message arived',
      'i want ${message['data']['title']} for ${message['data']['price']}',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );*/
  }
  getTokenz() async {
    print("caliinggg ");
    String token = await _firebaseMessaging.getToken();
    print("token %%%%%%%%%%%%%%%%%%%% ");
    print(token);
    setState(() {
      fire_token = token.toString();
    });
    FirebaseController.instanace.updateToken(timelineIdFoodi.toString(),token.toString());
    _con.tokenEditAccount(token.toString());
  }

  getUserLocation() async {
    try{print("loccc taking");
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var userloc = await locateUser();
    setState(() {
      userLocation = userloc;
    });
    print("llooooocccc "+userLocation.toString());
    final coordinates = new Coordinates(userLocation.latitude, userLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("srdtfjcgvkbhlkn;ml ${first.featureName} : ${first.addressLine}");
    setState(() {
      location_address =first.addressLine;
    });
    print("addresss 11111 "+userLocation.toString());
    print("addresss 2222222 "+location_address.toString());}
    catch(e){
      print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE "+e.toString());
    }
  }

  getCurrentLoc() async {
    try{print("loccc taking");
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var userloc = await locateUser();
    setState(() {
      userLocation = userloc;
    });
    print("llooooocccc "+userLocation.toString());
    final coordinates = new Coordinates(userLocation.latitude, userLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("srdtfjcgvkbhlkn;ml ${first.featureName} : ${first.addressLine}");
    setState(() {
      timeLineLocation.text = first.addressLine.toString().length>32 ?
      first.addressLine.toString().substring(0,32)+"..." : first.addressLine.toString();
    });
    print("addresss 11111 "+userLocation.toString());
    print("addresss 2222222 "+location_address.toString());}
    catch(e){
      print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE "+e.toString());
    }
  }

  Future<Position> locateUser() async {
    print("fvgbhnj ");
    try{ return Geolocator()
        .getCurrentPosition();}
    catch(e){
      print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE *************** : "+e.toString());
    }
  }

  @override
  void initState() {
    if (widget.upld == true) {
      print("caliinggg ************************************ 1111111111111");
      setState(() {
        timuloadinggg = true;
      });
    }

    getUserLocation();
    _firebaseMessaging.configure(
      onBackgroundMessage: myBackgroundHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
       /* showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(message["notification"]["title"]),
                content: Text(message['notification']['body']),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });*/
      },
    );
    // getTokenz();

    _con.getIDS(userid.toString());
    _con.getTimelineWallStart(userid.toString());
    _con.getOtherAbout1(userid.toString());
    _con.getAbout(userid.toString());
    _con.notification(userid.toString());
    FirebaseController.instanace.getUnreadMSGCount().then((value) {
      setState(() {
        chatmsgcount = value;
      });
    });
    // getUserLocation();
    _con.getPurchaseList(userid.toString());
    _timControoooo = ScrollController();
    _timControoooo.addListener(_scrollListener);
    setState(() {
      show_location=false;
      _con.timelinePostData = Splashtotimdata;
      starttim = 0;
      textSpan = false;
      _fullscreen = true;
    });
    // TODO: implement initState
    super.initState();
    getUserId();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
          scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    _tabContoller = TabController(length: 6, vsync: this);
    _tabContoller.addListener(_handleTabSelection);
  }


  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _introTextController = TextEditingController();

  VideoPlayerController _videoPlayerController1;


  Future<void> _shareText() async {
    try {
      Share.text('Share Foodiz Post', sharePost, 'text/plain');
    } catch (e) {
      //print('error: $e');
    }
  }


  void _handleTabSelection() {
    setState(() {});
  }

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;


  @override
  Widget build(BuildContext context) {
    // _con.getIDS(userid.toString());
var width = MediaQuery.of(context).size.width;
    var _location = Positioned(
      top: _fromTop,
      left: 0,
      right: 0,
      child: Column(
        children: [
          timuloadinggg == true ? ImageUploadProgress() : Container(),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0, right: 5, left: 5),
              child: Container(
                height: 47.0,
                decoration: BoxDecoration(
                    color: Color(0xFF23252E),
                    border: Border.all(color: Colors.grey[800],
                      width: 1,),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5.0,
                          spreadRadius: 0.0)
                    ]),
                child: Row(
                  children: [
                    Container( width: MediaQuery
                        .of(context)
                        .size
                        .width-60,
                      child: TextFormField(
                        autofocus: false,
                        readOnly: true,maxLines: 1,minLines: 1,
                        controller: timeLineLocation,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please add receiver location';
                          }
                          return null;
                        },
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => FoodiAddressBookPage()
                          ));
                        },
                      /*  onTap: () async {
                          LocationResult result = await showLocationPicker(
                            context, apiKey,
                            // initialCenter: LatLng(10.023286, 76.311371),
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
                            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%5 "+result.address_name);
                            _locatn.text = result.address;
                            location_lat = result.latLng.latitude;
                            location_long = result.latLng.longitude;
                          });
                          print("location ##################### "+_locatn.text);
                          print("location lattttt ##################### "+location_lat.toString());
                          print("location longggg ##################### "+location_long.toString());
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LocationAddPage(location: _locatn.text,lat: location_lat.toString(),
                            long: location_long.toString(),loc_name: result.address_name,)
                          ));
                        },*/
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on, color: Colors
                                .white),
                            border: InputBorder.none,
                            hintText: "Location",

                            hintStyle: TextStyle(color: Colors.white,
                                fontSize: 15)),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        getCurrentLoc();
                      },
                      icon: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    var _tabModules = Container(
      child: Padding(
          padding: EdgeInsets.only(top: _fromTop != 0 ? 7 : 62),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFF23252E),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5.0,
                          spreadRadius: 0.0)
                    ]),
                child: _fromTop != 0 ? Container(
                  height: 40,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: TabBar(

                    indicator: BoxDecoration(
                        color: Color((0xFFffd55e)),
                        borderRadius: BorderRadius.circular(4)),
                    controller: _tabContoller,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    indicatorColor: Colors.transparent,
                    tabs: <Widget>[
                      Tab(

                        icon: _tabContoller.index == 0
                            ? Image.asset(
                          "assets/Template1/image/Foodie/icons/wall.png",
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        )
                            : Image.asset(
                          "assets/Template1/image/Foodie/icons/wall.png",
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                      ),
                      Tab(

                        icon: _tabContoller.index == 1
                            ? Image.asset(
                          "assets/Template1/image/Foodie/icons/home-kitchen.png",
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        )
                            : Image.asset(
                          "assets/Template1/image/Foodie/icons/home-kitchen.png",
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                      ),
                      Tab(

                        icon: _tabContoller.index == 2
                            ? Image.asset(
                          "assets/Template1/image/Foodie/icons/shop.png",
                          height: 26,
                          width: 26,
                          color: Colors.black,
                        )
                            : Image.asset(
                          "assets/Template1/image/Foodie/icons/shop.png",
                          height: 26,
                          width: 26,
                          color: Colors.white,
                        ),
                      ),
                      Tab(

                        icon: _tabContoller.index == 3
                            ? Image.asset(
                          "assets/Template1/image/Foodie/icons/market.png",
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        )
                            : Image.asset(
                          "assets/Template1/image/Foodie/icons/market.png",
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                      ),
                      Tab(

                        icon: _tabContoller.index == 4
                            ? Image.asset(
                          "assets/Template1/image/Foodie/icons/Food-Bank-1.png",
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        )
                            : Image.asset(
                          "assets/Template1/image/Foodie/icons/Food-Bank-1.png",
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                      ),
                      Tab(

                        icon: _tabContoller.index == 5
                            ? Image.asset(
                          "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        )
                            : Image.asset(
                          "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ) :

                Container(
                  height: 70,
                  child: PreferredSize(
                    child: TabBar(
                      isScrollable: true,
                      indicator: BoxDecoration(
                          color: Color((0xFFffd55e)),
                          borderRadius: BorderRadius.circular(4)),
                      controller: _tabContoller,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white,
                      indicatorColor: Colors.transparent,
                      tabs: <Widget>[
                        Tab(
                          child: Text(
                            "Foodie Wall",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 0
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/wall.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/wall.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Home Kitchen",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 1
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/home-kitchen.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/home-kitchen.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Local Store",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 2
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/shop.png",
                            height: 26,
                            width: 26,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/shop.png",
                            height: 26,
                            width: 26,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Foodie Market",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 3
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/market.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/market.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Food Bank",
                            style: f14,
                          ),
                          icon: _tabContoller.index == 4
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/Food-Bank-1.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/Food-Bank-1.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Restaurants",
                            style: f14,
                            textAlign: TextAlign.center,
                          ),
                          icon: _tabContoller.index == 5
                              ? Image.asset(
                            "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                            height: 24,
                            width: 24,
                            color: Colors.black,
                          )
                              : Image.asset(
                            "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                            height: 24,
                            width: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    preferredSize: Size.fromHeight(100),
                  ),
                ),
              ),
              Container(
                height: _fromTop != 0 ? MediaQuery
                    .of(context)
                    .size
                    .height - 168 : MediaQuery
                    .of(context)
                    .size
                    .height - 240,
                // padding: EdgeInsets.only(bottom: 200),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 15),
                  child: TabBarView(
                    controller: _tabContoller,
                    children: <Widget>[
                      _con.timelinePostData.length > 0 ?
                      Column(
                        children: [
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: _getData,
                              backgroundColor: Color(0xFF0dc89e),
                              color: Colors.black,
                              child: ListView.builder(
                                controller: _timControoooo,
                                itemCount: _con.timelinePostData.length,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  _con.timelinePostData[index]
                                  [
                                  "youtube_video_id"]
                                      .toString()
                                      .length != 11 &&
                                      _con.timelinePostData[
                                      index][
                                      "youtube_video_id"] !=
                                          null
                                      ?
                                  _Videocontroller =
                                      VideoPlayerController.network(
                                          "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                              _con
                                                  .timelinePostData[index]['youtube_video_id']
                                                  .toString()
                                                  .replaceAll(" ", "%20") +
                                              "?alt=media")
                                      : null;
                                  _con.timelinePostData[index]['like_status'] ==
                                      true ?
                                  _likes[index] = true : _likes[index] = false;
                                  _con.timelinePostData[index]['save_status'] ==
                                      true ?
                                  _save[index] = true : _save[index] = false;
                                  _date = DateTime.parse(
                                      _con.timelinePostData[index]['created_at']
                                      ['date']);
                                  // print("daattaaaa date "+index.toString()+" time -> "+_date.toString());
                                  _con
                                      .timelinePostData[index]["shared_post_id"] !=
                                      null
                                      ? _date2 = DateTime.parse(
                                      _con
                                          .timelinePostData[index]["shared_post_details"]['created_at']
                                      ['date'])
                                      : null;
                                  final List<String> playlist = <String>[
                                    'https://www.youtube.com/watch?v=' +
                                        _con.timelinePostData[index]
                                        ['youtube_video_id']
                                            .toString()
                                  ];
                                  var c =
                                      DateTime
                                          .now()
                                          .difference(_date)
                                          .inHours;
                                  _con
                                      .timelinePostData[index]["shared_post_id"] !=
                                      null
                                      ? e =
                                      DateTime

                                          .now()
                                          .difference(_date2)
                                          .inHours
                                      : null;
                                  c > 24 && c <= 48
                                      ? d = "Yesterday" : c > 48 ?
                                  d = DateFormat.MMMd().format(_date)
                                      : c == 0
                                      ? d = DateTime
                                      .now()
                                      .difference(_date)
                                      .inMinutes
                                      .toString() +
                                      " mints ago"
                                      : d = DateTime
                                      .now()
                                      .difference(_date)
                                      .inHours
                                      .toString() +
                                      " hrs ago";
                                  final List<String> playlist2 = _con
                                      .timelinePostData[index]["shared_post_id"] !=
                                      null
                                      ? <String>[
                                    'https://www.youtube.com/watch?v=' +
                                        _con
                                            .timelinePostData[index]["shared_post_details"]
                                        ['youtube_video_id']
                                            .toString()
                                  ]
                                      : <String>[];
                                  _con
                                      .timelinePostData[index]["shared_post_id"] !=
                                      null
                                      ? e > 24 && e <= 48
                                      ? d2 = "Yesterday" : e > 48 ?
                                  d2 = DateFormat.MMMd().format(_date2)
                                      : e == 0
                                      ? d2 = DateTime
                                      .now()
                                      .difference(_date2)
                                      .inMinutes
                                      .toString() +
                                      " mints ago"
                                      : d2 = DateTime
                                      .now()
                                      .difference(_date2)
                                      .inHours
                                      .toString() +
                                      " hrs ago"
                                      : null;

                                  return new GestureDetector(
                                    child: new Column(
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.white.withOpacity(0.5),
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 5.0,

                                                      bottom: 2),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          // GestureDetector(
                                                          //   onTap: () {
                                                          //     showDialog(
                                                          //         context: context,
                                                          //         child:
                                                          //             Dialog(
                                                          //               backgroundColor: Color(
                                                          //                   0xFF1E2026),
                                                          //               child: Container(
                                                          //                 height: 230,width: 350,
                                                          //                 child: Padding(
                                                          //                   padding: const EdgeInsets.all(8.0),
                                                          //                   child: CachedNetworkImage(
                                                          //                     placeholder: (
                                                          //                         context,
                                                          //                         ind) =>
                                                          //                         Image
                                                          //                             .asset(
                                                          //                           "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                          //                           fit: BoxFit
                                                          //                               .cover,),
                                                          //                     imageUrl: _con
                                                          //                         .timelinePostData[index]["business_type"]
                                                          //                         .toString() ==
                                                          //                         "4" ||   _con
                                                          //                         .timelinePostData[index]["business_type"]
                                                          //                         .toString() ==
                                                          //                         "6"  ? _con
                                                          //                         .timelinePostData[index]["picture"]
                                                          //                         .toString()
                                                          //                         .replaceAll(
                                                          //                         " ",
                                                          //                         "%20") +
                                                          //                         "?alt=media" :
                                                          //                     _con
                                                          //                         .timelinePostData[index]["product_id"] !=
                                                          //                         null &&
                                                          //                         _con
                                                          //                             .timelinePostData[index]["business_profile_image"] !=
                                                          //                             null && _con
                                                          //                         .timelinePostData[index]["business_profile_image"] !=""
                                                          //                         ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          //                         _con
                                                          //                             .timelinePostData[index]["picture"]
                                                          //                             .toString() +
                                                          //                         "?alt=media"
                                                          //                         : _con
                                                          //                         .timelinePostData[index]["product_id"] !=
                                                          //                         null && _con
                                                          //                         .timelinePostData[index]["business_profile_image"] ==""
                                                          //                         ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                                                          //                         : _con
                                                          //                         .timelinePostData[index]["product_id"] ==
                                                          //                         null &&
                                                          //                         _con
                                                          //                             .timelinePostData[index]["post_type"]
                                                          //                             .toString() ==
                                                          //                             "page" &&
                                                          //                         _con
                                                          //                             .timelinePostData[index]["picture"]
                                                          //                             .toString() !=
                                                          //                             ""
                                                          //                         ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          //                         _con
                                                          //                             .timelinePostData[index]["picture"]
                                                          //                             .toString()
                                                          //                             .replaceAll(
                                                          //                             " ",
                                                          //                             "%20") +
                                                          //                         "?alt=media"
                                                          //                         : _con
                                                          //                         .timelinePostData[index]["product_id"] ==
                                                          //                         null &&
                                                          //                         _con
                                                          //                             .timelinePostData[index]["post_type"]
                                                          //                             .toString() ==
                                                          //                             "page" &&
                                                          //                         _con
                                                          //                             .timelinePostData[index]["picture"]
                                                          //                             .toString() ==
                                                          //                             ""
                                                          //                         ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          //                         "icu.png" +
                                                          //                         "?alt=media"
                                                          //                         : _con
                                                          //                         .timelinePostData[index]["picture"]
                                                          //                         .toString()
                                                          //                         .replaceAll(
                                                          //                         " ",
                                                          //                         "%20") +
                                                          //                         "?alt=media",
                                                          //
                                                          //                     fit: BoxFit
                                                          //                         .cover,
                                                          //                   ),
                                                          //                 ),
                                                          //               ),
                                                          //             ));
                                                          //   },
                                                          //   child: Stack(
                                                          //     alignment: Alignment.bottomRight,
                                                          //     children: [
                                                          //       Container(
                                                          //         height: 38.0,
                                                          //         width: 38.0,
                                                          //         child: Center(
                                                          //           child: Container(
                                                          //             height: 35.0,
                                                          //             width: 35.0,
                                                          //
                                                          //             decoration: BoxDecoration(
                                                          //                 image: DecorationImage(
                                                          //                     image: _con
                                                          //                         .timelinePostData[index]["picture"] !=
                                                          //                         null
                                                          //                         ? CachedNetworkImageProvider(
                                                          //                         _con
                                                          //                             .timelinePostData[index]["post_type"]
                                                          //                             .toString() ==
                                                          //                             "page" &&
                                                          //                             _con
                                                          //                                 .timelinePostData[index]["picture"]
                                                          //                                 .toString() ==
                                                          //                                 ""
                                                          //                             ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          //                             "icu.png" +
                                                          //                             "?alt=media" :
                                                          //                         _con
                                                          //                             .timelinePostData[index]["business_type"]
                                                          //                             .toString() ==
                                                          //                             "4"  ||   _con
                                                          //                             .timelinePostData[index]["business_type"]
                                                          //                             .toString() ==
                                                          //                             "6" ? _con
                                                          //                             .timelinePostData[index]["picture"]
                                                          //                             .toString()
                                                          //                             .replaceAll(
                                                          //                             " ",
                                                          //                             "%20") +
                                                          //                             "?alt=media" :
                                                          //                         _con
                                                          //                             .timelinePostData[index]["product_id"] !=
                                                          //                             null &&
                                                          //                             _con.timelinePostData[index]["business_profile_image"] != null &&  _con.timelinePostData[index]["business_profile_image"] != ""
                                                          //                             ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          //                             _con
                                                          //                                 .timelinePostData[index]["picture"]
                                                          //                                 .toString() +
                                                          //                             "?alt=media"
                                                          //                             : _con
                                                          //                             .timelinePostData[index]["product_id"] !=
                                                          //                             null && _con.timelinePostData[index]["business_profile_image"] == null
                                                          //                             ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media"
                                                          //                             : _con
                                                          //                             .timelinePostData[index]["product_id"] ==
                                                          //                             null &&
                                                          //                             _con
                                                          //                                 .timelinePostData[index]["post_type"]
                                                          //                                 .toString() ==
                                                          //                                 "page" &&
                                                          //                             _con
                                                          //                                 .timelinePostData[index]["picture"]
                                                          //                                 .toString() !=
                                                          //                                 ""
                                                          //                             ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          //                             _con
                                                          //                                 .timelinePostData[index]["picture"]
                                                          //                                 .toString()
                                                          //                                 .replaceAll(
                                                          //                                 " ",
                                                          //                                 "%20") +
                                                          //                             "?alt=media"
                                                          //                             :   _con
                                                          //                             .timelinePostData[index]["product_id"] ==
                                                          //                             null &&
                                                          //                             _con
                                                          //                                 .timelinePostData[index]["post_type"]
                                                          //                                 .toString() ==
                                                          //                                 "page" &&
                                                          //                             _con
                                                          //                                 .timelinePostData[index]["picture"]
                                                          //                                 .toString() ==
                                                          //                                 ""
                                                          //                             ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                          //                             "icu.png" +
                                                          //                             "?alt=media"
                                                          //                             :  _con
                                                          //                             .timelinePostData[index]["picture"]
                                                          //                             .toString()
                                                          //                             .replaceAll(
                                                          //                             " ",
                                                          //                             "%20") +
                                                          //                             "?alt=media")
                                                          //                         : CachedNetworkImageProvider(
                                                          //                       "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                          //                     ),
                                                          //                     fit: BoxFit
                                                          //                         .cover),
                                                          //                 border: Border
                                                          //                     .all(
                                                          //                     color: (_con
                                                          //                         .timelinePostData[index]["product_id"] ==
                                                          //                         null &&
                                                          //                         _con
                                                          //                             .timelinePostData[index]["post_type"]
                                                          //                             .toString() ==
                                                          //                             "page" &&
                                                          //                         _con
                                                          //                             .timelinePostData[index]["picture"]
                                                          //                             .toString() ==
                                                          //                             "") ||
                                                          //                         (_con
                                                          //                             .timelinePostData[index]["product_id"] !=
                                                          //                             null &&  _con
                                                          //                             .timelinePostData[index]["picture"]
                                                          //                             .toString() ==
                                                          //                             "" &&
                                                          //                             _con
                                                          //                                 .timelinePostData[index]["business_profile_image"] ==
                                                          //                                 null) || (_con
                                                          //                         .timelinePostData[index]["business_profile_image"] == "" &&
                                                          //                         _con
                                                          //                             .timelinePostData[index]["post_type"]
                                                          //                             .toString() ==
                                                          //                             "page" &&  _con
                                                          //                         .timelinePostData[index]["picture"]
                                                          //                         .toString() ==
                                                          //                         "")
                                                          //                         ? Color(
                                                          //                         0xFF48c0d8)
                                                          //                         : Colors
                                                          //                         .transparent),
                                                          //                 borderRadius: BorderRadius
                                                          //                     .all(
                                                          //                     Radius
                                                          //                         .circular(
                                                          //                         180.0))),
                                                          //           ),
                                                          //         ),
                                                          //       ),
                                                          //       _con.timelinePostData[index]["business_type"].toString() == "3" && _con.timelinePostData[index]["post_type"].toString() == "page"  ?  Padding(
                                                          //         padding: const EdgeInsets.only(left:18,top: 10),
                                                          //         child: Container(
                                                          //           height: 22,
                                                          //           width: 22,
                                                          //           decoration: BoxDecoration(
                                                          //               borderRadius: BorderRadius.circular(150),
                                                          //               color: Color(0xFF1E2026)
                                                          //           ),
                                                          //           child: Center(
                                                          //             child: Container(height: 17,
                                                          //               width: 17,
                                                          //               decoration: BoxDecoration(
                                                          //                   borderRadius: BorderRadius.circular(150),
                                                          //                   color: Color(0xFF48c0d8)
                                                          //               ),
                                                          //               child: Center(
                                                          //                 child: Image.asset(
                                                          //                   "assets/tray.png",
                                                          //                   height: 12,
                                                          //                   width: 12,
                                                          //                   color: Colors.black,
                                                          //                 ),
                                                          //               ),
                                                          //             ),
                                                          //           ),
                                                          //         ),
                                                          //       ) :
                                                          //       _con.timelinePostData[index]["business_type"].toString() == "2" && _con.timelinePostData[index]["post_type"].toString() == "page" ? Padding(
                                                          //         padding: const EdgeInsets.only(left:18,top: 10),
                                                          //         child: Container(
                                                          //           height: 22,
                                                          //           width: 22,
                                                          //           decoration: BoxDecoration(
                                                          //               borderRadius: BorderRadius.circular(150),
                                                          //               color: Color(0xFF1E2026)
                                                          //           ),
                                                          //           child: Center(
                                                          //             child: Container(height: 17,
                                                          //               width: 17,
                                                          //               decoration: BoxDecoration(
                                                          //                   borderRadius: BorderRadius.circular(150),
                                                          //                   color: Color(0xFF48c0d8)
                                                          //               ),
                                                          //               child: Center(
                                                          //                 child: Image.asset(
                                                          //                   "assets/Template1/image/Foodie/icons/market.png",
                                                          //                   height: 12,
                                                          //                   width: 12,
                                                          //                   color: Colors.black,
                                                          //                 ),
                                                          //               ),
                                                          //             ),
                                                          //           ),
                                                          //         ),
                                                          //       ) :
                                                          //       _con.timelinePostData[index]["business_type"].toString() == "1" && _con.timelinePostData[index]["post_type"].toString() == "page" ?
                                                          //       Padding(
                                                          //         padding: const EdgeInsets.only(left:18,top: 10),
                                                          //         child: Container(
                                                          //           height: 22,
                                                          //           width: 22,
                                                          //           decoration: BoxDecoration(
                                                          //               borderRadius: BorderRadius.circular(150),
                                                          //               color: Color(0xFF1E2026)
                                                          //           ),
                                                          //           child: Center(
                                                          //             child: Container(height: 17,
                                                          //               width: 17,
                                                          //               decoration: BoxDecoration(
                                                          //                   borderRadius: BorderRadius.circular(150),
                                                          //                   color: Color(0xFF48c0d8)
                                                          //               ),
                                                          //               child: Center(
                                                          //                 child: Image.asset(
                                                          //                   "assets/chef.png",
                                                          //                   height: 12,
                                                          //                   width: 12,
                                                          //                   color: Colors.black,
                                                          //                 ),
                                                          //               ),
                                                          //             ),
                                                          //           ),
                                                          //         ),
                                                          //       ) : _con.timelinePostData[index]["post_type"].toString() == "user" && _con.timelinePostData[index]["req_verified_user"].toString() == "1" ? Padding(
                                                          //         padding: const EdgeInsets.only(left:18,top: 10),
                                                          //         child: Container(
                                                          //           height: 22,
                                                          //           width: 22,
                                                          //           decoration: BoxDecoration(
                                                          //               borderRadius: BorderRadius.circular(150),
                                                          //               color: Color(0xFF1E2026)
                                                          //           ),
                                                          //           child: Center(
                                                          //             child: Container(height: 17,
                                                          //               width: 17,
                                                          //               decoration: BoxDecoration(
                                                          //                   borderRadius: BorderRadius.circular(150),
                                                          //                   color: Colors.blue[700]
                                                          //               ),
                                                          //               child: Center(
                                                          //                 child: Image.asset(
                                                          //                   "assets/star.png",
                                                          //                   height: 12,
                                                          //                   width: 12,
                                                          //                   color: Colors.white,
                                                          //                 ),
                                                          //               ),
                                                          //             ),
                                                          //           ),
                                                          //         ),
                                                          //       ) : Container(height: 0,)
                                                          //     ],
                                                          //   ),
                                                          // ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            child:
                                                            GestureDetector(
                                                              onTap: () {
                                                                _con
                                                                    .timelinePostData[index]["product_id"] !=
                                                                    null && _con
                                                                    .timelinePostData[index]["business_type"]
                                                                    .toString() ==
                                                                    "1" ?
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            KitchenProf(
                                                                              currentindex: 1,
                                                                              memberdate: "",
                                                                              pagid: _con
                                                                                  .timelinePostData[index]['business_page_id']
                                                                                  .toString(),
                                                                              timid: _con
                                                                                  .timelinePostData[index]['business_timeline_id']
                                                                                  .toString(),)
                                                                    )) : _con
                                                                    .timelinePostData[index]["product_id"] ==
                                                                    null && _con
                                                                    .timelinePostData[index]["post_type"]
                                                                    .toString() ==
                                                                    "page" &&
                                                                    _con
                                                                        .timelinePostData[index]["business_type"]
                                                                        .toString() ==
                                                                        "1" ?
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            KitchenProf(
                                                                              currentindex: 1,
                                                                              memberdate: "",
                                                                              pagid: _con
                                                                                  .timelinePostData[index]['business_page_id']
                                                                                  .toString(),
                                                                              timid: _con
                                                                                  .timelinePostData[index]['timeline_id']
                                                                                  .toString(),)
                                                                    ))

                                                                    : _con
                                                                    .timelinePostData[index]["product_id"] !=
                                                                    null && _con
                                                                    .timelinePostData[index]["business_type"]
                                                                    .toString() ==
                                                                    "2" ?

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            StoreProf(
                                                                              currentindex: 1,
                                                                              memberdate: "",
                                                                              pagid: _con
                                                                                  .timelinePostData[index]['business_page_id']
                                                                                  .toString(),
                                                                              timid: _con
                                                                                  .timelinePostData[index]['business_timeline_id']
                                                                                  .toString(),)
                                                                    )) : _con
                                                                    .timelinePostData[index]["product_id"] ==
                                                                    null && _con
                                                                    .timelinePostData[index]["post_type"]
                                                                    .toString() ==
                                                                    "page" &&
                                                                    _con
                                                                        .timelinePostData[index]["business_type"]
                                                                        .toString() ==
                                                                        "2"
                                                                    ?
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            StoreProf(
                                                                              currentindex: 1,
                                                                              memberdate: "",
                                                                              pagid: _con
                                                                                  .timelinePostData[index]['business_page_id']
                                                                                  .toString(),
                                                                              timid: _con
                                                                                  .timelinePostData[index]['timeline_id']
                                                                                  .toString(),)))
                                                                    : _con
                                                                    .timelinePostData[index]["product_id"] !=
                                                                    null && _con
                                                                    .timelinePostData[index]["business_type"]
                                                                    .toString() ==
                                                                    "3" ?
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            RestProf(
                                                                              currentindex: 1,
                                                                              memberdate: "",
                                                                              pagid: _con
                                                                                  .timelinePostData[index]['business_page_id']
                                                                                  .toString(),
                                                                              timid: _con
                                                                                  .timelinePostData[index]['business_timeline_id']
                                                                                  .toString(),)
                                                                    ))
                                                                    : _con
                                                                    .timelinePostData[index]["product_id"] ==
                                                                    null && _con
                                                                    .timelinePostData[index]["post_type"]
                                                                    .toString() ==
                                                                    "page" &&
                                                                    _con
                                                                        .timelinePostData[index]["business_type"]
                                                                        .toString() ==
                                                                        "3"
                                                                    ?
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            RestProf(
                                                                              currentindex: 1,
                                                                              memberdate: "",
                                                                              pagid: _con
                                                                                  .timelinePostData[index]['business_page_id']
                                                                                  .toString(),
                                                                              timid: _con
                                                                                  .timelinePostData[index]['timeline_id']
                                                                                  .toString(),)))
                                                                    : Navigator
                                                                    .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            TimelineFoodWallDetailPage(
                                                                              id: _con
                                                                                  .timelinePostData[index]['user_id']
                                                                                  .toString(),
                                                                            )));
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    _con
                                                                        .timelinePostData[index]["product_id"] !=
                                                                        null
                                                                        ? _con
                                                                        .timelinePostData[
                                                                    index]
                                                                    ['business_name']
                                                                        .toString()
                                                                        : _con
                                                                        .timelinePostData[
                                                                    index]
                                                                    ['name']
                                                                        .toString(),
                                                                    style: f15wB,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          d
                                                                              .toString(),
                                                                          style: f10g),
                                                                      _con
                                                                          .timelinePostData[index]
                                                                      ['post_location'] !=
                                                                          null &&
                                                                          _con
                                                                              .timelinePostData[
                                                                          index]
                                                                          ['post_location']
                                                                              .toString()
                                                                              .length >
                                                                              0
                                                                          ?
                                                                      Row(
                                                                        children: [
                                                                          Text("   - ",style: f10g,),
                                                                          Icon(Icons.location_on,color: Colors.grey,size: 13,),
                                                                          SizedBox(width: 1,),
                                                                          Text(
                                                                           userid.toString() == _con.timelinePostData[index]['user_id'].toString() && _con
                                                                             .timelinePostData[index]
                                                                           ['post_location']
                                                                             .toString().length>=45 && (_con.timelinePostData[index]["post_type"].toString()
                                                                             =="page" || _con.timelinePostData[index]["post_type"].toString()
                                                                             =="user")
                                                                             ?   _con
                                                                                    .timelinePostData[index]
                                                                                ['post_location']
                                                                                    .toString().substring(0,45)+"..." :
                                                                           userid.toString() == _con.timelinePostData[index]['user_id'].toString() && _con
                                                                             .timelinePostData[index]
                                                                           ['post_location']
                                                                             .toString().length<40 && (_con.timelinePostData[index]["post_type"].toString()
                                                                             =="page" || _con.timelinePostData[index]["post_type"].toString()
                                                                             =="user")
                                                                             ?   _con
                                                                             .timelinePostData[index]
                                                                           ['post_location']
                                                                             .toString() :  _con.timelinePostData[index]["post_type"].toString()
                                                                             =="page" && _con
                                                                             .timelinePostData[index]
                                                                           ['post_location']
                                                                             .toString().length>=21 && userid.toString() != _con.timelinePostData[index]['user_id'].toString()
                                                                               ?  _con
                                                                             .timelinePostData[index]
                                                                           ['post_location']
                                                                             .toString().substring(0,21)+"..." :
                                  _con.timelinePostData[index]["post_type"].toString()
                                  =="page" && _con
                                      .timelinePostData[index]
                                  ['post_location']
                                      .toString().length<21 && userid.toString() != _con.timelinePostData[index]['user_id'].toString() ?
                                                                             _con
                                                                                 .timelinePostData[index]
                                                                             ['post_location']
                                                                                 .toString() :
                                  _con.timelinePostData[index]["post_type"].toString()
                                  =="user" && _con
                                      .timelinePostData[index]
                                  ['post_location']
                                      .toString().length>=33 && userid.toString() != _con.timelinePostData[index]['user_id'].toString() ?
                                  _con
                                      .timelinePostData[index]
                                  ['post_location']
                                      .toString().substring(0,33)+"..." : _con
                                      .timelinePostData[index]
                                  ['post_location']
                                      .toString(),
                                                                            style: f10g,
                                                                          ),
                                                                        ],
                                                                      )
                                                                          : Container(),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          userid.toString() !=
                                                              _con
                                                                  .timelinePostData[index]["user_id"]
                                                                  .toString() &&
                                                              _con
                                                                  .timelinePostData[index]["post_type"]
                                                                  .toString() ==
                                                                  "page" && _con
                                                              .timelinePostData[index]["business_type"]
                                                              .toString() !="4" && _con
                                                              .timelinePostData[index]["business_type"]
                                                              .toString() !="6"
                                                              ? Container(height: 23,
                                                                child: MaterialButton(

                                                            onPressed: () {
                                                                if (_con
                                                                    .timelinePostData[index]["follow_status"] ==
                                                                    true) {
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (
                                                                          BuildContext context) {
                                                                        return AlertDialog(
                                                                          backgroundColor:
                                                                          Color(
                                                                              0xFF1E2026),
                                                                          content: new Text(
                                                                            "Do you want to Unfollow " +
                                                                                _con
                                                                                    .timelinePostData[index]
                                                                                ["name"]
                                                                                    .toString() +
                                                                                " ?",
                                                                            style: f14w,
                                                                          ),
                                                                          actions: <
                                                                              Widget>[
                                                                            MaterialButton(
                                                                              height: 28,
                                                                              color: Color(
                                                                                  0xFFffd55e),
                                                                              child: new Text(
                                                                                "Cancel",
                                                                                style: TextStyle(
                                                                                    color:
                                                                                    Colors
                                                                                        .black),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator
                                                                                    .pop(
                                                                                    context,
                                                                                    'Cancel');
                                                                              },
                                                                            ),
                                                                            MaterialButton(
                                                                              height: 28,
                                                                              color: Color(
                                                                                  0xFF48c0d8),
                                                                              child: new Text(
                                                                                "Unfollow",
                                                                                style: TextStyle(
                                                                                    color:
                                                                                    Colors
                                                                                        .black),
                                                                              ),
                                                                              onPressed: () {
                                                                                _con
                                                                                    .BusinessFollowunFollow(
                                                                                  _con
                                                                                      .timelinePostData[index]['business_page_id']
                                                                                      .toString(),
                                                                                  userid
                                                                                      .toString(),);
                                                                                setState(() {
                                                                                  _con
                                                                                      .timelinePostData[index]["follow_status"] =
                                                                                  false;
                                                                                });
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      });
                                                                }
                                                                else {
                                                                  _con
                                                                      .BusinessFollowunFollow(
                                                                    _con
                                                                        .timelinePostData[index]['business_page_id']
                                                                        .toString(),
                                                                    userid
                                                                        .toString(),);
                                                                  setState(() {
                                                                    _con
                                                                        .timelinePostData[index]["follow_status"] =
                                                                    true;
                                                                  });
                                                                }
                                                            },
                                                                  splashColor: Color(0xFFffd55e),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          2)
                                                                  ),
                                                            height: 23,
                                                            minWidth: 70,
                                                            color: Color(
                                                                  0xFF48c0d9),
                                                            child: Center(
                                                                  child: _con
                                                                      .timelinePostData[index][
                                                                  "follow_status"] ==
                                                                      true
                                                                      ? Text(
                                                                      "Unfollow",
                                                                      style: f14B)
                                                                      : Text(
                                                                      "Follow",
                                                                      style: f14B)),
                                                          ),
                                                              ) : Container(),
                                                          SizedBox(width: 12),
                                                          userid.toString() !=
                                                              _con
                                                                  .timelinePostData[
                                                              index][
                                                              "user_id"]
                                                                  .toString() && _con
                                                              .timelinePostData[index]["business_type"]
                                                              .toString() !="6" && _con
                                                              .timelinePostData[index]["business_type"]
                                                              .toString() !="4"
                                                              ? GestureDetector(
                                                              onTap: () {
                                                                try {
                                                                  String chatID = makeChatId(
                                                                      timelineIdFoodi
                                                                          .toString(),
                                                                      _con
                                                                          .timelinePostData[
                                                                      index]
                                                                      [
                                                                      'timeline_id']
                                                                          .toString());
                                                                  Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              ChatRoom(
                                                                                  timelineIdFoodi.toString(),
                                                                                  NAME,
                                                                                  _con
                                                                                      .timelinePostData[
                                                                                  index]
                                                                                  [
                                                                                  'device_token']
                                                                                      .toString(),
                                                                                  _con
                                                                                      .timelinePostData[
                                                                                  index]
                                                                                  ['timeline_id']
                                                                                      .toString(),
                                                                                  chatID,
                                                                                  _con
                                                                                      .timelinePostData[index]
                                                                                  ['username']
                                                                                      .toString(),
                                                                                  _con
                                                                                      .timelinePostData[
                                                                                  index]
                                                                                  [
                                                                                  'name']
                                                                                      .toString(),
                                                                                  _con
                                                                                      .timelinePostData[
                                                                                  index]
                                                                                  [
                                                                                  'post_type'] =="page"  ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                                      .timelinePostData[
                                                                                  index]
                                                                                  [
                                                                                  'picture']
                                                                                      .toString()
                                                                                      .replaceAll(
                                                                                      " ",
                                                                                      "%20") +
                                                                                      "?alt=media" : _con
                                                                                      .timelinePostData[
                                                                                  index]
                                                                                  [
                                                                                  'picture']
                                                                                      .toString()
                                                                                      .replaceAll(
                                                                                      " ",
                                                                                      "%20") +
                                                                                      "?alt=media",
                                                                                  "")));
                                                                } catch (e) {
                                                                  print(e
                                                                      .message);
                                                                }
                                                              },
                                                              child: Icon(
                                                                Icons.chat,
                                                                color: Color(
                                                                    (0xFFffd55e)),
                                                              ))
                                                              : Container(
                                                            height: 0,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showModalBottomSheet(backgroundColor: Color(0xFF1E2026),
                                                                  context: context,
                                                                  clipBehavior: Clip.antiAlias,
                                                                  builder: (BuildContext context) {
                                                                    return StatefulBuilder(
                                                                        builder: (
                                                                            BuildContext
                                                                            context,
                                                                           sss. StateSetter
                                                                            state) {
                                                                          return Padding(
                                                                            padding: const EdgeInsets.only(bottom:
                                                                            5.0, top: 5, right: 10, left: 10),
                                                                            child:
                                                                            Wrap(
                                                                              children: <
                                                                                  Widget>[
                                                                                    //edit post
                                                                                userid.toString() == _con.timelinePostData[index]['user_id'].toString() &&
                                                                                    _con.timelinePostData[index]["post_type"].toString() == "user"
                                                                                    ? Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .all(
                                                                                      6.0),
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      Navigator
                                                                                          .pop(
                                                                                          context);
                                                                                      Navigator
                                                                                          .push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (
                                                                                                  context) =>
                                                                                                  EditPost(
                                                                                                    desc: _con
                                                                                                        .timelinePostData[index]['description']
                                                                                                        .toString(),
                                                                                                    postid: _con
                                                                                                        .timelinePostData[index]["id"]
                                                                                                        .toString(),
                                                                                                  )));
                                                                                    },
                                                                                    child: Container(
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .center,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Image
                                                                                              .asset(
                                                                                            "assets/Template1/image/Foodie/icons/pencil.png",
                                                                                            height: 21,
                                                                                            width: 21,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 16,
                                                                                          ),
                                                                                          Text(
                                                                                            "Edit Post",
                                                                                            style: f15wB,
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                                    : Container(
                                                                                  height: 0,
                                                                                ),
                                                                                //delete post
                                                                                userid.toString() == _con.timelinePostData[index]['user_id'].toString() &&
                                                                                    _con.timelinePostData[index]["post_type"].toString() == "user"
                                                                                    ? Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .all(
                                                                                      6.0),
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      Navigator
                                                                                          .pop(
                                                                                          context);
                                                                                      showDialog(
                                                                                          context: context,
                                                                                          builder: (
                                                                                              BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              backgroundColor: Color(
                                                                                                  0xFF1E2026),
                                                                                              title: new Text(
                                                                                                "Delete Post?",
                                                                                                style: f16wB,
                                                                                              ),
                                                                                              content: new Text(
                                                                                                "Do you want to delete the post",
                                                                                                style: f14w,
                                                                                              ),
                                                                                              actions: <
                                                                                                  Widget>[
                                                                                                MaterialButton(
                                                                                                  height: 28,
                                                                                                  color: Color(
                                                                                                      0xFFffd55e),
                                                                                                  child: new Text(
                                                                                                    "Cancel",
                                                                                                    style: TextStyle(
                                                                                                        color: Colors
                                                                                                            .black),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator
                                                                                                        .pop(
                                                                                                        context,
                                                                                                        'Cancel');
                                                                                                  },
                                                                                                ),
                                                                                                MaterialButton(
                                                                                                  height: 28,
                                                                                                  color: Color(
                                                                                                      0xFF48c0d8),
                                                                                                  child: new Text(
                                                                                                    "Delete",
                                                                                                    style: TextStyle(
                                                                                                        color: Colors
                                                                                                            .black),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    _con
                                                                                                        .deleteTimelineWall(
                                                                                                        userid
                                                                                                            .toString(),
                                                                                                        _con
                                                                                                            .timelinePostData[index]['id']
                                                                                                            .toString());

                                                                                                    Navigator
                                                                                                        .pop(
                                                                                                        context);
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          });
                                                                                    },
                                                                                    child: Container(

                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .center,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Icon(
                                                                                            Icons
                                                                                                .delete_outline,
                                                                                            size: 26,
                                                                                            color: Colors
                                                                                                .white,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .start,
                                                                                            children: <
                                                                                                Widget>[
                                                                                              Text(
                                                                                                "Delete Post",
                                                                                                style: f15wB,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 3,
                                                                                              ),
                                                                                              Text(
                                                                                                "Delete the entire post",
                                                                                                style: f13w,
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                                    : Container(
                                                                                  height: 0,
                                                                                ),
                                                                                //save post
                                                                                Padding(
                                                                                  padding:
                                                                                  const EdgeInsets
                                                                                      .all(
                                                                                      6.0),
                                                                                  child:
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        postid =
                                                                                            _con
                                                                                                .timelinePostData[index]["id"]
                                                                                                .toString();
                                                                                        if(_save[index] ==
                                                                                            true)
                                                                                          {
                                                                                            _save[index] = false;
                                                                                            _con.timelinePostData[index]['save_status']=false;
                                                                                          }
                                                                                        else
                                                                                          {
                                                                                            _save[index] = true;
                                                                                            _con.timelinePostData[index]['save_status']=true;
                                                                                          }
                                                                                      });
                                                                                      _con
                                                                                          .saveTimelinePost(
                                                                                          postid
                                                                                              .toString(),
                                                                                          userid
                                                                                              .toString());
                                                                                      Navigator
                                                                                          .pop(
                                                                                          context);
                                                                                    },
                                                                                    child: Container(
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .center,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Icon(
                                                                                            Icons
                                                                                                .bookmark_border,
                                                                                            size: 26,
                                                                                            color: Colors
                                                                                                .white,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .start,
                                                                                            children: <
                                                                                                Widget>[
                                                                                              Text(
                                                                                                _con.timelinePostData[index]['save_status']? "Saved Post" : "Save Post",
                                                                                                style: f15wB,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 3,
                                                                                              ),
                                                                                              Text(_con.timelinePostData[index]['save_status']? "Added this to your saved post" :
                                                                                                "Add this to your saved post",
                                                                                                style: f13w,
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                //report post
                                                                                userid.toString() != _con.timelinePostData[index]['user_id'].toString()
                                                                                    ? Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .all(
                                                                                      6.0),
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      _con
                                                                                          .reportTimeWall(
                                                                                          userid.toString(),
                                                                                          _con
                                                                                              .timelinePostData[index]['id']);

                                                                                      Navigator
                                                                                          .pop(
                                                                                          context);
                                                                                    },
                                                                                    child: Container(
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .center,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Icon(
                                                                                            Icons
                                                                                                .block,
                                                                                            size: 26,
                                                                                            color: Colors
                                                                                                .white,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .start,
                                                                                            children: <
                                                                                                Widget>[
                                                                                              Text(
                                                                                                "Report & Support",
                                                                                                style: f15wB,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 3,
                                                                                              ),
                                                                                              Text(
                                                                                                "I'am concerned about this post",
                                                                                                style: f13w,
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                                    : Container(
                                                                                  height: 0,
                                                                                ),
                                                                                //follooww user
                                                                                userid.toString() != _con.timelinePostData[index]['user_id'].toString()
                                                                                    ? Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .all(
                                                                                      6.0),
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      _con.timelinePostData[index]["follow_status"] ?
                                                                                      showDialog(
                                                                                          context: context,
                                                                                          builder: (
                                                                                              BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              backgroundColor: Color(
                                                                                                  0xFF1E2026),
                                                                                              content: new Text(
                                                                                                "Do you want to Unfollow "+_con.timelinePostData[index]['name'].toString()+" ?",
                                                                                                style: f14w,
                                                                                              ),
                                                                                              actions: <
                                                                                                  Widget>[
                                                                                                MaterialButton(
                                                                                                  height: 28,
                                                                                                  color: Color(0xFFffd55e),
                                                                                                  child: new Text(
                                                                                                    "Cancel",
                                                                                                    style: TextStyle(
                                                                                                        color: Colors
                                                                                                            .black),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator
                                                                                                        .pop(
                                                                                                        context,
                                                                                                        'Cancel');
                                                                                                  },
                                                                                                ),
                                                                                                MaterialButton(
                                                                                                  height: 28,
                                                                                                  color: Color(0xFF48c0d8),
                                                                                                  child: new Text(
                                                                                                    "Unfollow",
                                                                                                    style: TextStyle(
                                                                                                        color: Colors
                                                                                                            .black),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    setState(() {
                                                                                                      selectedId = index;
                                                                                                    });
                                                                                                    setState(() { _con
                                                                                                        .timelinePostData[index]["follow_status"] = false;});
                                                                                                    _con
                                                                                                        .followerController(
                                                                                                        userid
                                                                                                            .toString(),
                                                                                                        _con
                                                                                                            .timelinePostData[index]['user_id']
                                                                                                            .toString());
                                                                                                    Navigator
                                                                                                        .pop(
                                                                                                        context);

                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          }) :
                                                                                      _con
                                                                                          .followerController(
                                                                                          userid
                                                                                              .toString(),
                                                                                          _con
                                                                                              .timelinePostData[index]['user_id']
                                                                                              .toString());
                                                                                      if(_con
                                                                                          .timelinePostData[index]["follow_status"] ==
                                                                                          false){
                                                                                        setState(() { _con
                                                                                            .timelinePostData[index]["follow_status"] = true;});
                                                                                      }

                                                                                      Navigator
                                                                                          .pop(
                                                                                          context);
                                                                                    },
                                                                                    child: Container(

                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .center,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Image
                                                                                              .asset(
                                                                                            "assets/Template1/image/Foodie/icons/person.png",
                                                                                            height: 21,
                                                                                            width: 21,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 16,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .start,
                                                                                            children: <
                                                                                                Widget>[
                                                                                              _con
                                                                                                  .timelinePostData[index]["follow_status"] ==
                                                                                                  true
                                                                                                  ? Text(
                                                                                                "Unfollow",
                                                                                                style: f15wB,
                                                                                              )
                                                                                                  : Text(
                                                                                                "Follow",
                                                                                                style: f15wB,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 3,
                                                                                              ),
                                                                                              _con
                                                                                                  .timelinePostData[index]["follow_status"] ==
                                                                                                  true
                                                                                                  ? Text(
                                                                                                "Unfollow  " +
                                                                                                    _con
                                                                                                        .timelinePostData[index]["name"],
                                                                                                style: f13w,
                                                                                              )
                                                                                                  : Text(
                                                                                                "Follow  " +
                                                                                                    _con
                                                                                                        .timelinePostData[index]["name"],
                                                                                                style: f13w,
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                                    : Container(
                                                                                  height: 0,
                                                                                ),
                                                                                // copy   post
                                                                                Padding(
                                                                                  padding:
                                                                                  const EdgeInsets
                                                                                      .all(
                                                                                      6.0),
                                                                                  child:
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        postid =
                                                                                            _con
                                                                                                .timelinePostData[index]['id']
                                                                                                .toString();
                                                                                        sharePost =
                                                                                            "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                                                                postid
                                                                                                    .toString();
                                                                                      });

                                                                                      Clipboard
                                                                                          .setData(
                                                                                          new ClipboardData(
                                                                                              text: sharePost
                                                                                                  .toString()));
                                                                                      Navigator
                                                                                          .pop(
                                                                                          context);
                                                                                      Fluttertoast
                                                                                          .showToast(
                                                                                          msg: "Link Copied",
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
                                                                                    child: Container(

                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .center,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Icon(
                                                                                            Icons
                                                                                                .link,
                                                                                            size: 26,
                                                                                            color: Colors
                                                                                                .white,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .start,
                                                                                            children: <
                                                                                                Widget>[
                                                                                              Text(
                                                                                                "Copy Link",
                                                                                                style: f15wB,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 3,
                                                                                              ),
                                                                                              Text(
                                                                                                "Copy Post link",
                                                                                                style: f13w,
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                //share post
                                                                                Padding(
                                                                                  padding:
                                                                                  const EdgeInsets
                                                                                      .all(
                                                                                      6.0),
                                                                                  child:
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        postid =
                                                                                            _con
                                                                                                .timelinePostData[index]['id']
                                                                                                .toString();
                                                                                        sharePost =
                                                                                            "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                                                                postid
                                                                                                    .toString();
                                                                                      });
                                                                                      _shareText();
                                                                                    },
                                                                                    child: Container(

                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .center,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Image
                                                                                              .asset(
                                                                                            "assets/Template1/image/Foodie/icons/share.png",
                                                                                            height: 21,
                                                                                            width: 21,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 16,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .start,
                                                                                            children: <
                                                                                                Widget>[
                                                                                              Text(
                                                                                                "Share Post",
                                                                                                style: f15wB,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 3,
                                                                                              ),
                                                                                              Text(
                                                                                                "Share post externally",
                                                                                                style: f13w,
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        });
                                                                  });
                                                            },
                                                            child: Icon(
                                                                Icons.more_vert,
                                                                color:
                                                                Colors.white),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              _con.timelinePostData[index]
                                              ['product_id']!=null && _con.timelinePostData[index]
                                              ['business_type'].toString()!="6" && _con.timelinePostData[index]
                                              ['business_type'].toString()!="4" ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8,bottom: 5,top: 3),
                                                child: SmartText(
                                  text: _con.timelinePostData[index]['item_sub_titile']!=null ?
                                  _con.timelinePostData[index]['item_name'].toString()+"  -  "+_con.timelinePostData[index]['item_sub_titile'] : _con
                                      .timelinePostData[index]['item_name'].toString(),
                                  style: TextStyle(
                                  color: Colors.white,
                                  ),
                                  onOpen: (link) {
                                  Navigator.push(context,
                                  MaterialPageRoute(
                                  builder: (
                                  context) =>
                                  WebViewContainer(
                                  url: link,)
                                  ));
                                  },

                                  onTagClick: (tag) {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (
                                  context) =>
                                  HashSearchAppbar(
                                  hashTag: tag,
                                  )));
                                  },
                                  onUserTagClick: (tag) {
                                  _con.getUseranametoId(context,
                                  tag.toString()
                                      .replaceFirst(
                                  "@", ""));
                                  },
                                  ),
                                              ) : Container(),
                                              _con.timelinePostData[index]
                                              ['post_title'] == null &&
                                              _con.timelinePostData[index]
                                              ['description'] !=
                                                  "" &&
                                                  _con.timelinePostData[index]
                                                  ['description'] != null && _con
                                                  .timelinePostData[index]["business_type"]
                                                  .toString() !="4" && _con
                                                  .timelinePostData[index]["business_type"]
                                                  .toString() !="6"
                                                  ?  Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: _con
                                                    .timelinePostData[index]
                                                ['description'].toString().length >
                                                    130 && /*textSpan==false &&*/
                                                    _showml[index] == false ?
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SmartText(
                                                      text:
                                                      _con
                                                          .timelinePostData[index]['description'].toString()
                                                          .substring(0, 129,) +
                                                          " ...",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      onOpen: (link) {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    WebViewContainer(
                                                                      url: link,)
                                                            ));
                                                      },

                                                      onTagClick: (tag) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    HashSearchAppbar(
                                                                      hashTag: tag,
                                                                    )));
                                                      },
                                                      onUserTagClick: (tag) {
                                                        _con.getUseranametoId(context,
                                                            tag.toString()
                                                                .replaceFirst(
                                                                "@", ""));
                                                      },
                                                    ),
                                                    SizedBox(height: 3,),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            textSpan = true;
                                                            _showml[index] =
                                                            true;
                                                          });
                                                        },
                                                        child: Text(
                                                          "Show more...",
                                                          style: f14p,)),
                                                    SizedBox(height: 2,),
                                                  ],
                                                ) : _con.timelinePostData[index]
                                                ['description'].length > 130 /* &&
                                textSpan == true*/ && _showml[index] == true ?
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SmartText(
                                                      text:
                                                      _con
                                                          .timelinePostData[index]['description'],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      onOpen: (link) {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    WebViewContainer(
                                                                      url: link,)
                                                            ));
                                                      },
                                                      onTagClick: (tag) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    HashSearchAppbar(
                                                                      hashTag: tag,
                                                                    )));
                                                      },
                                                      onUserTagClick: (tag) {
                                                        _con.getUseranametoId(context,
                                                            tag.toString()
                                                                .replaceFirst(
                                                                "@", ""));
                                                      },
                                                    ),
                                                    SizedBox(height: 3,),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            textSpan = false;
                                                            _showml[index] =
                                                            false;
                                                          });
                                                        },
                                                        child: Text(
                                                          "Show less...",
                                                          style: f14p,)),
                                                    SizedBox(height: 2,),
                                                  ],
                                                ) : _con.timelinePostData[index]
                                                ['description'].length <= 130
                                                    ? SmartText(
                                                  text:
                                                  _con
                                                      .timelinePostData[index]['description'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  onOpen: (link) {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                WebViewContainer(
                                                                  url: link,)
                                                        ));
                                                  },
                                                  onTagClick: (tag) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                HashSearchAppbar(
                                                                  hashTag: tag,
                                                                )));
                                                  },
                                                  onUserTagClick: (tag) {
                                                    _con.getUseranametoId(context,tag
                                                        .toString()
                                                        .replaceFirst("@", ""));
                                                  },
                                                )
                                                    : Container(),
                                              )
                                                  : Container(),
                                              _con
                                                  .timelinePostData[index]["shared_post_id"] !=
                                                  null ? Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8, right: 8, top: 5,),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey[300],
                                                          width: .2)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 5, right: 5),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                left: 5.0,
                                                                right: 5.0,
                                                                top: 10,
                                                                bottom: 2),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator
                                                                        .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder:
                                                                                (
                                                                                context) =>
                                                                                TimelineFoodWallDetailPage(
                                                                                  id: _con
                                                                                      .timelinePostData[index]["shared_post_details"]["user_id"]
                                                                                      .toString(),
                                                                                )));
                                                                  },
                                                                  child: Stack(alignment: Alignment.bottomRight,
                                                                    children: [
                                                                      Container(
                                                                        height: 38.0,
                                                                        width: 38.0,
                                                                        child: Center(
                                                                          child: Container(
                                                                            height: 35.0,
                                                                            width: 35.0,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                    image: _con
                                                                                        .timelinePostData[index]["shared_post_details"]["picture"] !=
                                                                                        null
                                                                                        ? CachedNetworkImageProvider(
                                                                                        _con
                                                                                            .timelinePostData[index]["shared_post_details"]["picture"]
                                                                                            .toString()
                                                                                            .replaceAll(
                                                                                            " ",
                                                                                            "%20") +
                                                                                            "?alt=media")
                                                                                        : CachedNetworkImageProvider(
                                                                                      "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                                                                    ),
                                                                                    fit: BoxFit
                                                                                        .cover),
                                                                                borderRadius: BorderRadius
                                                                                    .all(
                                                                                    Radius
                                                                                        .circular(
                                                                                        180.0))),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      _con.timelinePostData[index]["shared_post_details"]["business_type"].toString() == "3" && _con.timelinePostData[index]["shared_post_details"]["post_type"].toString() == "business"  ?  Padding(
                                                                        padding: const EdgeInsets.only(left:18,top: 10),
                                                                        child: Container(
                                                                          height: 22,
                                                                          width: 22,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(150),
                                                                              color: Color(0xFF1E2026)
                                                                          ),
                                                                          child: Center(
                                                                            child: Container(height: 17,
                                                                              width: 17,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(150),
                                                                                  color: Color(0xFF48c0d8)
                                                                              ),
                                                                              child: Center(
                                                                                child: Image.asset(
                                                                                  "assets/tray.png",
                                                                                  height: 12,
                                                                                  width: 12,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ) :
                                                                      _con.timelinePostData[index]["shared_post_details"]["business_type"].toString() == "2" && _con.timelinePostData[index]["shared_post_details"]["post_type"].toString() == "business" ? Padding(
                                                                        padding: const EdgeInsets.only(left:18,top: 10),
                                                                        child: Container(
                                                                          height: 22,
                                                                          width: 22,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(150),
                                                                              color: Color(0xFF1E2026)
                                                                          ),
                                                                          child: Center(
                                                                            child: Container(height: 17,
                                                                              width: 17,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(150),
                                                                                  color: Color(0xFF48c0d8)
                                                                              ),
                                                                              child: Center(
                                                                                child: Image.asset(
                                                                                  "assets/Template1/image/Foodie/icons/market.png",
                                                                                  height: 12,
                                                                                  width: 12,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ) :
                                                                      _con.timelinePostData[index]["shared_post_details"]["business_type"].toString() == "1" && _con.timelinePostData[index]["shared_post_details"]["post_type"].toString() == "business" ?
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left:18,top: 10),
                                                                        child: Container(
                                                                          height: 22,
                                                                          width: 22,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(150),
                                                                              color: Color(0xFF1E2026)
                                                                          ),
                                                                          child: Center(
                                                                            child: Container(height: 17,
                                                                              width: 17,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(150),
                                                                                  color: Color(0xFF48c0d8)
                                                                              ),
                                                                              child: Center(
                                                                                child: Image.asset(
                                                                                  "assets/chef.png",
                                                                                  height: 12,
                                                                                  width: 12,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ) : Container(height: 0,)
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  child:
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator
                                                                          .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (
                                                                                  context) =>
                                                                                  TimelineFoodWallDetailPage(
                                                                                    id: _con
                                                                                        .timelinePostData[index]["shared_post_details"]['user_id']
                                                                                        .toString(),
                                                                                  )));
                                                                    },
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          _con
                                                                              .timelinePostData[index]["shared_post_details"]
                                                                          [
                                                                          'name']
                                                                              .toString(),
                                                                          style: f15wB,
                                                                        ),
                                                                        SizedBox(
                                                                          height: 3,
                                                                        ),
                                                                        Text(
                                                                            d2
                                                                                .toString(),
                                                                            style: f10g)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 25,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        _con
                                                            .timelinePostData[index]["shared_post_details"]
                                                        ['description'] !=
                                                            "" && _con
                                                            .timelinePostData[index]["shared_post_details"]
                                                        ['description'] != null
                                                            ? Padding(
                                                          padding: const EdgeInsets
                                                              .only(left: 8,
                                                              right: 8),
                                                          child: _con
                                                              .timelinePostData[index]["shared_post_details"]
                                                          ['description']
                                                              .length >
                                                              130 && /*textSpan==false &&*/
                                                              _sharedshowml[index] ==
                                                                  false ?
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              SmartText(
                                                                text:
                                                                _con
                                                                    .timelinePostData[index]["shared_post_details"]['description']
                                                                    .substring(
                                                                  0, 129,) +
                                                                    " ...",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onOpen: (link) {
                                                                  Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              WebViewContainer(
                                                                                url: link,)
                                                                      ));
                                                                },
                                                                onTagClick: (
                                                                    tag) {
                                                                  Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              HashSearchAppbar(
                                                                                hashTag: tag,
                                                                              )));
                                                                },
                                                                onUserTagClick: (
                                                                    tag) {
                                                                  _con
                                                                      .getUseranametoId(context,
                                                                      tag
                                                                          .toString()
                                                                          .replaceFirst(
                                                                          "@",
                                                                          ""));
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 3,),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      textSpan =
                                                                      true;
                                                                      _sharedshowml[index] =
                                                                      true;
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    "Show more...",
                                                                    style: f14p,)),
                                                              SizedBox(
                                                                height: 2,),
                                                            ],
                                                          ) : _con
                                                              .timelinePostData[index]["shared_post_details"]
                                                          ['description']
                                                              .length > 130 /* &&
                                textSpan == true*/ && _sharedshowml[index] ==
                                                              true ?
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              SmartText(
                                                                text:
                                                                _con
                                                                    .timelinePostData[index]["shared_post_details"]['description'],
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onOpen: (link) {
                                                                  Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              WebViewContainer(
                                                                                url: link,)
                                                                      ));
                                                                },
                                                                onTagClick: (
                                                                    tag) {
                                                                  Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              HashSearchAppbar(
                                                                                hashTag: tag,
                                                                              )));
                                                                },
                                                                onUserTagClick: (
                                                                    tag) {
                                                                  _con
                                                                      .getUseranametoId(context,
                                                                      tag
                                                                          .toString()
                                                                          .replaceFirst(
                                                                          "@",
                                                                          ""));
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 3,),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      textSpan =
                                                                      false;
                                                                      _sharedshowml[index] =
                                                                      false;
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    "Show less...",
                                                                    style: f14p,)),
                                                              SizedBox(
                                                                height: 2,),
                                                            ],
                                                          ) : _con
                                                              .timelinePostData[index]["shared_post_details"]
                                                          ['description']
                                                              .length <= 130
                                                              ? SmartText(
                                                            text:
                                                            _con
                                                                .timelinePostData[index]["shared_post_details"]['description'],
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            onOpen: (link) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          WebViewContainer(
                                                                            url: link,)
                                                                  ));
                                                            },
                                                            onTagClick: (tag) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          HashSearchAppbar(
                                                                            hashTag: tag,
                                                                          )));
                                                            },
                                                            onUserTagClick: (
                                                                tag) {
                                                              _con
                                                                  .getUseranametoId(context,
                                                                  tag.toString()
                                                                      .replaceFirst(
                                                                      "@", ""));
                                                            },
                                                          )
                                                              : Container(),
                                                        )
                                                            : Container(),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              top: 5,
                                                              bottom: 5),
                                                          child: _con
                                                              .timelinePostData[
                                                          index]["shared_post_details"]['url_image'] !=
                                                              "" && _con
                                                              .timelinePostData[
                                                          index]["shared_post_details"]['url_image'] !=
                                                              null
                                                              ? GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          WebViewContainer(
                                                                            url: _con
                                                                                .timelinePostData[
                                                                            index]["shared_post_details"]['url_link'],)
                                                                  ));
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(5.0),
                                                              child: Container(
                                                                color: Colors
                                                                    .grey[800],
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .stretch,
                                                                  children: [
                                                                    CachedNetworkImage(
                                                                        imageUrl:
                                                                        _con
                                                                            .timelinePostData[
                                                                        index]["shared_post_details"][
                                                                        "url_image"]
                                                                            .toString(),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        placeholder: (
                                                                            context,
                                                                            ind) =>
                                                                            Image
                                                                                .asset(
                                                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                              fit: BoxFit
                                                                                  .cover,)
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top: 5,
                                                                          bottom: 5,
                                                                          left: 8,
                                                                          right: 8),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          Text(
                                                                            _con
                                                                                .timelinePostData[
                                                                            index]["shared_post_details"][
                                                                            "url_site"]
                                                                                .toString(),
                                                                            style: f14w,),
                                                                          SizedBox(
                                                                            height: 4,),
                                                                          Text(
                                                                            _con
                                                                                .timelinePostData[
                                                                            index]["shared_post_details"][
                                                                            "url_title"]
                                                                                .toString(),
                                                                            style: f14w,),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                              : _con
                                                              .timelinePostData[
                                                          index]["shared_post_details"]
                                                          ['post_images']
                                                              .length >
                                                              0 && _con
                                                              .timelinePostData[
                                                          index]["shared_post_details"]
                                                          ['post_images']
                                                              .length == 1
                                                              ? GestureDetector(
                                                            onTap: (){
                                                              Navigator.push(context, MaterialPageRoute(
                                                                  builder: (context) => GalleryScreen(ImageList: _con.timelinePostData[index]["shared_post_details"]['post_images'],)
                                                              ));
                                                            },
                                                                child: Container(
                                                            height: 350,
                                                            width: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width,
                                                            child: CachedNetworkImage(
                                                                placeholder: (
                                                                    context,
                                                                    ind) =>
                                                                    Image.asset(
                                                                      "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                      fit: BoxFit
                                                                          .cover,),
                                                                imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                    _con
                                                                        .timelinePostData[
                                                                    index]["shared_post_details"][
                                                                    "post_images"]
                                                                    [0]['source']
                                                                        .toString()
                                                                        .replaceAll(
                                                                        " ",
                                                                        "%20") +
                                                                    "?alt=media",
                                                                fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                              ) : _con
                                                              .timelinePostData[
                                                          index]["shared_post_details"]
                                                          ['post_images']
                                                              .length >
                                                              0 && _con
                                                              .timelinePostData[
                                                          index]["shared_post_details"]
                                                          ['post_images']
                                                              .length > 1 ?
                                                          GestureDetector(
                                                            onTap: (){
                                                              Navigator.push(context, MaterialPageRoute(
                                                                  builder: (context) => GalleryScreen(ImageList: _con.timelinePostData[index]["shared_post_details"]['post_images'],)
                                                              ));
                                                            },
                                                            child: Container(
                                                                height: 350.0,
                                                                child: new Carousel(
                                                                  boxFit: BoxFit
                                                                      .fill,
                                                                  dotColor: Colors
                                                                      .black,
                                                                  dotSize: 5.5,
                                                                  autoplay: false,
                                                                  dotSpacing: 16.0,
                                                                  dotIncreasedColor: Color(
                                                                      0xFF48c0d8),
                                                                  dotBgColor: Colors
                                                                      .transparent,
                                                                  showIndicator: true,
                                                                  overlayShadow: true,
                                                                  overlayShadowColors: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                      0.2),
                                                                  overlayShadowSize: 0.9,
                                                                  images: _con
                                                                      .timelinePostData[
                                                                  index]["shared_post_details"]
                                                                  ['post_images']
                                                                      .map((
                                                                      item) {
                                                                    return new CachedNetworkImage(
                                                                        placeholder: (
                                                                            context,
                                                                            ind) =>
                                                                            Image
                                                                                .asset(
                                                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                              fit: BoxFit
                                                                                  .cover,),
                                                                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                            item['source']
                                                                                .toString()
                                                                                .replaceAll(
                                                                                " ",
                                                                                "%20") +
                                                                            "?alt=media",
                                                                        imageBuilder: (
                                                                            context,
                                                                            imageProvider) =>
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                  image: imageProvider,
                                                                                  fit: BoxFit
                                                                                      .cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        errorWidget: (
                                                                            context,
                                                                            url,
                                                                            error) =>
                                                                            Icon(
                                                                                Icons
                                                                                    .error));
                                                                  }).toList(),
                                                                )),
                                                          )
                                                              :
                                                          _con.timelinePostData[
                                                          index]["shared_post_details"][
                                                          "youtube_video_id"]
                                                              .toString()
                                                              .length == 11 &&
                                                              _con
                                                                  .timelinePostData[
                                                              index]["shared_post_details"][
                                                              "youtube_video_id"] !=
                                                                  null
                                                              ? Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              WebViewContainer(
                                                                                url: 'https://www.youtube.com/watch?v=' +
                                                                                    _con
                                                                                        .timelinePostData[index]["shared_post_details"]
                                                                                    ['youtube_video_id']
                                                                                        .toString(),)
                                                                      ));
                                                                },
                                                                child: Stack(
                                                                  alignment: Alignment
                                                                      .center,
                                                                  children: [
                                                                    CachedNetworkImage(
                                                                        imageUrl: "https://img.youtube.com/vi/" +
                                                                            _con
                                                                                .timelinePostData[
                                                                            index]["shared_post_details"][
                                                                            "youtube_video_id"]
                                                                                .toString() +
                                                                            "/0.jpg",
                                                                        height: 200,
                                                                        width: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        placeholder: (
                                                                            context,
                                                                            ind) =>
                                                                            Image
                                                                                .asset(
                                                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                              fit: BoxFit
                                                                                  .cover,)
                                                                    ),
                                                                    Image.asset(
                                                                      "assets/Template1/image/Foodie/icons/youtube.png",
                                                                      height: 32,
                                                                      width: 32,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              _con
                                                                  .timelinePostData[index]["shared_post_details"]
                                                              ['youtube_title']
                                                                  .length >
                                                                  130 && /*textSpan==false &&*/
                                                                  _showSharedutube[index] ==
                                                                      false ?
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 8.0,
                                                                    right: 8,
                                                                    top: 5,
                                                                    bottom: 2),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    SmartText(
                                                                      text:
                                                                      _con
                                                                          .timelinePostData[index]["shared_post_details"]['youtube_title']
                                                                          .substring(
                                                                        0,
                                                                        130,) +
                                                                          " ...",
                                                                      style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      onOpen: (
                                                                          link) {
                                                                        Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (
                                                                                    context) =>
                                                                                    WebViewContainer(
                                                                                      url: link,)
                                                                            ));
                                                                      },

                                                                      onTagClick: (
                                                                          tag) {
                                                                        Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (
                                                                                    context) =>
                                                                                    HashSearchAppbar(
                                                                                      hashTag: tag,
                                                                                    )));
                                                                      },
                                                                      onUserTagClick: (
                                                                          tag) {
                                                                        _con
                                                                            .getUseranametoId(context,
                                                                            tag
                                                                                .toString()
                                                                                .replaceFirst(
                                                                                "@",
                                                                                ""));
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,),
                                                                    GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            textSpan =
                                                                            true;
                                                                            _showSharedutube[index] =
                                                                            true;
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                          "Show more...",
                                                                          style: f14p,)),
                                                                    SizedBox(
                                                                      height: 2,),
                                                                  ],
                                                                ),
                                                              ) : _con
                                                                  .timelinePostData[index]["shared_post_details"]
                                                              ['youtube_title']
                                                                  .length > 130 /* &&
                                textSpan == true*/ && _showSharedutube[index] ==
                                                                  true ?
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 8.0,
                                                                    right: 8,
                                                                    top: 5,
                                                                    bottom: 2),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    SmartText(
                                                                      text:
                                                                      _con
                                                                          .timelinePostData[index]["shared_post_details"]['youtube_title'],
                                                                      style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      onOpen: (
                                                                          link) {
                                                                        Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (
                                                                                    context) =>
                                                                                    WebViewContainer(
                                                                                      url: link,)
                                                                            ));
                                                                      },
                                                                      onTagClick: (
                                                                          tag) {
                                                                        Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (
                                                                                    context) =>
                                                                                    HashSearchAppbar(
                                                                                      hashTag: tag,
                                                                                    )));
                                                                      },
                                                                      onUserTagClick: (
                                                                          tag) {
                                                                        _con
                                                                            .getUseranametoId(context,
                                                                            tag
                                                                                .toString()
                                                                                .replaceFirst(
                                                                                "@",
                                                                                ""));
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,),
                                                                    GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            textSpan =
                                                                            false;
                                                                            _showSharedutube[index] =
                                                                            false;
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                          "Show less...",
                                                                          style: f14p,)),
                                                                    SizedBox(
                                                                      height: 2,),
                                                                  ],
                                                                ),
                                                              ) : _con
                                                                  .timelinePostData[index]["shared_post_details"]
                                                              ['youtube_title']
                                                                  .length <= 130
                                                                  ? Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 8.0,
                                                                    right: 8,
                                                                    top: 5,
                                                                    bottom: 2),
                                                                child: SmartText(
                                                                  text:
                                                                  _con
                                                                      .timelinePostData[index]["shared_post_details"]['youtube_title'],
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onOpen: (
                                                                      link) {
                                                                    Navigator
                                                                        .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (
                                                                                context) =>
                                                                                WebViewContainer(
                                                                                  url: link,)
                                                                        ));
                                                                  },
                                                                  onTagClick: (
                                                                      tag) {
                                                                    Navigator
                                                                        .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (
                                                                                context) =>
                                                                                HashSearchAppbar(
                                                                                  hashTag: tag,
                                                                                )));
                                                                  },
                                                                  onUserTagClick: (
                                                                      tag) {
                                                                    _con
                                                                        .getUseranametoId(context,
                                                                        tag
                                                                            .toString()
                                                                            .replaceFirst(
                                                                            "@",
                                                                            ""));
                                                                  },
                                                                ),
                                                              )
                                                                  : Container(),
                                                            ],
                                                          ) : _con
                                                              .timelinePostData[index]["shared_post_details"]
                                                          [
                                                          "youtube_video_id"]
                                                              .toString()
                                                              .length != 11 &&
                                                              _con
                                                                  .timelinePostData[
                                                              index]["shared_post_details"][
                                                              "youtube_video_id"] !=
                                                                  null ?
                                                          GestureDetector(
                                                            onTap: (){
                                                              Navigator.push(context, MaterialPageRoute(
                                                                  builder: (context) => FoodieTimelineWallVideos(idddd:  _con.timelinePostData[index]["shared_post_details"]["id"],)
                                                              ));
                                                            },
                                                            child: Stack(alignment: Alignment.center,
                                                              children: [
                                                                Container(
                                                                  height: 350,
                                                                  width: MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .width,
                                                                  child: CachedNetworkImage(
                                                                      imageUrl:  _con.timelinePostData[
                                                                      index]["shared_post_details"]["video_image"]!=null ? _con.timelinePostData[
                                                                      index]["shared_post_details"]["video_image"] : "",
                                                                      fit: BoxFit.cover,
                                                                      placeholder: (context,
                                                                          ind) => Container( height: 350,
                                                                        width: MediaQuery
                                                                            .of(context)
                                                                            .size
                                                                            .width,
                                                                        child: Image.asset(
                                                                          "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                          fit: BoxFit.cover,),
                                                                      )
                                                                  ),
                                                                ),
                                                                Icon(Icons.play_arrow,color: Color(0xFF1E2026),size: 60,)
                                                              ],
                                                            ),
                                                          )

                                                              : Container(
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : Container(height: 0),
                                              _con
                                                  .timelinePostData[index]["shared_post_id"] !=
                                                  null && _con
                                                  .timelinePostData[index]["business_type"]
                                                  .toString() =="6" ? SizedBox(height: 5,) : Container(),
                                              _con
                                                  .timelinePostData[index]["business_type"]
                                                  .toString() =="6" && _con
                                                  .timelinePostData[index]["shared_post_id"] ==
                                                  null ? Padding(
                                                    padding: const EdgeInsets.only(top:5.0),
                                                    child: Container(
                                                color: Colors.grey[850],
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 8,),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:10,right: 10,bottom: 5),
                                                          child: Text(_con
                                                              .timelinePostData[index]
                                                          ['item_name'].toString()+" @ Rs."+_con
                                                              .timelinePostData[index]
                                                          ['item_price'].toString(),style: f15wB,),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top:6,),
                                                          child: _con
                                                              .timelinePostData[index]
                                                          ['post_images']
                                                              .length >
                                                              0 && _con
                                                              .timelinePostData[
                                                          index]
                                                          ['post_images']
                                                              .length == 1 && _con
                                                              .timelinePostData[index]["business_type"]
                                                              .toString() =="6"
                                                              ? Container(
                                                            height: 300,
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width,
                                                            child: CachedNetworkImage(
                                                                imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                    _con.timelinePostData[
                                                                    index][
                                                                    "post_images"]
                                                                    [0]['source']
                                                                        .toString()
                                                                        .replaceAll(
                                                                        " ", "%20") +
                                                                    "?alt=media",
                                                                fit: BoxFit.cover,
                                                                placeholder: (context,
                                                                    ind) => Image.asset(
                                                                  "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                  fit: BoxFit.cover,)
                                                            ),
                                                          ) : _con
                                                              .timelinePostData[
                                                          index]
                                                          ['post_images']
                                                              .length >
                                                              0 && _con
                                                              .timelinePostData[
                                                          index]
                                                          ['post_images']
                                                              .length > 1 && _con
                                                              .timelinePostData[index]["business_type"]
                                                              .toString() =="6" ?
                                                          Container(
                                                              height: 300.0,
                                                              child: new Carousel(
                                                                boxFit: BoxFit.fill,
                                                                dotColor: Colors.black,
                                                                dotSize: 5.5,
                                                                autoplay: false,
                                                                dotSpacing: 16.0,
                                                                dotIncreasedColor: Color(
                                                                    0xFF48c0d8),
                                                                dotBgColor: Colors
                                                                    .transparent,
                                                                showIndicator: true,
                                                                overlayShadow: true,
                                                                overlayShadowColors: Colors
                                                                    .white
                                                                    .withOpacity(0.2),
                                                                overlayShadowSize: 0.9,
                                                                images: _con
                                                                    .timelinePostData[
                                                                index]
                                                                ['post_images'].map((
                                                                    item) {
                                                                  return new CachedNetworkImage(
                                                                    placeholder: (context,
                                                                        ind) =>
                                                                        Image.asset(
                                                                          "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                          fit: BoxFit
                                                                              .cover,),
                                                                    imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                        item['source']
                                                                            .toString()
                                                                            .replaceAll(
                                                                            " ", "%20") +
                                                                        "?alt=media",
                                                                    imageBuilder: (
                                                                        context,
                                                                        imageProvider) =>
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                            image: DecorationImage(
                                                                              image: imageProvider,
                                                                              fit: BoxFit
                                                                                  .cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                  );
                                                                }).toList(),
                                                              ))
                                                              : Container(height: 0,),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top:8,bottom: 8,left: 10,right: 10),
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(DateFormat.yMMMd().format(DateTime.parse(
                                                                    _con.timelinePostData[index]["created_at"]["date"])).toString(),style: f13w,),
                                                                Row(
                                                                    children: [
                                                                      Text("\u20B9 "+_con
                                                                          .timelinePostData[index]
                                                                      ['item_price'].toString(),style: f16wB,),
                                                                    userid.toString()!= _con.timelinePostData[index]["user_id"].toString() ?  SizedBox(width: 15,) : Container(height: 0,),
                                                                      userid.toString()!= _con.timelinePostData[index]["user_id"].toString() ?   Container(
                                                                        height: 25,
                                                                        child: MaterialButton(
                                                                          color: Color(0xFFffd55e),
                                                                          splashColor: Color(0xFF48c0d8),
                                                                          height: 25,
                                                                          minWidth: 90,

                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8)
                                                                          ),
                                                                          onPressed: (){
                                                                            _con.updateViewCountOfPost(_con
                                                                                .timelinePostData[index]["id"].toString());
                                                                            try {
                                                                            String chatID = makeChatId(
                                                                                timelineIdFoodi
                                                                                    .toString(),
                                                                                _con
                                                                                    .timelinePostData[index]["timeline_parent_id"].toString());
                                                                            Navigator
                                                                                .push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (
                                                                                        context) =>
                                                                                        ChatRoom(
                                                                                            timelineIdFoodi.toString(),
                                                                                            NAME,
                                                                                            _con
                                                                                                .timelinePostData[
                                                                                            index]
                                                                                            [
                                                                                            'device_token']
                                                                                                .toString(),
                                                                                            _con
                                                                                                .timelinePostData[
                                                                                            index]
                                                                                            [
                                                                                            'timeline_parent_id']
                                                                                                .toString(),
                                                                                            chatID,
                                                                                            _con
                                                                                                .timelinePostData[
                                                                                            index]
                                                                                            [
                                                                                            'username']
                                                                                                .toString(),
                                                                                            _con
                                                                                                .timelinePostData[
                                                                                            index]
                                                                                            [
                                                                                            'name']
                                                                                                .toString(),
                                                                                            _con
                                                                                                .timelinePostData[
                                                                                            index]
                                                                                            [
                                                                                            'picture']
                                                                                                .toString()
                                                                                                .replaceAll(
                                                                                                " ",
                                                                                                "%20") +
                                                                                                "?alt=media",
                                                                                            "Hai "+_con.timelinePostData[index]["name"].toString()+" . I'am interested this item https://saasinfomedia.com/butomy/foodimarket/product/"+
                                                                                                _con.timelinePostData[index]["product_id"].toString())));
                                                                          } catch (e) {
                                                                            print(e
                                                                                .message);
                                                                          }},
                                                                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.chat,
                                                                                size: 17,
                                                                                color: Colors.black,
                                                                              ),
                                                                              SizedBox(width: 3,),
                                                                              Text("Chat",style: f14B,),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ) : Container(height: 0,)
                                                                    ],
                                                                )
                                                              ],
                                                          ),
                                                        )
                                                      ],
                                                ),
                                              ),
                                                  ) : Container(height: 0,),
                                              _con
                                                  .timelinePostData[index]["business_type"]
                                                  .toString() =="6" ?  SizedBox(height: 5,) : Container(),
                                              _con
                                                  .timelinePostData[index]["business_type"]
                                                  .toString() =="4" && _con
                                                  .timelinePostData[index]["shared_post_id"] ==
                                                  null ? Padding(
                                                    padding: const EdgeInsets.only(left:8,right: 8,top: 5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey[300],
                                                              width: .2)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("FREE FOOD ITEM",style: f16wB,),
                                                          SizedBox(height: 3,),
                                                          Text(_con
                                                              .timelinePostData[index]
                                                          ['item_name'].toString(),style: f15wB,),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top:6,bottom: 7),
                                                            child: _con
                                                                .timelinePostData[index]
                                                            ['post_images']
                                                                .length >
                                                                0 && _con
                                                                .timelinePostData[
                                                            index]
                                                            ['post_images']
                                                                .length == 1 && _con
                                                                .timelinePostData[index]["business_type"]
                                                                .toString() =="4"
                                                                ? Container(
                                                              height: 300,
                                                              width: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width,
                                                              child: CachedNetworkImage(
                                                                  imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                      _con.timelinePostData[
                                                                      index][
                                                                      "post_images"]
                                                                      [0]['source']
                                                                          .toString()
                                                                          .replaceAll(
                                                                          " ", "%20") +
                                                                      "?alt=media",
                                                                  fit: BoxFit.cover,
                                                                  placeholder: (context,
                                                                      ind) => Image.asset(
                                                                    "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                    fit: BoxFit.cover,)
                                                              ),
                                                            ) : _con
                                                                .timelinePostData[
                                                            index]
                                                            ['post_images']
                                                                .length >
                                                                0 && _con
                                                                .timelinePostData[
                                                            index]
                                                            ['post_images']
                                                                .length > 1 && _con
                                                                .timelinePostData[index]["business_type"]
                                                                .toString() =="4" ?
                                                            Container(
                                                                height: 300.0,
                                                                child: new Carousel(
                                                                  boxFit: BoxFit.fill,
                                                                  dotColor: Colors.black,
                                                                  dotSize: 5.5,
                                                                  autoplay: false,
                                                                  dotSpacing: 16.0,
                                                                  dotIncreasedColor: Color(
                                                                      0xFF48c0d8),
                                                                  dotBgColor: Colors
                                                                      .transparent,
                                                                  showIndicator: true,
                                                                  overlayShadow: true,
                                                                  overlayShadowColors: Colors
                                                                      .white
                                                                      .withOpacity(0.2),
                                                                  overlayShadowSize: 0.9,
                                                                  images: _con
                                                                      .timelinePostData[
                                                                  index]
                                                                  ['post_images'].map((
                                                                      item) {
                                                                    return new CachedNetworkImage(
                                                                      placeholder: (context,
                                                                          ind) =>
                                                                          Image.asset(
                                                                            "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                            fit: BoxFit
                                                                                .cover,),
                                                                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                          item['source']
                                                                              .toString()
                                                                              .replaceAll(
                                                                              " ", "%20") +
                                                                          "?alt=media",
                                                                      imageBuilder: (
                                                                          context,
                                                                          imageProvider) =>
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit
                                                                                    .cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                    );
                                                                  }).toList(),
                                                                ))
                                                                : Container(height: 0,),
                                                          ),
                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                  children: [
                                                                    Icon(Icons.location_on,color: Colors.grey,size: 18,),
                                                                    Text(_con
                                                                        .timelinePostData[
                                                                    index]
                                                                    ['item_distance'].toString()+" km Away",style: f15w,)
                                                                  ],
                                                              ),
                                                           userid.toString()!= _con
                                                               .timelinePostData[
                                                           index]
                                                           ['user_id'].toString() ?  Padding(
                                                             padding: const EdgeInsets.only(bottom:4.0,top: 4),
                                                             child: Container(height: 30,
                                                               child: MaterialButton(
                                                                 splashColor: Color(0xFFffd55e),
                                                                 shape: RoundedRectangleBorder(
                                                                     borderRadius:
                                                                     BorderRadius
                                                                         .circular(
                                                                         6)
                                                                 ),
                                                                 height: 30,
                                                                 minWidth: 150,
                                                                 color: Color(
                                                                     0xFF48c0d9),
                                                                 onPressed: (){
                                                                   _con.updateViewCountOfPost(_con
                                                                       .timelinePostData[index]["id"].toString());
                                                                      Navigator.push(context, MaterialPageRoute(
                                                                        builder: (context) => FoodBankRequestForm(
                                                                          prod_id: _con
                                                                              .timelinePostData[
                                                                          index]
                                                                          ['product_id'].toString(),
                                                                          title: _con
                                                                              .timelinePostData[
                                                                          index]
                                                                          ['item_name'].toString(),
                                                                         owner_devicetoken: _con
                                                                             .timelinePostData[
                                                                         index]
                                                                         ['device_token'].toString(),
                                                                          owner_username: _con
                                                                              .timelinePostData[
                                                                          index]
                                                                          ['username'].toString(),
                                                                          owner_id: _con
                                                                              .timelinePostData[
                                                                          index]
                                                                          ['timeline_parent_id'].toString(),
                                                                          owner: _con
                                                                              .timelinePostData[
                                                                          index]
                                                                          ['name'].toString(),pic: _con
                                                                            .timelinePostData[
                                                                        index]
                                                                        ['post_images'][0]["source"].toString(),
                                                                          post_id: _con
                                                                              .timelinePostData[
                                                                          index]
                                                                          ['id'].toString(),owner_pic: _con
                                                                            .timelinePostData[
                                                                        index]
                                                                        ['picture']+"?alt=media",pickup: _con
                                                                            .timelinePostData[
                                                                        index]
                                                                        ['pickup_time'],
                                                                        )
                                                                      ));
                                                                    },
                                                                 child: Center(child: Text("Request This",style: f15B,)),
                                                               ),
                                                             ),
                                                           ) : Container(height: 0,)
                                                            ],
                                                          )
                                                        ],
                                              ),
                                                      ),
                                                    ),
                                                  ) : Container(height: 0,),
                                              _con.timelinePostData[index]
                                              ['post_title'] != null ? Padding(
                                                padding: const EdgeInsets.only(left: 6, right: 6, bottom: 8, top: 3),
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>BlogDetailPage(
                                                          video_id: _con.timelinePostData[index]["youtube_video_id"],
                                                          video_title: _con.timelinePostData[index]["youtube_title"],
                                                          id: _con.timelinePostData[index]["id"].toString(),
                                                           blogList:  [],
                                                          imageList: _con.timelinePostData[index]["post_images"],
                                                          title: _con.timelinePostData[index]["post_title"],
                                                          desc: _con.timelinePostData[index]['description'],
                                                          date: _con.timelinePostData[index]['created_at']['date'].toString(),
                                                          views: _con.timelinePostData[index]['view_count'].toString(),
                                                          comments: _con.timelinePostData[index]["comments_count"].toString(),
                                                          likes: _con.timelinePostData[index]["likes_count"],
                                                          shares: _con.timelinePostData[index]["share_count"].toString(),
                                                          saveStatus: _con.timelinePostData[index]["save_status"],
                                                          likeStatus: _con.timelinePostData[index]["like_status"],
                                                          // comments: ,
                                                        )
                                                    ));
                                                  },
                                                  child: Container(
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[850],
                                                        borderRadius: BorderRadius.circular(8)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: width,
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: width-165,
                                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    _con.timelinePostData[index]["post_title"],
                                                                    style: f16wB,maxLines: 2,overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                  Text( _con.timelinePostData[index]
                                                                  ['description'],style: f13w,maxLines: 3,overflow: TextOverflow.ellipsis,),

                                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text("Posted "+d.toString(),style: f13w,),
                                                                      Row(
                                                                        children: [
                                                                          Image.asset("assets/Template1/image/Foodie/icons/eye.png",height: 15,width: 15,),
                                                                          SizedBox(width: 4,),
                                                                          Text(_con.timelinePostData[index]
                                                                          ['view_count'].toString()+" Views",style: f13b,)
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),

                                                                  Row(
                                                                    children: [
                                                                      Text("Blog By  ",style: f14w,),
                                                                      Text(_con
                                                                          .timelinePostData[index]['name'],style: f14yB,),
                                                                    ],
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                             Stack(alignment: Alignment.bottomRight,
                                                              children: [
                                                                Container(clipBehavior: Clip.antiAlias,
                                                                  width: 120,
                                                                  height: 132,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(2)
                                                                  ),
                                                                  child: CachedNetworkImage(
                                                                      imageUrl: _con.timelinePostData[
                                                                      index][
                                                                      "post_images"].length >0 ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                          _con.timelinePostData[
                                                                          index][
                                                                          "post_images"]
                                                                          [0]['source']
                                                                              .toString()
                                                                              .replaceAll(" ", "%20") +
                                                                          "?alt=media" : _con.timelinePostData[index]["youtube_video_id"].toString().length == 11 ?
                                                                      "https://img.youtube.com/vi/"+_con.timelinePostData[index]["youtube_video_id"].toString()+"/0.jpg" :
                                                                      /*_con.timelinePostData[index]["youtube_video_id"].toString().length != 11 &&
                                                                          _con.timelinePostData[index]["youtube_video_id"].toString()!=null ? _con.timelinePostData[index]["video_image"]*/ "",
                                                                        fit: BoxFit.cover,placeholder: (context, ind) => Container(
                                                                      clipBehavior: Clip.antiAlias,
                                                                      width: 120,
                                                                      height: 132,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(2)
                                                                      ),
                                                                      child: Image.asset("assets/Template1/image/Foodie/post_dummy.jpeg",fit: BoxFit.cover,))
                                                                  ),
                                                                ),
                                                            userid.toString()== _con.timelinePostData[index]["user_id"].toString() &&
                                                                   _con.timelinePostData[index]["post_type"].toString() =="user" ?
                                                            Container(
                                                                  height: 50,
                                                                  width: 50,
                                                                  child: Center(
                                                                    child: Container(
                                                                      height: 33,
                                                                      width: 33,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.black,
                                                                          borderRadius: BorderRadius.circular(100)
                                                                      ),
                                                                      child: Center(child: Image.asset("assets/Template1/image/Foodie/icons/edit.png",color: Colors.white,height:15,width: 15,)),
                                                                    ),
                                                                  ),
                                                                ) : Container(height: 0,)
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ) : Container(height:0),
                                              _con
                                                  .timelinePostData[index]["business_type"]
                                                  .toString() !="6" && _con.timelinePostData[index]
                                              ['post_title'] == null ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child:
                                                _con.timelinePostData[
                                                index]['url_image'] != "" &&
                                                    _con.timelinePostData[
                                                    index]['url_image'] != null && _con
                                                    .timelinePostData[index]["business_type"]
                                                    .toString() !="4"
                                                    ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                WebViewContainer(
                                                                  url: _con
                                                                      .timelinePostData[
                                                                  index]['url_link'],)
                                                        ));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(5.0),
                                                      child: Container(

                                                      color: Colors.grey[800],
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .stretch,
                                                        children: [
                                                          CachedNetworkImage(
                                                              imageUrl:
                                                              _con
                                                                  .timelinePostData[
                                                              index][
                                                              "url_image"]
                                                                  .toString(),
                                                              fit: BoxFit
                                                                  .cover,
                                                              placeholder: (
                                                                  context,
                                                                  ind) =>
                                                                  Image.asset(
                                                                    "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                    fit: BoxFit
                                                                        .cover,)
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(top: 5,
                                                                bottom: 5,
                                                                left: 8,
                                                                right: 8),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(_con
                                                                    .timelinePostData[
                                                                index][
                                                                "url_site"]
                                                                    .toString(),
                                                                  style: f14w,),
                                                                SizedBox(
                                                                  height: 4,),
                                                                Text(_con
                                                                    .timelinePostData[
                                                                index][
                                                                "url_title"]
                                                                    .toString(),
                                                                  style: f14w,),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                    :
                                                _con
                                                    .timelinePostData[index]
                                                ['post_images']
                                                    .length >
                                                    0 && _con
                                                    .timelinePostData[
                                                index]
                                                ['post_images']
                                                    .length == 1 && _con
                                                    .timelinePostData[index]["business_type"]
                                                    .toString() !="4"
                                                    ? GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => GalleryScreen(ImageList: _con.timelinePostData[index]['post_images'],)
                                                    ));
                                                  },
                                                      child: Container(
                                                  height: 350,
                                                  width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                  child: CachedNetworkImage(
                                                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                            _con.timelinePostData[
                                                            index][
                                                            "post_images"]
                                                            [0]['source']
                                                                .toString()
                                                                .replaceAll(
                                                                " ", "%20") +
                                                            "?alt=media",
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                            ind) => Image.asset(
                                                          "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                          fit: BoxFit.cover,)
                                                  ),
                                                ),
                                                    ) : _con
                                                    .timelinePostData[
                                                index]
                                                ['post_images']
                                                    .length >
                                                    0 && _con
                                                    .timelinePostData[
                                                index]
                                                ['post_images']
                                                    .length > 1 && _con
                                                    .timelinePostData[index]["business_type"]
                                                    .toString() !="4" ?
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => GalleryScreen(ImageList: _con.timelinePostData[index]['post_images'],)
                                                    ));
                                                  },
                                                  child: Container(
                                                      height: 350.0,
                                                      child: new Carousel(
                                                        boxFit: BoxFit.fill,
                                                        dotColor: Colors.black,
                                                        dotSize: 5.5,
                                                        autoplay: false,
                                                        dotSpacing: 16.0,
                                                        dotIncreasedColor: Color(
                                                            0xFF48c0d8),
                                                        dotBgColor: Colors
                                                            .transparent,
                                                        showIndicator: true,
                                                        overlayShadow: true,
                                                        overlayShadowColors: Colors
                                                            .white
                                                            .withOpacity(0.2),
                                                        overlayShadowSize: 0.9,
                                                        images: _con
                                                            .timelinePostData[
                                                        index]
                                                        ['post_images'].map((
                                                            item) {
                                                          return new CachedNetworkImage(
                                                            placeholder: (context,
                                                                ind) =>
                                                                Image.asset(
                                                                  "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                  fit: BoxFit
                                                                      .cover,),
                                                            imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                item['source']
                                                                    .toString()
                                                                    .replaceAll(
                                                                    " ", "%20") +
                                                                "?alt=media",
                                                            imageBuilder: (
                                                                context,
                                                                imageProvider) =>
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                          );
                                                        }).toList(),
                                                      )),
                                                )
                                                    :
                                                _con.timelinePostData[
                                                index][
                                                "youtube_video_id"]
                                                    .toString()
                                                    .length == 11 &&
                                                    _con.timelinePostData[
                                                    index]["youtube_video_id"] !=
                                                        null && _con
                                                    .timelinePostData[index]["business_type"]
                                                    .toString() !="4"
                                                    ?
                                                Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => FoodieTimelineWallVideos(idddd:  _con.timelinePostData[index]["id"],video_id:_con
                                                                .timelinePostData[
                                                            index][
                                                            "youtube_video_id"]
                                                                .toString() ,)
                                                        ));
                                                      },
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .center,
                                                        children: [
                                                          CachedNetworkImage(
                                                              imageUrl: "https://img.youtube.com/vi/" +
                                                                  _con
                                                                      .timelinePostData[
                                                                  index][
                                                                  "youtube_video_id"]
                                                                      .toString() +
                                                                  "/0.jpg",
                                                              height: 200,
                                                              width: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width,
                                                              fit: BoxFit.cover,
                                                              placeholder: (
                                                                  context,
                                                                  ind) =>
                                                                  Image.asset(
                                                                    "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                    fit: BoxFit
                                                                        .cover,)
                                                          ),
                                                          Image.asset(
                                                            "assets/Template1/image/Foodie/icons/youtube.png",
                                                            height: 32,
                                                            width: 32,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    /*FluTube.playlist(
                                                      playlist,
                                                      autoInitialize: true,
                                                      aspectRatio: 16 / 9,
                                                      allowMuting: false,
                                                      looping: true,
                                                      deviceOrientationAfterFullscreen: [
                                                        DeviceOrientation.portraitUp,
                                                        DeviceOrientation.landscapeLeft,
                                                        DeviceOrientation.landscapeRight,
                                                      ],
                                                    ),*/

                                                    _con.timelinePostData[index]
                                                    ['youtube_title'].length >
                                                        130 && /*textSpan==false &&*/
                                                        _showutube[index] ==
                                                            false ?
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(left: 8.0,
                                                          right: 8,
                                                          top: 5,
                                                          bottom: 2),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SmartText(
                                                            text:
                                                            _con
                                                                .timelinePostData[index]['youtube_title']
                                                                .substring(
                                                              0, 130,) + " ...",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            onOpen: (link) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          WebViewContainer(
                                                                            url: link,)
                                                                  ));
                                                            },

                                                            onTagClick: (tag) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          HashSearchAppbar(
                                                                            hashTag: tag,
                                                                          )));
                                                            },
                                                            onUserTagClick: (
                                                                tag) {
                                                              _con
                                                                  .getUseranametoId(context,
                                                                  tag.toString()
                                                                      .replaceFirst(
                                                                      "@", ""));
                                                            },
                                                          ),
                                                          SizedBox(height: 3,),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  textSpan =
                                                                  true;
                                                                  _showutube[index] =
                                                                  true;
                                                                });
                                                              },
                                                              child: Text(
                                                                "Show more...",
                                                                style: f14p,)),
                                                          SizedBox(height: 2,),
                                                        ],
                                                      ),
                                                    ) : _con
                                                        .timelinePostData[index]
                                                    ['youtube_title'].length >
                                                        130 /* &&
                                textSpan == true*/ && _showutube[index] == true
                                                        ?
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(left: 8.0,
                                                          right: 8,
                                                          top: 5,
                                                          bottom: 2),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SmartText(
                                                            text:
                                                            _con
                                                                .timelinePostData[index]['youtube_title'],
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            onOpen: (link) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          WebViewContainer(
                                                                            url: link,)
                                                                  ));
                                                            },
                                                            onTagClick: (tag) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          HashSearchAppbar(
                                                                            hashTag: tag,
                                                                          )));
                                                            },
                                                            onUserTagClick: (
                                                                tag) {
                                                              _con
                                                                  .getUseranametoId(context,
                                                                  tag.toString()
                                                                      .replaceFirst(
                                                                      "@", ""));
                                                            },
                                                          ),
                                                          SizedBox(height: 3,),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  textSpan =
                                                                  false;
                                                                  _showutube[index] =
                                                                  false;
                                                                });
                                                              },
                                                              child: Text(
                                                                "Show less...",
                                                                style: f14p,)),
                                                          SizedBox(height: 2,),
                                                        ],
                                                      ),
                                                    )
                                                        : _con
                                                        .timelinePostData[index]
                                                    ['youtube_title'].length <=
                                                        130 ? Padding(
                                                      padding: const EdgeInsets
                                                          .only(left: 8.0,
                                                          right: 8,
                                                          top: 5,
                                                          bottom: 2),
                                                      child: SmartText(
                                                        text:
                                                        _con
                                                            .timelinePostData[index]['youtube_title'],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        onOpen: (link) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      WebViewContainer(
                                                                        url: link,)
                                                              ));
                                                        },
                                                        onTagClick: (tag) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      HashSearchAppbar(
                                                                        hashTag: tag,
                                                                      )));
                                                        },
                                                        onUserTagClick: (tag) {
                                                          _con.getUseranametoId(context,
                                                              tag.toString()
                                                                  .replaceFirst(
                                                                  "@", ""));
                                                        },
                                                      ),
                                                    ) : Container(),
                                                  ],
                                                ) : _con.timelinePostData[index]
                                                ["youtube_video_id"]
                                                    .toString()
                                                    .length != 11 &&
                                                    _con.timelinePostData[
                                                    index][
                                                    "youtube_video_id"] !=
                                                        null && _con
                                                    .timelinePostData[index]["business_type"]
                                                    .toString() !="4"  ?
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => FoodieTimelineWallVideos(idddd:  _con.timelinePostData[index]["id"],)
                                                    ));
                                                  },
                                                  child: Stack(alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height: 350,
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width,
                                                        child: CachedNetworkImage(
                                                            imageUrl:  _con.timelinePostData[
                                                            index]["video_image"]!=null ? _con.timelinePostData[
                                                                index]["video_image"] : "",
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                ind) => Container( height: 350,
                                                              width: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width,
                                                                  child: Image.asset(
                                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                              fit: BoxFit.cover,),
                                                                )
                                                        ),
                                                      ),
                                                      Icon(Icons.play_arrow,color: Color(0xFF1E2026),size: 60,)
                                                    ],
                                                  ),
                                                )
                                                /*VimeoPlayer(id: _con.timelinePostData[
                                                index][
                                                "youtube_video_id"].toString().replaceAll("/videos/", ""),autoPlay: false,looping: true,)*/
                                                    : Container(
                                                  height: 0,
                                                ),
                                              ) : Container(height: 0,),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7.0,
                                                    right: 7,
                                                    bottom: 5),
                                                child: Container(
                                                  child: InkWell(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  postid = _con
                                                                      .timelinePostData[
                                                                  index]
                                                                  ['id']
                                                                      .toString();
                                                                });
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            LikeCommentSharePage(
                                                                              statusIndex:
                                                                              0,
                                                                            )));
                                                              },
                                                              child: Text(
                                                                  _con
                                                                      .timelinePostData[
                                                                  index]
                                                                  [
                                                                  'likes_count']
                                                                      .toString() +
                                                                      " Likes",
                                                                  style: f14y),
                                                            ),
                                                            SizedBox(
                                                              width: 13,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  postid = _con
                                                                      .timelinePostData[
                                                                  index]
                                                                  ['id']
                                                                      .toString();
                                                                });
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            LikeCommentSharePage(
                                                                              statusIndex:
                                                                              1,
                                                                            )));
                                                                _con
                                                                    .getTimelineWall(
                                                                    userid
                                                                        .toString());
                                                              },
                                                              child: Text(
                                                                  _con
                                                                      .timelinePostData[
                                                                  index]
                                                                  [
                                                                  'comments_count']
                                                                      .toString() +
                                                                      " Comments",
                                                                  style: f14y),
                                                            ),
                                                            SizedBox(
                                                              width: 13,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  postid = _con
                                                                      .timelinePostData[
                                                                  index]
                                                                  ['id']
                                                                      .toString();
                                                                });
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            LikeCommentSharePage(
                                                                              statusIndex:
                                                                              2,
                                                                            )));
                                                              },
                                                              child: Text(
                                                                  _con
                                                                      .timelinePostData[
                                                                  index]
                                                                  [
                                                                  'share_count']
                                                                      .toString() +
                                                                      " Shares",
                                                                  style: f14y),
                                                            )
                                                          ],
                                                        ),
                                                        _con
                                                            .timelinePostData[index]["product_id"] !=
                                                            null && _con
                                                            .timelinePostData[index]["business_type"]
                                                            .toString() !="4" && _con
                                                            .timelinePostData[index]["business_type"]
                                                            .toString() !="6" ? Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _con
                                                                        .AddtoPurchaseList(
                                                                        userid
                                                                            .toString(),
                                                                        _con
                                                                            .timelinePostData[index]['product_id']
                                                                            .toString(),
                                                                        _con
                                                                            .timelinePostData[index]['business_type']
                                                                            .toString(),
                                                                        "1",
                                                                        _con
                                                                            .timelinePostData[index]['item_price']
                                                                            .toString(),
                                                                        _con
                                                                            .timelinePostData[index]['business_page_id']
                                                                            .toString());
                                                                    setState(() {
                                                                      splashcolor[index] =
                                                                      true;
                                                                    });
                                                                  },

                                                                  child: Image
                                                                      .asset(
                                                                    "assets/Template1/image/Foodie/icons/shopping-basket.png",
                                                                    height: 24,
                                                                    width: 24,
                                                                    color: splashcolor[index]
                                                                        ? Color(
                                                                        0xFF48c0d8)
                                                                        : Color(
                                                                        0xFFffd55e),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 16,
                                                                ),
                                                                Container(
                                                                  height: 27,
                                                                  child: MaterialButton(
                                                                    splashColor: _con.timelinePostData[index]['placeorder_type']
                                                                      .toString()=="0" ? Color(0xFF48c0d8) : Color(0xFFffd55e),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(6)
                                                                    ),
                                                                    height: 27,
                                                                    minWidth: 80,
                                  color:_con.timelinePostData[index]['placeorder_type']
                                      .toString()=="0" ?  Color(0xFFffd55e) : Color(0xFF0dc89e),

                                                                    onPressed: (){
                                                                      if(_con
                                                                          .timelinePostData[index]['placeorder_type']
                                                                          .toString()=="0")
                                                                     { _con
                                                                          .buyNow(context,
                                                                          userid.toString(),
                                                                          _con.timelinePostData[index]['product_id'].toString(),
                                                                          _con.timelinePostData[index]['business_type'].toString(),
                                                                          "1",
                                                                          _con
                                                                              .timelinePostData[index]['item_price'],
                                                                          _con
                                                                              .timelinePostData[index]['business_page_id']
                                                                              .toString(),_con.timelinePostData[index]["item_name"],
                                                                     1,_con.timelinePostData[index]["business_name"],_con.timelinePostData[index]["business_address"]);
                                                                   /*  showClearDialog == true ?  showModalBottomSheet(
                                                                         backgroundColor:
                                                                         Color(
                                                                             0xFF1E2026),
                                                                         context:
                                                                         context,
                                                                         clipBehavior: Clip
                                                                             .antiAlias,
                                                                         builder:
                                                                             (
                                                                             BuildContext
                                                                             context) {
                                                                           return StatefulBuilder(
                                                                               builder: (
                                                                                   BuildContext context, StateSetter state) {
                                                                                 return Padding(
                                                                                   padding: const EdgeInsets.only( top: 10,),
                                                                                   child: Wrap(
                                                                                     children: [

                                                                                       Padding(
                                                                                         padding: const EdgeInsets.only(top:10.0),
                                                                                         child: GestureDetector(

                                                                                           child: Container(
                                                                                             height: 47,
                                                                                             width: width,
                                                                                             color: Color(0xFFffd55e),
                                                                                             child: Center(child: Text("Proceed To Cart",style: f16B,)),
                                                                                           ),
                                                                                         ),
                                                                                       )


                                                                                     ],
                                                                                   ),
                                                                                 );
                                                                               });
                                                                         }) : null;*/
                                                                     }
                                                                      if(_con
                                                                          .timelinePostData[index]['placeorder_type']
                                                                          .toString()=="1")
                                                                      {
                                                                        setState(() {
                                                                          selectedDate = DateTime.now().add(Duration(days: 1));
                                                                          listDate = selectedDate.toString().split(" ");
                                                                          selectedTime = TimeOfDay.now();
                                                                          quantity = 1;
                                                                          total = _con
                                                                              .timelinePostData[index]['item_price'];
                                                                          sel_ind = index;
                                                                          var a =selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString().split(":");
                                                                          print("dfgh "+a.toString());
                                                                          if(int.parse(a[0])<=12)
                                                                            timeF="am";
                                                                          else
                                                                            timeF="pm";
                                                                        });
                                                                        showModalBottomSheet(
                                                                            backgroundColor:
                                                                            Color(
                                                                                0xFF1E2026),
                                                                            context:
                                                                            context,
                                                                            clipBehavior: Clip
                                                                                .antiAlias,
                                                                            builder:
                                                                                (
                                                                                BuildContext
                                                                                context) {
                                                                              return StatefulBuilder(
                                                                                  builder: (
                                                                                      BuildContext context,sss. StateSetter state) {
                                                                                    return Padding(
                                                                                      padding: const EdgeInsets.only( top: 10,),
                                                                                      child: Wrap(
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(
                                                                                                left: 12, right: 12,bottom: 5),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Image.asset("assets/Template1/image/Foodie/icons/meal.png",
                                                                                                  height: 30,width: 30,color: Colors.white,),
                                                                                                SizedBox(width: 10,),
                                                                                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text("Pre Order Scheduled On",style: f16wB,),
                                                                                                    SizedBox(height: 3,),
                                                                                                    Text(DateFormat.yMMMEd().format(selectedDate).toString()+", "+
                                                                                                        selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString(),style: f12w,)
                                                                                                  ],
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(
                                                                                                left: 12, right: 12,bottom: 5,top: 5),
                                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                GestureDetector(
                                                                                                  onTap: (){
                                                                                                    _selectDate(context,state);
                                                                                                    // Navigator.pop(context);
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 30,
                                                                                                    width: 120,
                                                                                                    decoration: BoxDecoration(
                                                                                                        color: Color(0xFF0dc89e),
                                                                                                        borderRadius: BorderRadius.circular(8)
                                                                                                    ),
                                                                                                    child: Center(child: Text("Change Schedule",style: f14B,)),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(top: 5,bottom: 5),
                                                                                            child: Container(
                                                                                              color: Color(0xFF23252E),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(12.0),
                                                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Text("Item to Order",style: f16wB,),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.only(top: 10,bottom: 5),
                                                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            children: [
                                                                                                              _con
                                                                                                                  .timelinePostData[index]
                                                                                                              ['post_images']
                                                                                                                  .length > 0 ?  Container(
                                                                                                                height: 60.0,
                                                                                                                width: 60.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                    image: DecorationImage(
                                                                                                                        image: CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                                                                            _con
                                                                                                                                .timelinePostData[index]
                                                                                                                            ['post_images'][0]["source"]+"?alt=media"),
                                                                                                                        fit: BoxFit.cover)),
                                                                                                              ) : Container(),
                                                                                                              SizedBox(width: 7,),
                                                                                                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Text(_con
                                                                                                                      .timelinePostData[index]['item_name'].toString().length>14 ?
                                                                                                                  _con
                                                                                                                      .timelinePostData[index]['item_name'].toString().substring(0,14)+"..." :
                                                                                                                  _con
                                                                                                                      .timelinePostData[index]['item_name'].toString(), style: f15wB),
                                                                                                                  SizedBox(height: 3,),
                                                                                                                  Text(
                                                                                                                    _con
                                                                                                                        .timelinePostData[index]
                                                                                                                    ['name']
                                                                                                                        , style:f14wB,),
                                                                                                                  SizedBox(height: 3,),
                                                                                                                  Text("\u20B9 "+
                                                                                                                      _con
                                                                                                                          .timelinePostData[index]['item_price'].toString(), style:f14wB,),
                                                                                                                ],
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                          Container(
                                                                                                            width: 112.0,
                                                                                                            decoration:
                                                                                                            BoxDecoration(
                                                                                                                color: Color(
                                                                                                                    0xFF1E2026)),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment:
                                                                                                              MainAxisAlignment
                                                                                                                  .spaceAround,
                                                                                                              children: <Widget>[
                                                                                                                /// Decrease of value item
                                                                                                                InkWell(
                                                                                                                  onTap: () {
                                                                                                                    state(() {
                                                                                                                      quantity = quantity - 1;
                                                                                                                      quantity = quantity > 0 ? quantity : 0;

                                                                                                                      total = quantity* _con
                                                                                                                          .timelinePostData[index]['item_price'];
                                                                                                                    });
                                                                                                                  },
                                                                                                                  child: Container(
                                                                                                                    height: 30.0,
                                                                                                                    width: 30.0,
                                                                                                                    decoration:
                                                                                                                    BoxDecoration(
                                                                                                                      color: Color(
                                                                                                                          0xFF1E2026),
                                                                                                                    ),
                                                                                                                    child: Center(
                                                                                                                        child: Text(
                                                                                                                          "-",
                                                                                                                          style: TextStyle(
                                                                                                                              color: Colors
                                                                                                                                  .white,
                                                                                                                              fontWeight:
                                                                                                                              FontWeight
                                                                                                                                  .w800,
                                                                                                                              fontSize:
                                                                                                                              16.0),
                                                                                                                        )),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Padding(
                                                                                                                  padding: const EdgeInsets
                                                                                                                      .symmetric(
                                                                                                                      horizontal:
                                                                                                                      18.0),
                                                                                                                  child: Text(
                                                                                                                    quantity.toString(),
                                                                                                                    style: TextStyle(
                                                                                                                        color: Colors
                                                                                                                            .white,
                                                                                                                        fontWeight:
                                                                                                                        FontWeight
                                                                                                                            .w500,

                                                                                                                        fontSize:
                                                                                                                        16.0),
                                                                                                                  ),
                                                                                                                ),

                                                                                                                /// Increasing value of item
                                                                                                                InkWell(
                                                                                                                  onTap: () {
                                                                                                                    state(() {
                                                                                                                      quantity = quantity + 1;
                                                                                                                      total = quantity* _con
                                                                                                                          .timelinePostData[index]['item_price'];
                                                                                                                    });
                                                                                                                  },
                                                                                                                  child: Container(
                                                                                                                    height: 30.0,
                                                                                                                    width: 28.0,
                                                                                                                    decoration: BoxDecoration(
                                                                                                                        color: Color(
                                                                                                                            0xFF1E2026)),
                                                                                                                    child: Center(
                                                                                                                        child: Text(
                                                                                                                          "+",
                                                                                                                          style: TextStyle(
                                                                                                                              color: Colors
                                                                                                                                  .white,
                                                                                                                              fontWeight:
                                                                                                                              FontWeight
                                                                                                                                  .w500,
                                                                                                                              fontSize:
                                                                                                                              16.0),
                                                                                                                        )),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(top:10.0),
                                                                                            child: GestureDetector(
                                                                                              onTap: (){
                                                                                                _con.Preorder(context,userid.toString(),_con
                                                                                                    .timelinePostData[index]['product_id']
                                                                                                    .toString().toString(),_con
                                                                                                    .timelinePostData[index]["business_type"]
                                                                                                    .toString(),quantity.toString(),_con
                                                                                                    .timelinePostData[index]['item_price']
                                                                                                    .toString(),
                                                                                                    _con
                                                                                                        .timelinePostData[index]['business_page_id']
                                                                                                        .toString(),listDate[0].toString(),
                                                                                                    selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString(),
                                                                                                    _con.timelinePostData[index]["item_name"],
                                                                                                    1,_con.timelinePostData[index]["business_name"],_con.timelinePostData[index]["business_address"]
                                                                                                );
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 47,
                                                                                                width: width,
                                                                                                color: Color(0xFFffd55e),
                                                                                                child: Center(child: Text("Proceed To Cart",style: f16B,)),
                                                                                              ),
                                                                                            ),
                                                                                          )


                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  });
                                                                            });
                                                                      }
                                                                    },
                                                                    child: _con
                                      .timelinePostData[index]['placeorder_type']
                                      .toString()!="" ? Center(
                                          child: Text(
                                            _con
                                                .timelinePostData[index]['placeorder_type']
                                                .toString()=="0" ?
                                            "Buy Now" : "Pre Order",
                                            style: f14B,)) : Container(),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 3,)
                                                              ],
                                                            ),
                                                          ],
                                                        ) : Container()
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7.0,
                                                    right: 7,
                                                    top: 5),
                                                child: Container(
                                                  child: InkWell(
                                                    child: Container(
                                                      height: 20.0,
                                                      width: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: <Widget>[
                                                          _likes[index] ==
                                                              true /*|| _con
                                                              .timelinePostData[
                                                          index]
                                                          [
                                                          'like_status'] == true*/
                                                              ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                postid = _con
                                                                    .timelinePostData[
                                                                index]
                                                                [
                                                                'id']
                                                                    .toString();
                                                                _likes[index] =
                                                                false;
                                                                _con
                                                                    .timelinePostData[index]['like_status'] =
                                                                false;
                                                                _con
                                                                    .timelinePostData[index]['likes_count'] =
                                                                    _con
                                                                        .timelinePostData[index]['likes_count'] -
                                                                        1;
                                                              });
                                                              _con.likePostTime(
                                                                  userid
                                                                      .toString(),
                                                                  postid
                                                                      .toString());
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Color(
                                                                      0xFFffd55e),
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Liked",
                                                                  style:
                                                                  f14w,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                              : GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                postid = _con
                                                                    .timelinePostData[
                                                                index]
                                                                [
                                                                'id']
                                                                    .toString();
                                                                _likes[index] =
                                                                true;
                                                                _con
                                                                    .timelinePostData[index]['like_status'] =
                                                                true;
                                                                _con
                                                                    .timelinePostData[index]['likes_count'] =
                                                                    _con
                                                                        .timelinePostData[index]['likes_count'] +
                                                                        1;
                                                              });
                                                              _con.likePostTime(
                                                                  userid
                                                                      .toString(),
                                                                  postid
                                                                      .toString());
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Like",
                                                                  style:
                                                                  f14w,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                postid = _con
                                                                    .timelinePostData[
                                                                index]
                                                                ['id']
                                                                    .toString();
                                                              });
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (
                                                                          context) =>
                                                                          CommentPage()));
                                                              _con
                                                                  .getTimelineWall(
                                                                  userid);
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .chat_bubble_outline,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Comment",
                                                                  style: f14w,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                postid = _con
                                                                    .timelinePostData[
                                                                index]
                                                                ['id']
                                                                    .toString();
                                                                sharePost =
                                                                    "https://saasinfomedia.com/foodiz/public/sharepost/" +
                                                                        postid
                                                                            .toString();
                                                              });
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          SharePost(
                                                                            postid: postid
                                                                                .toString(),
                                                                            sharepost: sharePost
                                                                                .toString(),)));
                                                              /* panelController
                                                                  .expand();*/
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Image.asset(
                                                                  "assets/Template1/image/Foodie/icons/share.png",
                                                                  height: 16,
                                                                  width: 16,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Share",
                                                                  style: f14w,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          _save[index] ==
                                                              true
                                                              ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _save[index] =
                                                                false;
                                                                _con
                                                                    .timelinePostData[index]['save_status'] =
                                                                false;
                                                                postid = _con
                                                                    .timelinePostData[
                                                                index]
                                                                [
                                                                "id"]
                                                                    .toString();
                                                              });
                                                              _con
                                                                  .saveTimelinePost(
                                                                  postid
                                                                      .toString(),
                                                                  userid
                                                                      .toString());
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .bookmark,
                                                                  color: Color(
                                                                      0xFF48c0d8),
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Saved",
                                                                  style:
                                                                  f14w,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                              : GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _save[index] =
                                                                true;
                                                                _con
                                                                    .timelinePostData[index]['save_status'] =
                                                                true;
                                                                postid = _con
                                                                    .timelinePostData[
                                                                index]
                                                                [
                                                                "id"]
                                                                    .toString();
                                                              });
                                                              _con
                                                                  .saveTimelinePost(
                                                                  postid
                                                                      .toString(),
                                                                  userid
                                                                      .toString());
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .bookmark_border,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Save",
                                                                  style:
                                                                  f14w,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 7,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: isLoading ? 50.0 : 0,
                            color: Colors.transparent,
                            child: Center(
                              child: Theme(
                                  data: ThemeData(
                                      accentColor: Color(0xFF0dc89e)
                                  ),
                                  child: new CircularProgressIndicator(
                                    strokeWidth: 3,)),
                            ),
                          ),
                        ],
                      )
                          : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xFF48c0d8),
                        ),
                      ),
                      _tabContoller.index == 1
                          ? TimelineHomeKitchen(kitcontrooo: _timControoooo,)
                          : Container(),
                      _tabContoller.index == 2
                          ? TimelineLocalStoree(stocontroo: _timControoooo,)
                          : Container(),
                      _tabContoller.index == 3
                          ? TimelineFoodMarcket(stocontroo: _timControoooo,)
                          : Container(),
                      _tabContoller.index == 4
                          ? TimelineFoodBank(bankcontroo: _timControoooo,
                        contheight: _fromTop != 0 ? MediaQuery
                            .of(context)
                            .size
                            .height - 168 : MediaQuery
                            .of(context)
                            .size
                            .height - 240,)
                          : Container(),
                      _tabContoller.index == 5
                          ? TimelineRestaurant(rescontroooo: _timControoooo,)
                          : Container()
                    ],
                  ),
                ),
              )
            ],
          )),
    );

    var _body = Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      //  padding: const EdgeInsets.only(top: 6.0),
      child: Stack(
        children: <Widget>[
          _tabModules,

          _location,
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        if(_tabContoller.index!=0){
          setState(() {
            _tabContoller.index =0;
          });
          return new Future.value(false);
        }
        else
        {
          return  (await showDialog(
            context: context,
            builder: (context) =>
        new AlertDialog(backgroundColor: Color(0xFF1E2026),
          contentPadding: EdgeInsets.only(top: 10, left: 10),
          title: Image.asset(
            "assets/Template1/image/Foodie/logo.png",height: 18,alignment: Alignment.topLeft,
          ),
          titlePadding: EdgeInsets.all(10),
          content: new Text("Are you sure you want to exit?",
              style: f15w),
          actions:
          <Widget>[
            MaterialButton(
              height: 28,
              color: Color(0xFFffd55e),
              child: new Text(
                "Cancel",
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
                "Ok",
                style: TextStyle(
                    color: Colors
                        .black),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],

        ),
        ));}
      },
      child: Scaffold(
        backgroundColor: Color(0xFF1E2026),
        appBar: AppBar(
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          brightness: Brightness.dark,
          elevation: 5,
          title: Image.asset(
            "assets/Template1/image/Foodie/logo.png",height: 23,
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  splashColor: Color(0xFF48c0d8),
                  icon: Image.asset(
                    "assets/Template1/image/Foodie/icons/search.png",
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new searchAppbar()));
                  },
                ),
                IconButton(
                    splashColor: Color(0xFF48c0d8),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new QRCODE()));
                    },
                    icon: Image.asset(
                      "assets/Template1/image/Foodie/QRcode.png",
                      height: 20,
                      width: 20,
                    )),

                IconButton(
                  splashColor: Color(0xFF48c0d8),
                  icon: Stack(
                    children: [
                      Image.asset(
                        "assets/Template1/image/Foodie/icons/bell.png",
                        height: 20,
                        width: 20,
                      ),
                      notificationReadStatus != 0 &&
                          notificationReadStatus != null ?
                      Padding(
                          padding: const EdgeInsets.only(left: 11.0),
                          child: Container(
                            height: 14, width: 14,
                            decoration: BoxDecoration(
                                color: Color(0xFF0dc89e),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text(
                              notificationReadStatus.toString(),
                              style: f10B, textAlign: TextAlign.center,)),
                          )
                      ) : Container(height: 0,)
                    ],
                  ),
                  onPressed: () {
                    _con.notificationRead(userid.toString());
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Notifications()));
                  },
                ),
                IconButton(
                  splashColor: Color(0xFF48c0d8),
                  onPressed: () {
                    // _con.getAccountWallImage(timelineIdFoodi.toString());
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                        new HomeScreenT1()));
                  },
                  icon: Container(
                    height: 28.0,
                    width: 28.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: userPIC != null
                                ? CachedNetworkImageProvider(userPIC)
                                : CachedNetworkImageProvider(
                              "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                            ),
                            fit: BoxFit.cover),
                        borderRadius:
                        BorderRadius.all(Radius.circular(180.0))),
                  ),
                ),
              ],
            )
          ],

        ),
        drawer: Drawer(
          child: Container(
            color: Color(0xFF1E2026),
            child: IDS != null ? ListView(scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  height: 70,
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFF1E2026)),
                    child: Center(
                        child: Image.asset(
                          "assets/Template1/image/Foodie/logo_Business.png",
                          height: 35,
                        )),
                  ),
                ),
                IDS["home_kitchen"].length > 0 ? Column(
                  children: [
                    CustomListTile3(cat: "Home Kitchen", addTap: () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuDrawerHomeKitchen()))},),
                    SizedBox(height: 5,),
                    Container(alignment: Alignment.centerLeft,
                        height: IDS["home_kitchen"].length.toDouble() * 96,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: IDS["home_kitchen"].length,
                            itemBuilder: (context, kit) {
                              Kdate = DateTime.parse(
                                  IDS["home_kitchen"][kit]['created_at']);
                              Kf = DateFormat.yMMMd().format(Kdate);
                              return IDS["home_kitchen"][kit]["verify_status"]
                                  .toString() == "2" ? CustomListTile2(pic:
                              IDS["home_kitchen"][kit]["profile_image"] != null
                                  ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                  IDS["home_kitchen"][kit]["profile_image"] +
                                  "?alt=media"
                                  : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                  "icu.png" + "?alt=media",

                                text: IDS["home_kitchen"][kit]["name"]
                                    .toString(),
                                Desc: "Member since " + Kf.toString(),
                                loc: IDS["home_kitchen"][kit]["address"]
                                    .toString(),
                                onTap: () {
                                  setState(() {
                                    Bus_NAME = IDS["home_kitchen"][kit]["name"];
                                    Bus_Address =
                                    IDS["home_kitchen"][kit]["address"];
                                    Bus_Profile =
                                    IDS["home_kitchen"][kit]["profile_image"] !=
                                        null
                                        ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                        IDS["home_kitchen"][kit]["profile_image"] +
                                        "?alt=media"
                                        : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                        "icu.png" + "?alt=media";
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BusinessPinAfterEntry(typ: "1",phone: IDS["home_kitchen"][kit]["phone"]
                                                  .toString(),
                                                pagid: IDS["home_kitchen"][kit]["page_id"]
                                                    .toString(),
                                                name: IDS["home_kitchen"][kit]["name"],
                                                pin: IDS["home_kitchen"][kit]["business_pin"]
                                                    .toString(),
                                                timid: IDS["home_kitchen"][kit]["timeline_id"]
                                                    .toString(),
                                                memberdate: Kf.toString(),
                                                upld: false,)));

                                  _con.getTimelineWallStart(userid.toString());
                                },
                              ) :
                              IDS["home_kitchen"][kit]["verify_status"]
                                  .toString() == "1" ? CustomListTile(
                                  "assets/Template1/image/Foodie/icons/home-kitchen.png",
                                  'Home Kitchen',
                                  "Your Application is\nunder process",
                                  "Proceed to Documentation",
                                      () =>
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomekitbusinessUpload(
                                                  username:  IDS["home_kitchen"][kit]["username"],
                                                  place: IDS["home_kitchen"][kit]["address"],
                                                  name: IDS["home_kitchen"][kit]["name"],
                                                  pagid: IDS["home_kitchen"][kit]["page_id"]
                                                      .toString(),
                                                  timid: IDS["home_kitchen"][kit]["timeline_id"]
                                                      .toString(),indexx: kit,)))
                                  },
                                  Colors.purple,
                                  12) :
                              IDS["home_kitchen"][kit]["verify_status"]
                                  .toString() == "0" ? CustomListTile(
                                  "assets/Template1/image/Foodie/icons/home-kitchen.png",
                                  'Home Kitchen',
                                  "Your Application is\nunder process",
                                  "Tele Verification  Pending",
                                      () {
                                    _con.updateIDStatus(
                                        IDS["home_kitchen"][kit]["page_id"]
                                            .toString(), "1","1",kit);
                                  },
                                  Colors.green,
                                  12) : Container();
                            })
                    ),
                  ],
                ) : CustomListTile(
                    "assets/Template1/image/Foodie/icons/home-kitchen.png",
                    'Home Kitchen',
                    "Are you passionate about cooking?\nRegister as home kitchen",
                    "Register as Home Chef",
                        () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuDrawerHomeKitchen()))
                    },
                    Colors.lime[900],
                    10),
                IDS["local_store"].length > 0 ? Column(
                  children: [
                    CustomListTile3(cat: "Local Store", addTap: () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuDrawerFoodMarket()))},),
                    SizedBox(height: 5,),
                    Container(alignment: Alignment.centerLeft,
                        height: IDS["local_store"].length.toDouble() * 96,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: IDS["local_store"].length,
                            itemBuilder: (context, sto) {
                              Sdate = DateTime.parse(
                                  IDS["local_store"][sto]['created_at']);
                              Sf = DateFormat.yMMMd().format(Sdate);
                              return IDS["local_store"][sto]["verify_status"]
                                  .toString() == "2" ? CustomListTile2(
                                pic: IDS["local_store"][sto]["profile_image"] !=
                                    null
                                    ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                    IDS["local_store"][sto]["profile_image"] +
                                    "?alt=media"
                                    : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                    "icu.png" + "?alt=media",
                                text: IDS["local_store"][sto]["name"]
                                    .toString(),
                                Desc: "Member Since " + Sf.toString(),
                                loc: IDS["local_store"][sto]["address"]
                                    .toString(),
                                onTap: () {
                                  setState(() {
                                    Bus_NAME = IDS["local_store"][sto]["name"];
                                    Bus_Address =
                                    IDS["local_store"][sto]["address"];
                                    Bus_Profile =
                                    IDS["local_store"][sto]["profile_image"] !=
                                        null
                                        ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                        IDS["local_store"][sto]["profile_image"] +
                                        "?alt=media"
                                        : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                        "icu.png" + "?alt=media";
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BusinessPinAfterEntry(typ: "2",phone: IDS["local_store"][sto]["phone"]
                                                  .toString(),
                                                pagid: IDS["local_store"][sto]["page_id"]
                                                    .toString(),
                                                name: IDS["local_store"][sto]["name"],
                                                pin: IDS["local_store"][sto]["business_pin"]
                                                    .toString(),
                                                timid: IDS["local_store"][sto]["timeline_id"]
                                                    .toString(),
                                                memberdate: Sf.toString(),
                                                upld: false,)));
                                  _con.getTimelineWallStart(userid.toString());
                                },
                              ) :
                              IDS["local_store"][sto]["verify_status"]
                                  .toString() == "1" ? CustomListTile(
                                  "assets/Template1/image/Foodie/icons/market.png",
                                  'Local Market',
                                  "Your Application is\nunder process",
                                  "Proceed to Documentation",
                                      () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LocalbusinessUpload(
                                                  username:  IDS["local_store"][sto]["username"],
                                                  place: IDS["local_store"][sto]["address"],
                                                  name: IDS["local_store"][sto]["name"],
                                                  pagid: IDS["local_store"][sto]["page_id"]
                                                      .toString(),
                                                  timid: IDS["local_store"][sto]["timeline_id"]
                                                      .toString(),indexx: sto,
                                                )));
                                  },
                                  Colors.purple,
                                  12) :
                              IDS["local_store"][sto]["verify_status"]
                                  .toString() == "0" ? CustomListTile(
                                  "assets/Template1/image/Foodie/icons/market.png",
                                  'Local Market',
                                  "Your Application is\nunder process",
                                  "Tele Verification  Pending",
                                      () {
                                    _con.updateIDStatus(
                                        IDS["local_store"][sto]["page_id"]
                                            .toString(), "1","2",sto);
                                  },
                                  Colors.green,
                                  12) : Container();
                            })
                    ),
                  ],
                ) : CustomListTile(
                    "assets/Template1/image/Foodie/icons/market.png",
                    'Local Market',
                    "Register as a local supplier",
                    "Register Local Shop",
                        () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuDrawerFoodMarket()))
                    },
                    Colors.lime[900],
                    10),
                IDS["restaurant"].length > 0 ? Column(
                  children: [
                    CustomListTile3(cat: "Restaurant", addTap: () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuDrawerRestaurant()))},),
                    SizedBox(height: 5,),
                    Container(alignment: Alignment.centerLeft,
                        height: IDS["restaurant"].length.toDouble() * 96,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: IDS["restaurant"].length,
                            itemBuilder: (context, res) {
                              Rdate = DateTime.parse(
                                  IDS["restaurant"][res]['created_at']);
                              Rf = DateFormat.yMMMd().format(Rdate);
                              return IDS["restaurant"][res]["verify_status"]
                                  .toString() == "2" ? CustomListTile2(
                                pic: IDS["restaurant"][res]["profile_image"] !=
                                    null
                                    ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                    IDS["restaurant"][res]["profile_image"] +
                                    "?alt=media"
                                    : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                    "icu.png" + "?alt=media",
                                text: IDS["restaurant"][res]["name"].toString(),
                                Desc: "Member Since " + Rf.toString(),
                                loc: IDS["restaurant"][res]["address"]
                                    .toString(),
                                onTap: () {
                                  setState(() {
                                    Bus_NAME = IDS["restaurant"][res]["name"];
                                    Bus_Address =
                                    IDS["restaurant"][res]["address"];
                                    Bus_Profile =
                                    IDS["restaurant"][res]["profile_image"] !=
                                        null
                                        ? "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                        IDS["restaurant"][res]["profile_image"] +
                                        "?alt=media"
                                        : "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                        "icu.png" + "?alt=media";
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BusinessPinAfterEntry(typ: "3",phone: IDS["restaurant"][res]["phone"]
                                                  .toString(),
                                                pagid: IDS["restaurant"][res]["page_id"]
                                                    .toString(),
                                                name: IDS["restaurant"][res]["name"],
                                                pin: IDS["restaurant"][res]["business_pin"]
                                                    .toString(),
                                                timid: IDS["restaurant"][res]["timeline_id"]
                                                    .toString(),
                                                memberdate: Rf.toString(),
                                                upld: false,)));
                                  _con.getTimelineWallStart(userid.toString());
                                },
                                /*"Sofis Kitchen",
                       "From Kottayam,Kearala",
                       "Member Since Feb 2020",
                       "Home Kitchen", () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) =>
                                 bottomNavBarhome(currentIndex: 0,)));
                   },*/

                              ) :
                              IDS["restaurant"][res]["verify_status"]
                                  .toString() == "1" ?
                              CustomListTile(
                                  "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                                  'Restaurant',
                                  "Your Application is\nunder process",
                                  "Proceed to Documentation",
                                      () =>
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RestbusinessUpload(
                                                  username:  IDS["restaurant"][res]["username"],
                                                  place: IDS["restaurant"][res]["address"],
                                                  name: IDS["restaurant"][res]["name"],
                                                  pagid: IDS["restaurant"][res]["page_id"]
                                                      .toString(),
                                                  timid: IDS["restaurant"][res]["timeline_id"]
                                                      .toString(),indexx: res,)))
                                  },
                                  Colors.purple,
                                  12) : IDS["restaurant"][res]["verify_status"]
                                  .toString() == "0" ? CustomListTile(
                                  "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                                  'Restaurant',
                                  "Your Application is\nunder process",
                                  "Tele Verification  Pending",
                                      () {
                                    _con.updateIDStatus(
                                        IDS["restaurant"][res]["page_id"]
                                            .toString(), "1","3",res);
                                  },
                                  Colors.green,
                                  12) : Container();
                            })
                    ),
                  ],
                ) : CustomListTile(
                    "assets/Template1/image/Foodie/icons/restaurent-wall.png",
                    'Restaurant',
                    "We are Launching Soon",
                    "Register Restaurant",
                        () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuDrawerRestaurant()))
                    },
                    Colors.lime[900],
                    10),

              ],
            ) : Container(),
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: _body,
        ),
        bottomNavigationBar: Container(
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
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/home.png",
                      height: 21,
                      color: Color(0xFFffd55e),
                      width: 21,
                    ),
                    Text("Home", style: f14y,)
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ChatList(timelineIdFoodi.toString(), NAME)
                    ));
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
                           chatmsgcount > 0 ? Container(
                            height: 14, width: 14,
                            decoration: BoxDecoration(
                                color: Color(0xFF0dc89e),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text(
                              chatmsgcount.toString(), style: f10B,
                              textAlign: TextAlign.center,)),
                          ) : Container()
                        ],
                      ),
                      Text("Chat", style: f14w54,)
                    ],
                  ),
                ),
                Container(
                  height: 42,
                  width: 42,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddNewEntries(videooo: "",vid_show: false,typpp: "",)
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
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => purchase()
                    ));
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
                          purchasecount > 0 ? Container(
                            height: 14, width: 14,
                            decoration: BoxDecoration(
                                color: Color(0xFF0dc89e),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text(
                              purchasecount.toString(), style: f10B,
                              textAlign: TextAlign.center,)),
                          ) : Container()
                        ],
                      ),
                      /*    Image.asset(
                        "assets/Template1/image/Foodie/icons/shopping-basket.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23,
                      ),*/
                      Text("Bucket list", style: f14w54,)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CartScreenT1(null,null,false)
                    ));
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
                      Text("Cart", style: f14w54,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

getAvatar(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

getNames(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

class CustomListTile extends StatelessWidget {
  final String img;
  final String text;
  final String botton;
  final Function onTap;
  final String Desc;
  final Color btnclr;
  final double font;

  CustomListTile(this.img, this.text, this.Desc, this.botton, this.onTap,
      this.btnclr, this.font);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        child: InkWell(
          splashColor: Colors.black45,
          child: Card(
            color: Color(0xFF1E2026),
            elevation: 0,
            child: Container(
              height: 92,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white12),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF23252E)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          img,
                          height: 30,
                          width: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(text, textAlign: TextAlign.center, style: f11w)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(width: 178.0,
                              child: Text(
                                Desc,
                                style: TextStyle(
                                    fontSize: font, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container( height: 35.0,
                              child: MaterialButton(
                                splashColor: Color(0xFF48c0d8),
                                height: 35.0,
                                minWidth: 175.0,
                                onPressed: onTap,
                                  color: btnclr,
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6.0)),),
                                child: Center(
                                  child: Text(
                                    botton,
                                    style: f12w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile2 extends StatelessWidget {
  final String text;
  final String pic;
  final Function onTap;
  final String loc;
  final String Desc;

  CustomListTile2({this.text, this.loc, this.Desc, this.onTap, this.pic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5),
      child: InkWell(
        splashColor: Colors.black45,
        child: Card(
          color: Color(0xFF1E2026),
          elevation: 0,
          child: Container(
            height: 80,
            child: InkWell(
              splashColor: Colors.black87,
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      pic,
                                      errorListener: () =>
                                      new Icon(Icons.error),
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(180.0))),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              text,
                              style: f16wB,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              loc,
                              style: f12g,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              Desc,
                              style: f12g,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Image.asset(
                        "assets/Template1/image/Foodie/icons/right-arrow.png",
                        height: 25,
                        width: 25,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile3 extends StatelessWidget {
  final Function addTap;
  final String cat;

  CustomListTile3({this.cat, this.addTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 5, 8.0, 0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF23252E),
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2.0)
          ],
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                cat,
                style: f16wB,
              ),
              GestureDetector(
                  onTap: addTap,
                  child: Image.asset(
                    "assets/Template1/image/Foodie/icons/add-item-plus.png",
                    height: 20,
                    width: 20,
                    color: Color(0xFFffd55e),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
