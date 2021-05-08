import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Controllers/ChatController/testuuu.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/ANOTHERPERSON/loc.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_home_kitchen_timeline.dart';
import 'package:Butomy/image_post.dart';
import 'package:geolocator/geolocator.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Screen/Template1/OnBoarding_Screen/Splash_Screen.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'Screen/Template1/OnBoarding_Screen/check_utube.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends StateMVC<MyApp> {

  HomeKitchenRegistration _con;
  _MyAppState() : super(HomeKitchenRegistration()) {
    _con = controller;
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
    getUserLocation();
    // TODO: implement initState
    super.initState();
    _con.getKitchenCategories("1");
    _con.getOrderStatus();
    _con.getStoreCategories("2");
    _con.getRestaurantCategories("3");
    _con.KitchenTimelineWalls("1");
    // _con.getCARTListControo(userid.toString());
    _con.StoreTimelineWalls("2");
    _con.FoodiMarketTimelineWalls1();
    _con.FoodiBankTimelineWalls1();
    _con.RestaurantTimelineWalls("3");
    _con.getFavouriteList();
    _con.popularKitchen();
    _con.popularStore();
    _con.popularRest();
    _con.stateList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Butomy",
      theme: ThemeData(
        textSelectionColor: Color(0xFFffd55e),
        primaryColor: Color(0xFF1E2026),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenTemplate1(),
    );
  }
}