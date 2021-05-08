import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/CART-PAYMENTS-SCREENS/razor_pay.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/CART-PAYMENTS-SCREENS/ConfirmpaymenScreent.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/Payout_Screen/Confirm_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/Payout_Screen/Delivery_Screen_T1.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PaymentChoosingScreen extends StatefulWidget {
  PaymentChoosingScreen({this.time,this.date,this.email,this.lastname,this.address,
    this.pincode,this.phone,this.city,this.firstname,this.street,this.itemList,this.locName});

  String firstname,lastname,email,phone,street,address,city,pincode,locName;
  List itemList;
  String date;
  String time;

  @override
  _PaymentChoosingScreenState createState() => _PaymentChoosingScreenState();
}

class _PaymentChoosingScreenState extends StateMVC<PaymentChoosingScreen> {

  HomeKitchenRegistration _con;
  _PaymentChoosingScreenState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }


  @override
  String _date = "06/23";

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        iconTheme: IconThemeData(color: white),
        title: Text(
          "Payment Methods",
          style: TextStyle(

              color: Colors.white,
              fontWeight: FontWeight.normal),
        ),
        backgroundColor: Color(0xFF1E2026),
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
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
                _circleOrange(),
                Icon(
                  Icons.credit_card,
                  color: Color(0xFFffd55e),
                  size: 21.0,
                ),
                _circleWhite(),
                Icon(
                  Icons.check_circle,
                  color: Colors.white70,
                  size: 21.0,
                ),
              ],
            ),
            SizedBox(
              height: 100.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ConfirmOrderScreen(
                  loc_name: widget.locName,
                  kitaddress: "",
                  type: "0",
                  date: widget.date,time: widget.time,
                  firstname: widget.firstname,
                  lastname: widget.lastname,
                  email: widget.email,
                  address: widget.address,
                  phone: widget.phone,
                  city: widget.city,
                  street: widget.street,
                  pincode: widget.pincode,
                  itemList: widget.itemList,
                )));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF48c0d8),
                  borderRadius: BorderRadius.circular(10)
                ),
                width: MediaQuery.of(context).size.width-100,
                child: Center(child: Text("Cash on Delivery",style: f16B,)),
              ),
            ),SizedBox(
              height: 50.0,
            ),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ConfirmOrderScreen(
              loc_name: widget.locName,
              kitaddress: "Order from "+widget.itemList[0]["business_name"].toString(),
              type: "1",
              date: widget.date,time: widget.time,
              firstname: widget.firstname,
              lastname: widget.lastname,
              email: widget.email,
              address: widget.address,
              phone: widget.phone,
              city: widget.city,
              street: widget.street,
              pincode: widget.pincode,
              itemList: widget.itemList,
            )));

          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Color(0xFF48c0d8),
                borderRadius: BorderRadius.circular(10)
            ),
            width: MediaQuery.of(context).size.width-100,
            child: Center(child: Text("Payment Gateway",style: f16B,)),
          ),
        ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

Widget _circleWhite() {
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

Widget _circleOrange() {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 18.0,
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFffd55e),
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFffd55e),
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFffd55e),
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFffd55e),
        radius: 2.0,
      ),
      SizedBox(
        width: 18.0,
      ),
    ],
  );
}
