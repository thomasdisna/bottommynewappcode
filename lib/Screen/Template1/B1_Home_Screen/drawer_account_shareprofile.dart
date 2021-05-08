import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:Butomy/Components/widget_style.dart';
class DrawerAccountShareProfile extends StatefulWidget {
  @override
  _DrawerAccountShareProfileState createState() => _DrawerAccountShareProfileState();
}

class _DrawerAccountShareProfileState extends State<DrawerAccountShareProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        title: Text("Share Profile",style:TextStyle(color:Colors.white),),
        centerTitle: true,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.only(top: 20),
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          CachedNetworkImageProvider(
                            "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                            errorListener: () =>
                            new Icon(Icons.error),
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(
                          Radius.circular(180.0))),
                ),
              ),
              SizedBox(height: 20,),
              Text("John",style:f16wB,textAlign: TextAlign.center,),
              SizedBox(height: 5,),
              Text("Kakkanad",style:f14gB,textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Text("Share your profile with friends",style:f14gB,textAlign: TextAlign.center,),
              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.only(left: 80,right: 80),
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
                          "Share",
                          style: f15wB,
                        )),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );

  }
}