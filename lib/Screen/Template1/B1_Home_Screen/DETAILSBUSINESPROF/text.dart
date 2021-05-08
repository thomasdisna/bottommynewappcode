import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20,
              child: MaterialButton(height: 40,minWidth: 90,
                color: Colors.black,
                splashColor: Colors.white,
                onPressed: (){},
                child: Center(child: Text("hllll",style: TextStyle(color: Colors.red),)),
              ),
            ),
            Text("fgkhb")
          ],
        ),
      ),
    );
  }
}
