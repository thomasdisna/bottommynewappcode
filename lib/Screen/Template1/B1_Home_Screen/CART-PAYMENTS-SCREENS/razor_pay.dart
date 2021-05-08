import 'dart:developer';

import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/CART-PAYMENTS-SCREENS/random_string.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_orders_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math' show Random;
var order_razo='';
var payment_id_razo='';
var order_id = '';
class PaymentGatewayScreen extends StatefulWidget {


  PaymentGatewayScreen({this.name,this.phone,this.amount,this.email,this.orderid,this.kitchenname,this.address});

  String name,phone,email,orderid,kitchenname,address;
  int amount;

 /* final String title;
  final String description;
  final String thumb;
  final amount;
  final id;*/

  @override
  _PaymentGatewayScreenState createState() => _PaymentGatewayScreenState();

}

class _PaymentGatewayScreenState extends StateMVC<PaymentGatewayScreen> {

  HomeKitchenRegistration _con;
  _PaymentGatewayScreenState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }


  final scaffoldKey = new GlobalKey<ScaffoldState>();

  Map<String, dynamic> formData;


  Razorpay _razorpay;

  get index => null;


  @override
  void initState() {

    super.initState();
    _razorpay = Razorpay();


    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }


  // Future<String> createorder() async{
  //
  //
  //   final accessToken = await http.post(APIData.tokenApi, body: {
  //     "email": fileContent['user'], "password": fileContent['pass'],
  //
  //   });
  //   var user = json.decode(accessToken.body);
  //
  //   final response = await http.get(APIData.userApi,
  //       // ignore: deprecated_member_use
  //       headers: {
  //         // ignore: deprecated_member_use
  //         HttpHeaders.AUTHORIZATION: "Bearer ${user['access_token']}!"
  //       });
  //
  //   dataUser = json.decode(response.body);
  //   userDetail = dataUser['users'];
  //
  //   print(order_id);
  //
  //   final register = await http.post(
  //       APIData.CreateorderApi, body: {
  //     "user_id": "${userDetail['id']}",
  //     "course": "${widget.id}",
  //     "order_id":"${order_id}",
  //   });
  //
  //
  //   if(register.statusCode == 200){
  //
  //     var order = json.decode(register.body);
  //
  //     print("Hai to everyone"+order['order_id']);
  //
  //     //  return  order['order_id'];
  //
  //   }
  //
  //   return null;
  //
  //
  // }

  void openCheckout() async{

    int payment_amount = 50;

    order_id  = randomAlphaNumeric(10);

    // createorder();

    var options = {
      'key': 'rzp_test_awG39xGOvkEQxz',
      'amount': widget.amount*100, //in the smallest currency sub-unit.
      'name': widget.name,
      'order':widget.orderid,
      'description': widget.kitchenname,
      'prefill': {
        'contact': widget.phone,
        'email': widget.email,
        'address': widget.address,
      }
    };
    _razorpay.open(options);

  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    // Do something when payment succeeds
    payment_id_razo = response.paymentId;
    print("RRRRRRRRRRRRR "+response.signature.toString());
    // updateorder();
_con.updatePaymentId(widget.orderid,"1",response.paymentId);
    Fluttertoast.showToast(msg: "Payment Success");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) => TimeLine(false)
    ), (route) => false);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => FoodiOrdersPage()
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(msg: "Order placed. But Payment cancelled.",toastLength: Toast.LENGTH_LONG);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) => TimeLine(false)
    ), (route) => false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    Fluttertoast.showToast(msg: "External Wallet  "+response.walletName);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF1E2026),

      // body: Center(
      //   child: Container(
      //     height: 50,
      //     padding: EdgeInsets.symmetric(
      //         vertical: 5.0, horizontal: 25.0),
      //     width: double.infinity,
      //     child: RaisedButton(
      //       padding: EdgeInsets.all(12.0),
      //       shape: StadiumBorder(),
      //       child: Text(
      //         "Submit",
      //         style: TextStyle(color: Colors.white),
      //       ),
      //       color: Colors.blue[800],
      //       onPressed: () {
      //         openCheckout();
      //         // ignore: unnecessary_statements
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}