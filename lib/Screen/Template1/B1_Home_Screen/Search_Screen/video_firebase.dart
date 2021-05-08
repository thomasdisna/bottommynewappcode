import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';

class GestureOnTap extends StatefulWidget {
  String username;
  GestureOnTap({this.username});
  @override
  _GestureOnTapState createState() => _GestureOnTapState();
}

class _GestureOnTapState extends State<GestureOnTap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("@ Userna Checking",style: TextStyle(color: Colors.white),),
      ),
      body: Center(child: Text(widget.username,style: f15bB,)),
    );
  }
}
