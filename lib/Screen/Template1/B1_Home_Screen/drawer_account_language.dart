import 'package:flutter/material.dart';

class DrawerAccountLanguage extends StatefulWidget {
  @override
  _DrawerAccountLanguageState createState() => _DrawerAccountLanguageState();
}

class _DrawerAccountLanguageState extends State<DrawerAccountLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(backgroundColor: Color(0xFF1E2026),titleSpacing: 0, iconTheme: IconThemeData(color: Colors.white),
        title: Text("Language",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        child: Container(
          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",style: TextStyle(fontSize: 13,color: Colors.white),),
        ),
      ),
    );
  }
}