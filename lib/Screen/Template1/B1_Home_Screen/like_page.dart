import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Likes extends StatefulWidget {
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  var clr = "Search";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1E2026),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                  color: Color(0xFF23252E),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15.0,
                        spreadRadius: 0.0)
                  ]),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search,color: Colors.white,),
                    hintText: clr,
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),

              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: MediaQuery.of(context).size.height-188,
             child: ListView.builder(
                 itemCount: 10,
                 itemBuilder: (BuildContext context, int index) {
                   return Column(
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Row(
                               children: <Widget>[
                                 Container(
                                   height: 45.0,
                                   width: 45.0,
                                   decoration: BoxDecoration(
                                     color: Colors.green,
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
                                 ),SizedBox(width: 10,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Text("aishwaraya_madhav",style: TextStyle(color: Colors.white,fontSize: 14),),
                                     SizedBox(height: 5,),
                                     Text("aishwaraya_madhav",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                   ],
                                 ),

                               ],
                             ),

                             Container(
                               height: 25,
                               width: 85,
                               decoration: BoxDecoration(
                                   color: Color(
                                       0xFF48c0d9),
                                   borderRadius:
                                   BorderRadius
                                       .circular(
                                       4)),
                               child: Center(
                                   child: Text(
                                     "Follow",
                                     style: TextStyle(fontWeight: FontWeight.w500,
                                         fontSize: 14,color: Colors.white),
                                   )),
                             ),
                           ],
                         ),
                       ),
                     ],
                   );
                 }),
            ),
          ),
        ],
      ),
    );
  }
}
