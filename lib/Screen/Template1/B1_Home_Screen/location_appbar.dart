import 'package:flutter/material.dart';

class LocationBar extends StatelessWidget {

  final double appBarheight = 66;
  const LocationBar();


  @override
  Widget build(BuildContext context) {
    TextEditingController _loc = TextEditingController();
    final double statusHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusHeight+80),
      height: statusHeight + appBarheight,
      child:  Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 3.0,bottom: 3,right: 16,left: 16),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 47.0,

              decoration: BoxDecoration(
                  color: Color(0xFF23252E),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5.0,
                        spreadRadius: 0.0)
                  ]),
              child: Container(
                child: TextField(
                  controller: _loc,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(prefixIcon: Icon(Icons.location_on,color: Colors.white),
                      border: InputBorder.none,
                      hintText: "Location",suffixIcon: Icon(Icons.my_location,color: Colors.white,),
                      hintStyle:
                      TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

