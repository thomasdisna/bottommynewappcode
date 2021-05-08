import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekit_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodiz_business_item_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'Business_Restaurant_Add_Product_Page.dart';
import 'business_home_kitchen_timeline.dart';
import 'business_restaurant_chat.dart';
import 'business_restaurant_new_entry.dart';
import 'business_restaurant_orders.dart';
import 'business_restaurant_timeline.dart';

class BusinessRestaurantProductListPage extends StatefulWidget {

  BusinessRestaurantProductListPage({this.pagid,this.timid,this.memberdate});
  String pagid,timid,memberdate;


  @override
  _BusinessRestaurantProductListPageState createState() => _BusinessRestaurantProductListPageState();
}

class _BusinessRestaurantProductListPageState extends StateMVC<BusinessRestaurantProductListPage> {
  bool switchControlAll = false;
  bool switchControlActInact = false;
  bool switchControlBuyPre = false;
  var textHolder = 'Switch is OFF';
  List<bool> _active = List.filled(1000, false);
  List<bool> _buynow = List.filled(1000, false);
  HomeKitchenRegistration _con;
  _BusinessRestaurantProductListPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.RestaurantProductList("3",widget.pagid,widget.timid);
    _con.getKitchenCategories("3");
    super.initState();
    setState(() {
    });
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
      _con.RestaurantProductList("3",widget.pagid,widget.timid);
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void toggleActivateAll(bool value) {
    if (switchControlAll == false) {
      _con.RestaurantActiveAllStatus(widget.pagid,widget.timid);
      setState(() {
        switchControlAll = true;
        textHolder = 'Switch is ON';
      });

    } else {
      setState(() {
        switchControlAll = false;
        textHolder = 'Switch is OFF';
      });

    }
  }

  void toggleActiveInactive(bool value) {
    if (switchControlActInact == false) {
      setState(() {
        switchControlActInact = true;
        textHolder = 'Switch is ON';
      });

    } else {
      setState(() {
        switchControlActInact = false;
        textHolder = 'Switch is OFF';
      });

    }
  }

  void toggleBuyPre(bool value) {
    if (switchControlBuyPre == false) {
      setState(() {
        switchControlBuyPre = true;
        textHolder = 'Switch is ON';
      });

    } else {
      setState(() {
        switchControlBuyPre = false;
        textHolder = 'Switch is OFF';
      });

    }
  }

  TextEditingController _search = TextEditingController();

  List _searchFollowerResult = [];

  void searchOperation(String searchText) {
    _searchFollowerResult.clear();
    if (searchText.isEmpty) {
      setState(() {
        _search.text = "";
      });
      return;
    }

    _con.RProductList.forEach((userDetail) {
      var ll = _searchFollowerResult.length;
      if (userDetail["kitchen_item_name"].toString().toLowerCase().contains(searchText.toLowerCase()) )
      {
        print("REEEEE 555 "+userDetail.toString());
        setState(() {
          _searchFollowerResult.insert(ll,userDetail);
        });
      }
      print("REEEEE 333 "+_searchFollowerResult.toString());
    });

    setState(() {});
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
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 23,
        ),

      ),

      body: Column(
        children: [
          Center(
            child: Visibility(
                visible: _con.statusRItem,
                child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.8),
                    child: CircularProgressIndicator()
                )
            ),
          ),
          _con.RProductList.length>0 && _con.statusRItem==false ? Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(color: Colors.black,backgroundColor: Color(0xFF0dc89e),),
              onRefresh: _getData,
              controller: _refreshController,
              onLoading: _onLoading,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child:  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Card(
                              color: Colors.grey[700],
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 3.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Total Items",
                                      style: f14w,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      _con.RTOTAL.toString(),
                                      style: f14wB,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.grey[700],
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 3.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Active Items", style: f14w),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(_con.RACTIVE.toString(), style: f14wB)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              splashColor: Color(0xFF48c0d8),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>BusinessRestaurantAddProductPage(pagid: widget.pagid,timid: widget.timid,memberdate: widget.memberdate,)
                                ));
                              },
                              child:  Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 3.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/Template1/image/Foodie/icons/add-item.png",
                                      height: 30,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Add Item", style: f14w)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(60)),
                        child: TextField(
                          style: f14w,
                          controller: _search,
                          onChanged: searchOperation,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 6),
                              prefixIcon:
                              Icon(Icons.search, color: Colors.grey),
                              suffixIcon:
                              GestureDetector(
                                  onTap: (){
                                    searchOperation('');
                                  },
                                  child: Icon(Icons.close, color: Colors.grey)),
                              border: InputBorder.none,
                              hintText: "Search Item",
                              hintStyle: f14w54),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.filter_list,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text("Sort/Filter", style: f14wB),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Activate All", style: f14w),
                              Transform.scale(
                                  scale: .7,
                                  child: Switch(
                                    onChanged: toggleActivateAll,
                                    value: switchControlAll,
                                    activeColor: Color((0xFFffd55e)),
                                    activeTrackColor: Colors.grey,
                                    inactiveThumbColor: Color((0xFFffd55e)),
                                    inactiveTrackColor: Colors.grey,
                                  )),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:0.0),
                        child: _searchFollowerResult.length >0 ? Container(
                          height:
                          _searchFollowerResult.length.toDouble() * 140,
                          child:  ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              reverse: true,
                              itemCount: _searchFollowerResult.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                _searchFollowerResult[index]['products_status']
                                    .toString() ==
                                    "0"
                                    ? _active[index] = true
                                    : _active[index] = false;
                                _searchFollowerResult[index]['placeorder_type']
                                    .toString() ==
                                    "0"
                                    ? _buynow[index] = false
                                    : _buynow[index] = true;
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ItemDetailPage(tabb: 1,
                                                  member: widget.memberdate,typ: "3",timid: widget.timid,
                                                  productid: _searchFollowerResult[index][
                                                  'kitchen_item_id']
                                                      .toString(),
                                                  pageid: widget.pagid,

                                                  pic: _searchFollowerResult[
                                                  index][
                                                  'kitchen_item_image']
                                                  [0]["source"]
                                                      .toString(),
                                                )));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12.0, bottom: 12),
                                          child: Column(
                                            children: [
                                              Opacity(
                                                opacity: _searchFollowerResult[
                                                index][
                                                'products_status']
                                                    .toString() ==
                                                    "0"
                                                    ? .2
                                                    : 1,
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                        _searchFollowerResult[
                                                        index][
                                                        'kitchen_item_name'],
                                                        style: f15wB),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      height: 14,
                                                      width: 14,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:_searchFollowerResult[index]['products_type']
                                                                  .toString() ==
                                                                  "1"
                                                                  ? Colors.red[
                                                              700]
                                                                  : Colors.greenAccent[
                                                              700]),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              2)),
                                                      child: Icon(
                                                        Icons.brightness_1,
                                                        color: _searchFollowerResult[
                                                        index]
                                                        [
                                                        'products_type']
                                                            .toString() ==
                                                            "1"
                                                            ? Colors
                                                            .red[700]
                                                            : Colors.greenAccent[
                                                        700],
                                                        size: 8,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: <Widget>[
                                                  Opacity(
                                                    opacity: _searchFollowerResult[
                                                    index][
                                                    'products_status']
                                                        .toString() ==
                                                        "0"
                                                        ? .2
                                                        : 1,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(clipBehavior: Clip.antiAlias,
                                                                      height: 72,
                                                                      width: 68,
                                                                      child:
                                                                      CachedNetworkImage(
                                                                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                            _searchFollowerResult[index]['kitchen_item_image'][0]["source"].toString() +
                                                                            "?alt=media",
                                                                        fit:
                                                                        BoxFit.cover,
                                                                        placeholder: (context, ind) =>
                                                                            Container(
                                                                              height: 72,
                                                                              width: 68,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)), boxShadow: [
                                                                                BoxShadow(blurRadius: 6.0, color: Colors.black12.withOpacity(0.1), spreadRadius: 2.0)
                                                                              ]),
                                                                              child: Image.asset(
                                                                                "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.black12,
                                                                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                          boxShadow: [
                                                                            BoxShadow(blurRadius: 5.0, color: Colors.black12.withOpacity(0.1), spreadRadius: 2.0)
                                                                          ]),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                      5,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          "In "+ _searchFollowerResult[index]['products_category'][0]["parent_category_name"],
                                                                          style: f14w,
                                                                        ),
                                                                        SizedBox(height: 3),
                                                                        Text(
                                                                          "In "+_searchFollowerResult[index]['products_category'][0]["category_name"],
                                                                          style: f14w,
                                                                        ),
                                                                        SizedBox(height: 3),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Icon(
                                                                              Icons.star,
                                                                              color: Colors.yellow,
                                                                              size: 14,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 2,
                                                                            ),
                                                                            Text(_searchFollowerResult[index]['kitchen_item_rating'].toString(), style: f14gB),
                                                                            Text(" Ratings", style: f14g)
                                                                          ],
                                                                        ),

                                                                        SizedBox(height: 3),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Text("Price: ", style: f14w),
                                                                            Text("\u20B9 " + _searchFollowerResult[index]['kitchen_item_amount'].toString(), style: f14wB),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .end,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 32,
                                                        width: 169,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[700],
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <
                                                              Widget>[
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  5.0),
                                                              child: Text(
                                                                  "Active",
                                                                  style:
                                                                  f135w),
                                                            ),
                                                            Transform.scale(
                                                                scale: .7,
                                                                child:
                                                                Switch(
                                                                  onChanged:
                                                                      (bool
                                                                  val) {
                                                                    if (_active[index] ==
                                                                        true)
                                                                      setState(
                                                                              () {
                                                                            _active[index] =
                                                                            false;
                                                                            _searchFollowerResult[index]['products_status'] =
                                                                            1;
                                                                            _con.HKACTIVE =
                                                                                _con.HKACTIVE + 1;
                                                                            _con.HomeKitchenUpdateActiveStatus(
                                                                                _searchFollowerResult[index]['kitchen_item_id'].toString(),
                                                                                "1",
                                                                                widget.pagid);
                                                                          });
                                                                    else
                                                                      setState(
                                                                              () {
                                                                            _active[index] =
                                                                            true;
                                                                            _searchFollowerResult[index]['products_status'] =
                                                                            0;
                                                                            _con.HKACTIVE =
                                                                                _con.HKACTIVE - 1;
                                                                            _con.HomeKitchenUpdateActiveStatus(
                                                                                _searchFollowerResult[index]['kitchen_item_id'].toString(),
                                                                                "0",
                                                                                widget.pagid);
                                                                          });
                                                                  },
                                                                  value: _active[
                                                                  index],
                                                                  activeColor:
                                                                  Color(
                                                                      0xFFffd55e),
                                                                  activeTrackColor:
                                                                  Colors
                                                                      .grey,
                                                                  inactiveThumbColor:
                                                                  Colors
                                                                      .greenAccent[700],
                                                                  inactiveTrackColor:
                                                                  Colors
                                                                      .grey,
                                                                )),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  right:
                                                                  5.0),
                                                              child: Text(
                                                                  "Inactive",
                                                                  style:
                                                                  f135w),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Opacity(
                                                        opacity: _searchFollowerResult[
                                                        index]
                                                        [
                                                        'products_status']
                                                            .toString() ==
                                                            "0"
                                                            ? .2
                                                            : 1,
                                                        child: Container(
                                                          height: 32,
                                                          width: 169,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[
                                                              700],
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: <
                                                                Widget>[
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left:
                                                                    5.0),
                                                                child: Text(
                                                                    "Buynow",
                                                                    style:
                                                                    f135w),
                                                              ),
                                                              Transform.scale(
                                                                  scale: .7,
                                                                  child:
                                                                  Switch(
                                                                    onChanged:
                                                                        (bool
                                                                    val) {
                                                                      if (_buynow[index] ==
                                                                          true)
                                                                        setState(
                                                                                () {
                                                                              _buynow[index] =
                                                                              false;
                                                                              _searchFollowerResult[index]['placeorder_type'] =
                                                                              0;
                                                                              _con.buynoePreSETTING(
                                                                                  _searchFollowerResult[index]['kitchen_item_id'].toString(),
                                                                                  "0");
                                                                            });
                                                                      else
                                                                        setState(
                                                                                () {
                                                                              _buynow[index] =
                                                                              true;
                                                                              _searchFollowerResult[index]['placeorder_type'] =
                                                                              1;

                                                                              _con.buynoePreSETTING(
                                                                                _searchFollowerResult[index]['kitchen_item_id'].toString(),
                                                                                "1",);
                                                                            });
                                                                    },
                                                                    value: _buynow[index],
                                                                    activeColor:
                                                                    Color(0xFF0dc89e
                                                                    ),

                                                                    activeTrackColor:
                                                                    Colors
                                                                        .grey,
                                                                    inactiveThumbColor:
                                                                    Color( 0xFFffd55e),
                                                                    inactiveTrackColor:
                                                                    Colors
                                                                        .grey,
                                                                  )),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    5.0),
                                                                child: Text(
                                                                    "Preorder",
                                                                    style:
                                                                    f135w),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Divider(
                                        color: Colors.black87,
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ) : Container(
                          height:_con.RProductList.length.toDouble()* 140,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),reverse: true,
                              itemCount: _con.RProductList.length,
                              itemBuilder: (BuildContext context, int index) {
                                _con.RProductList[index]['products_status'].toString()=="0" ? _active[index]=true : _active[index] = false;
                                _con.RProductList[index]['placeorder_type']
                                    .toString() ==
                                    "0"
                                    ? _buynow[index] = false
                                    : _buynow[index] = true;
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ItemDetailPage(tabb: 1,
                                              member: widget.memberdate,typ: "3",timid: widget.timid,
                                              pageid: widget.pagid,
                                              productid: _con.RProductList[index]['kitchen_item_id'].toString(),
                                              pic: _con.RProductList[index]['kitchen_item_image'][0]["source"].toString(),
                                              )));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:12.0,bottom: 12),
                                          child: Column(
                                            children: [
                                            Opacity(
                                              opacity:_con.RProductList[index]['products_status'].toString()=="0" ?  .2 : 1,
                                              child:   Row(
                                                children: <Widget>[
                                                  Text(_con.RProductList[index]['kitchen_item_name'],
                                                      style: f15wB),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    height: 14,
                                                    width: 14,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: _con.RProductList[index]['products_type'].toString()=="1" ? Colors.red[700] : Colors.greenAccent[700]),
                                                        borderRadius:
                                                        BorderRadius.circular(2)),
                                                    child: Icon(
                                                      Icons.brightness_1,
                                                      color: _con.RProductList[index]['products_type'].toString()=="1" ? Colors.red[700] : Colors.greenAccent[700],
                                                      size: 8,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Opacity(
                                                    opacity:_con.RProductList[index]['products_status'].toString()=="0" ?  .2 : 1,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: <Widget>[

                                                            Row(
                                                              children: <Widget>[
                                                                Row(
                                                                  children: <Widget>[
                                                                    Container(clipBehavior: Clip.antiAlias,
                                                                      height: 72,
                                                                      width: 68,
                                                                      child:
                                                                      CachedNetworkImage(
                                                                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                            _con.RProductList[index]['kitchen_item_image'][0]["source"].toString() +
                                                                            "?alt=media",
                                                                        fit:
                                                                        BoxFit.cover,
                                                                        placeholder: (context, ind) =>
                                                                            Container(
                                                                              height: 72,
                                                                              width: 68,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)), boxShadow: [
                                                                                BoxShadow(blurRadius: 6.0, color: Colors.black12.withOpacity(0.1), spreadRadius: 2.0)
                                                                              ]),
                                                                              child: Image.asset(
                                                                                "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.black12,
                                                                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                          boxShadow: [
                                                                            BoxShadow(blurRadius: 5.0, color: Colors.black12.withOpacity(0.1), spreadRadius: 2.0)
                                                                          ]),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: <Widget>[
                                                                        Text(
                                                                          "In "+ _con.RProductList[index]['products_category'][0]["parent_category_name"],
                                                                          style: f14w,
                                                                        ),
                                                                        SizedBox(height: 3),
                                                                        Text(
                                                                          "In "+_con.RProductList[index]['products_category'][0]["category_name"],
                                                                          style: f14w,
                                                                        ),
                                                                        SizedBox(height: 3),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Icon(
                                                                              Icons.star,
                                                                              color: Colors.yellow,
                                                                              size: 14,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 2,
                                                                            ),
                                                                            Text(_con.RProductList[index]['kitchen_item_rating'].toString(),
                                                                                style: f14gB),
                                                                            Text(" Ratings",
                                                                                style: f14g)
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 3),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Text(
                                                                                "Price: ",
                                                                                style: f14w
                                                                            ),
                                                                            Text(
                                                                                "\u20B9 " + _con.RProductList[index]['kitchen_item_amount'].toString(),
                                                                                style: f14wB
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 32,
                                                        width: 169,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey[700],
                                                            borderRadius:
                                                            BorderRadius.circular(5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: const EdgeInsets.only(
                                                                  left: 5.0),
                                                              child: Text("Active",
                                                                  style: f135w),
                                                            ),
                                                            Transform.scale(
                                                                scale: .7,
                                                                child: Switch(
                                                                  onChanged: (bool val){
                                                                    if(_active[index]==true)
                                                                      setState(() {
                                                                        _active[index]=false;
                                                                        _con.RProductList[index]['products_status']=1;
                                                                        _con.RACTIVE=_con.RACTIVE+1;
                                                                        _con.RestaurantUpdateActiveStatus(_con.RProductList[index]['kitchen_item_id'].toString(),"1",widget.pagid);
                                                                      });
                                                                    else
                                                                      setState(() {
                                                                        _active[index]=true;
                                                                        _con.RProductList[index]['products_status']=0;
                                                                        _con.RACTIVE=_con.RACTIVE-1;
                                                                        _con.RestaurantUpdateActiveStatus(_con.RProductList[index]['kitchen_item_id'].toString(),"0",widget.pagid);
                                                                      });
                                                                  },
                                                                  value: _active[index],
                                                                  activeColor:Color(0xFFffd55e),
                                                                  activeTrackColor: Colors.grey,
                                                                  inactiveThumbColor:Colors.greenAccent[700],
                                                                  inactiveTrackColor: Colors.grey,
                                                                )),
                                                            Padding(
                                                              padding: const EdgeInsets.only(
                                                                  right: 5.0),
                                                              child: Text("Inactive",
                                                                  style: f135w),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Opacity(
                                                        opacity:_con.RProductList[index]['products_status'].toString()=="0" ?  .2 : 1,
                                                        child: Container(
                                                          height: 32,
                                                          width: 169,
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey[700],
                                                              borderRadius:
                                                              BorderRadius.circular(5)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: const EdgeInsets.only(
                                                                    left: 5.0),
                                                                child: Text("Buynow",
                                                                    style: f135w),
                                                              ),
                                                              Transform.scale(
                                                                  scale: .7,
                                                                  child:
                                                                  Switch(
                                                                    onChanged:
                                                                        (bool
                                                                    val) {
                                                                      if (_buynow[index] ==
                                                                          true)
                                                                        setState(
                                                                                () {
                                                                              _buynow[index] =
                                                                              false;
                                                                              _con.RProductList[index]['placeorder_type'] =
                                                                              0;
                                                                              _con.buynoePreSETTING(
                                                                                  _con.RProductList[index]['kitchen_item_id'].toString(),
                                                                                  "0");
                                                                            });
                                                                      else
                                                                        setState(
                                                                                () {
                                                                              _buynow[index] =
                                                                              true;
                                                                              _con.RProductList[index]['placeorder_type'] =
                                                                              1;

                                                                              _con.buynoePreSETTING(
                                                                                _con.RProductList[index]['kitchen_item_id'].toString(),
                                                                                "1",);
                                                                            });
                                                                    },
                                                                    value: _buynow[index],
                                                                    activeColor:
                                                                    Color(0xFF0dc89e
                                                                    ),

                                                                    activeTrackColor:
                                                                    Colors
                                                                        .grey,
                                                                    inactiveThumbColor:
                                                                    Color( 0xFFffd55e),
                                                                    inactiveTrackColor:
                                                                    Colors
                                                                        .grey,
                                                                  )),
                                                              Padding(
                                                                padding: const EdgeInsets.only(
                                                                    right: 5.0),
                                                                child: Text("Preorder",
                                                                    style: f135w),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4,),
                                      Divider(
                                        color: Colors.black87,
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
              :  _con.statusRItem == false ? Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.8),
                child: InkWell(
                  splashColor: Color(0xFF48c0d8),
                  borderRadius: BorderRadius.circular(8),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>BusinessRestaurantAddProductPage(pagid: widget.pagid,timid: widget.timid,memberdate: widget.memberdate,)
                    ));
                  },
                  child:  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 3.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/Template1/image/Foodie/icons/add-item.png",
                          height: 30,
                          width: 25,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Add Item", style: f14w)
                      ],
                    ),
                  ),
                ),
              ):Container(height: 0,),
        ],
      ),
     /* bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E2026),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 2,
            ),
          ],
        ),
        height: 56,
        child: Padding(
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      BusinessRestaurantTimeline(memberdate: widget.memberdate,pagid: widget.pagid,
                        timid: widget.timid,upld: false,)), );
                },
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/home.png",
                      height: 21,
                      color: Colors.white54,
                      width: 21,
                    ),
                    Text("Home", style: f14w54,)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => BusinessRestaurantChatList(memberdate: widget.memberdate,timid: widget.timid,pagid: widget.pagid,
                        myID: userid.toString(),myName: NAME.toString(),)
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/chat.png",
                      height: 21,
                      color: Colors.white54,
                      width: 21,
                    ),
                    Text("Chat", style: f14w54,)
                  ],
                ),
              ),
              Container(
                height: 42,
                width: 42,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => RestaurantNewEntryForm(timid: widget.timid,pagid: widget.pagid,memberdate: widget.memberdate,)
                    ));
                  },
                  elevation: 5,
                  backgroundColor: Color(0xFF48c0d9),
                  child: Icon(
                    Icons.add,
                    size: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/Template1/image/Foodie/icons/list.png",
                      height: 23,
                      color: Color(0xFFffd55e),
                      width: 23,
                    ),
                    Text("Item list", style: f14y,)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => BusinessRestaurantOrderPage(memberdate: widget.memberdate,pagid: widget.pagid,timid: widget.timid,)
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        "assets/Template1/image/Foodie/icons/order-list.png",
                        height: 23, color: Colors.white54, width: 23),
                    Text("Orders", style: f14w54,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),*/

    );
  }
}
class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black87))),
        child: InkWell(
          splashColor: Colors.black45,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: f14w,
                      ),
                    ),
                  ],
                ),
                //Icon(Icons.arrow_right, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}