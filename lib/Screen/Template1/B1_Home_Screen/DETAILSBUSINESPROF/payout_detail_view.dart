import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';

class PayoutDetailView extends StatefulWidget {
  @override
  _PayoutDetailViewState createState() => _PayoutDetailViewState();
}

class _PayoutDetailViewState extends State<PayoutDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        elevation: 5,
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          // main column
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // first section
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("CURRENT PAYOUT CYCLE",style: f13w,),
                          SizedBox(
                            height: 2,
                          ),
                          Text("24 jan - 31st jan",style: f15wB,),
                        ],
                      ),
                      Column(
                        children: [
                          Text("PAYOUT DATE",style: f13w,),
                          SizedBox(
                            height: 2,
                          ),
                          Text("4th Feb 21",style: f15wB,),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'NET PAYOUT',
                            style: f13w,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '11,050.97',
                            style: f21yB,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text('70 Orders',style: f14wB,),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3.0),
                            width: 75,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(left:8,right: 8,top: 2,bottom: 2),
                              child: Center(
                                child: Text(
                                  'PAID',style: f13w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("on jan 27th",style: f14wB,),
                        ],
                      ),
                    ],
                  ),
                ),
                // first complete
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: Colors.grey[800],
                  height: 1.0,
                  width: MediaQuery.of(context).size.width,
                ),
                // second section
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivered-61 Orders",
                        style: f14wB,
                      ),
                      Text(
                        "₹10,952.71.00",
                        style: f14yB,
                      )
                    ],
                  ),
                ),
                BoxContainer(label: "Total Customer Payable",amount: "₹15,494.00",amColors: "1",),
                BoxContainer(label: "Total Service Fee",amount: "-₹4,424.98",amColors: "0",),
                BoxContainer(label: "Order Adjustments",amount: "₹0.00",amColors: "1",),
                BoxContainer(label: "TCS & TDS",amount: "-₹116.21",amColors: "0",),
                SizedBox(
                  height: 15.0,
                ),

                Icon(Icons.add,color: Colors.white,size: 25.0,),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cancelled - 1 Orders",
                        style:f14wB,
                      ),
                      Text(
                        "₹98",
                        style: f15yB),
                    ],
                  ),
                ),
                BoxContainer(label: "Total Customer Payable",amount: "₹139.00",amColors: "1",),
                BoxContainer(label: "Total service Fee",amount: "-₹39.69",amColors: "0",),
                BoxContainer(label: "Order Adjustment",amount: "₹0.00",amColors: "1"),
                BoxContainer(label: "TCS & TDS ",amount: "-₹1.04",amColors: "0",),
                SizedBox(
                  height: 15.0,
                ),
                Icon(Icons.add,color: Colors.white,size: 25.0,),
                SizedBox(
                  height: 5.0,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payout Adjustment",
                        style: f14wB,
                      ),
                      Text(
                        "₹0.00",
                        style: f14yB,
                      ),
                    ],
                  ),
                ),
                BoxContainer(label: "Adjustments",amount: "₹0.00",amColors: "1",),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Net Payout : ",style:f21wB),
                      Text("₹11,050.97",style: f21yB,),
                    ],
                  ),
                ),
                Divider(),
                IconSection(text: "Reports",),
                Divider(),
                IconSection(text: "Tax Invoice",),
                Divider(),
                IconSection(text: "Payment Recipet",),
                Divider(),
                SizedBox(height: 20,)


              ],
            ),
          ),
        ),
      ),
    );
  }
}

// divider
class Divider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5),
      child: Container(
        color: Colors.grey[800],
        height: 1.0,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}

// pdf section
class IconSection extends StatelessWidget {

  final String text;

  IconSection({this.text});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.insert_drive_file,color: Colors.green[200],size: 25,),
          SizedBox(width: 8,),
          Text(text,style: f16wB,)


        ],
      ),
    );
  }
}

// box container
class BoxContainer extends StatelessWidget {
  final String label;
  final String amount;
  final String amColors;

  BoxContainer({this.label, this.amount, this.amColors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 15,),
                  Text(label,style: f14w,),
                ],
              ),
              Row(
                children: [
                  Text (amount,style: amColors =="1"  ? f14wB : f14oB,),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}