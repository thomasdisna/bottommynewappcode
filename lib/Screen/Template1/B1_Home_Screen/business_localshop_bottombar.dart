import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_local_shop_new_entry.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'Business_LocalShop_Product_List_Page.dart';
import 'business_homekitchen_chat.dart';

class bottomNavBarLocalShop extends StatefulWidget {
  bottomNavBarLocalShop(
      {this.currentIndex, this.pagid, this.timid, this.memberdate, this.upld});

  int currentIndex;
  String pagid, timid, memberdate;
  bool upld;

  _bottomNavBarState createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBarLocalShop> {
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new BusinessLocalShopTimeline(
          upld: widget.upld,
          pagid: widget.pagid,
          memberdate: widget.memberdate,
          timid: widget.timid,
        );
        break;
      case 1:
        return new BusinessHomeKitchenChatList(
          myID: widget.timid.toString(),
          timid: widget.timid,
          pagid: widget.pagid,
          memberdate: widget.memberdate,
          myName: Bus_NAME,
        );
        break;
      case 2:
        return new LocalShopNewEntryForm(
          memberdate: widget.memberdate,
          pagid: widget.pagid,
          timid: widget.timid,
        );
        break;
      case 3:
        return new BusinessLocalShopProductListPage(
          pagid: widget.pagid,
          timid: widget.timid,
          memberdate: widget.memberdate,
        );
        break;
      case 4:
        return new BusinessHomeKitchenOrderPage(
          memberdate: widget.memberdate,
          pagid: widget.pagid,
          timid: widget.timid,
        );
        break;
      default:
        return new BusinessLocalShopTimeline(
          upld: widget.upld,
          pagid: widget.pagid,
          memberdate: widget.memberdate,
          timid: widget.timid,
        );
    }
  }

  void onTappedBar(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if(widget.currentIndex!=0){
      setState(() {
        widget.currentIndex =0;
      });
      return new Future.value(false);
    }
    else{return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Color(0xFF1E2026),
        contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
        title: Image.asset(
          "assets/Template1/image/Foodie/logo_Business.png",
          height: 30,
          alignment: Alignment.topLeft,
        ),
        titlePadding: EdgeInsets.all(10),
        content: new Text(
          "Dou you want to switch " + Bus_NAME + " to " + NAME.toString() + "?",
          style: f15w,
        ),
        actions: <Widget>[
          MaterialButton(
            height: 28,
            color: Color(0xFFffd55e),
            child: new Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          SizedBox(
            width: 15,
          ),
          MaterialButton(
            height: 28,
            color: Color(0xFF48c0d8),
            child: new Text(
              "Switch",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => TimeLine(false)),
                (route) => false),
          ),
        ],
      ),
    ));}
  }

  @override
  void initState() {
    FirebaseController.instanace.getUnreadMSGCountBusiness(widget.timid).then((value) {
      setState(() {
        businesschatcount=value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: callPage(widget.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFffd55e),
          elevation: 10,
          onTap: onTappedBar,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentIndex,
          backgroundColor: Color(0xFF1E2026),
          items: [
            BottomNavigationBarItem(
                icon: widget.currentIndex == 0
                    ? Image.asset(
                        "assets/Template1/image/Foodie/icons/home.png",
                        height: 23,
                        color: Color(0xFFffd55e),
                        width: 23,
                      )
                    : Image.asset(
                        "assets/Template1/image/Foodie/icons/home.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23,
                      ),
                title: Text('Home'),
                backgroundColor: Color(0xFFffd55e)),
            BottomNavigationBarItem(
                icon: businesschatcount > 0
                    ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: 38,
                      child: widget.currentIndex == 1
                          ? Image.asset(
                        "assets/Template1/image/Foodie/icons/chat.png",
                        height: 21,
                        color: Color(0xFFffd55e),
                        width: 21,
                      )
                          : Image.asset(
                        "assets/Template1/image/Foodie/icons/chat.png",
                        height: 21,
                        color: Colors.white54,
                        width: 21,
                      ),
                    ),
                    Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          color: Color(0xFF0dc89e),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Text(
                            businesschatcount.toString(),
                            style: f10B,
                            textAlign: TextAlign.center,
                          )),
                    )
                  ],
                )
                    : Container(
                  child: widget.currentIndex == 1
                      ? Image.asset(
                    "assets/Template1/image/Foodie/icons/chat.png",
                    height: 21,
                    color: Color(0xFFffd55e),
                    width: 21,
                  )
                      : Image.asset(
                    "assets/Template1/image/Foodie/icons/chat.png",
                    height: 21,
                    color: Colors.white54,
                    width: 21,
                  ),
                ),
                title: Text('Chat'),
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Container(
                  height: 42,
                  width: 42,
                  child: FloatingActionButton(
                    elevation: 5,
                    backgroundColor: Color(0xFF48c0d9),
                    child: Icon(
                      Icons.add,
                      size: 35,
                    ),
                  ),
                ),
                title: Text(
                  "",
                  style: TextStyle(fontSize: .1),
                )),
            BottomNavigationBarItem(
                icon: widget.currentIndex == 3
                    ? Image.asset(
                        "assets/Template1/image/Foodie/icons/list.png",
                        height: 23,
                        color: Color(0xFFffd55e),
                        width: 23,
                      )
                    : Image.asset(
                        "assets/Template1/image/Foodie/icons/list.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23,
                      ),
                title: Text('Item list'),
                backgroundColor: Color(0xFFffd55e)),
            BottomNavigationBarItem(
                icon: widget.currentIndex == 4
                    ? Image.asset(
                        "assets/Template1/image/Foodie/icons/order-list.png",
                        height: 23,
                        color: Color(0xFFffd55e),
                        width: 23,
                      )
                    : Image.asset(
                        "assets/Template1/image/Foodie/icons/order-list.png",
                        height: 23,
                        color: Colors.white54,
                        width: 23,
                      ),
                title: Text('Orders'),
                backgroundColor: Color(0xFFffd55e)),
          ],
        ),
      ),
    );
  }
}
