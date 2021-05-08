import 'dart:async';

import 'package:flutter/material.dart';

import 'a2.dart';

class page11 extends StatefulWidget {
  page11({Key key, this.title}) :super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => new _page11State();
}

class _page11State extends State<page11> {

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Home Page"),
        ),
        body: GestureDetector(
          onTap: (){

          },
          child: new Center(
            child: new Text("Home Page"),
          ),
        ),
      ),
    );
  }
}