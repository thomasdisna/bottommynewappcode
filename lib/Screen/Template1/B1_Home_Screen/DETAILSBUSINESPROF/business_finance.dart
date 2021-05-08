
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/payout_tab1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/payout_tab2.dart';

class BusinessFinance extends StatefulWidget {
  @override
  _BusinessFinanceState createState() => _BusinessFinanceState();
}

class _BusinessFinanceState extends State<BusinessFinance> with SingleTickerProviderStateMixin {

  TabController _controller;
  // int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

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
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                child: Text("Finance",style: TextStyle(color: Colors.white,fontSize: 20.0,),)),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[600],
                      )
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom:1,right: 20,left: 20),
                child: TabBar(
                  indicatorColor: Color(0xFFffd55e),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 4,
                  controller: _controller,
                  tabs: [
                    Tab(
                      child: Text("PAYOUTS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),),
                    ),
                    Tab(
                      child: Text("CURRENT CHARGES",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),),
                    )
                  ],

                ),
              ),
            ),
            Container(height: MediaQuery.of(context).size.height-172,
              child: TabBarView(
                  controller: _controller,
                  children: [
                    TabOne(),
                    TabTwo()
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
