import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:http/http.dart' as http;

var UserHMData;
var UserLSData;
var RestLSData;
var dataUser;
var deldata1;

Future GetIDSRepooo(useridInfo) async {
  print("cccccccaaaaaaaaalingggggg idssssss 222222222222");
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getids?user_id=" +
            useridInfo.toString()),
  );
  var  data = json.decode(response.body);
  print("cccccccaaaaaaaaalingggggg idssssss 3333333333333333333 "+data.toString());
  return data;
}

Future KitchenFormRepo(kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/registerhomekitchen";
  final res = await http.post(url, body: {
    "home_kitchen_name": kitchenname.toString(),
    "kitchen_address": address.toString(),
    "kitchen_name": username.toString(),
    "kitchen_mobile": mobile.toString(),
    "kitchen_email": email.toString(),
    // "kitchen_category": cat.toString(),
    "business_type":businesstype.toString(),
    "user_id":userid.toString(),
    "fssai_license_number":fssai.toString(),
    "state":state.toString(),
    "district":district.toString(),
    "place":place.toString(),
    "pincode":pincode.toString(),
    "status": "0",
  });
  var RegData = json.decode(res.body);
  return RegData;
}

Future RestaurantFormRepo(kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/registerhomekitchen";
  final res = await http.post(url, body: {
    "home_kitchen_name": kitchenname.toString(),
    "kitchen_address": address.toString(),
    "kitchen_name": username.toString(),
    "kitchen_mobile": mobile.toString(),
    "kitchen_email": email.toString(),
    // "kitchen_category": cat.toString(),
    "business_type":businesstype.toString(),
    "user_id":userid.toString(),
    "fssai_license_number":fssai.toString(),
    "state":state.toString(),
    "district":district.toString(),
    "place":place.toString(),
    "pincode":pincode.toString(),
    "status":"0"
  });
  var RegData = json.decode(res.body);
  return RegData;
}

Future LocalStoreFormRepo(kitchenname,address,username,mobile,email,category,businesstype,state,district,place,pincode,fssai) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/registerhomekitchen";
  final res = await http.post(url, body: {
    "home_kitchen_name": kitchenname.toString(),
    "kitchen_address": address.toString(),
    "kitchen_name": username.toString(),
    "kitchen_mobile": mobile.toString(),
    "kitchen_email": email.toString(),
    // "kitchen_category": cat.toString(),
    "business_type":businesstype.toString(),
    "user_id":userid.toString(),
    "fssai_license_number":fssai.toString(),
    "state":state.toString(),
    "district":district.toString(),
    "place":place.toString(),
    "pincode":pincode.toString(),
    "status": "0",
  });
  var RegData = json.decode(res.body);

  return RegData;
}

Future<List> categoryListRepo(parentId) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getcategories?parent_id="+parentId.toString()),
  );
  var category = json.decode(response.body);

  return category["data"];
}



Future LocalStoreDocUploadRepo(pancard,fssai,bustype,page,time,accname,accnum,ifsc,branch,profile,bankname) async {
  print("uuuuuuuuuuu stooooooo repoooooooooo");
  final String url = "https://saasinfomedia.com/foodiz/public/api/uploaddocuments";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
    "page_id": page.toString(),
    "timeline_id": time.toString(),
    "business_pancard": pancard.toString(),
    "business_certificate": fssai.toString(),
    "bank_account_name": accname.toString(),
    "bank_name": bankname.toString(),
    "account_number": accnum.toString(),
    "IFSC_code": ifsc.toString(),
    "branch_name": branch.toString(),
    "change_avatar": profile.toString(),
    "status": "2",
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future RestaurantDocUploadRepo(pancard,certi,bustyp,page,tim) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/uploaddocuments";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
    "page_id": page.toString(),
    "timeline_id": tim.toString(),
    "business_pancard": pancard.toString(),
    "business_certificate": certi.toString(),
    "status": "2",
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future SetBusinessPINRepoo(page,pin) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/businesspinset";
  final response = await http.post(url, body: {
    "page_id": page.toString(),
    "business_pin": pin.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future<List> HmKitchenPhoneVerificationRepo(kitchenUserId,KitchenMob) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?kitchen_user_id="+kitchenUserId.toString()+"&kitchen_mobile="+
            KitchenMob.toString()),
  );
  var VerfData = json.decode(response.body);
  return VerfData;
}

Future HKAddItemRepo(PostImage,Description,Type,ProductsName,ProductsPrice,ProductsDescription,
    hotdeal,ProductsType,BusinessType,CategoryIds,PostType,prodStatus,page,tim,quantity,system_charge,eranings,unit,
    item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproduct";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
    "timeline_id":tim.toString(),
    "page_id":page.toString(),
    "post_image": PostImage.toString(),
    "item_sub_titile": item_sub_titile.toString(),
    "item_discount_price": item_discount_price.toString(),
    "item_discount_percentage": item_discount_percentage.toString(),
    "item_packaging_charge": item_packaging_charge.toString(),
    "item_gst": item_gst.toString(),
    "description": "",
    "products_name": ProductsName.toString(),
    "type": Type.toString(),
    "products_price": ProductsPrice.toString(),
    "products_description": "",
    "is_feature": hotdeal.toString(),
    "products_type": ProductsType.toString(),
    "business_type": BusinessType.toString(),
    "category_ids": CategoryIds.toString(),
    "post_type": PostType.toString(),
    "products_status": prodStatus.toString(),
    "products_quantity": quantity.toString(),
    "products_dp": system_charge.toString(),
    "products_profit": eranings.toString(),
    "products_weight_unit": unit.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future LOCAddItemRepo(PostImage,Description,Type,ProductsName,ProductsPrice,ProductsDescription,
    hotdeal,ProductsType,BusinessType,CategoryIds,PostType,prodStatus,page,tim,quantity,system_charge,eranings,unit,
    item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproduct";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
    "timeline_id":tim.toString(),
    "page_id":page.toString(),
    "post_image": PostImage.toString(),
    "item_sub_titile": item_sub_titile.toString(),
    "item_discount_price": item_discount_price.toString(),
    "item_discount_percentage": item_discount_percentage.toString(),
    "item_packaging_charge": item_packaging_charge.toString(),
    "item_gst": item_gst.toString(),
    "description": "",
    "products_name": ProductsName.toString(),
    "type": Type.toString(),
    "products_price": ProductsPrice.toString(),
    "products_description": "",
    "is_feature": hotdeal.toString(),
    "products_type": ProductsType.toString(),
    "business_type": BusinessType.toString(),
    "category_ids": CategoryIds.toString(),
    "post_type": PostType.toString(),
    "products_status": prodStatus.toString(),
    "products_quantity": quantity.toString(),
    "products_dp": system_charge.toString(),
    "products_profit": eranings.toString(),
    "products_weight_unit": unit.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future RESAddItemRepo(PostImage,Description,Type,ProductsName,ProductsPrice,ProductsDescription,
    hotdeal,ProductsType,BusinessType,CategoryIds,PostType,prodStatus,page,tim,quantity,system_charge,eranings,unit,
    item_sub_titile,item_discount_price,item_discount_percentage,item_packaging_charge,item_gst) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproduct";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
    "timeline_id":tim.toString(),
    "page_id":page.toString(),
    "post_image": PostImage.toString(),
    "item_sub_titile": item_sub_titile.toString(),
    "item_discount_price": item_discount_price.toString(),
    "item_discount_percentage": item_discount_percentage.toString(),
    "item_packaging_charge": item_packaging_charge.toString(),
    "item_gst": item_gst.toString(),
    "description": "",
    "products_name": ProductsName.toString(),
    "type": Type.toString(),
    "products_price": ProductsPrice.toString(),
    "products_description": "",
    "is_feature": hotdeal.toString(),
    "products_type": ProductsType.toString(),
    "business_type": BusinessType.toString(),
    "category_ids": CategoryIds.toString(),
    "post_type": PostType.toString(),
    "products_status": prodStatus.toString(),
    "products_quantity": quantity.toString(),
    "products_dp": system_charge.toString(),
    "products_profit": eranings.toString(),
    "products_weight_unit": unit.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future HKProductListRepo(businessType,page,tim) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type="+
            businessType.toString()+"&timeline_id="+tim.toString()+"&page_id="+page.toString()+"&user_id="+userid.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future LSProductListRepo(businessType,page,tim) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type="+
            businessType.toString()+"&timeline_id="+tim.toString()+"&page_id="+page.toString()+"&user_id="+userid.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future RESProductListRepo(businessType,page,tim) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type="+
            businessType.toString()+"&timeline_id="+tim.toString()+"&page_id="+page.toString()+"&user_id="+userid.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future HomeKitAddSubCatRepo(name,parent_id, categories_image,page,tim,typ) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/addcategories";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
    "timeline_id":tim.toString(),
    "page_id":page.toString(),
    "name": name.toString(),
    "business_type": typ.toString(),
    "categories_image": categories_image.toString(),
    "parent_id": parent_id.toString(),
  });
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future KitchenItemStatusUpdate(page,prodid,status) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/productstatusupdate";
  final response = await http.post(url, body: {
    "page_id":  page.toString(),
    "product_id":  prodid.toString(),
    "product_status":  status.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future buynowPreSETTREPO(prodid,status) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/updateplaceordertype";
  final response = await http.post(url, body: {
    "products_id":  prodid.toString(),
    "placeorder_type":  status.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future LocalStoreItemStatusUpdate(page,prodid,status) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/productstatusupdate";
  final response = await http.post(url, body: {
    "page_id":  page.toString(),
    "product_id":  prodid.toString(),
    "product_status":  status.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future RestaurantItemStatusUpdate(page,prodid,status) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/productstatusupdate";
  final response = await http.post(url, body: {
    "page_id":  page.toString(),
    "product_id":  prodid.toString(),
    "product_status":  status.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future BusinessTimelineRepoo(businessType) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/userproductslist?parent_category="+
            businessType.toString()/*+"&user_id="+userid.toString()*/),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future BusinessTimelineRepoo1(businessType) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/userproductslist?parent_category="+
            businessType.toString()+"&user_id="+userid.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future popularKitchen(type) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type="+type.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future FoodiMarketTiimmm() async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type=6"),
  );
  var ProdData = json.decode(response.body);
  return ProdData["products"];
}

Future FoodBankTiimmm() async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type=4"),
  );
  var ProdData = json.decode(response.body);
  return ProdData["products"];
}

Future FoodBankAccount(typp,page) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type="+typp+"&page_id="+page.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData["products"];
}

Future KitchenStatusAllUpdate(page_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/productstatusupdate";
  final response = await http.post(url, body: {
    "page_id":  page_id.toString(),
    "product_status":  "1".toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future StoreStatusAllUpdate(page_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/productstatusupdate";
  final response = await http.post(url, body: {
    "page_id":  page_id.toString(),
    "product_status":  "1".toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future RestauStatusAllUpdate(page_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/productstatusupdate";
  final response = await http.post(url, body: {
    "page_id":  page_id.toString(),
    "product_status":  "1".toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future UpdatePriceRepoo(prodid,price) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/catalogupdate";
  final response = await http.post(url, body: {
    "product_id":  prodid.toString(),
    "products_price":  price.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future AddCatelogueRepoo(prodid,desc,uurl,kitchen_item_name,item_sub_titile,products_type,kitchen_hotdeal_status) async {
  print("RRRRRRRRRRRRRR "+prodid.toString()+" "+desc+" "+uurl);
  final String url = "https://saasinfomedia.com/foodiz/public/api/catalogupdate";
  final response = await http.post(url, body: {
    "product_id":  prodid.toString(),
    "products_description":  desc.toString(),
    "item_sub_titile":  item_sub_titile.toString(),
    "kitchen_item_name":  kitchen_item_name.toString(),
    "products_type":  products_type.toString(),
    "kitchen_hotdeal_status":  kitchen_hotdeal_status.toString(),
    "product_video_url":  uurl.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future BusinessTimelineCatRepoo(business_type,category_id) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getcategories?business_type="+
            business_type.toString()+"&parent_id="+category_id.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future BusinessTimelineCatwiseItemRepoo(business_type,category_id) async {
  print("cattt idd "+category_id.toString());
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type="+
            business_type.toString()+"&category_id="+category_id.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future BusinessBusinessCatwiseItemMenuRepoo(business_type,category_id,page) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?business_type="+
            business_type.toString()+"&category_id="+category_id.toString()+"&page_id="+page.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future BusinessItemDetailPage(product_id) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productdetail?product_id="+
            product_id.toString()+"&user_id="+userid.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future businessRelatedItemList(pagg,typ) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/productslist?page_id="+
            pagg.toString()+"&business_type="+typ),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future AddPurchaseListRepoo(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/addtopurchaselist";
  final response = await http.post(url, body: {
    "user_id":user_id.toString(),
    "products_id":products_id.toString(),
    "business_type":business_type.toString(),
    "customers_basket_quantity": customers_basket_quantity.toString(),
    "final_price": final_price.toString(),
    "business_page_id": page_id.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future GetPurchaseListRepoo(user_id) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getpurchaselist?user_id="+
            user_id.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future EditPurchaseListRepoo(customers_basket_id,customers_basket_quantity) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/updatepurchaselist";
  final response = await http.post(url, body: {
    "customers_basket_id":customers_basket_id.toString(),
    "customers_basket_quantity":customers_basket_quantity.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future AddtoCartRepoo(page_id,user) async {
  print("paaggee dddddd"+page_id.toString());
  final String url = "https://saasinfomedia.com/foodiz/public/api/movetocart";
  final response = await http.post(url, body: {
    "business_page_id":page_id.toString(),
    "user_id":user.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future getCARTLISTRepoo(user_id) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getcartlist?user_id="+
            user_id.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future HomeKitGetProfile(pageIds) async {
  print("reset 222222 ");
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getpageinfo?page_id="+pageIds+"&user_id="+userid.toString()),
  );
  UserHMData = json.decode(response.body);
  return UserHMData;
}

Future LSGetProfile(pageId) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getpageinfo?page_id="+pageId.toString()+"&user_id="+userid.toString()),
  );
  UserLSData = json.decode(response.body);
  return UserLSData;
}
Future RestGetProfile(pageId) async {

  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getpageinfo?page_id="+pageId.toString()+"&user_id="+userid.toString()),
  );
  RestLSData = json.decode(response.body);
  return RestLSData;
}

Future FollowerRepo(userid, followerid) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/followuser";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);

  return dataUser;
}

Future BusprofileImage(avatarImage, timelineId) async {

  final String url = "https://saasinfomedia.com/foodiz/public/api/updateavatar";
  final register = await http.post(url, body: {
    "change_avatar": avatarImage,
    "timeline_id": timelineId,
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future businessprofileEdit(pageid,email,address,website,current_location,
    location_lat,location_long,specialised,signature,known_as) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/pageedit";
  final response = await http.post(url, body: {
    "page_id":pageid.toString(),
    "specialised_categories":specialised.toString(),
    "signature_dishes":signature.toString(),
    "email":email.toString(),
    "address": address.toString(),
    "website": website.toString(),
    "known_as": known_as.toString(),
    "current_location":current_location.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future<List> getAccWallImage(timelineid) async {
  final response = await http.get(Uri.encodeFull(
      "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?timeline_id=" +
          timelineid.toString() +
          "&memberid=" +
          timelineid +
          "&type=image"));
  var qData = json.decode(response.body);

  return qData['posts'];
}
Future<List> getLocalStoreAccWallImage(timelineid) async {
  final response = await http.get(Uri.encodeFull(
      "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?timeline_id=" +
          timelineid.toString() +
          "&memberid=" +
          timelineid +
          "&type=image"));
  var qData = json.decode(response.body);

  return qData['posts'];
}
Future<List> getRestaurantAccWallImage(timelineid) async {
  final response = await http.get(Uri.encodeFull(
      "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?timeline_id=" +
          timelineid.toString() +
          "&memberid=" +
          timelineid +
          "&type=image"));
  var qData = json.decode(response.body);
  return qData['posts'];
}

Future<List> getFollowingList(userid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/followeringlist?userid=" +
            userid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['following'];
}
Future reportTimelineWall(userid, post_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/report-post";

  final response = await http.post(url, body: {
    "userid": userid.toString(),
    "post_id": post_id.toString(),
  });
  var reportData = json.decode(response.body);
  if (reportData['status'] == "200") {
  } else {}
  return reportData;
}
Future deleteTimeWall(userid, post_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/post-delete";

  final response = await http.post(url, body: {
    "userid": userid.toString(),
    "post_id": post_id.toString(),
  });
  var deldata = json.decode(response.body);
  if (deldata['status'] == "200") {
  } else {}
  return deldata;
}
Future savePost(post_id, userid) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/savepost";
  final response = await http.post(url, body: {
    "post_id": post_id,
    "userid": userid,
    "memberid": userid,
  });
  var saveData = json.decode(response.body);
  if (saveData['status'] == 200) {
  } else {}
  return saveData;
}
Future<List> likePostTimeline(userid, post_id) async {
  try {
    final String url = "https://saasinfomedia.com/foodiz/public/api/like-post";

    final response = await http.post(url, body: {
      "userid": userid.toString(),
      "memberid": userid.toString(),
      "post_id": post_id.toString(),
    });
    //deldata1 = json.decode(response.body);

    deldata1 = json.decode(response.body);
    if (deldata1['status'] == "200") {
    } else {}
    return deldata1["data"];
  } catch (e) {}
}
Future<List> getTimeWall(user) async {
  //getUserId();
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?memberid=" +
            user.toString()),
  );
  var qData = json.decode(response.body);
  return qData['posts'];
}
Future UserNametoID(username) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getuserid?username=" +
            username.toString()),
  );

  var abtInfo = json.decode(response.body);
  var namerr=abtInfo["data"][0]["id"].toString();
  return namerr;
}

Future BlogPost1(pageid, description, image, type, cat,_location,lat,lng,title) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "post_image": image,
    "post_title": title,
    "type": "image",
    "post_type": "Blog",
    "post_location": _location.toString(),
    "post_lat": lat.toString(),
    "post_lng": lng.toString(),
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future BlogPost4(pageid, description, image, type, cat,_location,lat,lng,title,video) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "post_image": image,
    "post_title": title,
    "post_type": "Blog",
    "post_location": _location.toString(),
    "post_lat": lat.toString(),
    "post_lng": lng.toString(),
    "type" : "image",
    "video": video.toString(),
    "video_type" : "youtube",
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future BlogPost2(pageid, description, image, type, cat,title) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "post_image": image,
    "post_title": title,
    "type": "image",
    "post_type": "Blog",


    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future BlogPost3(pageid, description, image, type, cat,title,video) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "post_image": image,
    "post_title": title,
    "type": "image",
    "post_type": "Blog",
    "video": video.toString(),
    "video_type" : "youtube",


    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future TimelineWallPost1(pageid, description, image, type,loc,lat,long) async {

  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "post_image": image,
    "type": type.toString(),
    "post_location": loc.toString(),
    "post_lat": lat.toString(),
    "post_lng": long.toString(),
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future TimelineWallPost2(pageid, description, image, type,) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "post_image": image.toString(),
    "type": type.toString(),
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future TimelineDescPost1(pageid, description,pic,title,desc,site,link) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "url_image": pic.toString(),
    "url_title": title.toString(),
    "url_desc": desc.toString(),
    "url_site": site.toString(),
    "url_link": link.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future<List> getPersonPost(tim, acc) async {
  // getUserId();
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?timeline_id=" +
            tim.toString() +
            "&accountid=" +
            acc.toString()),
  );
  var qData = json.decode(response.body);
  return qData['posts'];
}


Future TimelineDescPost2(pageid, description,loc,lat,long,pic,title,desc,site,link) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "post_location": loc.toString(),
    "post_lat": lat.toString(),
    "post_lng": long.toString(),
    "url_image": pic.toString(),
    "url_title": title.toString(),
    "url_desc": desc.toString(),
    "url_site": site.toString(),
    "url_link": link.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}
Future TimelineUTubeVideoPost1(pageid, description, video,_location,lat,lng) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "video": video.toString(),
    "video_type" : "youtube",
    "post_location": _location.toString(),
    "post_lat": lat.toString(),
    "post_lng": lng.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future TimelineUTubeVideoPost2(pageid, description, video,) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "page_id": pageid.toString(),
    "description": description.toString(),
    "video": video.toString(),
    "video_type" : "youtube",

  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}



Future userListNamespace() async {
  // getUserId();
  final response = await http.get(
    Uri.encodeFull("https://saasinfomedia.com/foodiz/public/api/userlist"),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future<List> businessFollowingList(pageId,UserId) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/pagefollowing?page_id=" +
            pageId.toString()+"&user_id="+UserId.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['following'];
}


Future PageFollower(pageId,userId) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/followpage";
  final responseFollow = await http.post(url, body: {
    "page_id": pageId.toString(),
    "follower_id": userId.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future getStateList() async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/statelist"),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['data'];
}

Future getDistrictList(stateid) async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/districtlist?state_id="+stateid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['data'];
}

Future<List> BlogListRepoooo(timelineid) async {
  final response = await http.get(Uri.encodeFull(
      "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?timeline_id=" +
          timelineid.toString() +
          "&type=Blog"));
  var qData = json.decode(response.body);
  return qData['posts'];
}

Future addFavouriteRepoo(products_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/productfavorite";
  final responseFollow = await http.post(url, body: {
    "products_id": products_id.toString(),
    "user_id": userid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future<List> getFavouriteListRepoo() async {
  final response = await http.get(Uri.encodeFull(
      "https://saasinfomedia.com/foodiz/public/api/favoritelist?user_id=" +
          userid.toString()));
  var qData = json.decode(response.body);
  return qData['data'];
}

Future placeOrderRepoo(page,email,company,firstname,lastname,street,city,postcode,delivery_phone,methodPay) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/place_order";
  final responseFollow = await http.post(url, body: {
    "page_id": page.toString(),
    "delivery_charge": "4".toString(),
    "tax": ((cartTotal/100)*2).toString(),
    "order_price": (cartTotal+4+((cartTotal/100)*2)).toString(),
    "customers_id": userid.toString(),
    "email": email.toString(),
    "company": company.toString(),
    "firstname": firstname.toString(),
    "lastname": lastname.toString(),
    "street": street.toString(),
    "city": city.toString(),
    "postcode": postcode.toString(),
    "delivery_phone": delivery_phone.toString(),
    "delivery_state": "Kerala",
    "delivery_country": "India",
    "billing_firstname": firstname.toString(),
    "billing_lastname": lastname.toString(),
    "billing_street": street.toString(),
    "billing_city": city.toString(),
    "billing_zip": postcode.toString(),
    "billing_phone": delivery_phone.toString(),
    "billing_company": company.toString(),
    "billing_state": "Kerala",
    "billing_country": "India",
    "payment_method": methodPay,
    "method_name": "Order_"+userid.toString(),
    "order_comments": "fast delivery at user_"+userid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future PreorderplaceOrderRepoo(page,email,company,firstname,lastname,street,city,postcode,delivery_phone,date,time,methodPay) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/place_order";
  final responseFollow = await http.post(url, body: {
    "page_id": page.toString(),
    "delivery_date": date.toString(),
    "delivery_time": time.toString(),
    "order_type": "preorder",
    "delivery_charge": "4".toString(),
    "tax": ((cartTotal/100)*2).toString(),
    "order_price": (cartTotal+4+((cartTotal/100)*2)).toString(),
    "customers_id": userid.toString(),
    "email": email.toString(),
    "company": company.toString(),
    "firstname": firstname.toString(),
    "lastname": lastname.toString(),
    "street": street.toString(),
    "city": city.toString(),
    "postcode": postcode.toString(),
    "delivery_phone": delivery_phone.toString(),
    "delivery_state": "Kerala",
    "delivery_country": "India",
    "billing_firstname": firstname.toString(),
    "billing_lastname": lastname.toString(),
    "billing_street": street.toString(),
    "billing_city": city.toString(),
    "billing_zip": postcode.toString(),
    "billing_phone": delivery_phone.toString(),
    "billing_company": company.toString(),
    "billing_state": "Kerala",
    "billing_country": "India",
    "payment_method": methodPay,
    "method_name": "Order_"+userid.toString(),
    "order_comments": "fast delivery at user_"+userid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future getFoodieOderListRepo() async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/orderlist?customers_id="+userid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['data'];
}

Future getBusinessOderListRepo(page) async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/vendororderdetail?page_id="+page.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['data'];
}

Future foodieOderDetailRepo(order) async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/orderdetail?order_id="+order.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['data'];
}

Future buynoww(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/buynow";
  final response = await http.post(url, body: {
    "user_id":user_id.toString(),
    "products_id":products_id.toString(),
    "business_type":business_type.toString(),
    "customers_basket_quantity": customers_basket_quantity.toString(),
    "final_price": final_price.toString(),
    "business_page_id": page_id.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future clearCart() async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/clearcart";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future clearPurchase(page) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/clearcart";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
    "page_id":page.toString(),
  });
  var UploadedData = json.decode(response.body);
  print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&& "+UploadedData.toString());
  return UploadedData;
}

Future clearCartList() async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/clearcart";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
  });
  var UploadedData = json.decode(response.body);
  print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&& "+UploadedData.toString());
  return UploadedData;
}

Future updateProductIconImage(media_id,post_image) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/catalogupdate";
  final responseFollow = await http.post(url, body: {
    "post_image": post_image.toString(),
    "media_id": media_id.toString(),
    "image_update_type" :"update"
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future deleteProductImage(media_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/catalogupdate";
  final responseFollow = await http.post(url, body: {
    "media_id": media_id.toString(),
    "image_update_type" :"delete"
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future addProductImage(prod_id,post_image) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/catalogupdate";
  final responseFollow = await http.post(url, body: {
    "product_id": prod_id.toString(),
    "post_image": post_image.toString(),
    "image_update_type" :"create"
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future updateProductValue(prod_id,title,valll) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/catalogupdate";
  final responseFollow = await http.post(url, body: {
    "product_id": prod_id.toString(),
    title : valll.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future<List> getPageMenuRepo(paggee) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/businessmenucategory?page_id="+paggee.toString()),
  );
  var category = json.decode(response.body);

  return category["data"];
}

Future updateViewCountOfPost(postid) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/postview";
  final responseFollow = await http.post(url, body: {
    "post_id": postid.toString(),

  });
  var dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future updatePaymentId(orderid,payment_status,transaction_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/updateorderstatus";
  final response = await http.post(url, body: {
    "order_id":orderid.toString(),
    "payment_status":payment_status.toString(),
    "transaction_id":transaction_id.toString(),
    "payment_method":"Bank",
  });
  var UploadedData = json.decode(response.body);
  print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&& update pay id"+UploadedData.toString());
  return UploadedData;
}

Future<List> getOrderStatus() async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/orderstatus"),
  );
  var category = json.decode(response.body);
  return category["data"];
}

Future updateOrderStatus(orderid,status_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/updateorderstatus";
  final response = await http.post(url, body: {
    "order_id":orderid.toString(),
    "orders_status_id":status_id.toString(),
  });
  var UploadedData = json.decode(response.body);
  print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&& update order status: "+UploadedData.toString());
  return UploadedData;
}