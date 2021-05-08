import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';import 'package:Butomy/Screen/Template1/B1_Home_Screen/food_bank_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountFoodBank extends StatefulWidget {

  ScrollController bankControo;
  String pageid;
  AccountFoodBank({this.bankControo,this.pageid});

  @override
  _AccountFoodBankState createState() => _AccountFoodBankState();
}

class _AccountFoodBankState extends StateMVC<AccountFoodBank>
    with SingleTickerProviderStateMixin {

  HomeKitchenRegistration _con;

  _AccountFoodBankState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {
      });
    _refreshController.loadComplete();
  }

  Future<void> _getData() async {
    setState(() {
      _con.FoodiBankAccount("4",widget.pageid.toString());
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  TabController _tabContoller;

  @override
  void initState() {
    _con.FoodiBankAccount("4",widget.pageid.toString());
    // TODO: implement initState
    super.initState();
    _tabContoller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var _NeedyBagGridView = Column(
      children: [
        Center(
          child: Visibility(
              visible: _con.AccFdBankStatus,
              child: Container(
                  margin: EdgeInsets.only(top: 100, ),
                  child: CircularProgressIndicator()
              )
          ),
        ),
        _con.AccFoodBank.length>0 && _con.AccFdBankStatus==false ?  Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropMaterialHeader(color: Colors.black,backgroundColor: Color(0xFF0dc89e),),
            onRefresh: _getData,
            controller: _refreshController,
            onLoading: _onLoading,
            child: GridView.builder(
                // physics: NeverScrollableScrollPhysics(),
                itemCount: _con.AccFoodBank.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .736,
                ),
                itemBuilder: (BuildContext context, int indexxx) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8,left: 1,right: 1),
                    child: new GestureDetector(
                      onTap: () {
                        _con.updateViewCountOfPost(_con.AccFoodBank[indexxx]["kitchen_item_image"][0]["pivot"]["post_id"].toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FoodBankDetailPage(product_id: _con
                                        .AccFoodBank[indexxx]["kitchen_item_id"].toString(),req_show: true,)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF1E2026),
                            borderRadius: BorderRadius.all(
                                Radius.circular(4.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  blurRadius: 8.0,
                                  spreadRadius: 0.0)
                            ]),
                        child: Container(
                          // color: Colors.white.withOpacity(0.5),
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 6, left: 3, right: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .stretch,
                                children: <Widget>[
                                  CachedNetworkImage(
                                    imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                        _con
                                            .AccFoodBank[indexxx]["kitchen_item_image"][0]["source"] +
                                        "?alt=media",
                                    imageBuilder: (context,
                                        imageProvider) =>
                                        Container(
                                          height: 110,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              color: Colors.black12,
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(2.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors
                                                        .black12
                                                        .withOpacity(
                                                        0.1),
                                                    spreadRadius: 2.0)
                                              ]
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                        Container(
                                          height: 110,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              color: Colors.black12,
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(2.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors
                                                        .black12
                                                        .withOpacity(
                                                        0.1),
                                                    spreadRadius: 2.0)
                                              ]
                                          ),
                                        ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 3, right: 0.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Text(_con
                                              .AccFoodBank[indexxx]["kitchen_item_name"].toString().length>20 ? _con
                                              .AccFoodBank[indexxx]["kitchen_item_name"].toString().substring(0,20)+" ..."
                                              : _con
                                              .AccFoodBank[indexxx]["kitchen_item_name"].toString()
                                              /*"Food Box for neddy 15 Boxes"
                                                        .substring(0, 22) +
                                                        "..."*/,
                                              style: f14wB),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Image.asset(
                                                "assets/Template1/image/Foodie/icons/eye.png",
                                                height: 18,
                                                width: 18,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(_con
                                                  .AccFoodBank[indexxx]["view_count"].toString()+" Views",
                                                  style: f12w)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (
                                                          context) =>
                                                          TimelineFoodWallDetailPage(
                                                            id: _con
                                                                .AccFoodBank[indexxx]['user_id']
                                                                .toString(),
                                                          )));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image:
                                                          CachedNetworkImageProvider(
                                                              _con
                                                                  .AccFoodBank[indexxx]["busprofileimage"]+"?alt=media"
                                                          ),
                                                          fit: BoxFit
                                                              .cover),
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              180.0))),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Text(
                                                        _con
                                                            .AccFoodBank[indexxx]["busname"],
                                                        style: f14w,
                                                      ),
                                                      SizedBox(height: 2,),
                                                      Text(_con
                                                          .AccFoodBank[indexxx]["busaddress"]
                                                          .toString()
                                                          .substring(
                                                          0, 11) + "...",
                                                          style: f11g),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.grey,
                                                size: 14,
                                              ),
                                              Text(
                                                "2.1 km",
                                                style: f12g,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 3),
                                    child: Divider(
                                      color: Colors.black87,
                                      thickness: 1,
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 2.0),
                                        child: Text(
                                          "Free",
                                          style: f14wB,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
            :_con.AccFdBankStatus == false ? Center(child: Padding(
          padding: const EdgeInsets.only(top:100.0),
          child: Text("No Items",style: f16wB,),
        )):Container(height: 0,)
      ],
    );
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: _NeedyBagGridView,
    );
  }
}
