import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/validations.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDrawerRestaurant extends StatefulWidget {
  @override
  _MenuDrawerRestaurantState createState() => _MenuDrawerRestaurantState();
}

class _MenuDrawerRestaurantState extends StateMVC<MenuDrawerRestaurant> {
  bool autovalidate = false;
  Validations validations = new Validations();
  final TextEditingController _kitchenName=TextEditingController();
  final TextEditingController _FullAddress=TextEditingController();
  final TextEditingController _fssainum=TextEditingController();
  final TextEditingController _place=TextEditingController();
  final TextEditingController _pincode=TextEditingController();
  final TextEditingController _username=TextEditingController();
  final TextEditingController _Mobile=TextEditingController();
  final TextEditingController _Email=TextEditingController();
  int selectedRadio;
  HomeKitchenRegistration _con;
  _MenuDrawerRestaurantState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  String selected_State;
  String selected_State_id;
  String selected_district;
  String selected_category;
  String selected_category_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.stateList();
    _con.getKitchenCategories("3");

  }




  submit(){
    final FormState form = _con.RegFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      _con.RestaurantForm(context,_kitchenName.text.toString(),_FullAddress.text.toString(),
          _username.text.toString(),_Mobile.text.toString(),_Email.text.toString(),
          selected_category_id,"3",selected_State,selected_district,_place.text,
          _pincode.text,_fssainum.text,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF1E2026),iconTheme: IconThemeData(color: Colors.white),
        elevation: 4,titleSpacing: 0,
        brightness: Brightness.dark,
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),
      ),
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Color(0xFF23252E)),
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Register as Restaurant",
                  textAlign: TextAlign.center,
                  style: f15wB,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/28,
            ),
            Text(
              "Partner with Foodizwall\nand do more",
              style: TextStyle(
                  color: Color(0xFF48c0d8),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Get Started",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height/42,
            ),
            Text(
              "Foodizwall is a technology platform helping\nworldwide expand their reach, delight customers and"
                  "\nboost their button line. Partner with us today.",
              style: f14gB,
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height:20
            ),
            Form(
              key:_con.RegFormKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 9.0, right: 9.0, bottom: 5.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
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
                            validator:validations.validateName,
                            controller: _kitchenName,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0.0),
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: "Restaurant Name",
                                hintStyle:
                                f14g
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 9, bottom: 5,left: 9),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.15,
                        ),
                      ),
                      height:50,
                      child: Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: validations.validateUserName,
                          controller: _username,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                              hintText: "Business username",
                              hintStyle:f14g),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 9.0, right: 9.0, bottom: 2.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
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
                            validator: validations.validateFSSAINum,
                            controller: _fssainum,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0.0),
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: "FSSAI License No.",
                                hintStyle:
                                f14g
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10,right: 10,bottom: 5),
                    child: Text("( If not available our team will guide to get registered. Dial : 80866595642 )",style: f10g,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 9.0, right: 9.0, bottom: 5.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
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
                            validator: validations.validateAddr,
                            controller: _FullAddress,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0.0),
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: "Restaurant Address",
                                hintStyle:
                                f14g
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //stateeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 9.0, right: 2.5, bottom: 5.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: MediaQuery.of(context).size.width/2.137,
                          decoration: BoxDecoration(
                            color: Color(0xFF23252E),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.15,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: DropdownButton(isExpanded: true,
                              value: selected_State,
                              hint: Text("State\u002A",style: f14g,),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 9.0, left: 2.5, bottom: 5.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: MediaQuery.of(context).size.width/2.137,
                          decoration: BoxDecoration(
                            color: Color(0xFF23252E),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.15,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: DropdownButton(isExpanded: true,
                              value: selected_district,
                              hint: Text("District\u002A",style: f14g,),

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
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 9.0, right: 2.5, bottom: 5.0),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width/2.137,
                          decoration: BoxDecoration(
                            color: Color(0xFF23252E),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
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
                                validator: validations.validatePlace,
                                controller: _place,
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
                                    hintText: "Place\u002A",
                                    hintStyle:
                                    f14g
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 2.5, right: 9.0, bottom: 5.0),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width/2.137,
                          decoration: BoxDecoration(
                            color: Color(0xFF23252E),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
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
                                validator: validations.validatePincode,
                                controller: _pincode,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.start,
                                autocorrect: false,
                                autofocus: false,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0.0),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: "Pincode\u002A",
                                    hintStyle:
                                    f14g
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 9.0, right: 9.0, bottom: 5.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
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
                            validator: validations.validateMobile,
                            controller: _Mobile,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.start,
                            autocorrect: false,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0.0),
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: "Mobile Number (xxxxxxxxxx)",
                                hintStyle:
                                f14g
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 9.0, right: 9.0, bottom: 5.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF23252E),
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
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
                            validator: validations.validateEmail,
                            controller: _Email,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.start,
                            autocorrect: false,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0.0),
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: "Business Email Address",
                                hintStyle:
                                f14g
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10,left: 10),
                  //   child: Container(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: <Widget>[
                  //         Text("Category",style: f15gB),
                  //         Container(
                  //             width: 200,decoration: BoxDecoration(
                  //             color: Color(0xFF23252E),
                  //             border: Border.all(color: Colors.grey,width: 0.15,),
                  //             borderRadius: BorderRadius.circular(4)
                  //         ),
                  //             height: 50,
                  //             child: Padding(
                  //               padding: const EdgeInsets.only(left:10),
                  //               child: DropdownButton(
                  //                 value: selected_category,
                  //                 hint: Text("Choose Category",style: f14g,),
                  //                 dropdownColor: Color(0xFF1E2026),
                  //                 iconEnabledColor: Colors.grey,
                  //                 iconSize: 25,
                  //                 elevation: 16,isExpanded: true,
                  //                 style: f14w,
                  //                 underline: Container(height: 0,),
                  //                 onChanged: (newValue) {
                  //                   setState(() {
                  //                     selected_category = newValue;
                  //                   });
                  //                 },
                  //                 items: _con.KitchenCategories.map((item) {
                  //                   return DropdownMenuItem(
                  //                     value: item["name"],
                  //                     onTap: (){
                  //                       setState(() {
                  //                         selected_category_id=item["id"].toString();
                  //                       });
                  //                     },
                  //                     child: Text(item["name"]),
                  //                   );
                  //                 }).toList(),
                  //               ),
                  //             )
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height/34
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    "By clicking 'Submit', you agree to ",
                    style: f13g
                ),
                Text(
                    "Foodizwall General Terms and",
                    style: f13y
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Conditions ",
                    style: f13y
                ),
                Text(
                    "and acknowledge you have read the ",
                    style: f13g
                ),
                Text(
                    "Privacy Policy.",
                    style: f13y
                ),
              ],
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
            onPressed: (){
              submit();
            },
            child: Center(
                child: Text(
                  "SUBMIT",
                  style: f15wB,
                )),
          ),
        ),
      ),
    );
  }
}