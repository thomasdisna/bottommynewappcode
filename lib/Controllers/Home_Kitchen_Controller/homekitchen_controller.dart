

import 'dart:math';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/CART-PAYMENTS-SCREENS/razor_pay.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/Repository/Home_kitchen_Repository/homekitchen_repository.dart';
import 'package:Butomy/Repository/Home_kitchen_Repository/homekitchen_repository.dart' as repository;
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_HomeKitchen_Product_List_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_LocalShop_Product_List_Page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_Restaurant_Product_List_Page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_homekitchen_bottom_bar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_localshop_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_pin_setting.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_bottombar.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_restaurant_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodiz_business_item_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/welcome_foodizwall_business.dart';
import 'package:fluttertoast/fluttertoast.dart';

var kit_page;
var res_page;
var sto_page;
var kit_tim;
var res_tim;
var sto_tim;

class HomeKitchenRegistration extends ControllerMVC
{
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> RegFormKey;
  bool busstatusFollowing = true;
  List AccountPostData = [];
  bool statusPosts = true;
  var busFollowing=[];
  var userListNamespace=[];
  var HKProd;
  var LSProd;
  var RTProd;
  var postVideo;
  var postImage;
  List timelinePostData=[];
  var likeposttim = [];
  var likesCountApi;
  var reportTimeWallData;
  var deleteTimeWallData;
  List followingList = [];
  var savePostStorage;
  bool statusFollowing = true;
  List AccountWall = [];
  List BlogListt = [];
  List FavouriteList = [];
  List FoodiOrderList = [];
  List BusinessOrderList = [];
  bool statusAccWall = true;
  bool statusBlog = true;
  List LSAccountWall = [];
  bool LSstatusAccWall = true;
  bool favStatus = true;
  List RESTAccountWall = [];
  bool RESTstatusAccWall = true;
  var followerInfo;
  var homeKitchenProfileData;
  var LocalStoreProfileData;
  var RestaurantProfileData;
  var flag = 0;
  var OrderDetail;
  var registered;
  var uploadedData;
  var addedsubCat;
  List KitchenCategories = [];
  List MENULIST = [];
  List StoreCategories = [];
  List RestaurantCategories = [];
  List TimeSubCat = [];
  List TimeSubCatItemList = [];
  List RelatedItem = [];
  var ProductDetail;
  List HomeKitchenTimeline=[];
  List popKitchenList=[];
  List popStoreList=[];
  List popRestList=[];
  List LocalStoreTimeline=[];
  List TimFoodMarket=[];
  List TimFoodBank=[];
  List AccFoodBank=[];
  List RestaurantTimeline=[];
  List Subcategories = [];
  List PurchaseList = [];
  List CartList = [];
  var HKProductList=[];
  var LSProductList=[];
  var RProductList=[];
  var HKACTIVE;
  var LSACTIVE;
  var RACTIVE;
  var HKTOTAL;
  var LSTOTAL;
  var RTOTAL;
  bool statusHKItem=true;
  bool orderDetailStatus=true;
  bool orderStatus=true;
  bool AccFdBankStatus=true;
  bool statusCart=true;
  bool statusPurchase=true;
  bool statusProductDetail=true;
  bool statusTimeSubCat=true;
  bool catdetailstatus=true;
  bool bustimelinestatus=true;
  bool addedsubcatstaus=true;
  bool statusLSItem=true;
  bool statusRItem=true;
  HomeKitchenRegistration() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    RegFormKey = new GlobalKey<FormState>();
  }

  setHomeKitpageTime(pageid,timlineid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('HK_page_id',pageid.toString());
    await prefs.setString('HK_tim_id',timlineid.toString());
  }

  setLocStopageTime(pageid,timlineid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('LS_page_id',pageid.toString());
    await prefs.setString('LS_tim_id',timlineid.toString());
  }

  setRestpageTime(pageid,timlineid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('R_page_id',pageid.toString());
    await prefs.setString('R_tim_id',timlineid.toString());
  }

  getHome() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kit_page= prefs.getString('HK_page_id').toString();
    kit_tim= prefs.getString('HK_tim_id').toString();
  }

  getLOC() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sto_page= prefs.getString('LS_page_id').toString();
    sto_tim= prefs.getString('LS_tim_id').toString();
  }

  getRES() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    res_page= prefs.getString('R_page_id').toString();
    res_tim= prefs.getString('R_tim_id').toString();
  }

  void LocalStoreForm(context,kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai) async {

    repository.LocalStoreFormRepo(kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai). then((value) {
      setLocStopageTime(value["page_id"].toString(),value["timeline_id"].toString());
      if(value["status"]=="200")
       {
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WelcomeFoodizWallBusiness()));

       }
      else
        Fluttertoast.showToast(
          msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
    });
  }

  void RestaurantForm(context,kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai,) async {

    repository.RestaurantFormRepo(kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai). then((value) {
      setRestpageTime(value["page_id"].toString(),value["timeline_id"].toString());
      if(value["status"]=="200")
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WelcomeFoodizWallBusiness()));

        }
      else
        Fluttertoast.showToast(
          msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
    });
  }

  void getIDS(userid)  {
    print("cccccccaaaaaaaaalingggggg idssssss 111111111111111");
    repository.GetIDSRepooo(userid).then((value) {
      print("cccccccaaaaaaaaalingggggg idssssss 44444444444444444 "+value.toString());
      setState(() {
        IDS=value;
        Market_pageid=value["food_market"][0]["page_id"].toString();
        Market_timid=value["food_market"][0]["timeline_id"].toString();
        Foodbank_pageid=value["food_bank"][0]["page_id"].toString();
        Foodbank_timid=value["food_bank"][0]["timeline_id"].toString();
      });
      print("IIIIIIIIDDDDDDDDDDDDDDDDDDDDDSSSSSSSSSSSSS "+IDS.toString());
    } );
  }


  void HomeKitchenForm(context,kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai) async {

    repository.KitchenFormRepo(kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai).then((value) {

      setHomeKitpageTime(value["page_id"].toString(),value["timeline_id"].toString());

      if(value["status"]=="200")
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WelcomeFoodizWallBusiness()));

        }
      else
        Fluttertoast.showToast(
          msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
    });
  }

  void getKitchenCategories(parentId) async {
    Stream<List> stream = new Stream.fromFuture(categoryListRepo(parentId));
    stream.listen((data) {
      setState(() {
        KitchenCategories = data;
        KitCat=KitchenCategories;
        cat=KitchenCategories[0]["name"];
        // Catids=categories[0]["name"];
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getStoreCategories(parentId) async {
    Stream<List> stream = new Stream.fromFuture(categoryListRepo(parentId));
    stream.listen((data) {
      setState(() {
        StoreCategories = data;
        Stocat=StoreCategories;
        // cat=KitchenCategories[0]["name"];
        // Catids=categories[0]["name"];
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getRestaurantCategories(parentId) async {
    Stream<List> stream = new Stream.fromFuture(categoryListRepo(parentId));
    stream.listen((data) {
      setState(() {
        RestaurantCategories = data;
        ResCat=RestaurantCategories;
        // cat=KitchenCategories[0]["name"];
        // Catids=categories[0]["name"];
      });

    }, onDone: () {}, onError: (error) {});
  }

  void getSubCategories(parentId) async {
    Stream<List> stream = new Stream.fromFuture(categoryListRepo(parentId));
    stream.listen((data) {
      setState(() {
        Subcategories = data;
        // cat=Subcategories[0]["name"];
        // Catids=categories[0]["name"];
      });
    }, onDone: () {}, onError: (error) {});
  }


  void LocalStoDocumentUpload(context,pancard,fssai,bustype,page,time,accname,accnum,ifsc,branch,profile,busname,ind,name,username,place,bankname) async {
    print("uuuuuuuuuuu stooooooo Controoooooooooo");
    // getLOC();
    repository.LocalStoreDocUploadRepo(pancard,fssai,bustype,page,time,accname,accnum,ifsc,branch,profile,bankname).then((value) {
      if(value['status'].toString()=="200")
      {
        Fluttertoast.showToast(
          msg: "Documents Updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        FirebaseController.instanace.savingdataofuser(time.toString(),profile.toString().replaceAll(".png", "_512x512.png"),name,username,fire_token.toString());
        /*setState((){
          bustype=="1" ? IDS["home_kitchen"][ind]["verify_status"]=2 :
          bustype=="2" ? IDS["local_store"][ind]["verify_status"]=2 :
          bustype=="3" ? IDS["restaurant"][ind]["verify_status"]=2 :
          null;
        });*/
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=>BusinessPinSetting(name: busname.toString(),page: page.toString(),goo: "1",typ: "4",)
        ));
        // Navigator.pop(context);
      }
      else
        Fluttertoast.showToast(
          msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
    });
  }

  void SetBusinessPIN(context,page,pin,val,typ) async {
    // getRES();
    repository.SetBusinessPINRepoo(page,pin).then((value) {
      print("reset 11111 ");
      repository.HomeKitGetProfile(page.toString()).then((value) {
        print("reset 33333 ");
        setState(() {
          homeKitchenProfileData  = value;
          print("PPPPPPAGGGGEEEEEEEEEe "+value.toString());
          BusinessProfileData=value;
          flag = 1;
        },
        );
        if (value != null) {
        } else {
        }
      });
      if(value['status'].toString()=="200")
      {
        // getIDS(userid.toString());
        // Fluttertoast.showToast(
        //   msg: "Documents Updated successfully",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.TOP,
        //   timeInSecForIosWeb: 35,
        //   backgroundColor: Color(0xFF48c0d8),
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );

       val=="1" ? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context)=>TimeLine(false)
        ), (route) => false) : Navigator.pop(context);

      }
      else
        Fluttertoast.showToast(
          msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
    });
  }

  void HomeKitchenAddItem(context,userid,PostImage,Description,Type,ProductsName,ProductsPrice,
      ProductsDescription,hotdeal,ProductsType,BusinessType,CategoryIds,PostType,prodStatus,
      quantity,system_charge,eranings,unit,page,time,memdate,
      item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst) async {
    // getHome();

    repository.HKAddItemRepo(PostImage,Description,Type,ProductsName,ProductsPrice,
        ProductsDescription,hotdeal,ProductsType,BusinessType,CategoryIds,PostType,
        prodStatus,page.toString(),time.toString(),quantity,system_charge,eranings,unit,
        item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst)
        .then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  bottomNavBarHomeKitchen(pagid: page,memberdate: memdate,timid: time,currentIndex: 3,upld: false,)));

    });
  }

  void RestAddItem(context,userid,PostImage,Description,Type,ProductsName,ProductsPrice,
      ProductsDescription,hotdeal,ProductsType,BusinessType,CategoryIds,PostType,prodStatus,quantity,system_charge,eranings,unit,page,time,memdate,
      item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst) async {
    // getRES();
    repository.RESAddItemRepo(PostImage,Description,Type,ProductsName,ProductsPrice,ProductsDescription,
        hotdeal,ProductsType,BusinessType,CategoryIds,PostType,prodStatus,page.toString(),time.toString(),quantity,system_charge,eranings,unit,
        item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst)
        .then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  bottomNavBarRestaurant(pagid: page,timid: time,memberdate: memdate,currentIndex: 3,upld: false,)));
    });
  }

  void LocAddItem(context,userid,PostImage,Description,Type,ProductsName,ProductsPrice,
      ProductsDescription,hotdeal,ProductsType,BusinessType,CategoryIds,PostType,prodStatus,quantity,system_charge,eranings,unit,page,time,memdate,
      item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst) async {
    // getLOC();
    repository.LOCAddItemRepo(PostImage,Description,Type,ProductsName,ProductsPrice,ProductsDescription,
        hotdeal,ProductsType,BusinessType,CategoryIds,PostType,prodStatus,page.toString(),time.toString(),quantity,system_charge,eranings,unit,
        item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst)
        .then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  bottomNavBarLocalShop(pagid: page,timid: time,memberdate: memdate,currentIndex: 3,
                  upld: false,)));
    });
  }

  void HomeKitchenProductList(businessType,page,time) async {
    print("222222222222 callinggg bus "+businessType+" pag "+page+" time "+time);
    // getHome();
    repository.HKProductListRepo(businessType,page.toString(),time.toString()).then((value) {
      print("333333333333333 callinggg vall "+value.toString());
      setState(() {
        HKProd=value;
        HKProductList=[];
        HKProductList =  value["products"];
        HKACTIVE = value["active_products_count"];
        HKTOTAL = value["total_products_count"];
        statusHKItem=false;
      },);
      print("23456 45"+value["products"].toString());
      print("23456 67"+HKProductList.toString());
    });
  }

  void LocalStoreProductList(businessType,page,time) async {
    // getLOC();
    repository.LSProductListRepo(businessType,page.toString(),time.toString()).then((value) {
      setState(() {
        LSProd=value;
        LSProductList = value["products"];
         LSACTIVE= value["active_products_count"];
        LSTOTAL = value["total_products_count"];
        statusLSItem=false;
      },
      );
      if (value != null) {
      } else {
      }
    });
  }

  void RestaurantProductList(businessType,page,time) async {
    getRES();
    repository.RESProductListRepo(businessType,page.toString(),time.toString()).then((value) {
      setState(() {
        RTProd=value;
        RProductList = value["products"];
        RACTIVE = value["active_products_count"];
        RTOTAL = value["total_products_count"];
        statusRItem=false;
      },
      );
      if (value != null) {
      } else {
      }
    });
  }

  void HomekitchenAddSubCategory(name,parent_id, categories_image,context,page,time,typ) async {
    getHome();
    repository.HomeKitAddSubCatRepo(name,parent_id, categories_image,page.toString(),time.toString(),typ).then((value) {
      setState(() {
        addedsubCat=value;
      },
      );
      if(value["status"] == "200") {

        setState((){
          addedsubcatstaus=true;
        });
      } else {
        Fluttertoast.showToast(msg: value['message'].toString(),
        backgroundColor: Color(0xFF48c0d8), toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.TOP,textColor: Colors.white);
      }

    });
  }

  void HomeKitchenUpdateActiveStatus(product_id,product_status,page) async {
    // getHome();
    repository.KitchenItemStatusUpdate(page.toString(),product_id.toString(),product_status).then((value) {
    });
  }

  void buynoePreSETTING(product_id,product_status) async {
    // getHome();
    repository.buynowPreSETTREPO(product_id.toString(),product_status).then((value) {
      Fluttertoast.showToast(msg: value['message'].toString(),
          backgroundColor: Color(0xFF48c0d8), toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.TOP,textColor: Colors.white);
    });
  }

  void LocalStoreUpdateActiveStatus(product_id,product_status,page) async {
    // getLOC();
    repository.LocalStoreItemStatusUpdate(page.toString(),product_id.toString(),product_status).then((value) {
    });
  }

  void RestaurantUpdateActiveStatus(product_id,product_status,page) async {
    // getRES();
    repository.RestaurantItemStatusUpdate(page.toString(),product_id.toString(),product_status).then((value) {

    });
  }

  void KitchenActiveAllStatus(page,time) async {
    // getHome();
    repository.KitchenStatusAllUpdate(page.toString()).then((value) {
      HomeKitchenProductList("1",page,time);

    });
  }

  void StoreActiveAllStatus(page,time) async {
    // getLOC();
    repository.StoreStatusAllUpdate(page.toString()).then((value) {
      LocalStoreProductList("2",page,time);

    });
  }

  void RestaurantActiveAllStatus(page,time) async {
    // getRES();
    repository.RestauStatusAllUpdate(page.toString()).then((value) {
      RestaurantProductList("3",page,time);

    });
  }

  void AmountUpdateContro(prodid,amount,bustyp,pag,tim) async {
    repository.UpdatePriceRepoo(prodid.toString(),amount).then((value) {
      print("111111111111111 callinggg");
      bustyp=="1" ? HomeKitchenProductList("1",pag,tim)  :
          bustyp=="2" ? LocalStoreProductList("2",pag,tim) :
              bustyp=="3" ? RestaurantProductList("3",pag,tim) : null;
      // print("PRODUCT AMOUNT UPDATE  "+value.toString());
    });
  }

  void AddCatelogue(context,prodid,desc,url,kitchen_item_name,item_sub_titile,products_type,kitchen_hotdeal_status,pic,pageid,productid,typ,timid,member,tab) async {
    repository.AddCatelogueRepoo(prodid,desc,url,kitchen_item_name,item_sub_titile,products_type,kitchen_hotdeal_status).then((value) {
      // print("PRODUCT Cateloggg UPDATE  "+value.toString());
      Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ItemDetailPage(tabb: 2,
        member: member,typ: typ,timid: timid,
        pageid:pageid,
        productid: productid,
        pic:pic,
      )));
    });

  }




  void KitchenTimelineWalls(businessType) async {
    repository.BusinessTimelineRepoo(businessType).then((value) {
      setState(() {
      HomeKitchenTimeline = value["data"];
      KITCHENDATA=HomeKitchenTimeline;
      UserKitchen=value["user_product_count"];
        // bustimelinestatus=false;
      },
      );
    });
  }

  void KitchenTimelineWalls1(businessType) async {
    repository.BusinessTimelineRepoo1(businessType).then((value) {
      setState(() {
        HomeKitchenTimeline = value["data"];
        KITCHENDATA=HomeKitchenTimeline;
        UserKitchen=value["user_product_count"];
        // bustimelinestatus=false;
      },
      );
    });
  }

  void popularKitchen() async {
    repository.popularKitchen("1").then((value) {
      setState(() {
        popKitchenList = value["products"];
        popKitchen=popKitchenList;
        // bustimelinestatus=false;
      },
      );
    });
  }

  void popularStore() async {
    repository.popularKitchen("2").then((value) {
      setState(() {
        popStoreList = value["products"];
        popStore=popStoreList;
        // bustimelinestatus=false;
      },
      );
    });
  }

  void popularRest() async {
    repository.popularKitchen("3").then((value) {
      setState(() {
        popRestList = value["products"];
        popRest=popRestList;
        // bustimelinestatus=false;
      },
      );
    });
  }

  void StoreTimelineWalls(businessType) async {
    repository.BusinessTimelineRepoo(businessType).then((value) {
      setState(() {
       LocalStoreTimeline= value["data"];
       STOREDATA=LocalStoreTimeline;
       UserStore=value["user_product_count"];
        // bustimelinestatus=false;
      },
      );
    });
  }
  void StoreTimelineWalls1(businessType) async {
    repository.BusinessTimelineRepoo1(businessType).then((value) {
      setState(() {
        LocalStoreTimeline= value["data"];
        STOREDATA=LocalStoreTimeline;
        UserStore=value["user_product_count"];
        // bustimelinestatus=false;
      },
      );
    });
  }

  void FoodiMarketTimelineWalls1() async {
    repository.FoodiMarketTiimmm().then((value) {
      setState(() {
        TimFoodMarket= value;
        TimMARKET=TimFoodMarket;
      },
      );
    });
  }

  void FoodiBankTimelineWalls1() async {
    repository.FoodBankTiimmm().then((value) {
      setState(() {
        TimFoodBank= value;
        TimBANK=TimFoodBank;
      },

      );
      print("Fooooddd bank "+TimFoodBank.toString());
    });
  }

  void FoodiBankAccount(type,page_id) async {
    repository.FoodBankAccount(type,page_id).then((value) {
      setState(() {
        AccFoodBank= value;
        AccFdBankStatus=false;
      },
      );
    });
  }

  void RestaurantTimelineWalls(businessType) async {
    repository.BusinessTimelineRepoo(businessType).then((value) {
      setState(() {
    RestaurantTimeline = value["data"];
    RESTAURANTDATA=RestaurantTimeline;
    UserRestaurant=value["user_product_count"];
        // bustimelinestatus=false;
      });
    });
  }
  void RestaurantTimelineWalls1(businessType) async {
    repository.BusinessTimelineRepoo1(businessType).then((value) {
      setState(() {
        RestaurantTimeline = value["data"];
        RESTAURANTDATA=RestaurantTimeline;
        UserRestaurant=value["user_product_count"];
        // bustimelinestatus=false;
      });
    });
  }

  void BusinessTimelineCategoryWiseList(business_type,category_id) async {
    setState((){
      statusTimeSubCat=true;
    });
    repository.BusinessTimelineCatRepoo(business_type,category_id).then((value) {
      setState((){
        TimeSubCat=value["data"];
        statusTimeSubCat=false;
      });
      TimeSubCat.length>0 ? BusinessTimelineSubCategoryItemList(business_type.toString(),value["data"][0]["id"].toString()) : null;
    });
  }

  void BusinessTimelineCategoryWiseListMenu(business_type,category_id,pagee) async {
    setState((){
      statusTimeSubCat=true;
    });
    repository.BusinessTimelineCatRepoo(business_type,category_id).then((value) {
      setState((){
        TimeSubCat=value["data"];
        statusTimeSubCat=false;
      });
      TimeSubCat.length>0 ? BusinessTimelineSubCategoryItemListMenu(business_type.toString(),value["data"][0]["id"].toString(),pagee) : null;
    });
  }

  void BusinessTimelineSubCategoryItemList(business_type,category_id) async {
setState((){
  catdetailstatus=true;
});
    repository.BusinessTimelineCatwiseItemRepoo(business_type.toString(),category_id.toString()).then((value) {
      setState((){
        TimeSubCatItemList=value["products"];
        catdetailstatus=false;
      });
    });
  }

  void BusinessTimelineSubCategoryItemListMenu(business_type,category_id,pagee) async {
    setState((){
      // catdetailstatus=true;
      // TimeSubCatItemList = [];
    });

    repository.BusinessBusinessCatwiseItemMenuRepoo(business_type.toString(),category_id.toString(),pagee).then((value) {
      setState((){

        TimeSubCatItemList=value["products"];
        catdetailstatus=false;
      });
    });
  }

  void BusinessEveryItemDetailPage(product_id) async {
    repository.BusinessItemDetailPage(product_id.toString()).then((value) {
      print("Detailss "+value["data"].toString());
      setState((){
        ProductDetail=value["data"];
        statusProductDetail=false;
      });
    });
  }

  void BusinessRelatedItem(pagee,typ) async {
    repository.businessRelatedItemList(pagee.toString(),typ).then((value) {
      print("Related listtss "+value["products"].toString());
      setState((){
        RelatedItem=value["products"];
        statusProductDetail=false;
      });
    });
  }

  void AddtoPurchaseList(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id) async {
    Fluttertoast.showToast(msg: "  Added to Bucket  ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    repository.AddPurchaseListRepoo(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id)
        .then((value) {
      getPurchaseList(userid.toString());
    });
  }

  void getPurchaseList(user_id) async {
    print("uuuuuuuuuuuuuu "+user_id.toString());
    repository.GetPurchaseListRepoo(user_id.toString())
        .then((value) {
          setState((){
            PurchaseList=value["data"];
            PURCHASELIST=value["data"];
            purchasecount=value["data"].length;
            statusPurchase=false;
          });
    });
  }

  void EditPurchaseListItem(customers_basket_id,customers_basket_quantity) async {
    repository.EditPurchaseListRepoo(customers_basket_id.toString(),customers_basket_quantity.toString())
        .then((value) {
      /*Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );*/
    });
  }

  void AddToCartControo(context,page_id,user,kitchenname,loct,item,itemcount) async {
    repository.AddtoCartRepoo(page_id,user.toString())
        .then((value) {
          print("cart adding errr "+value.toString());
      getPurchaseList(userid.toString());
      Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      if(value["status"].toString()=="200"){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>CartScreenT1(null,null,false)
        ));
      }
      else {
        setState((){
          showClearDialog = true;
          showCartProceedButton = false;
          showCartClearButton = true;
        });
        showModalBottomSheet(
            backgroundColor:
            Colors.grey[800],
            context:
            context,
            clipBehavior: Clip
                .antiAlias,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (
                      BuildContext context, sss.StateSetter state) {
                    return Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Clear your Cart ?",style: f21BB,),
                              IconButton(icon: Icon(Icons.close,color: Colors.white,size: 25,),
                                onPressed: (){
                                  Navigator.pop(context);
                                },)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Divider(color: Colors.grey[200],),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:12,right: 12,bottom: 8,top: 8),
                          child: RichText(textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Your cart has existing items from ",
                                style: f14w,children: [
                              TextSpan(
                                text: value["kitchen_name"]+".",
                                style: f14yB,
                              ),
                              TextSpan(
                                  text: " Do yoy want to clear it and add items from ",
                                  style: f14w
                              ),
                              TextSpan(
                                  text: kitchenname,
                                  style: f14yB
                              )
                            ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kitchenname,style: f16wB,),
                                        SizedBox(height: 3,),
                                        Text(loct,style: f14wB,)
                                      ],
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF23252E),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    )
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:15,right: 15,bottom: 12,top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(item,style: f14w,),
                                          SizedBox(width: 10,),
                                          Text(itemcount>1 ? "+ "+(itemcount-1).toString()+" more items" : "",style: f14y,),
                                        ],
                                      ),
                                    ),
                                    /*Padding(
                                            padding: const EdgeInsets.only(left:8,right: 8,bottom: 8),
                                            child: Divider(color: Colors.black87,thickness: 1,),
                                          )*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:7.0,left: 12,right: 12,),
                          child: GestureDetector(
                            onTap: (){
                              if(showCartProceedButton == false) {
                                Fluttertoast.showToast(msg: "Please Clear your Cart",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 35,
                                  backgroundColor: Color(0xFF48c0d8),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                ); }
                              else{
                                Navigator.pop(context);
                                AddToCartControo(context,page_id,user,kitchenname,loct,item,itemcount);
                              }
                              // Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: showCartProceedButton ? 1 : .1,
                              child: Container(
                                height: 47,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Color(0xFFffd55e),width: 2),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(child: Text("Proceed with this Item",style: f15yB,)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:13.0,left: 12,right: 12,bottom: 10),
                          child: GestureDetector(
                            onTap: (){
                              showCartClearButton ? clearCart(state) : Fluttertoast.showToast
                                (msg: "Already Cart Cleared",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 35,
                                backgroundColor: Color(0xFF48c0d8),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              // Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: showCartClearButton ? 1 : .1,
                              child: Container(
                                height: 47,
                                decoration: BoxDecoration(
                                    color: Color(0xFFffd55e),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text("Clear Cart",style: f16B,)),
                              ),
                            ),
                          ),
                        )


                      ],
                    );
                  });
            });
      }
    });
  }

  void getCARTListControo(user_id) async {
    repository.getCARTLISTRepoo(user_id.toString())
        .then((value) {
          setState((){
            CartList=value["data"];
             cartCount =CartList.length>0 ?  CartList.length : 0;
            cartTotal=value["total_amount"];
            statusCart=false;
          });
    });
  }

  void HomekitchenGetProfile(page) async {
    // getHome();
    repository.HomeKitGetProfile(page.toString()).then((value) {
      setState(() {
        homeKitchenProfileData  = value;
        print("PPPPPPAGGGGEEEEEEEEEe "+value.toString());
        BusinessProfileData=value;
        flag = 1;
      },
      );
      if (value != null) {
      } else {
      }
    });
  }

  void LocalStoreGetProfile(page) async {
    // getLOC();
    repository.LSGetProfile(page.toString()).then((value) {
      setState(() {
        homeKitchenProfileData=value;

      },
      );

      if (value != null) {

      } else {
      }
    });
  }

  void RestaurantGetProfile(page) async {
    getRES();
    repository.RestGetProfile(page.toString()).then((value) {
      setState(() {
        homeKitchenProfileData = value;
      },
      );
      if (value != null) {
      } else {
      }
    });
  }

  void followerController(useridCon, followeridCon) async {
    repository.FollowerRepo(useridCon, followeridCon).then((value) {
      setState(() => followerInfo = value);
    });
  }

  void BusaddProfileImage(profImg, timIds) async {
    repository.BusprofileImage(profImg,timIds).then((value) {
      if (value != null) {
        if (value["status"].toString() == "200") {
        } else {

        }
      } else {}
    });
  }

  void BusinessKitchenProfileEdit(context,email,address,website,current_location,location_lat,location_long,page,specialised,signature,known_as) async {
    // getHome();
    repository.businessprofileEdit(page.toString(),email,address,website,current_location,location_lat,location_long,specialised,signature,known_as). then((value) {
      if(value["status"]=="200") {
        HomekitchenGetProfile(page);
        Navigator.pop(context);
      }
    });
  }



  void getAccountWallImage(timelineid) async {
    Stream<List> stream = new Stream.fromFuture(getAccWallImage(timelineid));
    stream.listen((data) {
      setState(() {
        AccountWall = data;
        BUS_KITCHEN_WALL=data;
        statusAccWall = false;
      });
    }, onDone: () {}, onError: (error) {});
  }
  void LocalStoregetAccountWallImage(timelineid) async {

    Stream<List> stream = new Stream.fromFuture(getLocalStoreAccWallImage(timelineid));
    stream.listen((data) {
      setState(() {
        LSAccountWall = data;
        BUS_STORE_WALL=data;
        LSstatusAccWall = false;
      });
    }, onDone: () {}, onError: (error) {});
  }
  void RestaurantgetAccountWallImage(timelineid) async {

    Stream<List> stream = new Stream.fromFuture(getRestaurantAccWallImage(timelineid));
    stream.listen((data) {
      setState(() {
        RESTAccountWall = data;
        BUS_RESTAURANT_WALL=data;
        RESTstatusAccWall = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getFollowing(userid) async {
    Stream<List> stream = new Stream.fromFuture(getFollowingList(userid));
    stream.listen((data) {
      setState(() {
        followingList = data;
        statusFollowing = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void reportTimeWall(userid, post_id) async {
    repository.reportTimelineWall(userid, post_id).then((value) {
      setState(() => reportTimeWallData = value);
      getTimelineWall(userid);
      // getAccountWallImage(userid.toString());
    });
  }
  void deleteTimelineWall(userid, post_id) async {
    repository.deleteTimeWall(userid, post_id).then((value) {
      setState(() => deleteTimeWallData = value);
      //getTimelineWall(userid);
      //  savePostListController(userid.toString());
      // getAccountWallImage(userid.toString());
    });
  }
  void saveTimelinePost(post_id, userid) async {
    repository.savePost(post_id.toString(), userid.toString()).then((value) {
      setState(() => savePostStorage = value);
      // getTimelineWall(userid);
      //savePostListController(userid.toString());
      // getAccountWallImage(userid.toString());
    });
  }
  void likePostTime(userid, post_id) async {
    Stream<List> stream =
    new Stream.fromFuture(likePostTimeline(userid, post_id));
    stream.listen((data) {
      // getTimelineWall(userid.toString());
      setState(() => likeposttim = data);

      setState(() {
        likesCountApi = likeposttim[0]["likecount"].toString();
      });

      // savePostListController(userid.toString());
      // getAccountWallImage(userid.toString());
    }, onDone: () {}, onError: (error) {});
  }


  void getTimelineWall(userId) async {
    Stream<List> stream = new Stream.fromFuture(getTimeWall(userId));
    stream.listen((data) {
      setState(() {
        timelinePostData = [];
        timelinePostData = data;
      });
    }, onDone: () {}, onError: (error) {});
  }
  void getUseranametoId(username) async {
    repository.UserNametoID(username).then((value) {
      /*  Navigator.push(
        context, MaterialPageRoute(builder: (context) => TimelineFoodWallDetailPage(id: value.toString(),)));*/
    } );
  }

  void getPersonalPosts(tim,acc) async {
    Stream<List> stream = new Stream.fromFuture(getPersonPost(tim,acc));
    stream.listen((data) {
      setState(() {
        AccountPostData = data;
        statusPosts = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void postBlogPost1(context,pageid, description,title, image, type, categry,_location,lat,lng,timid,memdate,bustype) async {
    print("BBBBBBBBBBBBBBBBBBBBBBB 333333333333");
    bustype=="1" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="2" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="3" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,)))
        : Container();
    repository.BlogPost1(pageid, description, image, type, categry,_location,lat,lng,title)
        .then((value) {
      print("BBBBBBBBBBBBBBBBBBBBBBB 44444444444444");
      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() => postImage = value);
    });
  }

  void postBlogPost2(context,pageid, description,title, image, type, categry,timid,memdate,bustype) async {
    print("BBBBBBBBBBBBBBBBBBBBBBB 55555555555555");
    bustype=="1" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="2" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="3" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,)))
        : Container();
    repository.BlogPost2(pageid, description, image, type, categry,title)
        .then((value) {
      print("BBBBBBBBBBBBBBBBBBBBBBB 666666666666666666666666");
      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() => postImage = value);
    });
  }

  void postBlogPost3(context,pageid, description,title, image, type, categry,timid,memdate,bustype,video) async {
    print("BBBBBBBBBBBBBBBBBBBBBBB 55555555555555");
    bustype=="1" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="2" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="3" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,)))
        : Container();
    repository.BlogPost3(pageid, description, image, type, categry,title,video)
        .then((value) {
      print("BBBBBBBBBBBBBBBBBBBBBBB 666666666666666666666666");
      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() => postImage = value);
    });
  }

  void postBlogPost4(context,pageid, description,title, image, type, categry,_location,lat,lng,timid,memdate,bustype,video) async {
    print("BBBBBBBBBBBBBBBBBBBBBBB 333333333333");
    bustype=="1" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="2" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="3" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,)))
        : Container();
    repository.BlogPost4(pageid, description, image, type, categry,_location,lat,lng,title,video)
        .then((value) {
      print("BBBBBBBBBBBBBBBBBBBBBBB 44444444444444");
      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() => postImage = value);
    });
  }

  void posttimelineWallPost1(context,pageid, description, image, type,loc,lat,long,timid,memdate,bustype) async {
    print("testttttttt 1111");
    bustype=="1" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="2" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="3" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,)))
        : Container();
    repository.TimelineWallPost1(pageid, description, image, type,loc,lat,long).then((value) {
      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() => postImage = value);
    });
  }



  void posttimelineWallPost2(context,pageid, description, image, type,timid,memdate,bustype) async {
    bustype=="1" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,))) :
    bustype=="2" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid, upld: true,currentIndex: 0,))) :
    bustype=="3" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: true,currentIndex: 0,)))
        : Container();
    repository.TimelineWallPost2(pageid, description, image, type,).then((value) {
      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() => postImage = value);
    });
  }

  void posttimelineDescPost1(context,userid, description,pic,title,desc,site,link,timid,memdate,bustype) async {
    bustype=="1" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
    bustype=="2" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
    bustype=="3" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,)))
        : Container();
    repository.TimelineDescPost1(userid, description,pic,title,desc,site,link).then((value) {
      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,)))
          : Container();
      Fluttertoast.showToast(
        msg: "Post Uploaded",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() => postImage = value);
    });
  }

  void posttimelineDescPost2(context,userid, description,loc,lat,long,pic,title,desc,site,link,timid,memdate,bustype) async {
    bustype=="1" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
    bustype=="2" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
    bustype=="3" ?
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,)))
        : Container();
    repository.TimelineDescPost2(userid, description,loc,lat,long,pic,title,desc,site,link).then((value) {
      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,)))
          : Container();

      setState(() => postImage = value);
    });
  }

  void posttimelineDescPostp(context,userid, description,pic,title,desc,site,link,type,timid,memdate,bustype) async {
    getHome();
    getLOC();
    getRES();
    repository.TimelineDescPost1(type=="1"?"16":type=="2"?sto_page.toString():res_page.toString(), description,pic,title,desc,site,link).then((value) {

      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: userid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() => postImage = value);
    });
  }

  void posttimelineUTubeVideoPost1(context,pageid, description, video,_location,lat,lng,timid,memdate,bustype) async {
    repository.TimelineUTubeVideoPost1(pageid, description, video,_location,lat,lng).then((value) {

      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() {
        postVideo = value;
      });
    });
  }

  void posttimelineUTubeVideoPost2(context,pageid, description, video,timid,memdate,bustype) async {
    repository.TimelineUTubeVideoPost2(pageid, description, video,).then((value) {

      bustype=="1" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarHomeKitchen(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="2" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarLocalShop(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,))) :
      bustype=="3" ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => bottomNavBarRestaurant(timid: timid,memberdate: memdate,pagid: pageid,upld: false,currentIndex: 0,)))
          : Container();
      setState(() {
        postVideo = value;
      });
    });
  }


  void getUsers ()  async {
    repository.userListNamespace().then((value) {
      setState(() => userListNamespace = value);
      if (value != null) {
      } else {
      }
    });
  }

  void HomeKitchenBusinessFollowing(pageId,UserId) async {
    getHome();

    repository.businessFollowingList(pageId.toString(),UserId.toString()).then((value) {
      setState(() {
        busFollowing = value;
        busstatusFollowing=false;
      },
      );
      if (value != null) {
      } else {
      }
    });
  }

  void BusinessFollowunFollow(pageId,userId,type) async {
    // getHome();
    repository.PageFollower(pageId.toString(),userId.toString(),).then((value) {
     type=="1"? HomekitchenGetProfile(pageId) : type=="2" ? LocalStoreGetProfile(pageId) :
     type=="3" ? RestaurantGetProfile(pageId) : null;
      setState(() {
      },
      );
      if (value != null) {
        // HomeKitchenBusinessFollowing(pageId.toString(),userId.toString());
      } else {
      }
    });
  }

  void stateList ()  async {
    repository.getStateList().then((value) {
      setState(() => STATES = value);
    });
  }

  void DistrictList (stateid)  async {
    repository.getDistrictList(stateid).then((value) {
      setState(() => DISTRICTS = value);
    });
  }

  void getBlogListt(timelineid) async {
    Stream<List> stream = new Stream.fromFuture(BlogListRepoooo(timelineid));
    stream.listen((data) {
      setState(() {
        BlogListt = data;
        statusBlog = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void addFavourite(products_id)  async {
    repository.addFavouriteRepoo(products_id).then((value) {
      getFavouriteList();

    });
  }



  void getFavouriteList() async {
    Stream<List> stream = new Stream.fromFuture(getFavouriteListRepoo());
    stream.listen((data) {
      setState(() {
        FavouriteList = data;
        favouriteList = data;
        favStatus = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void placeOrder(context,page,email,company,firstname,lastname,street,city,postcode,delivery_phone)  async {
    print("AAAAAAAAAAAAAAAAAAa "+page.toString());
    repository.placeOrderRepoo(page,email,company,firstname,lastname,street,city,postcode,delivery_phone,"Cash On Delivery").then((value) {
      print("uuuuuuuuuuuuu "+value.toString());
      if(value["status"].toString()=="200"){
        Fluttertoast.showToast(msg: value["message"].toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 35,
              backgroundColor: Color(0xFF48c0d8),
              textColor: Colors.white,
              fontSize: 16.0,
            );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeLine(false)), (route) => false);
      }
      else
        {
          Fluttertoast.showToast(msg: value["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 35,
            backgroundColor: Color(0xFF48c0d8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
    });
  }

  void PreOrderplaceOrder(context,page,email,company,firstname,lastname,street,city,postcode,delivery_phone,date,time)  async {
    print("AAAAAAAAAAAAAAAAAAa "+page.toString());
    repository.PreorderplaceOrderRepoo(page,email,company,firstname,lastname,street,city,postcode,delivery_phone,date,time,"Cash On Delivery").then((value) {
      print("uuuuuuuuuuuuu "+value.toString());
      if(value["status"].toString()=="200"){
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeLine(false)), (route) => false);
      }
      else
      {
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void placeOrder2(context,page,email,company,firstname,lastname,street,city,postcode,delivery_phone,kittt)  async {
    print("AAAAAAAAAAAAAAAAAAa "+page.toString());
    repository.placeOrderRepoo(page,email,company,firstname,lastname,street,city,postcode,delivery_phone,"Bank").then((value) {
      print("uuuuuuuuuuuuu "+value.toString());
      if(value["status"].toString()=="200"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentGatewayScreen(amount: cartTotal,email: email,name: firstname,orderid: value["order_id"].toString(),phone: delivery_phone,kitchenname: kittt,address: postcode+", "+city,)));
      }
      else
      {
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void PreOrderplaceOrder2(context,page,email,company,firstname,lastname,street,city,postcode,delivery_phone,date,time,kittt)  async {
    print("AAAAAAAAAAAAAAAAAAa "+page.toString());
    repository.PreorderplaceOrderRepoo(page,email,company,firstname,lastname,street,city,postcode,delivery_phone,date,time,"Bank").then((value) {
      print("uuuuuuuuuuuuu "+value.toString());
      if(value["status"].toString()=="200"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentGatewayScreen(amount: cartTotal,email: email,name: firstname,orderid: value["order_id"].toString(),phone: delivery_phone,kitchenname: kittt,address:  postcode+", "+city,)));

      }
      else
      {
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }


  void getFoodiOrderList()  async {
    repository.getFoodieOderListRepo().then((value) {
      setState(() {
        FoodiOrderList = value;
        orderStatus = false;
      });
    });
  }

  void getBusinessOrderList(page)  async {
    repository.getBusinessOderListRepo(page).then((value) {
      print("order list "+value.toString());
      setState(() {
        BusinessOrderList = value;
        orderStatus = false;
      });
    });
  }

  void foodiOrderDetail(order)  async {
    repository.foodieOderDetailRepo(order).then((value) {
      setState(() {
        OrderDetail = value;
        orderDetailStatus = false;
      });
      print("OOOOODER DDDDDDDDDDDD "+OrderDetail.toString());
    });
  }

  void buyNow(context,user_id,products_id,business_type,customers_basket_quantity,final_price,page_id,item,quantity,kitchenname,loct) async {

    repository.buynoww(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id)
        .then((value) {
      print("buyyyyy "+value.toString());
      if(value["status"]=="200")
      {
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CartScreenT1(null,null,false)
        ));
      }
      else if(value["status"]=="201"){
        setState((){
          showClearDialog = true;
          showCartProceedButton = false;
          showCartClearButton = true;
        });
        showModalBottomSheet(
            backgroundColor:
            Colors.grey[800],
            context:
            context,
            clipBehavior: Clip
                .antiAlias,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (
                      BuildContext context, sss.StateSetter state) {
                    return Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Clear your Cart ?",style: f21BB,),
                              IconButton(icon: Icon(Icons.close,color: Colors.white,size: 25,),
                                onPressed: (){
                                  Navigator.pop(context);
                                },)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Divider(color: Colors.grey[200],),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:12,right: 12,bottom: 8,top: 8),
                          child: RichText(textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Your cart has existing items from ",
                                style: f14w,children: [
                              TextSpan(
                                text: value["kitchen_name"]+".",
                                style: f14yB,
                              ),
                              TextSpan(
                                  text: " Do yoy want to clear it and add items from ",
                                  style: f14w
                              ),
                              TextSpan(
                                  text: kitchenname,
                                  style: f14yB
                              )
                            ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kitchenname,style: f16wB,),
                                        SizedBox(height: 3,),
                                        Text(loct,style: f14wB,)
                                      ],
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF23252E),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    )
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:15,right: 15,bottom: 5,top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item,style: f14w,),
                                          Text("\u20B9 "+(final_price*quantity).toString(),style: f14y,),
                                          Row(
                                            children: [
                                              IconButton(
                                                splashColor: Color(0xFF48c0d8),
                                                icon: Text("-",style: f15wB,),onPressed: (){
                                                state((){
                                                  quantity=quantity-1;
                                                  quantity= quantity >0 ? quantity : 0;
                                                });
                                              },),
                                              Text(quantity.toString(),style: f14wB,),
                                              IconButton(
                                                splashColor: Color(0xFF48c0d8),
                                                icon: Text("+",style: f15wB,),onPressed: (){
                                                state((){
                                                  quantity = quantity+1;
                                                });
                                              },),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                   /* Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(color: Colors.black87,thickness: 1,),
                                    )*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:7.0,left: 12,right: 12,),
                          child: GestureDetector(
                            onTap: (){
                              if(showCartProceedButton == false) {
                                Fluttertoast.showToast(msg: "Please Clear your Cart",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 35,
                                  backgroundColor: Color(0xFF48c0d8),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                ); }
                              else{
                                Navigator.pop(context);
                                buyNow(context,user_id,products_id,business_type,customers_basket_quantity,final_price,page_id,item,quantity,kitchenname,loct);
                              }
                              // Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: showCartProceedButton ? 1 : .1,
                              child: Container(
                                height: 47,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Color(0xFFffd55e),width: 2),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(child: Text("Proceed with this Item",style: f15yB,)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:13.0,left: 12,right: 12,bottom: 10),
                          child: GestureDetector(
                            onTap: (){
                              showCartClearButton ? clearCart(state) : Fluttertoast.showToast
                                (msg: "Already Cart Cleared",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 35,
                                backgroundColor: Color(0xFF48c0d8),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              // Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: showCartClearButton ? 1 : .1,
                              child: Container(
                                height: 47,
                                decoration: BoxDecoration(
                                    color: Color(0xFFffd55e),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text("Clear Cart",style: f16B,)),
                              ),
                            ),
                          ),
                        )


                      ],
                    );
                  });
            });
      }
      else{
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void clearCart(state) async {

    repository.clearCart().then((value) {
      print("cart clear "+value.toString());
      if(value["status"]=="200")
      {
        Fluttertoast.showToast(msg: "Cart cleared Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        state((){
          showCartProceedButton = true;
          showCartClearButton = false;
        });
      }
      else{
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void Preorder(context,user_id,products_id,business_type,customers_basket_quantity,final_price,page_id,date,time,item,quantity,kitchenname,loct) async {

    repository.buynoww(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id)
        .then((value) {
      print("buyyyyy "+value.toString());
      if(value["status"]=="200")
      {
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CartScreenT1(date,time,true)
        ));
      }
      else if(value["status"]=="201"){
        Navigator.pop(context);
        setState((){
          showClearDialog = true;
          showCartProceedButton = false;
          showCartClearButton = true;
        });
        showModalBottomSheet(
            backgroundColor:
            Colors.grey[800],
            context:
            context,
            clipBehavior: Clip
                .antiAlias,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (
                      BuildContext context, sss.StateSetter state) {
                    return Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Clear your Cart ?",style: f21BB,),
                              IconButton(icon: Icon(Icons.close,color: Colors.white,size: 25,),
                                onPressed: (){
                                  Navigator.pop(context);
                                },)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Divider(color: Colors.grey[200],),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:12,right: 12,bottom: 8,top: 8),
                          child: RichText(textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Your cart has existing items from ",
                                style: f14w,children: [
                              TextSpan(
                                text: value["kitchen_name"]+".",
                                style: f14yB,
                              ),
                              TextSpan(
                                  text: " Do yoy want to clear it and add items from ",
                                  style: f14w
                              ),
                              TextSpan(
                                  text: kitchenname,
                                  style: f14yB
                              )
                            ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kitchenname,style: f16wB,),
                                        SizedBox(height: 3,),
                                        Text(loct,style: f14wB,)
                                      ],
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF23252E),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    )
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:15,right: 15,bottom: 5,top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item,style: f14w,),
                                          Text("\u20B9 "+(final_price*quantity).toString(),style: f14y,),
                                          Row(
                                            children: [
                                              IconButton(
                                                splashColor: Color(0xFF48c0d8),
                                                icon: Text("-",style: f15wB,),onPressed: (){
                                                state((){
                                                  quantity=quantity-1;
                                                  quantity= quantity >0 ? quantity : 0;
                                                });
                                              },),
                                              Text(quantity.toString(),style: f14wB,),
                                              IconButton(
                                                splashColor: Color(0xFF48c0d8),
                                                icon: Text("+",style: f15wB,),onPressed: (){
                                                state((){
                                                  quantity = quantity+1;
                                                });
                                              },),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  /*  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(color: Colors.black87,thickness: 1,),
                                    )*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:7.0,left: 12,right: 12,),
                          child: GestureDetector(
                            onTap: (){
                              if(showCartProceedButton == false) {
                                Fluttertoast.showToast(msg: "Please Clear your Cart",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 35,
                                  backgroundColor: Color(0xFF48c0d8),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                ); }
                              else{
                                Navigator.pop(context);
                                Preorder(context,user_id,products_id,business_type,customers_basket_quantity,final_price,page_id,date,time,item,quantity,kitchenname,loct);
                              }
                              // Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: showCartProceedButton ? 1 : .1,
                              child: Container(
                                height: 47,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Color(0xFFffd55e),width: 2),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(child: Text("Proceed with this Item",style: f15yB,)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:13.0,left: 12,right: 12,bottom: 10),
                          child: GestureDetector(
                            onTap: (){
                              showCartClearButton ? clearCart(state) : Fluttertoast.showToast
                                (msg: "Already Cart Cleared",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 35,
                                backgroundColor: Color(0xFF48c0d8),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              // Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: showCartClearButton ? 1 : .1,
                              child: Container(
                                height: 47,
                                decoration: BoxDecoration(
                                    color: Color(0xFFffd55e),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text("Clear Cart",style: f16B,)),
                              ),
                            ),
                          ),
                        )


                      ],
                    );
                  });
            });
      }
      else{
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void updateProductIconImage(context,media_id,post_image,pic,pageid,productid,typ,timid,member) async {
    // getHome();
    repository.updateProductIconImage(media_id,post_image).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ItemDetailPage(tabb: 3,
        member: member,typ: typ,timid: timid,
        pageid:pageid,
        productid: productid,
        pic:pic,
      )));
    });
  }

  void deleteProductImage(media_id,) async {
    // getHome();
    repository.deleteProductImage(media_id).then((value) {

    });
  }

  void addGalleryProductImage(context,prod_id,post_image,pic,pageid,productid,typ,timid,member) async {
    // getHome();
    repository.addProductImage(prod_id,post_image).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ItemDetailPage(tabb: 3,
        member: member,typ: typ,timid: timid,
        pageid:pageid,
        productid: productid,
        pic:pic,
      )));
    });
  }

  void updateProductValues(context,prod_id,title,valll,pic,pageid,typ,timid,member) async {
    // getHome();
    repository.updateProductValue(prod_id,title,valll).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ItemDetailPage(tabb: 1,
        member: member,typ: typ,timid: timid,
        pageid:pageid,
        productid: prod_id,
        pic:pic,
      )));
    });
  }

  void getPageMenu(pageee) async {
    setState((){
      MenuSubCat = [];
    });
    Stream<List> stream = new Stream.fromFuture(getPageMenuRepo(pageee));
    stream.listen((data) {
      print("MENUUUUU "+data.toString());
      setState(() {
        main_currentind = 0;
        MENULIST = data;
         x =0;
         if(MENULIST.length==0){
           statusCart = false;
           catdetailstatus=false;
         }
      });

  for(int i=0;i<MENULIST.length;i++){
        if(x==0 && MENULIST[i]["pro_count"]>0){
          setState((){
            main_currentind=i;
            MenuSubCat =  MENULIST[i]["subcategory"];
            statusCart = false;
            x++;
          });
        }
  }
  setState((){
    statusCart = false;
    catdetailstatus=false;
  });
      print("DDDDDDDDDDDDD 333333333 : "+main_currentind.toString());
      setState((){});
    }, onDone: () {}, onError: (error) {});
  }

  void updateViewCountOfPost(postid) async {
    // getHome();
    repository.updateViewCountOfPost(postid).then((value) {
      print("Post view count update "+value.toString());

    });
  }

  void removePurchase(pageee)  async {
    repository.clearPurchase(pageee).then((value) {
      print("%%%%%%%%%%%%%%%%%%%% "+value.toString());
      getPurchaseList(userid.toString());

    });
  }

  void removeCartList()  async {
    repository.clearCartList().then((value) {
      print("%%%%%%%%%%%%%%%%%%%% "+value.toString());
      getCARTListControo(userid.toString());
    });
  }

  void updatePaymentId(orderid,payment_status,transaction_id)  async {
    repository.updatePaymentId(orderid,payment_status,transaction_id).then((value) {
      print("%%%%%%%%%%%%%%%%%%%% update pay id "+value.toString());
    });
  }

  void getOrderStatus() async {
    // getHome();
    repository.getOrderStatus().then((value) {
      setState(() {
        orderStatusList = value;
      });
      print("Order status :  "+orderStatusList.toString());
    });
  }

  void updateOrderStatus(orderid,status_id,)  async {
    repository.updateOrderStatus(orderid,status_id).then((value) {
      print("%%%%%%%%%%%%%%%%%%%% update order status: "+value.toString());
    });
  }


}//