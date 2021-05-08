import 'dart:io';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Controllers/UserController/userController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/notificationController.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Components/validations.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiKey = 'AIzaSyAm22_7Hj0aHN09DvP-VmaXSk64dm1WSfg';

class MobilePasswordPage extends StatefulWidget {
  MobilePasswordPage(
      {Key key, this.name, this.surname, this.email, this.dob, this.gender,this.lastname})
      : super(key: key);
  String name, surname, email, dob, gender,lastname;

  @override
  _MobilePasswordPageState createState() => _MobilePasswordPageState();
}

class _MobilePasswordPageState extends StateMVC<MobilePasswordPage> {
  LocationResult _pickedLocation;

  bool autovalidate = false;
  Validations validations = new Validations();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController location_lat = TextEditingController();
  final TextEditingController location_long = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  String _date = "Date of Birth";
  int selectedRadio;
  TimelineWallController _con;

  _MobilePasswordPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  String selected_State;
  String selected_State_id;
  String selected_district;

  LatLng _center ;
  Position currentLocation;

  @override
  void initState() {
    setState(() {
      _location.text = location_address;
      location_lat.text = userLocation.latitude.toString();
      location_long.text = userLocation.longitude.toString();
    });
    print("mobbbbb add "+_location.text);
    print("mobbbbb lat & long "+location_lat.text+" & "+location_long.text);
    // getUserLocation();
    // TODO: implement initState
    NotificationController.instance.takeFCMTokenWhenAppLaunch();
    setCurrentChatRoomID('none');
    // _currentloc();
    super.initState();
    selectedRadio = 0;
    _takeUserInformationFromFBDB();
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    print("llllllllllaaaaaaaattttttt "+currentLocation.latitude.toString());
    print("looooooooonggggggggggggggg "+currentLocation.longitude.toString());
    print("Looooooccccccccc "+currentLocation.toString());
    setState(() {
      location_lat.text = currentLocation.latitude.toString();
      location_long.text = currentLocation.longitude.toString();
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    final coordinates = new Coordinates(userLocation.latitude, userLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("srdtfjcgvkbhlkn;ml ${first.featureName} : ${first.addressLine}");
    setState(() {
      _location.text =first.addressLine;
    });
    print('center $_center');
  }

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _introTextController = TextEditingController();
  File _userImageFile = File('');
  String _userImageUrlFromFB = '';

  bool _isLoading = true;

  _takeUserInformationFromFBDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.get('FCMToken');
    setState(() {fire_token=userToken;});
    FirebaseController.instanace.takeUserInformationFromFBDB().then((documents) {
      if (documents.length > 0) {
        _nameTextController.text = documents[0]['name'];
        _introTextController.text = documents[0]['username'];
        setState(() {
          _userImageUrlFromFB = documents[0]['userImageUrl'];
        });
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  submit() async {
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userToken = prefs.get('FCMToken');
      setState(() {
        fire_token=userToken;
      });


      _con.register(context,
          _name.text,
          _surname.text,
          _email.text,
          _dob.text,
          _gender.text,
          _mobile.text,
          _password.text,
          location_lat.text,
          location_long.text,fire_token.toString(),
          selected_State,selected_district,_location.text,widget.lastname);
    }
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  bool _isPassHidden = true;

  void _togglePassVisibility() {
    setState(() {
      _isPassHidden = !_isPassHidden;
    });
  }

  bool _isPassHidden1 = true;

  void _togglePassVisibility1() {
    setState(() {
      _isPassHidden1 = !_isPassHidden1;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _name.text = widget.name;
      _surname.text = widget.surname;
      _email.text = widget.email;
      _dob.text = widget.dob;
      _gender.text = widget.gender;
    });
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
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
              decoration: BoxDecoration(color: Colors.black12.withOpacity(0.2)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 130.0),
              child: Container(
                height: _height,
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
                    Form(
                      key: _con.loginFormKey,
                      child: Column(
                        children: <Widget>[
                          Visibility(
                            visible: false,
                            child: TextFormField(
                              controller: _name,
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: TextFormField(
                              controller: _surname,
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: TextFormField(
                              controller: _email,
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: TextFormField(
                              controller: _dob,
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: TextFormField(
                              controller: _gender,
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: TextFormField(
                              controller: location_lat,
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: TextFormField(
                              controller: location_long,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 40.0),
                            child: Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Color(0xFF23252E),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  color: Colors.grey[800],
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 5.0),
                                child: Theme(
                                  data:
                                      ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      validator: validations.validateMobile,
                                      controller: _mobile,
                                      style: new TextStyle(color: Colors.white),
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.phone,
                                      autocorrect: false,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(0.0),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          labelText: 'Mobile Number',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /*Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Color(0xFF23252E),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.15,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 5.0),
                                child: Theme(
                                  data:
                                      ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                        controller: _location,
                                        validator: validations.validateLocation,
                                        style:
                                            new TextStyle(color: Colors.white),
                                        // readOnly: true,
                                        textAlign: TextAlign.start,
                                        // keyboardType: TextInputType.phone,
                                        autocorrect: false,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(0.0),
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            labelText: 'Location',
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            labelStyle: TextStyle(
                                              color: Colors.white70,
                                            )),
                                        onTap: () async {
                                          LocationResult result =
                                              await showLocationPicker(
                                            context, apiKey,
                                            initialCenter:
                                                LatLng(10.023286, 76.311371),
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
                                            _location.text = result.address;
                                            location_lat.text = result
                                                .latLng.latitude
                                                .toString();
                                            location_long.text = result
                                                .latLng.longitude
                                                .toString();
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Color(0xFF23252E),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  color: Colors.grey[800],
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 5.0),
                                child: Theme(
                                  data:
                                  ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: DropdownButton(isExpanded: true,
                                      value: selected_State,
                                      hint: Text("State\u002A",style: TextStyle(color: Colors.white70),),
                                      dropdownColor: Color(0xFF1E2026),
                                      iconEnabledColor: Colors.grey,
                                      iconSize: 25,
                                      elevation: 16,
                                      style: f14w,
                                      underline: Container(height: 0,),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selected_State = newValue;
                                        });
                                      },
                                      items: STATES.map((item) {
                                        return DropdownMenuItem(
                                          value: item["name"],
                                          onTap: (){
                                            setState(() {selected_State_id=item["id"].toString();});
                                            _con.DistrictList(selected_State_id.toString());
                                          },
                                          child: Text(item["name"]),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Color(0xFF23252E),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  color: Colors.grey[800],
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 5.0),
                                child: Theme(
                                  data:
                                  ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child:  DropdownButton(isExpanded: true,
                                      value: selected_district,
                                      hint: Text("District\u002A",style: TextStyle(color: Colors.white70,)),
                                      dropdownColor: Color(0xFF1E2026),
                                      iconEnabledColor: Colors.grey,
                                      iconSize: 25,
                                      elevation: 16,
                                      style: f14w,
                                      underline: Container(height: 0,),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selected_district = newValue;
                                        });
                                      },
                                      items: DISTRICTS.map((item) {
                                        return DropdownMenuItem(
                                          value: item["name"],
                                          child: Text(item["name"]),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 53.5,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF23252E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(
                                      color: Colors.grey[800],
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 5),
                                    child: Row(
                                      children: [
                                        Container(width:MediaQuery.of(context).size.width-112,
                                          child: Theme(
                                            data:
                                                ThemeData(hintColor: Colors.transparent),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: TextFormField(
                                                controller: _password,
                                                obscureText: _isPassHidden,
                                                validator: validations.validatePassword,
                                                style: new TextStyle(color: Colors.white),
                                                textAlign: TextAlign.start,
                                                keyboardType: TextInputType.text,
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    filled: true,  contentPadding: EdgeInsets.symmetric(vertical: 0),
                                                    fillColor: Colors.transparent,
                                                    labelText: 'Password',
                                                    hintStyle:
                                                        TextStyle(color: Colors.white),
                                                    labelStyle: TextStyle(
                                                      color: Colors.white70,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _togglePassVisibility();
                                          },
                                          icon: _isPassHidden
                                              ? Icon(
                                            Icons.visibility_off,
                                            size: 21,
                                            color: Colors.white70,
                                          )
                                              : Icon(Icons.visibility,
                                              size: 21,
                                              color: Colors.white70),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:8,left: 2,right: 2),
                                  child: Container(
                                    child: Text("Password need with minimum 8 characters and include"
                                        " letters, numbers and special characters...",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey,fontSize: 12.5),),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Color(0xFF23252E),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  color: Colors.grey[800],
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0,  top: 5.0),
                                child: Row(
                                  children: [
                                    Container(width:MediaQuery.of(context).size.width-112,
                                      child: Theme(
                                        data:
                                            ThemeData(hintColor: Colors.transparent),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            validator: (val) {
                                              if (val.isEmpty)
                                                return "please confirm password !!!";
                                              if (val != _password.text)
                                                return "Password not Match !!!";
                                              return null;
                                            },
                                            controller: _confirmpassword,
                                            style: new TextStyle(color: Colors.white),
                                            textAlign: TextAlign.start,
                                            keyboardType: TextInputType.text,
                                            autocorrect: false,
                                            autofocus: false,
                                            obscureText: _isPassHidden1,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,

                                                contentPadding: EdgeInsets.symmetric(vertical: 0),
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                labelText: 'Confirm Password',
                                                hintStyle:
                                                    TextStyle(color: Colors.white),
                                                labelStyle: TextStyle(
                                                  color: Colors.white70,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _togglePassVisibility1();
                                      },
                                      icon: _isPassHidden1
                                          ? Icon(
                                        Icons.visibility_off,
                                        size: 21,
                                        color: Colors.white70,
                                      )
                                          : Icon(Icons.visibility,
                                          size: 21,
                                          color: Colors.white70),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 64.0),
                      child: MaterialButton(
                        onPressed: () {
                          submit();
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
                          "Next",
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
    );
  }
}
