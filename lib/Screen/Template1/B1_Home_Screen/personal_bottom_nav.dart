
import 'package:flutter/material.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/B1_Home_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/bottom_chat.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/purchase_list.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Components/global_data.dart';
import 'New_Entry_Form.dart';

class AccountbottomNavBar extends StatefulWidget {
  AccountbottomNavBar();

  _AccountbottomNavBarState createState() => _AccountbottomNavBarState();
}

class _AccountbottomNavBarState extends StateMVC<AccountbottomNavBar> {
  TimelineWallController _con;

  _AccountbottomNavBarState() : super(TimelineWallController()) {
    _con = controller;
  }

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userId');
  }

  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new HomeScreenT1();
        break;
      case 1:
        return new BottomChat();
        break;
      case 2:
        return new AddNewEntries(videooo: "",vid_show: false,typpp: "",);
        break;
      case 3:
        return new purchase();
        break;
      case 4:
        return new CartScreenT1(null,null,false);
        break;
      default:
        return new TimeLine(false);
    }
  }

  void onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _con.getAbout(userid.toString());
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFFffd55e),
        elevation: 5,
        onTap: onTappedBar,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Color(0xFF1E2026),
        items: [
          BottomNavigationBarItem(
              icon: currentIndex == 0
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
              icon: currentIndex == 1
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
              icon: currentIndex == 3
                  ? Image.asset(
                "assets/Template1/image/Foodie/icons/shopping-basket.png",
                height: 23,
                color: Color(0xFFffd55e),
                width: 23,
              )
                  : Image.asset(
                "assets/Template1/image/Foodie/icons/shopping-basket.png",
                height: 23,
                color: Colors.white54,
                width: 23,
              ),
              title: Text('Purchase'),
              backgroundColor: Color(0xFFffd55e)),
          BottomNavigationBarItem(
              icon: currentIndex == 4
                  ? Image.asset(
                "assets/Template1/image/Foodie/icons/cart.png",
                height: 23,
                color: Color(0xFFffd55e),
                width: 23,
              )
                  : Image.asset("assets/Template1/image/Foodie/icons/cart.png",
                  height: 23, color: Colors.white54, width: 23),
              title: Text('Cart'),
              backgroundColor: Color(0xFFffd55e)),
        ],
      ),
    );
  }
}
