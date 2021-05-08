import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/validations.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/CART-PAYMENTS-SCREENS/Payment-method-choosing.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/Payout_Screen/Payment_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
as repo;

class PaymentRequestScreen extends StatefulWidget {
  PaymentRequestScreen({this.cartList,this.time,this.date});

  List cartList;
  String date;
  String time;

  @override
  _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
}

class _PaymentRequestScreenState extends StateMVC<PaymentRequestScreen> {

  TimelineWallController _con;

  _PaymentRequestScreenState() : super(TimelineWallController()) {
    _con = controller;
  }

  Validations validations = new Validations();
  bool autovalidate = false;
  
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _home = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _postcode = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();


  @override
  void initState() {
    super.initState();
    setState(() {
      _firstName.text = NAME;
      _phone.text = PHONE;
      _email.text = EMAIL;
      _lastName.text = LNAME!=null ? LNAME : "";
    });
  }

  _submit() {
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      Navigator.push(context, MaterialPageRoute(builder: (context) =>PaymentChoosingScreen(
        date: widget.date,time: widget.time,
        firstname: _firstName.text,
        lastname: _lastName.text,
        email: _email.text,
        phone: _phone.text,
        address: _home.text,
        street: _street.text,
        city: _city.text,
        pincode: _postcode.text,
        itemList: widget.cartList,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "Delivery To",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => TimeLine(false))),
        ),
        // backgroundColor: Color(0xFF1E2026),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 16,left: 16),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Color(0xFFffd55e),
                    size: 22.0,
                  ),
                  _circle(),
                  Icon(
                    Icons.credit_card,
                    color: Colors.white70,
                    size: 21.0,
                  ),
                  _circle(),
                  Icon(
                    Icons.check_circle,
                    color: Colors.white70,
                    size: 21.0,
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Form(
                key: _con.loginFormKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Name",style: f15wB,),
                    SizedBox(height: 3,),
                    TextFormField(
                      validator: validations.validateFirstName,
                      style: f14w,
                      controller: _firstName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "First Name",
                          hintStyle: f14g,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF48c0d8))
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[700]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Last Name",style: f15wB,),
                    SizedBox(height: 3,),
                    TextFormField(
                      style: f14w,
                      validator: validations.validateLastName,
                      controller: _lastName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF48c0d8))
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Last Name",
                          hintStyle: f14g,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[700]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("House Name/Flat No.",style: f15wB,),
                    SizedBox(height: 3,),
                    TextFormField(
                      validator: validations.validateAddr,
                      style: f14w,
                      controller: _home,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF48c0d8))
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Enter you home address",
                          hintStyle: f14g,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[700]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Email",style: f15wB,),
                    SizedBox(height: 3,),
                    TextFormField(
                      validator: validations.validateEmail,
                      style: f14w,
                      controller: _email,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF48c0d8))
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Email",
                          hintStyle: f14g,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[700]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Mobile Number",style: f15wB,),
                    SizedBox(height: 3,),
                    TextFormField(
                      validator: validations.validateMobile,
                      style: f14w,
                      controller: _phone,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF48c0d8))
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Mobile Number",
                          hintStyle: f14g,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[700]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Street",style: f15wB,),
                    SizedBox(height: 3,),
                    TextFormField(
                      style: f14w,
                      controller: _street,
                      validator: validations.validateStreet,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF48c0d8))
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Enter your street",
                          hintStyle: f14g,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[700]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("City",style: f15wB,),
                    SizedBox(height: 3,),
                    TextFormField(
                      validator: validations.validateCity,
                      style: f14w,
                      controller: _city,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF48c0d8))
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Enter your city",
                          hintStyle: f14g,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[700]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("PIN code",style: f15wB,),
                    SizedBox(height: 3,),
                    TextFormField(
                      validator: validations.validatePincode,
                      style: f14w,
                      controller: _postcode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF48c0d8))
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Enter PIN code",
                          hintStyle: f14g,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[700]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48c0d8)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: (){
            _submit();
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFF48c0d8)
            ),
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("Continue",style: f16B,)),
          ),
        ),
      ),
    );
  }
}


Widget _circle() {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 18.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 18.0,
      ),
    ],
  );
}
