import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';

class TabTwo extends StatefulWidget {
  @override
  _TabTwoState createState() => _TabTwoState();
}

class _TabTwoState extends State<TabTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.0),
              Text("BUID : 120222521452541",style: f18WB,),
              SizedBox(height: 15.0),
              ListContainer(firstLabel: "SERVICE FEE",secondLabel: "12%",),
              ListContainer(firstLabel: "SERVICE FEE",secondLabel:"7%" ,),
              ListContainer(firstLabel: "CANCELLATION POLICY" ,secondLabel: "Cancellation Policy : Order Type policy "
                  "Payout post cancellation window (Prepaid orders):"
                  "100%", ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListContainer extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  ListContainer({this.firstLabel,this.secondLabel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0,bottom: 3.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white12,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(firstLabel,style: f14w,),
              SizedBox(height: 6.0,),
              Text(secondLabel,style: f14w,),
            ],
          ),
        ),
      ),
    );
  }
}