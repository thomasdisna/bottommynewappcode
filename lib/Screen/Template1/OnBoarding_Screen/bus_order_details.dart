import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';

class BuisnessOrderAkhil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "BUTOMY",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

      ),
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 9,bottom: 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "#5320",
                                style: f16B,),
                              SizedBox(height: 3,),
                              Text(
                                "19-02-2021 12:54 pm",
                                style: f13,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                color: Colors.orange[700],
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 40,top: 5,bottom: 5),
                                  child: Text(
                                    "NEW ORDER",
                                    style: f14wB,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text("\u20B9270.0"/*+_con.BusinessOrderList[index]["amount"].toString()*/,style: f18B,)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[400],
                      child: Padding(
                        padding: const EdgeInsets.only(left:30.0,right: 30.0,top: 8.0,bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pre Order Pickup Schedule",
                              style:f14
                            ),
                            Text(
                              "21-02-2021 04:00 pm",
                              style: f13,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(width: width/1.6,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        border:
                                        Border.all(color:  /*_con.HomeKitchenTimeline[index]['products'][ind]
                                        ["products_type"].toString()=="0" ? Colors.green[600] :*/ Colors.red[600]),
                                        borderRadius: BorderRadius.circular((2)),
                                      ),
                                      child: Icon(Icons.brightness_1,
                                          color: /* _con.HomeKitchenTimeline[index]['products'][ind]
                                          ["products_type"].toString()=="0" ? Colors.green[600] :*/ Colors.red[600], size: 8),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      "Chiken Biriyani Combo",
                                      style: f16B,
                                    ),
                                  ],
                                ),
                              ),
                              Container(width: width/8,
                                child: Text(
                                  "X 1",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Container(width: width/6,
                                child: Text(
                                  "₹2750.00",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                Text(
                                  "Biriyani - Chiken biriyani",
                                  style:
                                  f10g,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey[400],
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,right: 8.0,top: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(width: width/2.2,
                                child: Text(
                                  "Total",
                                  style: f15B,
                                ),
                              ),
                              Container(width: width/7,
                                child: Text(
                                  "2 items",
                                  style: f15B,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "₹4,550.00",
                                  style: f15B,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Packing Charges",style: f14B),
                              Text("₹4,550.00",style: f14B,)
                            ],
                          ),
                          SizedBox(height: 5.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("GST",style: f14B),
                              Text("₹0.00",style: f14B)
                            ],
                          ),
                          SizedBox(height: 5.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discount",style: f14B,),
                              Text("₹0.00",style: f14B,)
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                      color: Colors.grey[400],
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                    ),
                    SizedBox(height: 5.0,),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0,left: 19.0,right: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Bill",style: f18B,),
                          Text("₹4,550.00",style: f18B)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0,bottom: 10.0),
                      child: Text("Cooking Instruction :",style: f13B),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                      child: Text("Need biriyani spicy and write happy birthday faiizan in \nCake",style: TextStyle(color: Colors.black),),
                    ),
                    SizedBox(height: 20.0,),
                    Center(
                      child: MaterialButton(height: 30,
                        splashColor: Color(0xFF48c0d8),
                        onPressed: (){},
                        color: Colors.green[400],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: Text(
                            "ACCEPT ORDER",
                            style: f14wB,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
