import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
class Testuuu extends StatefulWidget {
  @override
  _TestuuuState createState() => _TestuuuState();
}

class _TestuuuState extends State<Testuuu> {
var ListDataa=[];
  Future logout() async {
    final response = await http.get(Uri.encodeFull("http://a974b3d89890843dd81858e9598c8d12-199436556.ap-south-1.elb.amazonaws.com/api/goferquestions?productid=1"));
    var qData = json.decode(response.body);
    print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDd "+qData.toString());
    setState(() {
      ListDataa = qData;
      DropDwn = ListDataa[1]["answers"];
    });
  }


  int val =2;
  bool val1 = false;
  bool val2 = false;

  int sc;
  @override
  void initState() {
    logout();
    // TODO: implement initState
    super.initState();
    setState(() {
      sc=0;

      val= 2;
      ListDataa= [];
      val1 = false;
      val2 = false;
    });
  }
final ItemScrollController itemScrollController = ItemScrollController();

/// Listener that reports the position of items when the list is scrolled.
final ItemPositionsListener itemPositionsListener =
ItemPositionsListener.create();
  var drop_val;

  List DropDwn = ["Option 1","Option 2","Option 3","Option 4","Option 5"];
  double jum = 0;
ScrollController  _scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.pink[400],
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Text("drfhgjfh "),
                Text("drfhgjfh ",),
                SizedBox(height: 30,),
                Text("drfhgjfh "),
                SizedBox(height: 30,),
                val == 2 ? Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Checkbox(value: val1,
                          activeColor: Colors.white,
                          checkColor: Color(0xF0DE1462),
                          onChanged:(bool newValue){
                            setState(() {
                              val1 = newValue;
                            });
                          }),
                      Checkbox(value: val2,
                          activeColor: Colors.white,
                          checkColor: Color(0xF0DE1462),
                          onChanged:(bool newValue){
                            setState(() {
                              val2 = newValue;
                              val =4;
                            });
                          }),
                    ],
                  ),
                ) : val == 4 ? Container(
                  height: 45,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: DropdownButton(
                      value: drop_val,
                      hint: Text("Select",style: TextStyle(color: Colors.black,fontSize: 15),),
                      dropdownColor: Colors.white,
                      iconEnabledColor: Colors.black,
                      iconSize: 25,
                      elevation: 16,isExpanded: true,
                      style: TextStyle(color: Colors.black,fontSize: 15),
                      underline: Container(height: 0,),
                      onChanged: (newValue) {
                        setState(() {
                          drop_val = newValue;
                          _scroll.jumpTo(500);
                        });
                      },
                      items: ListDataa[1]["answers"].join(",").toString().split(",").map((item) {
                        print("sdfghuij "+item);
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item,style: TextStyle(fontSize: 15),),
                        );
                      }).toList(),
                    ),
                  ),
                ) : Container(),
                Container(height: 10.toDouble()*128,
                  child:  ScrollablePositionedList.builder(
                      initialScrollIndex: sc,
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                    // physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context,ind){
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(color: Colors.grey,
                        height: 100,alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text("Abcd "+ind.toString()),
                            SizedBox(height: 10,),
                            Text("FFFF "+ind.toString()),
                            SizedBox(height: 10,),
                            Text("YYYYY "+ind.toString()),
                          ],
                        ),
                      ),
                    );
                  }),
                )

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
alignment: Alignment.center,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("fcgvhbj n "),
            SizedBox(height: 10,),
            MaterialButton(
              color: Colors.white,
              onPressed: (){
                setState(() {
                  jum=jum+600;
                  sc=6;
                  print("dxcfgvbhnj "+sc.toString());
                  itemScrollController.jumpTo(index: 6,);
                });
                //
              },
              child: Text("JUMP"),
            ),
          ],
        ),
      ),
    );
  }
}
