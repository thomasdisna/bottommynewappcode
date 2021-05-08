import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chat_link_detail_page.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';

class FoodBankRequestForm extends StatefulWidget {

  FoodBankRequestForm({this.pic,this.post_id,this.owner,this.owner_pic,this.prod_id,this.pickup,this.owner_username,this.owner_devicetoken,this.owner_id,this.title});

  String pic,pickup,owner,owner_pic,post_id,owner_id,owner_devicetoken,owner_username,title,prod_id;

  @override
  _FoodBankRequestFormState createState() => _FoodBankRequestFormState();
}

class _FoodBankRequestFormState extends State<FoodBankRequestForm> {

  TextEditingController _foodi = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _foodi.text = "Hai "+widget.owner;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        elevation: 5,
        title: Text("Request This",style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Stack(alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height-97,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          child: CachedNetworkImage(
                            imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"
                            +widget.pic+"?alt=media",fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title.length>33 ? /*"For the needy  -  "+*/widget.title.substring(0,33)+"..." : /*"For the needy  -  "+*/widget.title,style: f15wB,),
                            SizedBox(height: 6,),
                            Text("Pick : "+widget.pickup,style: f15wB,),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Divider(color: Colors.grey[700],),
                    SizedBox(height: 30,),
                    Center(
                      child: Container(clipBehavior: Clip.antiAlias,
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.owner_pic,
                            placeholder: (
                                context,
                                ind) =>
                                Container( height: 100,
                                  width: 100,clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/Template1/image/Foodie/post_dummy.jpeg",
                                    fit: BoxFit
                                        .cover,),
                                )
                        )/* CachedNetworkImage(
                          imageUrl: widget.owner_pic,
                        )*/,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Center(child: Text(widget.owner,style: f16wB,)),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on,color: Colors.grey,size: 18,),
                        Text("XX km Away",style: f15w,)
                      ],
                    ),
                    SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:8,bottom: 8,left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 27,width: 27,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow[700],
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(child: Icon(Icons.lightbulb_outline,color: Colors.white,size: 20,)),
                                ),
                                SizedBox(width: 3,),
                                Text("Top tops",style: f15wB,)
                              ],
                            ),
                            SizedBox(height: 13,),
                            Row(
                              children: [
                                Icon(Icons.brightness_1,color: Colors.grey,size: 5,),
                                Text(" Say when you can pick up this listing",style: f13w,)
                              ],
                            ),
                            SizedBox(height: 2,),
                            Row(
                              children: [
                                Icon(Icons.brightness_1,color: Colors.grey,size: 5,),
                                Text(" Be polite by saying please and thank you",style: f13w,)
                              ],
                            ),
                            SizedBox(height: 2,),
                            Row(
                              children: [
                                Icon(Icons.brightness_1,color: Colors.grey,size: 5,),
                                Text(" Never set off without the pickup confirmed, and an address",style: f13w,)
                              ],
                            ),
                            SizedBox(height: 16,),
                            Text("Read our safety sharing guidelines here",style: f14yB,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(children: [
                  Container(
                    height: 43,
                    width: MediaQuery.of(context).size.width-85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: _foodi,
                      style: f14,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "Hai "+widget.owner,
                          hintStyle: f14,
                          border: InputBorder.none
                      ),

                    ),
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      try {
                        String chatID = makeChatId(
                            timelineIdFoodi
                                .toString(),
                            widget.owner_id);
                        Navigator
                            .push(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) =>
                                    ChatRoom(
                                        timelineIdFoodi.toString(),
                                        NAME,
                                        widget.owner_devicetoken,
                                        widget.owner_id,
                                        chatID,
                                        widget.owner_username,
                                        widget.owner,
                                        widget.owner_pic
                                            .replaceAll(
                                            " ",
                                            "%20") +
                                            "?alt=media",
                                        _foodi.text +" . I need this item https://saasinfomedia.com/butomy/foodbank/product/"+widget.prod_id)));
                      } catch (e) {
                        print(e
                            .message);
                      }
                    },
                    child: Container(
                      height: 43,width: 60,
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Send")),
                    ),
                  )
                ],),
              )
            ],
          ),
        ),
      ),
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(children: [
            Container(
              height: 43,
              width: MediaQuery.of(context).size.width-85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: _foodi,
                style: f14,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "Hai "+widget.owner,
                  hintStyle: f14,
                  border: InputBorder.none
                ),

              ),
            ),
            SizedBox(width: 5,),
            InkWell(
              onTap: (){
                try {
                  String chatID = makeChatId(
                      userid
                          .toString(),
                     widget.owner_id);
                  Navigator
                      .push(
                      context,
                      MaterialPageRoute(
                          builder: (
                              context) =>
                              ChatRoom(
                                  userid,
                                  NAME,
                                  widget.owner_devicetoken,
                                  widget.owner_id,
                                  chatID,
                                  widget.owner_username,
                                  widget.owner,
                                  widget.owner_pic
                                      .replaceAll(
                                      " ",
                                      "%20") +
                                      "?alt=media",
                                  _foodi.text +" . I need this item link https://saasinfomedia.com/foodiz/public/sharepost/"+widget.post_id)));
                } catch (e) {
                  print(e
                      .message);
                }
              },
              child: Container(
                height: 43,width: 60,
                decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Send")),
              ),
            )
          ],),
        ),
      ),*/
    );
  }
}
