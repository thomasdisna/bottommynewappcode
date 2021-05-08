import 'package:flutter/material.dart';

class DrawerAccountHelpSupport extends StatefulWidget {
  @override
  _DrawerAccountHelpSupportState createState() => _DrawerAccountHelpSupportState();
}

class _DrawerAccountHelpSupportState extends State<DrawerAccountHelpSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(backgroundColor: Color(0xFF1E2026),titleSpacing: 0, iconTheme: IconThemeData(color: Colors.white),
        title: Text("Help & Support",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

