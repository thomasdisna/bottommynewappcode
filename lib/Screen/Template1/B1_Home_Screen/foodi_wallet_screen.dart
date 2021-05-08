import 'package:flutter/material.dart';

class FoodieWalletScreen extends StatefulWidget {
  @override
  _FoodieWalletScreenState createState() => _FoodieWalletScreenState();
}

class _FoodieWalletScreenState extends State<FoodieWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          brightness: Brightness.dark,
          elevation: 5,centerTitle: true,
          title: Text("Wallet",style: TextStyle(color: Colors.white),)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
