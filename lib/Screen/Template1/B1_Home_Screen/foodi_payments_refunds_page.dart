import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_payment&refund_manage_payments.dart';

class FoodiPaymentsAndRefundsPage extends StatefulWidget {
  @override
  _FoodiPaymentsAndRefundsPageState createState() => _FoodiPaymentsAndRefundsPageState();
}

class _FoodiPaymentsAndRefundsPageState extends State<FoodiPaymentsAndRefundsPage> {
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
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  children: [
                    Image.asset("assets/Template1/image/Foodie/icons/refund.png",height: 33,color: Colors.grey[500],),
                    SizedBox(width: 15,),
                    Text("Refund Status",style: f16wB,)
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
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => FoodiPaymentManage()
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      Image.asset("assets/Template1/image/Foodie/icons/valid.png",height: 35,color: Colors.grey[500],),
                      SizedBox(width: 15,),
                      Text("Manage payment methods",style: f16wB,)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(color: Colors.grey[800],),
              SizedBox(
                height: 5,
              ),


            ],
          ),
        ),
      )
    );
  }
}
