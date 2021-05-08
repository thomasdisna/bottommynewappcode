import 'package:flutter/material.dart';

class Pricing extends StatefulWidget {
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Color(0xFf5f5f5f)),
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 4,bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Product Price"),
                          Text("(including GST)"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Update Price",
                            style: TextStyle(color:Color(0xFFf6d879)),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.white),
                          color: Colors.black,
                        ),
                        child: Center(child: Text("₹200.00")),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width - 30,
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xFf5f5f5f)),
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 4,bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Discount Percentage"),
                          Text("(including GST)"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Update Price",
                            style: TextStyle(color:Color(0xFFf6d879)),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.white),
                          color: Colors.black,
                        ),
                        child: Center(child: Text("₹150.00")),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width - 30,
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xFf5f5f5f)),
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 4,bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Discount percentage"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Update Price",
                            style: TextStyle(color: Color(0xFFf6d879)),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.white),
                          color: Colors.black,
                        ),
                        child: Center(child: Text("50%")),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width - 30,
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xFf5f5f5f)),
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 4,bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Packing"),
                          Text("(including All Taxes)"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Update Price",
                            style: TextStyle(color: Color(0xFFf6d879)),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.white),
                          color: Colors.black,
                        ),
                        child: Center(child: Text("₹150.00")),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width - 30,
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xFf5f5f5f)),
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 4,bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("GST*"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Update Price",
                            style: TextStyle(color: Color(0xFFf6d879)),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.white),
                          color: Colors.black,
                        ),
                        child: Center(child: Text("₹200.00")),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF303136),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Final Pricing",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "₹110.00",
                              style: TextStyle(
                                color: Color(0xFFf6d879),
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text("Price + packaging + GST"),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                  "please ensure the item matches the price in your menu to",
                                  style: TextStyle(fontSize: 10)),
                              Text(
                                "avoid rejection of changes",
                                style: TextStyle(fontSize: 10),
                              ),
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
