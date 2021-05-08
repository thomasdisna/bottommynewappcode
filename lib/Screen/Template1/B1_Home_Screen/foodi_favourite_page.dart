import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Each_Item_Detail_view_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FoodiFavouritesPage extends StatefulWidget {
  @override
  _FoodiFavouritesPageState createState() => _FoodiFavouritesPageState();
}

class _FoodiFavouritesPageState extends StateMVC<FoodiFavouritesPage> {


  HomeKitchenRegistration _con;
  _FoodiFavouritesPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }
  List<bool> splashcolor = List.filled(1000, false);
  
  @override
  void initState() {
    setState(() {
      _con.FavouriteList = favouriteList;
    });
    _con.getFavouriteList();
    // TODO: implement initState
    super.initState();
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
        title: Text("Favourite Items",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Visibility(
                  visible: _con.favStatus,
                  child: Container(
                      margin: EdgeInsets.only(top: 250, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            _con.FavouriteList.length>0 && _con.favStatus==false  ? Container(
              height: _con.FavouriteList.length.toDouble()*160,
              child: ListView.builder(
                // scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _con.FavouriteList.length,
                itemBuilder: (ctx, inditem) {
                  return Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _con.FavouriteList[inditem]['products_status'].toString()=="1" ?
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>EachItemDetailPage(
                                    page_id: _con.FavouriteList[inditem]['page_id'].toString(),
                                    typ: _con.FavouriteList[inditem]['business_type'].toString(),product_id: _con.FavouriteList[inditem]["kitchen_item_id"].toString(),)
                              )) : Fluttertoast.showToast(msg: "Product not available !!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 35,
                                backgroundColor: Color(0xFF48c0d8),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10, right: 8, left: 8),
                              child: Opacity(
                                opacity: _con.FavouriteList[inditem]['products_status'].toString()=="0" ?  .2 : 1,
                                child: Container(
                                  height: 126.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10.0,
                                          color: Colors.black12.withOpacity(0.03),
                                          spreadRadius: 10.0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(clipBehavior: Clip.antiAlias,
                                              height: 105.0,
                                              width: 95.0,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10.0)),
                                                      ),
                                              child: CachedNetworkImage(
                                                  imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                  _con.FavouriteList[inditem]["kitchen_item_image"][0]["source"].toString()+"?alt=media",
                                                fit: BoxFit
                                                    .cover,
                                                placeholder: (
                                                    context,
                                                    ind) =>
                                                    Container(clipBehavior: Clip.antiAlias,
                                                      height: 105.0,
                                                      width: 95.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0)),
                                                      ),
                                                      child: Image
                                                          .asset(
                                                        "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                        fit: BoxFit
                                                            .cover,),
                                                    ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text( _con.FavouriteList[inditem]["kitchen_item_name"].toString().length>15 ?  _con.FavouriteList[inditem]["kitchen_item_name"].toString().substring(0,15)+"..."
                                                        : _con.FavouriteList[inditem]["kitchen_item_name"],
                                                        style: f15wB
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: _con.FavouriteList[inditem]
                                                            ["products_type"].toString()=="0" ? Colors.green[600] : Colors.red[600]),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            (2)),
                                                      ),
                                                      child: Icon(
                                                          Icons.brightness_1,
                                                          color:
                                                          _con.FavouriteList[inditem]
                                                          ["products_type"].toString()=="0" ? Colors.green[600] : Colors.red[600],
                                                          size: 8),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                _con.FavouriteList[inditem]
                                                ["products_category"].length > 0 ?  Text(
                                                    "In " +_con.FavouriteList[inditem]
                                                    ["products_category"][0]["category_name"],
                                                    style: f14w
                                                ) : Container(),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                        "5",
                                                        style: f14wB
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFffd55e),
                                                      size: 15,
                                                    ),



                                                    Text(
                                                        " ("+_con.FavouriteList[inditem]
                                                        ["products_quantity"].toString()+minPic+")",
                                                        style: f14wB
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                        "\u20B9 "+ _con.FavouriteList[inditem]["kitchen_item_amount"].toString(),
                                                        style: f14wB
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 30.0,
                                                        decoration: BoxDecoration(
                                                            image:
                                                            DecorationImage(
                                                                image:
                                                                CachedNetworkImageProvider(
                                                                  _con.FavouriteList[inditem]["busprofileimage"]!=null ?
                                                                  _con.FavouriteList[inditem]["busprofileimage"]+"?alt=media" :
                                                                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2Ficu.png?alt=media",
                                                                ),
                                                                fit: BoxFit
                                                                    .cover),
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    180.0))),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 7),
                                                        child: Container(height: 29,width: MediaQuery.of(context).size.width-248,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Text(
                                                                _con.FavouriteList[inditem]["busname"],
                                                                overflow: TextOverflow.ellipsis,
                                                                style: f14w,
                                                              ),
                                                              Text( _con.FavouriteList[inditem]["busaddress"],
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: f11g),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap:(){
                                                    if(_con.FavouriteList[inditem]['products_status'].toString()=="1") { _con.AddtoPurchaseList(userid.toString(), _con.FavouriteList[inditem]
                                                    ["kitchen_item_id"].toString(), _con.FavouriteList[inditem]['business_type'].toString(),"1",
                                                        _con.FavouriteList[inditem]["kitchen_item_amount"].toString(), _con.FavouriteList[inditem]["page_id"].toString());
                                                    setState(() {
                                                      splashcolor[inditem]=true;
                                                    });}
                                                  },
                                                  child: Image.asset(
                                                    "assets/Template1/image/Foodie/icons/shopping-basket.png",
                                                    height: 24,
                                                    width: 24,
                                                    color:splashcolor[inditem]? Color(0xFF48c0d8) : Color(0xFFffd55e),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (
                                                            BuildContext context) {
                                                          return AlertDialog(
                                                            backgroundColor: Color(
                                                                0xFF1E2026),
                                                            title: new Text(
                                                              "Delete Item?",
                                                              style: f16wB,
                                                            ),
                                                            content: new Text(
                                                              "Do you want to delete the item",
                                                              style: f14w,
                                                            ),
                                                            actions: <
                                                                Widget>[
                                                              MaterialButton(
                                                                height: 28,
                                                                color: Color(
                                                                    0xFFffd55e),
                                                                child: new Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator
                                                                      .pop(
                                                                      context,
                                                                      'Cancel');
                                                                },
                                                              ),
                                                              MaterialButton(
                                                                height: 28,
                                                                color: Color(
                                                                    0xFF48c0d8),
                                                                child: new Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onPressed: () {
                                                                  _con.addFavourite(_con.FavouriteList[inditem]
                                                                  ["kitchen_item_id"].toString());
                                                                  Navigator
                                                                      .pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child:Icon(Icons.delete_outline,
                                                      color: Color(0xFF48c0d8))

                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 25.0,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  color: Color(0xFFffd55e)),
                                              child: Center(
                                                child: Text(
                                                  "Buy Now",
                                                  style: f14B,
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
                            ),
                          ),
                          Divider(
                            color: Colors.black87,
                            thickness: 7,
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ) : _con.favStatus == false ? Center(child: Padding(
              padding: const EdgeInsets.only(top:100.0),
              child: Text("No Items",style: f15bB,),
            )):Container(height: 0,),
          ],
        ),
      ),
    );
  }
}
