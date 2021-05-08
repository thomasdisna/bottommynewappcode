import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/validations.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Controllers/UserController/userController.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'SignIn_Screen.dart';
import 'mob_pass_page.dart';

class signupTemplate1 extends StatefulWidget {
  signupTemplate1({Key key}) : super(key: key);

  @override
  _signupTemplate1State createState() => _signupTemplate1State();
}

class _signupTemplate1State extends StateMVC<signupTemplate1> {
  TimelineWallController _con;
  bool autovalidate = false;
  Validations validations = new Validations();

  _signupTemplate1State() : super(TimelineWallController()) {
    _con = controller;
  }

  submit() {
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();

     _con.register_Username_Email_Validation(context,_name.text,_surname.text,_email.text,_dob.text,sex == "0"
         ? "male"
         : sex == "1"
         ? "female"
         : sex == "2"
         ? "other"
         : "male",_lastName.text);
    }
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  String _date = "Date of Birth";
  String sex;
  int selectedRadio;

  @override
  void initState() {
    getUserLocation();
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
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

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(backgroundColor: Color(0xFF1E2026),
        contentPadding: EdgeInsets.only(top: 10, left: 10),
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23, alignment: Alignment.topLeft,
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
    ));
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              Form(
                key: _con.loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
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
                          height: 20.0,
                        ),
                        Text(
                          "Create Account",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 30.0),
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
                                data: ThemeData(hintColor: Colors.transparent),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                    controller: _name,
                                    validator: validations.validateName,
                                    style: new TextStyle(color: Colors.white),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0.0),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: 'First name',
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(
                                          color: Colors.white70,
                                        )),
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
                                data: ThemeData(hintColor: Colors.transparent),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                    controller: _lastName,
                                    validator: validations.validateName,
                                    style: new TextStyle(color: Colors.white),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.text,
                                    autocorrect: false,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0.0),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: 'Last name',
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(
                                          color: Colors.white70,
                                        )),
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
                                data: ThemeData(hintColor: Colors.transparent),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                    controller: _surname,
                                    validator: validations.validateUserName,
                                    style: new TextStyle(color: Colors.white),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0.0),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: 'Username',
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(
                                          color: Colors.white70,
                                        )),
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
                                data: ThemeData(hintColor: Colors.transparent),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                    controller: _email,
                                    validator: validations.validateEmail,
                                    style: new TextStyle(color: Colors.white),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0.0),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: 'Email',
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(
                                          color: Colors.white70,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    /*    GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                    itemStyle: TextStyle(color: Colors.white),
                                    backgroundColor: Color(0xFF23252E)),
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime(2022, 12, 31),
                                onConfirm: (date) {
                                  _date =
                                  '${date.year} - ${date.month} - ${date.day}';
                                  setState(() {});
                                  validations.validateDOB(_date);
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Padding(
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
                                  data: ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          size: 18,
                                          color: Colors.white70,
                                        ),
                                        Text(
                                          " $_date",
                                          style: TextStyle(color: Colors.white70),
                                        )
                                      ],
                                    ),
                                  ),
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
                                data: ThemeData(hintColor: Colors.transparent),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: TextFormField(
                                    controller: _dob,readOnly: true,
                                    onTap: (){
                                      DatePicker.showDatePicker(context,
                                          theme: DatePickerTheme(
                                              itemStyle: TextStyle(color: Colors.white),cancelStyle: TextStyle(color: Color(0xFF48c0d8)),doneStyle: TextStyle(
                                            color: Color(0xFFffd55e)
                                          ),
                                              backgroundColor: Color(0xFF23252E)),
                                          showTitleActions: true,
                                          minTime: DateTime(1950, 1, 1),
                                          maxTime: DateTime.now().subtract(Duration(days: 6570)),
                                          onConfirm: (date) {
                                            _dob.text =
                                            '${date.day} - ${date.month} - ${date.year}';
                                            setState(() {});
                                          },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    validator: validations.validateDOB,
                                    style: new TextStyle(color: Colors.white),
                                    textAlign: TextAlign.start,
                                    autocorrect: false,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0.0),
                                        filled: true,

                                        fillColor: Colors.transparent,
                                        labelText: 'Date of Birth',
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(
                                          color: Colors.white70,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, right: 25, left: 25),
                          child: Container(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white70,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Gender",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: selectedRadio,
                                    activeColor: Color(0xFFffd55e),
                                    onChanged: (val) {
                                      setSelectedRadio(val);
                                      sex = val.toString();
                                    },
                                  ),
                                  Text(
                                    "Male",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Radio(
                                    value: 1,
                                    groupValue: selectedRadio,
                                    activeColor: Color(0xFFffd55e),

                                    onChanged: (val) {

                                      setSelectedRadio(val);
                                      sex = val.toString();
                                    },
                                  ),
                                  Text(
                                    "Female",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: selectedRadio,
                                    activeColor: Color(0xFFffd55e),
                                    onChanged: (val) {

                                      setSelectedRadio(val);
                                      sex = val.toString();
                                    },
                                  ),
                                  Text(
                                    "Other",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
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
                        SizedBox(
                          height: 18.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        signinTemplate1()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Have an account?",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15.0),
                              ),
                              Text(" Signin",
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      color: Color(0xFFffd55e),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15.0))
                            ],
                          ),
                        ),
                      ],
                    ),
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