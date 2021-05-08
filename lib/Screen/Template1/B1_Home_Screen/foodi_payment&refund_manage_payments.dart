import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';

class FoodiPaymentManage extends StatefulWidget {
  @override
  _FoodiPaymentManageState createState() => _FoodiPaymentManageState();
}

class _FoodiPaymentManageState extends State<FoodiPaymentManage> {
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
          title: Text("Refunds & Payments Modes",style: TextStyle(color: Colors.white),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      Image.asset("assets/Template1/image/Foodie/icons/valid.png",height: 35,color: Colors.grey[500],),
                      SizedBox(width: 15,),
                      Text("Manage payment methods",style: f16wB,)
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.grey[800],),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Text("Online Payments",style: f18WB,),
                ),
                SizedBox(height: 3,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Text("After first payment, we will save your details for future use.",style: f13w,),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.only(left:20,right: 20),
                    child: Row(
                      children: [
                        Image.asset("assets/Template1/image/Foodie/icons/visa.png",height: 35,),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Personal",style: f16wB,),
                            SizedBox(height: 1,),
                            Text("460133xxxxxxxx8296",style: f14w,),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.only(left:20,right: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/card.png",height: 35,color: Colors.white,),
                            SizedBox(width: 15,),
                            Text("Credit, Debit & ATM Cards",style: f16wB,)
                          ],
                        ),
                        Image.asset("assets/Template1/image/Foodie/icons/right_arrow.png",height: 15,color: Colors.white,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.only(left:20,right: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/netbank.png",height: 32,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text("Netbanking",style: f16wB,)
                          ],
                        ),
                        Image.asset("assets/Template1/image/Foodie/icons/right_arrow.png",height: 15,color: Colors.white,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 11,),
                Padding(
                  padding: const EdgeInsets.only(left:20,right: 20),
                  child: Text("UPI",style: f18WB,),
                ),
                SizedBox(height: 11,),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.only(left:20,right: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/Template1/image/Foodie/icons/gpay.png",height: 17,),
                            SizedBox(width: 15,),
                            Text("Google Pay",style: f16wB,)
                          ],
                        ),
                        Image.asset("assets/Template1/image/Foodie/icons/right_arrow.png",height: 15,color: Colors.white,)
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
