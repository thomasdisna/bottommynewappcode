import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_refereal_tracking_screen.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:share/share.dart';

class DrawerAccountReferFriend extends StatefulWidget {
  @override
  _DrawerAccountReferFriendState createState() => _DrawerAccountReferFriendState();
}

class _DrawerAccountReferFriendState extends State<DrawerAccountReferFriend> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        title: Text("Refer a Friend",style:TextStyle(color:Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Colors.white24,
                height: 130,
                width: width,
                child: Center(child: Text("Banner",style: f16bB,))),
            SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ReferralTrackingScreen()
                ));
              },
              child: Center(
                child: Container(width: width-60,
                  height: 45,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Referral Tracking",style: f18WB,),
                      Image.asset("assets/Template1/image/Foodie/icons/right_arrow.png",height: 15,color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black87,thickness: 1,),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: width-100,
              height: 42,
              splashColor: Colors.black,
              onPressed: (){},
              color: Color(0xFFffd55e),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text("Invite your Contacts",style: f16B,),
            ),
            SizedBox(height: 30),
            Text("or Share your Referral link ",style: f16wB,),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("https://butomy.com/referral/mg81Q3pV",style: f14w,),
                IconButton(
                    onPressed : (){},
                    icon : Icon(Icons.content_copy,color: Colors.white,size: 20,))
              ],
            ),
            SizedBox(height: 30),
            MaterialButton(

              height: 45,
              splashColor: Colors.black,
              onPressed: (){},
              color: Colors.transparent,
              shape: RoundedRectangleBorder(side: BorderSide(
                color: Color(0xFFffd55e),
                width: 1.5
              ),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Container(
                width: width-132,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.open_in_browser,color: Colors.white,size: 25),
                    SizedBox(width: 8,),
                    Text("Share With ...",style: f16wB,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Container(
                    height: 180,
                    width: 180,
                    color: Colors.black,
                    child: Image.asset(
                      "assets/Template1/image/Foodie/reff.jpg",
                      height: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80,right: 80,top: 20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: DashPathBorder.all(
                      dashArray: CircularIntervalList<double>(<double>[6.0, 2.0]),
                    ),
                  ),
                  child:Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("JOHNID45N",style: f15bB),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Text("Share your code with your friends",style: f13g),
              SizedBox(height: 20,),
              Text("or",style:f16wB),
              //Text("and get exciting bonus points",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: InkWell(
                  onTap: (){
                    Share.share(
                        'check out my website ');
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF48c0d8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                          "Refer",
                          style: f16wB,
                        )),
                  ),
                ),
              ),




            ],
          ),
        ),
      )*/

//----------------------------------
class DashPathBorder extends Border {
  DashPathBorder({
    @required this.dashArray,
    BorderSide top = BorderSide.none,
    BorderSide left = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
  }) : super(
    top: top,
    left: left,
    right: right,
    bottom: bottom,
  );

  factory DashPathBorder.all({
    BorderSide borderSide = const BorderSide(color: Colors.grey),
    @required CircularIntervalList<double> dashArray,
  }) {
    return DashPathBorder(
      dashArray: dashArray,
      top: borderSide,
      right: borderSide,
      left: borderSide,
      bottom: borderSide,
    );
  }
  final CircularIntervalList<double> dashArray;

  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        TextDirection textDirection,
        BoxShape shape = BoxShape.rectangle,
        BorderRadius borderRadius,
      }) {
    if (isUniform) {
      switch (top.style) {
        case BorderStyle.none:
          return;
        case BorderStyle.solid:
          switch (shape) {
            case BoxShape.circle:
              assert(borderRadius == null,
              'A borderRadius can only be given for rectangular boxes.');
              canvas.drawPath(
                dashPath(Path()..addOval(rect), dashArray: dashArray),
                top.toPaint(),
              );
              break;
            case BoxShape.rectangle:
              if (borderRadius != null) {
                final RRect rrect =
                RRect.fromRectAndRadius(rect, borderRadius.topLeft);
                canvas.drawPath(
                  dashPath(Path()..addRRect(rrect), dashArray: dashArray),
                  top.toPaint(),
                );
                return;
              }
              canvas.drawPath(
                dashPath(Path()..addRect(rect), dashArray: dashArray),
                top.toPaint(),
              );

              break;
          }
          return;
      }
    }

    assert(borderRadius == null,
    'A borderRadius can only be given for uniform borders.');
    assert(shape == BoxShape.rectangle,
    'A border can only be drawn as a circle if it is uniform.');

    // TODO(dnfield): implement when borders are not uniform.
  }
}
