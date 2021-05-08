import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import   'package:flutter/cupertino.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_HomeKitchen_Product_List_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_Restaurant_Product_List_Page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Search_Screen/Search_Screen_T1.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekitchen_bottom_bar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_referfriend.dart';
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
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'business_home_kitchen_timeline.dart';
import 'package:Butomy/Components/widget_style.dart';
class ItemDetailPage extends StatefulWidget {
  String pic,pageid,productid,typ,timid,member;
  int tabb;
  ItemDetailPage({this.pic,this.member,this.pageid,this.productid,this.typ,this.timid,this.tabb});
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends StateMVC<ItemDetailPage> {

  HomeKitchenRegistration _con;
  _ItemDetailPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  Future<Null> _pickImage() async {
   var image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 20);
    if (image != null) {
      setState(() {
        imageFile = image;
      });
    }
  }

  File imageFile;
  bool autofo;
  bool qntyy;
  bool autofo2;
  bool autofo3;
  bool readonlyy;
  bool readonlyy2;
  bool readonlyy3;
  int tabbb;

  bool switchControlBuyPre = false;
  bool switchControlActInact = false;
  var textHolder = 'Switch is OFF';
  var priceText;
  FocusNode myFocusNode;
  FocusNode myFocusNode2;
  FocusNode myFocusNode3;

  TextEditingController _displayName = TextEditingController();
  TextEditingController _subtitle = TextEditingController();

  void toggleBuyPre(bool value) {
    if (switchControlBuyPre == false) {
      setState(() {
        switchControlBuyPre = true;
      });
    } else {
      setState(() {
        switchControlBuyPre = false;
      });
    }
  }

  int contind;
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;
  _startUpload() {

    var nows = DateTime.now();
    String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
    setState(() {
      iiimmgg = filePath;
      _uploadTask = _storage.ref().child(filePath).putFile(imageFile);
    });
    _imagUpload();
  }

  var iiimmgg;
  _imagUpload(){
_con.updateProductIconImage(context,b,iiimmgg,a,widget.pageid,widget.productid,widget.typ,widget.timid,widget.member);
    // _uploadTask=null;
    return Container();
  }

  _imagUploadgallery(){

    _con.addGalleryProductImage(context,widget.productid,IMAGELIST.join(",").toString(),a,widget.pageid,widget.productid,widget.typ,widget.timid,widget.member);
    // _uploadTask=null;
    return Container();
  }

  List<File> imageList;
  List IMAGELIST = [];
  bool hot_deal;
  List ImageLLists=[];

  List<Asset> images = List<Asset>();

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarTitleColor: "#48c0d8",
          actionBarColor: "#1E2026",
          actionBarTitle: "Choose Photos ",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {}
    if (!mounted) return;
    setState(() {
      images = resultList;
      getFileList();
    });
  }

  void getFileList() async {
    imageList.clear();
    for (int i = 0; i < images.length; i++) {
      var path2 =
      await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      //var path = await images[i].filePath;
      var file = await getImageFileFromAsset(path2);
      imageList.add(file);
    }
  }

  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  _startUploadgallery() {
    for (var i = 0; i < imageList.length; i++) {
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELIST.add(filePath);
        _uploadTask = _storage.ref().child(filePath).putFile(imageList[i]);
      });
    }
    //IMAGELIST.join(",").toString()
    _imagUploadgallery();
  }

@override
  void initState() {
  _con.BusinessEveryItemDetailPage(widget.productid);
  getHomeKitpageTime();
  print("PRROODD IIDDD "+widget.productid);
  myFocusNode = FocusNode();
  myFocusNode2 = FocusNode();
  myFocusNode3 = FocusNode();
  setState(() {
    contind = 1;
    a= widget.pic;
    imageList = [];
    ImageLLists = [];
    hot_deal = false;
    quantity_value ="1";
    tabbb=widget.tabb;
    _price.text="0";
    autofo=false;
    autofo2=false;
    qntyy=false;
    autofo3=false;
    readonlyy=true;
    readonlyy2=true;
    readonlyy3=true;
    priceText = 'Update Price';
  });
  // TODO: implement initState
    super.initState();
  }

  var b;
  getHomeKitpageTime() async {
    return Timer(Duration(milliseconds: 2500), _Navigator);}
  _Navigator(){
    setState(() {
      ImageLLists= _con.ProductDetail["kitchen_item_image"];
      a = _con.ProductDetail["kitchen_item_image"][0]["source"];
      b = _con.ProductDetail["kitchen_item_image"][0]["id"].toString();
      ImageLLists.removeAt(0);
      hot_deal = _con.ProductDetail["kitchen_hotdeal_status"].toString()=="1"? true : false;
      switchControlBuyPre = _con.ProductDetail["products_type"].toString()=="1"? true : false;
      quantity_value = _con.ProductDetail["products_quantity"].toString();
      _price.text=_con.ProductDetail["kitchen_item_amount"].toString();
      _discount.text=_con.ProductDetail["item_discount_price"].toString();
      _package.text=_con.ProductDetail["item_packaging_charge"].toString();
      _desc.text= _con.ProductDetail["products_description"]!=null ?
      _con.ProductDetail["products_description"].toString() : "";
      _utube.text= _con.ProductDetail["product_video_url"]!= null ?
      _con.ProductDetail["product_video_url"].toString() : "";
      _displayName.text=_con.ProductDetail["kitchen_item_name"].toString();
      _subtitle.text=_con.ProductDetail["item_sub_titile"].toString();


    });
    /*setState(() {

    });*/
  }
var a;
  var quantity_value;

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
  TextEditingController _price = TextEditingController();
  TextEditingController _discount = TextEditingController();
  TextEditingController _package = TextEditingController();
  TextEditingController _utube = TextEditingController();
  TextEditingController _desc = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        _con.HomeKitchenProductList("1", widget.pageid, widget.timid);
        return new Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Color(0xFF1E2026),
        appBar: AppBar(titleSpacing: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
             widget.typ =="1" ? Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) =>  bottomNavBarHomeKitchen(
                  memberdate: widget.member,pagid: widget.pageid,timid: widget.timid,currentIndex: 3,upld: false,))) :
             widget.typ=="2" ? Navigator.pushReplacement(context, MaterialPageRoute(
                 builder: (context) =>  bottomNavBarLocalShop(
                   memberdate: widget.member,pagid: widget.pageid,timid: widget.timid,currentIndex: 3,upld: false,))) :
             widget.typ=="3" ? Navigator.pushReplacement(context, MaterialPageRoute(
                 builder: (context) =>  bottomNavBarRestaurant(
                   memberdate: widget.member,pagid: widget.pageid,timid: widget.timid,currentIndex: 3,upld: false,))) : Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          brightness: Brightness.dark,
          elevation: 5,
          title: Image.asset(
            "assets/Template1/image/Foodie/logo.png",
            height: 23,
          ),
        ),
        body: _con.ProductDetail!=null && _con.statusProductDetail==false ? SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    _con.ProductDetail["kitchen_item_name"],
                    style: f15wB
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8,top: 5,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(clipBehavior: Clip.antiAlias,
                          height: 50,
                          width: 60,
                          child:
                          CachedNetworkImage(
                            imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                a+"?alt=media",
                            fit:
                            BoxFit.cover,
                            placeholder: (context, ind) =>
                                Container(
                                  height: 50,
                                  width: 60,
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
                        SizedBox(width: 10,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Status  :  ",
                                  style: f14w,
                                ),
                                Text(
                                  _con.ProductDetail["products_status"].toString()=="1"? "Active" :"Inactive",
                                  style: TextStyle(
                                      color: Colors.greenAccent[700], fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Price    :  " + "\u20B9" + _con.ProductDetail["kitchen_item_amount"].toString(),
                              style: f14w,
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "Share", style: f14w,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8),
                child: Divider(color: Colors.black87,thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8,),
                child: Row(
                  children: <Widget>[
                    Container(height: 30,
                      width: 80,

                      child: MaterialButton(
                        height: 30,padding: EdgeInsets.all(0),
                          splashColor: Color(0xFFffd55e),
                          onPressed: (){
                            setState(() {
                              tabbb=1;
                            });
                          },
                          child: Text("Pricing",style: tabbb==1 ? f15bB :f15wB )),
                    ),

                    Container(height: 30,
                      width: 80,

                      child: MaterialButton(
                          height: 30,
                          splashColor: Color(0xFFffd55e),
                          onPressed: (){
                            setState(() {
                              tabbb=2;
                            });
                          },padding: EdgeInsets.all(0),
                          child: Text("Catalogue",style: tabbb==2 ? f15bB :f15wB)),
                    ),

                    Container(height: 30,
                      width: 80,

                      child: MaterialButton(
                          height: 30,padding: EdgeInsets.all(0),
                          splashColor: Color(0xFFffd55e),
                          onPressed: (){
                            setState(() {
                              tabbb=3;
                            });
                          },
                          child: Text("Photos",style: tabbb==3 ? f15bB :f15wB)),
                    ),

                    Container(height: 30,
                      width: 80,
                      child: MaterialButton(
                          height: 30,padding: EdgeInsets.all(0),
                          splashColor: Color(0xFFffd55e),
                          onPressed: (){
                            setState(() {
                              tabbb=4;
                            });
                          },
                          child: Text("Sale",style: tabbb==4 ? f15bB :f15wB)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8),
                child: Divider(color: Colors.black87,thickness: 1),
              ),
           tabbb==1 ?  Column(crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                   color: Colors.white38,
                   child: Padding(
                     padding: const EdgeInsets.only(top:10,bottom: 10),
                     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               Column(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Row(
                                     children: [
                                       Text("Product Price ",style: f14w),
                                       Text("(Including GST)",style: f11w),
                                     ],
                                   ),
                                   SizedBox(height: 3,),
                                   Container(height: 30,
                                     width: 103,alignment: Alignment.centerLeft,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5.0),
                                       border: Border.all(color: Colors.white),
                                       color: Colors.black,
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.only(left:8.0,right: 8),
                                       child: Row(
                                         children: [
                                           Text("\u20B9 ",style: f14w,),
                                           Container(
                                             height: 25,
                                             width: 74,
                                             child: TextField(
                                               keyboardType: TextInputType.number,
                                               focusNode: myFocusNode,
                                               style: f14w,
                                               // autofocus: autofo,
                                               readOnly: readonlyy,
                                               controller: _price,
                                               decoration: InputDecoration(
                                                   border: InputBorder.none
                                               ),

                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   )
                                   // Text("\u20B9"+widget.price.toString(),style: f14w)
                                 ],
                               ),
                               readonlyy ?  InkWell(
                                   splashColor: Colors.white,
                                   onTap: (){
                                       setState(() {
                                         readonlyy=false;
                                         autofo=true;
                                         myFocusNode.requestFocus();
                                       });
                                   },
                                   child: Text("Update Price",style: f14y)) :  Container(height: 30,
                                 width: 80,
                                 child: MaterialButton(
                                     height: 30,padding: EdgeInsets.all(0),
                                     splashColor: Color(0xFFffd55e),
                                     color: Color(0xFF48c0d8),
                                     onPressed: (){
                                       _con.updateProductValues(context,widget.productid,"kitchen_item_amount",_price.text,a.toString(),widget.pageid,widget.typ,widget.timid,widget.member);
                                       setState(() {
                                         readonlyy=true;
                                       });
                                     },
                                     child: Text("Update",style: f15wB)),)
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Divider(color: Colors.black87,thickness: 1,),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               Column(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Row(
                                     children: [
                                       Text("Discounted Price ",style: f14w),
                                       Text("(Including GST)",style: f11w),
                                     ],
                                   ),
                                   SizedBox(height: 3,),
                                   Container(height: 30,
                                     width: 103,alignment: Alignment.centerLeft,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5.0),
                                       border: Border.all(color: Colors.white),
                                       color: Colors.black,
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.only(left:8.0,right: 8),
                                       child: Row(
                                         children: [
                                           Text("\u20B9 ",style: f14w,),
                                           Container(
                                             height: 25,
                                             width: 74,
                                             child: TextField(
                                               keyboardType: TextInputType.number,
                                               focusNode: myFocusNode2,
                                               style: f14w,
                                               // autofocus: autofo,
                                               readOnly: readonlyy2,
                                               controller: _discount,
                                               decoration: InputDecoration(
                                                   border: InputBorder.none
                                               ),

                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   )
                                   // Text("\u20B9"+widget.price.toString(),style: f14w)
                                 ],
                               ),
                               readonlyy2 ?  InkWell(
                                   splashColor: Colors.white,
                                   onTap: (){
                                       setState(() {
                                         readonlyy2=false;
                                         autofo2=true;
                                         myFocusNode2.requestFocus();
                                       });
                                   },
                                   child: Text("Update Price",style: f14y)) :  Container(height: 30,
                                 width: 80,
                                 child: MaterialButton(
                                     height: 30,padding: EdgeInsets.all(0),
                                     splashColor: Color(0xFFffd55e),
                                     color: Color(0xFF48c0d8),
                                     onPressed: (){
                                       _con.updateProductValues(context,widget.productid,"item_discount_price",_discount.text,a.toString(),widget.pageid,widget.typ,widget.timid,widget.member);
                                       // _con.AmountUpdateContro(widget.productid,(int.parse(_price.text)+3).toString(),widget.typ,widget.pageid,widget.timid);
                                       setState(() {
                                         readonlyy2=true;
                                       });
                                     },
                                     child: Text("Update",style: f15wB)),)
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Divider(color: Colors.black87,thickness: 1,),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               Column(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text("Discounted Percentage ",style: f14w),
                                   SizedBox(height: 3,),
                                   Container(height: 30,
                                     width: 103,alignment: Alignment.centerLeft,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5.0),
                                       border: Border.all(color: Colors.white),
                                       color: Colors.black,
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.only(left:8.0,right: 8),
                                       child: Text((((_con.ProductDetail["item_discount_price"]/_con.ProductDetail["kitchen_item_amount"])*100).round()).toString()+"%",style: f14w,),
                                     ),
                                   )
                                   // Text("\u20B9"+widget.price.toString(),style: f14w)
                                 ],
                               ),
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Divider(color: Colors.black87,thickness: 1,),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               Column(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Row(
                                     children: [
                                       Text("Packaging",style: f14w),
                                       Text("(Including All Taxes)",style: f11w),
                                     ],
                                   ),
                                   SizedBox(height: 3,),
                                   Container(height: 30,
                                     width: 103,alignment: Alignment.centerLeft,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5.0),
                                       border: Border.all(color: Colors.white),
                                       color: Colors.black,
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.only(left:8.0,right: 8),
                                       child: Row(
                                         children: [
                                           Text("\u20B9 ",style: f14w,),
                                           Container(
                                             height: 25,
                                             width: 74,
                                             child: TextField(
                                               keyboardType: TextInputType.number,
                                               focusNode: myFocusNode3,
                                               style: f14w,
                                               // autofocus: autofo,
                                               readOnly: true,
                                               controller: _package,
                                               decoration: InputDecoration(
                                                   border: InputBorder.none
                                               ),

                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   )
                                   // Text("\u20B9"+widget.price.toString(),style: f14w)
                                 ],
                               ),
                               readonlyy3 ?  InkWell(
                                   splashColor: Colors.white,
                                   onTap: (){
                                     setState(() {
                                       readonlyy3=false;
                                     });
                                     showDialog(
                                         context: context,
                                         builder: (BuildContext context) {
                                           return AlertDialog(backgroundColor: Color(0xFF1E2026),
                                               shape: RoundedRectangleBorder(
                                                   side: BorderSide(
                                                       color: Colors.white,
                                                       width: 1
                                                   ),
                                                   borderRadius: BorderRadius.all(
                                                       Radius.circular(4.0))),
                                               contentPadding: EdgeInsets.all(
                                                   0),
                                               content: StatefulBuilder(
                                                 builder: (BuildContext context,sss.StateSetter state){
                                                   return SingleChildScrollView(
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(6.0),
                                                       child: Column(
                                                         children: [
                                                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Container(alignment : Alignment.center,
                                                                   width: MediaQuery.of(context).size.width-161,
                                                                   child: Text("Packaging Charge Guide",style: f15GB,)),
                                                               IconButton(
                                                                   onPressed: (){
                                                                     Navigator.pop(context);
                                                                   },
                                                                   icon: Icon(Icons.close,color: Colors.white,size: 20,))
                                                             ],
                                                           ),
                                                           SizedBox(height: 5,),
                                                           Padding(
                                                             padding: const EdgeInsets.only(left: 20,right: 20),
                                                             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                               children: [
                                                                 Container(
                                                                   width: MediaQuery.of(context).size.width/3.8,
                                                                   child: Text("Item Price",style: f12w,),
                                                                 ),
                                                                 Container(
                                                                   child: Text("Maximum Packaging Charge",style: f13w,),
                                                                 ),
                                                               ],
                                                             ),
                                                           ),
                                                           Divider(color: Colors.white,thickness: .5,),
                                                           InkWell(
                                                             onTap: (){
                                                               setState(() {
                                                                 _package.text = "5";
                                                               });
                                                               Navigator.pop(context);
                                                             },
                                                             child: Padding(
                                                               padding: const EdgeInsets.only(left: 20,right: 20),
                                                               child: Row(
                                                                 children: [
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3.2,
                                                                     child: Text("<50",style: f14w,),
                                                                   ),
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3.2,
                                                                     child: Text("5",style: f14w,),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),
                                                           ),
                                                           Divider(color: Colors.white,thickness: .5,),
                                                           InkWell(
                                                             onTap: (){
                                                               setState(() {
                                                                 _package.text = "7";
                                                               });
                                                               Navigator.pop(context);
                                                             },
                                                             child: Padding(
                                                               padding: const EdgeInsets.only(left: 20,right: 20),
                                                               child: Row(
                                                                 children: [
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3.2,
                                                                     child: Text("50 - 150",style: f14w,),
                                                                   ),
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3,
                                                                     child: Text("7",style: f14w,),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),
                                                           ),
                                                           Divider(color: Colors.white,thickness: .5,),
                                                           InkWell(
                                                             onTap: (){
                                                               setState(() {
                                                                 _package.text = "10";
                                                               });
                                                               Navigator.pop(context);
                                                             },
                                                             child: Padding(
                                                               padding: const EdgeInsets.only(left: 20,right: 20),
                                                               child: Row(
                                                                 children: [
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3.2,
                                                                     child: Text("151 - 300",style: f14w,),
                                                                   ),
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3,
                                                                     child: Text("10",style: f14w,),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),
                                                           ),
                                                           Divider(color: Colors.white,thickness: .5,),
                                                           InkWell(
                                                             onTap: (){
                                                               setState(() {
                                                                 _package.text = "15";
                                                               });
                                                               Navigator.pop(context);
                                                             },
                                                             child: Padding(
                                                               padding: const EdgeInsets.only(left: 20,right: 20),
                                                               child: Row(
                                                                 children: [
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3.2,
                                                                     child: Text("301 - 500",style: f14w,),
                                                                   ),
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3,
                                                                     child: Text("15",style: f14w,),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),
                                                           ),
                                                           Divider(color: Colors.white,thickness: .5,),
                                                           InkWell(
                                                             onTap: (){
                                                               setState(() {
                                                                 _package.text = "20";
                                                               });
                                                               Navigator.pop(context);
                                                             },
                                                             child: Padding(
                                                               padding: const EdgeInsets.only(left: 20,right: 20),
                                                               child: Row(
                                                                 children: [
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3.2,
                                                                     child: Text("500+",style: f14w,),
                                                                   ),
                                                                   Container(
                                                                     width: MediaQuery.of(context).size.width/3,
                                                                     child: Text("20",style: f14w,),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),
                                                           ),
                                                           SizedBox(height: 10,),
                                                         ],
                                                       ),
                                                     ),
                                                   );
                                                 },
                                               ));
                                         });
                                   },
                                   child: Text("Update",style: f14y)) :  Container(height: 30,
                                 width: 80,
                                 child: MaterialButton(
                                     height: 30,padding: EdgeInsets.all(0),
                                     splashColor: Color(0xFFffd55e),
                                     color: Color(0xFF48c0d8),
                                     onPressed: (){
                                       _con.updateProductValues(context,widget.productid,"item_packaging_charge",_package.text,a.toString(),widget.pageid,widget.typ,widget.timid,widget.member);
                                       // _con.AmountUpdateContro(widget.productid,(int.parse(_price.text)+3).toString(),widget.typ,widget.pageid,widget.timid);
                                       setState(() {
                                         readonlyy3=true;
                                       });
                                     },
                                     child: Text("Update",style: f15wB)),)
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Divider(color: Colors.black87,thickness: 1,),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 8.0,left: 8),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               Column(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text("GST\u002A",style: f14w),
                                   SizedBox(height: 3,),
                                   Container(height: 30,
                                     width: 103,alignment: Alignment.centerLeft,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5.0),
                                       border: Border.all(color: Colors.white),
                                       color: Colors.black,
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.only(left:8.0,right: 8),
                                       child: Text("5%",style: f14w,),
                                     ),
                                   )
                                   // Text("\u20B9"+widget.price.toString(),style: f14w)
                                 ],
                               ),
                             ],
                           ),
                         ),


                       ],
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(14.0),
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                         color: Colors.white10,
                         border: Border.all(color: Colors.grey[200],width: 1),
                         borderRadius: BorderRadius.circular(6)
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(15.0),
                       child: Column(
                         children: [
                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Final Pricing",style: f18WB,),
                               Text("\u20B9"+_con.ProductDetail["kitchen_display_amount"].toString(),style: f18yB,),
                             ],
                           ),
                           Row(mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Text("Price + Packaging + GST",style: f12wB,),
                             ],
                           ),
                           SizedBox(height: 10,),
                           Text("Please ensure the item matches the price in your menu to\navoid rejection of changes",style: f11w,textAlign: TextAlign.center,)
                         ],
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(right: 14.0,left: 14),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           Text("Minimum Quantity\nof Item",textAlign: TextAlign.center,style: f14wB,),
                           SizedBox(width: 10,),
                         qntyy? Container(height: 30,width: 90,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                               border: Border.all(color: Colors.grey[800],width: 1)
                           ),
                           alignment: Alignment.centerLeft,
                           child:  Padding(
                             padding: const EdgeInsets.only(left:8.0),
                             child: DropdownButton(
                               value: quantity_value,
                               hint: Text("Select",style: f14g,),
                               dropdownColor: Color(0xFF1E2026),
                               iconEnabledColor: Colors.grey,
                               iconSize: 25,
                               elevation: 16,isExpanded: true,
                               style: f14w,
                               underline: Container(height: 0,),
                               onChanged: (newValue) {
                                 setState(() {
                                   quantity_value = newValue;
                                 });
                               },
                               items: Quantity.map((item) {
                                 return DropdownMenuItem(
                                   value: item,
                                   child: Text(item),
                                 );
                               }).toList(),
                             ),
                           ),
                         ) : Container(height: 30,width: 80,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                                 border: Border.all(color: Colors.grey[800],width: 1)
                             ),
                             alignment: Alignment.centerLeft,
                             child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.only(left:8.0),
                                   child: Text(quantity_value,style: f14w),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                       qntyy ? Container(height: 30,
                         child: MaterialButton(
                             height: 30,padding: EdgeInsets.all(0),
                             splashColor: Color(0xFFffd55e),
                             color: Color(0xFF48c0d8),
                             onPressed: (){
                               _con.updateProductValues(context,widget.productid,"products_quantity",quantity_value.toString(),a.toString(),widget.pageid,widget.typ,widget.timid,widget.member);
                               // _con.AmountUpdateContro(widget.productid,(int.parse(_price.text)+3).toString(),widget.typ,widget.pageid,widget.timid);
                               setState(() {
                                 qntyy=false;
                               });
                             },
                             child: Padding(
                               padding: const EdgeInsets.only(left: 8, right: 8),
                               child: Text("Update",style: f15wB),
                             )),) :  InkWell(
                           splashColor: Colors.white,
                           onTap: (){
                             setState(() {
                               qntyy=true;
                             });
                           },
                           child: Text("Update Quantity",style: f14y))

                     ],
                   ),
                 ),
                 /* Padding(
                   padding: const EdgeInsets.only(right: 8.0,left: 8),
                   child: Divider(color: Colors.black87,thickness: 1,),
                 ),
                Padding(
                   padding: const EdgeInsets.only(left:8.0,right: 8,top: 8),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text("Paid to You",style:f14w),
                       Container(height: 25,width: 80,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             border: Border.all(color: Colors.white)
                         ),
                         child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.only(left: 3.0),
                               child: Text("\u20B9 "+(widget.price-3).toString(),style:f14w),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0,left: 8),
                   child: Divider(color: Colors.black87,thickness: 1),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:8.0,right: 8),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text("Service Charge",style: f14w),
                       Container(height: 25,width: 80,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             border: Border.all(color: Colors.white)
                         ),
                         child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.only(left: 3.0),
                               child: Text("\u20B9 3",style: f14w),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0,left: 8),
                   child: Divider(color: Colors.black87,thickness: 1),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:8.0,right: 8,),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text("Product Cost",style: f14w),
                       Container(height: 25,width: 80,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             border: Border.all(color: Colors.white)
                         ),
                         child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.only(left: 3.0),
                               child: Text("\u20B9 "+widget.price.toString(),style: f14w),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0,left: 8),
                   child: Divider(color: Colors.black87,thickness: 1),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0,left: 8),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text("Delivery Charge",style: f14w),
                       Column(
                         children: <Widget>[
                           Row(
                             children: <Widget>[
                               Text("Limit",style: f14w),
                               SizedBox(width: 5,),
                               Container(height: 25,width: 80,
                                 decoration: BoxDecoration(color: Colors.white,
                                     borderRadius: BorderRadius.circular(5),
                                     border: Border.all(color: Colors.white)
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.only(left:2.0),
                                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: <Widget>[
                                       Text("5km",style: f14w),
                                       Icon(Icons.arrow_drop_down,color: Colors.black,)
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                           SizedBox(height: 10,),
                           Row(
                             children: <Widget>[
                               Text("Limit",style: TextStyle(color: Colors.white, fontSize: 13)),
                               SizedBox(width: 5,),
                               Container(height: 25,width: 80,
                                 decoration: BoxDecoration(color: Colors.white,
                                     borderRadius: BorderRadius.circular(5),
                                     border: Border.all(color: Colors.white)
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.only(left:2.0),
                                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: <Widget>[
                                       Text("5-10",style: f14w),
                                       Icon(Icons.arrow_drop_down,color: Colors.black,)
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                       Column(
                         children: <Widget>[
                           Container(height: 25,width: 80,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                                 border: Border.all(color: Colors.white)
                             ),
                             child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.only(left: 3.0),
                                   child: Text("\u20B9 0",style: f14w),
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(height: 10,),
                           Container(height: 25,width: 80,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                                 border: Border.all(color: Colors.white)
                             ),
                             child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.only(left: 3.0),
                                   child: Text("\u20B9 40",style: f14w),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),

                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0,left: 8),
                   child: Divider(color: Colors.grey,thickness: .3,),
                 ),*/
               ],
             ) : tabbb==2 ?
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       height: 120,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey[800],width: 1),
                           borderRadius: BorderRadius.circular(8)),
                       child: Padding(
                         padding: const EdgeInsets.only(left:8.0,right: 8,),
                         child: TextField(
                           controller: _desc,
                           expands: true,
                           maxLines: null,
                           minLines: null,
                           autocorrect: true,
                           keyboardType: TextInputType.text,
                           style: TextStyle(color: Colors.white, fontSize: 14),
                           decoration: InputDecoration(
                             border: InputBorder.none,
                             hintText: "Product Description",
                             hintStyle: f14g,
                           ),
                         ),
                       ),
                     ),
                     SizedBox(height: 15,),
                     Container(
                       height: 55,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(

                           border: Border.all(color: Colors.grey[800],width: 1),
                           borderRadius: BorderRadius.circular(8)),
                       alignment: Alignment.center,
                       child: Padding(
                         padding: const EdgeInsets.only(left:8, right: 8),
                         child: Row(
                           crossAxisAlignment:
                           CrossAxisAlignment.center,
                           children: [
                             Image.asset(
                               "assets/Template1/image/Foodie/icons/youtube.png",
                               height: 28,
                               width: 28,
                             ),
                             SizedBox(
                               width: 8,
                             ),
                             Container(
                               width:
                               MediaQuery.of(context).size.width -
                                   78,
                               child: TextField(
                                 keyboardType: TextInputType.text,
                                 maxLines: 4,
                                 controller: _utube,
                                 // controller: _loc,
                                 style: TextStyle(color: Colors.white),
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.symmetric(vertical: 16),
                                     border: InputBorder.none,
                                     hintText:
                                     "Copy Youtube video Link...",
                                     hintStyle: f14g),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     SizedBox(height: 20,),
                     Text("Item Name",style: f14w,),
                     SizedBox(height: 5,),
                     Container(
                       height: 45,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(6),
                           border: Border.all(color: Colors.grey[200],width: 1),
                           color: Colors.grey[700]
                       ),alignment: Alignment.centerLeft,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(_con.ProductDetail["products_category"][0]["category_name"],style: f14wB,),
                       ),
                     ),
                     SizedBox(height: 20,),
                     Text("Display Name",style: f14w,),
                     SizedBox(height: 5,),
                     Container(
                         height: 45,
                         width: MediaQuery.of(context).size.width,
                         /* decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)
                ),*/
                         alignment: Alignment.centerLeft,
                         child: TextField(
                           controller: _displayName,
                           style: f14w,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.only(top: 6,left: 8),
                             hintText: "Write a name to display...",
                             hintStyle: f14g,
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(6)),
                               borderSide: BorderSide(width: 1,color: Color(0xFF48c0d8)),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(6)),
                               borderSide: BorderSide(color: Colors.grey[800],width: 1),
                             ),
                           ),
                         )
                     ),
                     SizedBox(height: 15,),
                     Text("Sub Title Description",style: f14w,),
                     SizedBox(height: 5,),
                     Container(
                         height: 100,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(6)),
                           border: Border.all(color: Colors.grey[800],width: 1),
                         ),
                         width: MediaQuery.of(context).size.width,
                         /* decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)
                ),*/
                         alignment: Alignment.topCenter,
                         child: TextField(
                           minLines: null,
                           maxLines: null,
                           expands: true,
                           controller: _subtitle,
                           style: f14w,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.only(top: 6,left: 8),
                           ),
                         )
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 18,right: 5),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               Text(
                                 "Veg",
                                 style: f14w,
                               ),
                               Transform.scale(
                                   scale: .9,
                                   child: Switch(
                                     onChanged: toggleBuyPre,
                                     value: switchControlBuyPre,
                                     activeColor: Color(0xFF48c0d8),
                                     activeTrackColor: Colors.grey,
                                     inactiveThumbColor: Color(0xFFffd55e),
                                     inactiveTrackColor: Colors.grey,
                                   )),
                               Text(
                                 "Non-Veg",
                                 style: f14w,
                               ),
                             ],
                           ),
                           Row(
                             children: [
                               Text("Hot Deal",style: f15w,),
                               SizedBox(width: 10,),
                               Theme(
                                 data: Theme.of(context).copyWith(
                                   unselectedWidgetColor: Colors.white70,
                                 ),
                                 child: Checkbox(value: hot_deal,
                                     checkColor: Colors.black,
                                     activeColor: Color(0xFF48c0d8),
                                     onChanged:(bool newValue){
                                       setState(() {
                                         hot_deal = newValue;
                                       });
                                     }),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 25,),
                     Center(
                       child: InkWell(
                         splashColor: Color(0xFF48c0d8),
                         onTap: (){
                            _con.AddCatelogue(context,widget.productid,_desc.text,_utube.text,_displayName.text,_subtitle.text,switchControlBuyPre ? "1" : "0",hot_deal ? "1" : "0",a,widget.pageid,widget.productid,widget.typ,widget.timid,widget.member,2);
                         },
                         child: Container(
                           height: 45,
                           width: 180,
                           decoration: BoxDecoration(
                             border: Border.all(color: Colors.white),
                             borderRadius: BorderRadius.circular(6)
                           ),
                           child: Center(child: Text("Submit",style: f16wB,)),
                         ),
                       ),
                     )
                   ],
                 ),
               ) : tabbb==3 ?
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Column(
               children: [
                 imageFile!=null ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     MaterialButton(
                       height: 33,
                       color: Color(0xFFffd55e),
                       splashColor: Color(0xFF48c0d8),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)
                       ),
                       onPressed: (){
                         _startUpload();
                       },
                       child: Padding(
                         padding: const EdgeInsets.only(left: 12,right: 12),
                         child: Text("Update Icon",style: f15B,),
                       ),
                     ),
                     Stack(
                       children: [
                         Container(
                           height: 85,
                           width: 100,clipBehavior: Clip.antiAlias,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: Image.file(imageFile,fit: BoxFit.cover,)
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(
                                   left: 70.0, top: 5),
                               child: GestureDetector(
                                 onTap: () {
                                   setState(() {
                                     imageFile = null;
                                   });
                                 },
                                 child: Container(
                                     height: 25,
                                     width: 25,
                                     decoration: BoxDecoration(
                                         color: Color(0xFFffd55e),
                                         borderRadius:
                                         BorderRadius.circular(100)),
                                     child: Center(
                                         child: Icon(
                                           Icons.clear,
                                           size: 18,
                                         ))),
                               ),
                             ),
                           ],
                         )
                       ],
                     )
                   ],
                 ) :
                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     MaterialButton(
                       height: 33,
                       color: Color(0xFF48c0d8),
                       splashColor: Color(0xFFffd55e),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10)
                       ),
                       onPressed: (){_pickImage();},
                       child: Padding(
                         padding: const EdgeInsets.only(left: 12,right: 12),
                         child: Text("Add Icon Photo",style: f15B,),
                       ),
                     ),
                     Container(
                       height: 85,
                       width: 100,clipBehavior: Clip.antiAlias,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10)
                       ),
                       child: CachedNetworkImage(
                         imageUrl: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                             a+"?alt=media",
                         fit: BoxFit.cover,
                       ),
                     )
                   ],
                 ),
                 SizedBox(height: 10,),
                 Divider(color: Colors.grey[700],thickness: 1,),
                imageList.length==0 ? SizedBox(height: 10,) : Container(),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       imageList.length>0 ? Container() : MaterialButton(
                         height: 33,
                         color: Color(0xFF48c0d8),
                         splashColor: Color(0xFFffd55e),
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)
                         ),
                         onPressed: (){
                           loadAssets();
                         },
                         child: Padding(
                           padding: const EdgeInsets.only(left: 12,right: 12),
                           child: Text("Upload Gallery Photo",style: f15B,),
                         ),
                       ),
                       SizedBox(height: 10,),
                       Container(
                         height:ImageLLists.length==0 ? 0 : ImageLLists.length<=3 && ImageLLists.length>0 ? 100 : ImageLLists.length>=3 && ImageLLists.length<=6 ? 200 : 300,
                         child: GridView.builder(
                             gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount:3, childAspectRatio: 1.3,mainAxisSpacing: 8),
                             physics: NeverScrollableScrollPhysics(),
                             itemCount: ImageLLists.length,
                             itemBuilder: (context, ind) {
                               return  Stack(
                                 children: [
                                   Padding(
                                     padding:
                                     const EdgeInsets.only(left: 6, right: 6),
                                     child: Container(
                                       height: 90,
                                       width: 110,
                                       clipBehavior: Clip.antiAlias,
                                       child: CachedNetworkImage(
                                      imageUrl:   "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                          ImageLLists[ind]["source"]+"?alt=media",
                                         fit: BoxFit.cover,
                                         placeholder: (
                                             context,
                                             ind) =>
                                             Container(
                                               height: 90,
                                               width: 110,
                                               clipBehavior: Clip.antiAlias,
                                               decoration: BoxDecoration(
                                                 borderRadius:
                                                 BorderRadius.all(Radius.circular(5.0)),
                                               ),
                                               child: Image
                                                   .asset(
                                                 "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                 fit: BoxFit
                                                     .cover,),
                                             ),
                                       ),
                                       decoration: BoxDecoration(
                                         borderRadius:
                                         BorderRadius.all(Radius.circular(5.0)),
                                       ),
                                     ),
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.only(
                                             right: 13.0, top: 5),
                                         child: GestureDetector(
                                           onTap: () {
                                             _con.deleteProductImage(ImageLLists[ind]["id"].toString());
                                             setState(() {
                                               ImageLLists.removeAt(ind);
                                             });
                                           },
                                           child: Container(
                                               height: 25,
                                               width: 25,
                                               decoration: BoxDecoration(
                                                   color: Color(0xFFffd55e),
                                                   borderRadius:
                                                   BorderRadius.circular(100)),
                                               child: Center(
                                                   child: Icon(
                                                     Icons.clear,
                                                     size: 18,
                                                   ))),
                                         ),
                                       ),
                                     ],
                                   )
                                 ],
                               );
                             }),
                       ),

                       SizedBox(height: 15,),
                       imageList.length>0 ? Text("Gallery Photos :",style: f16bB,) : Container(),
                       SizedBox(height: 15,),
                       Container(
                         height: imageList.length<=3 ? 100 : imageList.length>=3 && imageList.length<=6 ? 200 : 300,
                         child: GridView.builder(
                             gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount:3, childAspectRatio: 1.3,mainAxisSpacing: 8),
                             physics: NeverScrollableScrollPhysics(),
                             itemCount: imageList.length,
                             itemBuilder: (context, ind) {
                               return  Stack(
                                 children: [
                                   Padding(
                                     padding:
                                     const EdgeInsets.only(left: 6, right: 6),
                                     child: Container(
                                       height: 90,
                                       width: 110,
                                       clipBehavior: Clip.antiAlias,
                                       child:Image.file(imageList[ind],fit: BoxFit.cover,),
                                       decoration: BoxDecoration(
                                         borderRadius:
                                         BorderRadius.all(Radius.circular(5.0)),
                                       ),
                                     ),
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.only(
                                             right: 13.0, top: 5),
                                         child: GestureDetector(
                                           onTap: () {
                                             setState(() {
                                               imageList.removeAt(ind);
                                               images.removeAt(ind);
                                             });
                                           },
                                           child: Container(
                                               height: 25,
                                               width: 25,
                                               decoration: BoxDecoration(
                                                   color: Color(0xFFffd55e),
                                                   borderRadius:
                                                   BorderRadius.circular(100)),
                                               child: Center(
                                                   child: Icon(
                                                     Icons.clear,
                                                     size: 18,
                                                   ))),
                                         ),
                                       ),
                                     ],
                                   )
                                 ],
                               );
                             }),
                       ),
                       SizedBox(height: 15,),
                       imageList.length>0 ? MaterialButton(
                         height: 33,
                         color: Color(0xFFffd55e),
                         splashColor: Color(0xFF48c0d8),
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)
                         ),
                         onPressed: (){
                           _startUploadgallery();
                         },
                         child: Padding(
                           padding: const EdgeInsets.only(left: 12,right: 12),
                           child: Text("Update Photos",style: f15B,),
                         ),
                       ) : Container()
                     ],

                 ),
               ],
             ),
           ) :
           Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(width: width - 54,
                   decoration: BoxDecoration(
                       color: Colors.grey,
                       borderRadius: BorderRadius.circular(8)
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(3.0),
                     child: Row(
                       children: [
                         GestureDetector(
                           onTap: (){
                             setState(() {
                               contind=1;
                             });
                           },
                           child: Container(
                             decoration: BoxDecoration(
                                 color: contind==1 ? Colors.black :Colors.transparent,
                                 borderRadius: BorderRadius.circular(8)
                             ),
                             child: Padding(
                               padding: const EdgeInsets.only(left:10,right: 10,bottom: 5,top: 5),
                               child: Center(child: Text("Current Week",style: f15wB,),
                               ),
                             ),
                           ),
                         ),
                         GestureDetector(
                           onTap: (){
                             setState(() {
                               contind=2;
                             });
                           },
                           child: Container(
                             decoration: BoxDecoration(
                                 color:  contind == 2 ? Colors.black : Colors.transparent,
                                 borderRadius: BorderRadius.circular(8)
                             ),
                             child: Padding(
                               padding: const EdgeInsets.only(left:10,right: 10,bottom: 5,top: 5),
                               child: Center(child: Text("Current Month",style: f15wB,),
                               ),
                             ),
                           ),
                         ),
                         GestureDetector(
                           onTap: (){
                             setState(() {
                               contind=3;
                             });
                           },
                           child: Container(
                             decoration: BoxDecoration(
                                 color:  contind == 3 ? Colors.black : Colors.transparent,
                                 borderRadius: BorderRadius.circular(8)
                             ),
                             child: Padding(
                               padding: const EdgeInsets.only(left:10,right: 10,bottom: 5,top: 5),
                               child: Center(child: Text("Current Year",style: f15wB,),
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Column(
                   children: [
                     Container(
                         decoration: BoxDecoration(
                             color: Colors.grey[800],
                             borderRadius: BorderRadius.circular(8),
                             border: Border.all(color: Colors.white,)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Column(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   contind== 1 ? Text("Current Week Item Sale",style: f14w,) : contind == 2 ? Text("Current Month Item Sale",style: f14w) : contind ==3 ? Text("Current Year Item Sale",style: f14w) : Container(),
                                   SizedBox(height: 3,),
                                   Text("25",style: f18yB,)
                                 ],
                               ),
                               Text("\u20b92750.00",style: f18yB,)
                             ],
                           ),
                         )),
                     Padding(
                       padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 25.0,bottom: 10.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                               width: width/6,
                               child: Text("Date",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
                           Container(width: width/6,child: Text("Sale",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                           Container(width: width/6,child: Text("Amount",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),

                         ],
                       ),
                     ),
                     Container(
                       height: 3.toDouble()*60,
                       child: ListView.builder(
                           itemCount: 3,
                           physics: NeverScrollableScrollPhysics(),
                           itemBuilder: (context,index){
                             return Padding(
                               padding: const EdgeInsets.only(top:5),
                               child: Container(
                                 color: Colors.grey[800],
                                 child: Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Container(width: width/4,child: Text("18/02/2021",style: f14w,)),
                                       Container(width: width/5,child: Text("2",style: f14wB,)),
                                       Container(width: width/5.7,child: Text("\u20b92750.00",style: f15yB,)),
                                     ],

                                   ),
                                 ),
                               ),
                             );
                           }),
                     ),
                   ],
                 ),
               )
             ],
           )
            ],
          ),
        ) :
        Center(child: CircularProgressIndicator()),
      ),
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