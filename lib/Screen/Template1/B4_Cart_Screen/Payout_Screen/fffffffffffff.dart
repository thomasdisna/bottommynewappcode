import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  TextEditingController _promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0xFF22252e),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      "Add cooking instructions(Optional)",
                      style: TextStyle(color: Color(0xFF0bc9e6)),
                    ),
                    Text(
                      "---------------------------------------------------------",
                      style: TextStyle(color: Color(0xFF0bc9e6)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, left: 20.0, right: 20.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("PROMOCODE"),
                    Text(
                      "View Promocode",
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width - 150,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter promo code",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          //for focusing the border in blue color with thickness
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0bc9e6),
                              width: 1.0,
                            ),
                          ),
                        ),
                        controller: _promoCodeController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: MaterialButton(
                          height: 30.0,
                          onPressed: () {},
                          color: Color(0xFF0bc9e6),
                          child: Text(
                            "APPLY",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w300),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: Color(0xFF22252e),
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Text("You have saved ₹50 on the bill")),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Item Total",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "₹840.00",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Delivery partner fee",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              color: Colors.white,
                              height: 1,
                              width: 140,
                            )
                          ],
                        ),
                        Text(
                          "₹20.00",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Taxes",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              color: Colors.white,
                              height: 1,
                              width: 40,
                            )
                          ],
                        ),
                        Text(
                          "₹31.00",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Applied Discount",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "-₹50.00",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              SizedBox(height: 9),
              Padding(
                padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "To Pay",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text("₹902.00")
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.rate_review,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Review your order and address details to avoid \ncancellation",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left :10.0,right: 10.0),
                child: MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  color: Color(0xFFf4c130),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("₹902.00",style: TextStyle(color: Colors.black),),
                      Row(
                        children: [
                          Text("Place Order",style: TextStyle(color: Colors.black),),
                          SizedBox(
                            width: 40,
                          ),
                          Image.asset(
                            "lib/images/right_arrow.png",
                            color: Colors.black,
                            height: 40,
                            width: 20,
                          ),
                        ],
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