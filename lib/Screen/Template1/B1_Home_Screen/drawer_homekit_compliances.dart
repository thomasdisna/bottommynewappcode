import 'package:flutter/material.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';

class DrawerHomekitCompliances extends StatefulWidget {
  @override
  _DrawerHomekitCompliancesState createState() => _DrawerHomekitCompliancesState();
}

class _DrawerHomekitCompliancesState extends State<DrawerHomekitCompliances> {
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
          height: 35,
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new searchAppbar()));
                },
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new QRCODE()));
                  },
                  child: Image.asset(
                    "assets/Template1/image/Foodie/QRcode.png",
                    height: 20,
                    width: 20,
                  )),
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                  MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
