import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 5.0,
          title: Text(
            "BUTOMY",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
      ),
      body: SafeArea(
        child: Column(
          children: [
            OrderContainer(number: "#5320",orderDetails: "NEW ORDER",containerOrderDetails: "ACCEPT ORDER",containerOrderDetailsColor: Colors.green,orderDetailsColor: Colors.orange,),
            OrderContainer(number: "#5320",orderDetails: "NEW ORDER",containerOrderDetails: "ACCEPT ORDER",containerOrderDetailsColor: Colors.green,orderDetailsColor: Colors.orange,),
            OrderContainer(number: "#5320",orderDetails: "NEW ORDER",containerOrderDetails: "ACCEPT ORDER",containerOrderDetailsColor: Colors.green,orderDetailsColor: Colors.orange,),
            OrderContainer(number: "#5320",orderDetails: "NEW ORDER",containerOrderDetails: "ACCEPT ORDER",containerOrderDetailsColor: Colors.yellow,orderDetailsColor: Colors.blue,),
            OrderContainer(number: "#5320",orderDetails: "NEW ORDER",containerOrderDetails: "ACCEPT ORDER",containerOrderDetailsColor: Colors.yellow,orderDetailsColor: Colors.blue,),
          ],
        ),
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {

  final String number;
  final String orderDetails;
  final Color orderDetailsColor;
  final String containerOrderDetails;
  final Color containerOrderDetailsColor;

  OrderContainer({this.number,this.orderDetails,this.orderDetailsColor,this.containerOrderDetails,this.containerOrderDetailsColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    number,
                    style: TextStyle(color: Colors.black),
                  ),
                  Row(children: [
                    Icon(
                      Icons.directions_bike,
                      color: Colors.green,
                    ),
                    Text(
                      "Track Driver",
                      style: TextStyle(color: Colors.green),
                    )
                  ]),
                  Container(
                    color: orderDetailsColor,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 40),
                      child: Text(
                        orderDetails,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "19-02-2021 12:54 pm",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Quarter Kandari alfam D...",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "₹2750",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 7.0, top: 7.0, bottom: 4.0),
                  child: Container(
                    color: containerOrderDetailsColor,
                    width: MediaQuery.of(context).size.width - 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        containerOrderDetails,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Text(
                    "View Details",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pre Order Pickup Schedule",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "21-02-2021 04:00 pm",
                      style: TextStyle(color: Colors.black),
                    )
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