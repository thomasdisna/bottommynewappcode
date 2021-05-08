import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BusinessIntegration extends StatefulWidget {
  @override
  _BusinessIntegrationState createState() => _BusinessIntegrationState();
}

class _BusinessIntegrationState extends StateMVC<BusinessIntegration> {

  TimelineWallController _con;

  _BusinessIntegrationState() : super(TimelineWallController()) {
    _con = controller;
  }

  bool homeKitchen, localStore, restaurant,pressed1,pressed2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getIDS(userid.toString());
    setState(() {
      homeKitchen = false;
      localStore = false;
      restaurant = false;
      pressed1 = false;
      pressed2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF1E2026),titleSpacing: 0, iconTheme: IconThemeData(color: Colors.white),
        title: Text("Business Integration",style: TextStyle(color: Colors.white),),

      ),
      body: _con.statusAccWall == false && IDS!=null ? SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MaterialButton(height: 50,
                onPressed: () {
                  setState(() {
                    homeKitchen = !homeKitchen;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Home Kitchen",
                      style: f18WB,
                    ),
                    Image.asset(
                      'assets/Template1/image/Foodie/icons/down-arrow.png',
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              homeKitchen
                  && IDS["home_kitchen"].length>0 ?
              Container(height: IDS["home_kitchen"].length.toDouble() * 70,
                    child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                        itemCount: IDS["home_kitchen"].length,
                        itemBuilder: (context,ind){
                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(height: 60,alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0,top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                   CachedNetworkImage(
                                     imageUrl: IDS["home_kitchen"][ind]["profile_image"]!=null ?
                                     "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"
                                         +IDS["home_kitchen"][ind]["profile_image"]+"?alt=media" :
                                     "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                     height: 40,
                                    ),
                                    SizedBox(
                                      width: 13.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(IDS["home_kitchen"][ind]["name"],style: f15wB,),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Text("BUID :",style: f13w),
                                            Text(
                                              "410121000001",
                                              style:
                                              f13y,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // active & inactive  button
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: MaterialButton(
                                    height: 30.0,
                                    onPressed: () {
                                      setState(() {
                                        pressed1 = !pressed1;
                                      });
                                    },
                                    color: pressed1 ? Colors.green : Colors.orange[800],
                                    child:
                                     Text(pressed1 ?"Active" : "Inactive",style: f14wB,),
                                  ),
                                  //
                                ),
                              ],
                            ),
                          )
                        ),
                      );
              }),
                  )
                  :  homeKitchen
                  && IDS["home_kitchen"].length==0 ? Padding(
                padding: const EdgeInsets.only(bottom:18),
                child: Container(
                  height: 70,
                  child: Center(child: Text("No Homekitchens !!!",style: f16bB,)),
                ),
              ) : Container(),
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              MaterialButton(height: 50,
                onPressed: () {
                  setState(() {
                    localStore = !localStore;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Local Store",
                      style: f18WB,
                    ),
                    Image.asset(
                      'assets/Template1/image/Foodie/icons/down-arrow.png',
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              localStore && IDS["local_store"].length>0
                  ? Container(height: IDS["local_store"].length.toDouble() * 70,
                child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                    itemCount: IDS["local_store"].length,
                    itemBuilder: (context,ind){
                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(height: 60,alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0,top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: IDS["local_store"][ind]["profile_image"]!=null ?
                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"
                                            +IDS["local_store"][ind]["profile_image"]+"?alt=media" :
                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 13.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(IDS["local_store"][ind]["name"],style: f15wB,),
                                          SizedBox(height: 5,),
                                          Row(
                                            children: [
                                              Text("BUID :",style: f13w),
                                              Text(
                                                "410121000001",
                                                style:
                                                f13y,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // active & inactive  button
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: MaterialButton(
                                      height: 30.0,
                                      onPressed: () {
                                        setState(() {
                                          pressed1 = !pressed1;
                                        });
                                      },
                                      color: pressed1 ? Colors.green : Colors.orange[800],
                                      child:
                                      Text(pressed1 ?"Active" : "Inactive",style: f14wB,),
                                    ),
                                    //
                                  ),
                                ],
                              ),
                            )
                        ),
                      );
                    }),
              )
                  : localStore
                  && IDS["local_store"].length==0 ? Padding(
                padding: const EdgeInsets.only(bottom:18),
                child: Container(
                  height: 70,
                  child: Center(child: Text("No Local Stores !!!",style: f16bB,)),
                ),
              ) : Container(),
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              MaterialButton(height: 50,
                onPressed: () {
                 setState(() {
                   restaurant = !restaurant;
                 });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Restaurant",
                      style: f18WB,
                    ),
                    Image.asset(
                      'assets/Template1/image/Foodie/icons/down-arrow.png',
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              restaurant && IDS["restaurant"].length>0 ? Container(height: IDS["restaurant"].length.toDouble() * 70,
                child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                    itemCount: IDS["restaurant"].length,
                    itemBuilder: (context,ind){
                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(height: 60,alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0,top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: IDS["restaurant"][ind]["profile_image"]!=null ?
                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"
                                            +IDS["restaurant"][ind]["profile_image"]+"?alt=media" :
                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 13.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(IDS["restaurant"][ind]["name"],style: f15wB,),
                                          SizedBox(height: 5,),
                                          Row(
                                            children: [
                                              Text("BUID :",style: f13w),
                                              Text(
                                                "410121000001",
                                                style:
                                                f13y,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // active & inactive  button
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: MaterialButton(
                                      height: 30.0,
                                      onPressed: () {
                                        setState(() {
                                          pressed1 = !pressed1;
                                        });
                                      },
                                      color: pressed1 ? Colors.green : Colors.orange[800],
                                      child:
                                      Text(pressed1 ?"Active" : "Inactive",style: f14wB,),
                                    ),
                                    //
                                  ),
                                ],
                              ),
                            )
                        ),
                      );
                    }),
              )
                  : restaurant
                  && IDS["restaurant"].length==0 ? Padding(
                    padding: const EdgeInsets.only(bottom:18),
                    child: Container(
                height: 70,
                child: Center(child: Text("No Restaurants !!!",style: f16bB,)),
              ),
                  ) : Container(),
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
