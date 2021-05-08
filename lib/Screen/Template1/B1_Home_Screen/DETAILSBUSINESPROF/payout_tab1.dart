import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/payout_detail_view.dart';

class TabOne extends StatefulWidget {
  @override
  _TabOneState createState() => _TabOneState();
}

class _TabOneState extends State<TabOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Week so far',style: f14wB,),
                SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        color: Color(0xFF48c0d8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20,top: 5,bottom: 5),
                          child: Text(
                            'CYCLE ID : CID/21/1001',
                            style:
                            f13B,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
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
                                Text("4th Feb",style: f15wB,),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'WEEK SO FAR*',
                                style: f10w,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '₹35,000.00',
                                style: f21yB,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text('70 Orders',style: f14wB,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MaterialButton(height: 40,
                            minWidth: MediaQuery.of(context).size.width - 90,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PayoutDetailView()
                              ));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "VIEW PAYOUTS",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Center(
                  child: Text('This is the current expected amount. As you receive orders during\n'
                      'the payout cycle, this will be updated',style: f10g,textAlign: TextAlign.center,),
                ),
                SizedBox(height: 20.0),
                Text('Past Payouts',style: f14wB,),
                SizedBox(height: 10.0),
                ListContainer(
                  colors: Colors.orange[800],
                  label: "PENDING",
                  labelColors: Colors.black,
                ),
                SizedBox(height: 10.0),
                ListContainer(
                  colors: Colors.green,
                  label: "PAID",
                  labelColors: Colors.white,
                ),
                SizedBox(height: 10.0),
                ListContainer(
                  colors: Colors.green,
                  label: "PAID",
                  labelColors: Colors.white,
                ),
                SizedBox(height: 10.0),
                ListContainer(
                  colors: Colors.green,
                  label: "PAID",
                  labelColors: Colors.white,
                ),
                SizedBox(height: 4),
                Center(
                  child: MaterialButton(minWidth: 160,height: 35,
                    color: Color(0xFF48c0d8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onPressed: () {},
                    child: Text(
                      "VIEW MORE",
                      style: f14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListContainer extends StatelessWidget {
  final String label;
  final Color colors;
  final Color labelColors;

  ListContainer({this.label, this.colors, this.labelColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white12,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("24 jan - 31st jan",style: f14w,),
                Container(
                  padding: EdgeInsets.all(3.0),
width: 75,
                  decoration: BoxDecoration(
                      color: colors, borderRadius: BorderRadius.circular(6.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left:8,right: 8,top: 2,bottom: 2),
                    child: Center(
                      child: Text(
                        label,
                        style: f13w,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₹26,200.00",
                  style: f21yB),

                Text("on jan 27th",style: f14wB,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
