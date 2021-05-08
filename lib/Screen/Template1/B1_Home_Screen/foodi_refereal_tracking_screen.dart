import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';

class ReferralTrackingScreen extends StatefulWidget {
  @override
  _ReferralTrackingScreenState createState() => _ReferralTrackingScreenState();
}

class _ReferralTrackingScreenState extends State<ReferralTrackingScreen> {
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

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
            SizedBox(height: 15),
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(width: width-60,
                  height: 45,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Referral Tracking",style: f18WB,),
                      Image.asset("assets/Template1/image/Foodie/icons/down-arrow.png",height: 15,color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black87,thickness: 1,),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(clipBehavior: Clip.antiAlias,
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",)
                          ),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Color(0xFF48c0d8)),

                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Mammutty P S",style: f16wB,)
                  ],
                ),
                Text("Pending 1st Purchase",style: f15w,)
              ],
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(clipBehavior: Clip.antiAlias,
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",)
                        ),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Color(0xFF48c0d8)),

                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Tojo Thomas",style: f16wB,)
                  ],
                ),
                MaterialButton(
                  onPressed: (){},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  color: Color(0xFFffd55e),
                  minWidth: 110,
                    height: 35,
                    child: Text("Clame \u20B950" ,style: f15B,))
              ],
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(clipBehavior: Clip.antiAlias,
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",)
                        ),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Color(0xFF48c0d8)),

                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Mammutty P S",style: f16wB,)
                  ],
                ),
                Text("Pending 1st Purchase",style: f15w,)
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(clipBehavior: Clip.antiAlias,
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",)
                        ),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Color(0xFF48c0d8)),

                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Mammutty P S",style: f16wB,)
                  ],
                ),
                Text("Pending 1st Purchase",style: f15w,)
              ],
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(clipBehavior: Clip.antiAlias,
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",)
                        ),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Color(0xFF48c0d8)),

                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Mammutty P S",style: f16wB,)
                  ],
                ),
                Text("Pending 1st Purchase",style: f15w,)
              ],
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(clipBehavior: Clip.antiAlias,
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",)
                        ),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Color(0xFF48c0d8)),

                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Tojo Thomas",style: f16wB,)
                  ],
                ),
                MaterialButton(
                    onPressed: (){},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    color: Color(0xFFffd55e),
                    minWidth: 110,
                    height: 35,
                    child: Text("Clame \u20B950" ,style: f15B,))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
