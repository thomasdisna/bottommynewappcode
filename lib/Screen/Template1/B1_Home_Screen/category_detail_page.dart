import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template2/B1_Home_Screen/Component_Detail_Food/Food_Detail_Screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'Each_Item_Detail_view_page.dart';
import 'package:intl/intl.dart';

var s = "unlike";

class Category_Detail extends StatefulWidget {
  String image;
  String cat_item;
  String cat;

  String item_name;
  String owner;
  int cat_id;
  int typ;

  Category_Detail(
      {this.image, this.cat_item,this.cat_id,this.typ});

  @override
  _Category_DetailState createState() => _Category_DetailState();
}

class _Category_DetailState extends StateMVC<Category_Detail> {

  HomeKitchenRegistration _con;
  _Category_DetailState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }
  int currentind;

  List<bool> splashcolor = List.filled(1000, false);

  @override
  void initState() {
    setState(() {
      currentind=0;
    });
    _con.BusinessTimelineCategoryWiseList(widget.typ.toString(),widget.cat_id.toString());
    // TODO: implement initState
    super.initState();
  }

  DateTime selectedDate;
  int sel;
  TimeOfDay selectedTime;
  var listDate=[];
  int quantity;
  int total;
  int sel_ind;

  Future<Null> _selectDate(BuildContext context,sss.StateSetter state) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      state(() {
        selectedDate = picked;
      });
    listDate = selectedDate.toString().split(" ");
    print("ddaaateeeeee "+selectedDate.toString());
    print("ddaaateeeeee listtttt"+listDate.toString());
    print("ddaaateeeeee 333333333"+DateFormat.yMMMEd().format(selectedDate).toString());
    _selectTime(context,state);
  }

  String timeF = "am";
  Future<Null> _selectTime(BuildContext context,sss.StateSetter state) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      state(() {
        selectedTime = picked;
        var a =selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString().split(":");
        print("dfgh "+a.toString());
        if(int.parse(a[0])<=12)
          timeF="am";
        else
          timeF="pm";
      });
    print("timmmmeewe -"+selectedTime.toString());
    print("timmmmeewe cuuutttt 11111 -"+selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", ""));
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
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // color: Color(0xFF1E2026),
              color: Colors.black12,
              height: 140,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "FLAVOURFUL " + widget.cat_item.toUpperCase(),
                              style: f15wB,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Text(
                                  "A culinary blend of ",
                                  style: f14g,
                                ),
                                Text(
                                  widget.cat_item + ".",
                                  style: f14gB,
                                ),
                              ],
                            ),
                            Text(
                              "Order now from top eateries Nearby.",
                              style: f14g
                            ),
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(widget.image),
                      radius: 54,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Visibility(
                  visible: _con.statusTimeSubCat,
                  child: Container(
                      margin: EdgeInsets.only(top: 170, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            // lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
           _con.TimeSubCat.length>0  && _con.statusTimeSubCat==false ? Column(
             children: [
               Padding(
                 padding: const EdgeInsets.only(
                     left: 10.0, right: 10, top: 8, bottom: 8),
                 child: Container(
                   height: 133,
                   child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                       itemCount: _con.TimeSubCat.length,
                       itemBuilder: (context,index){
                     return InkWell(
                       onTap: () {
                         setState(() {
                           currentind=index;
                         });
                         _con.BusinessTimelineSubCategoryItemList(widget.typ.toString(),_con.TimeSubCat[index]["id"].toString());
                        /* Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => Category_Detail(
                                   image:
                                   "assets/Template1/image/Foodie/chinese.jpg",
                                   cat_item: "Chinese",
                                   cat: "rest",
                                   owner: "Arya Bhavan",
                                   item_name: "Fried Rice",
                                 )));*/
                       },
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                           color: currentind==index ? Color(0xFF23252E) : Colors.transparent,
                           boxShadow:currentind==index ? <BoxShadow>[
                             BoxShadow(
                               color: Colors.black54,
                               blurRadius: 2,
                             ),
                           ] : null,
                         ),

                         child: Padding(
                           padding: const EdgeInsets.only(top: 5,bottom: 5,left:12,right: 12),
                           child: Column(
                             children: <Widget>[
                               CircleAvatar(
                                 backgroundImage: CachedNetworkImageProvider(
                                     "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/"+ _con.TimeSubCat[index]["categories_image"].toString()+"?alt=media"),
                                 radius: 36,
                               ),
                               SizedBox(
                                 height: 15,
                               ),
                               Container(
                                 width: 80,
                                 child: Text(
                                     _con.TimeSubCat[index]["name"].toString(),
                                     style: currentind==index ? f15bB : f15wB,textAlign: TextAlign.center,
                                 ),
                               )
                             ],
                           ),
                         ),
                       ),
                     );
                   }),
                 ),
               ),
               SizedBox(height: 8),
               Divider(
                 color: Colors.black87,
                 thickness: 1,
               ),
               /*Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "4 "+widget.cat+" NEARBY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "SORT/FILTER",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),*/
               Center(
                 child: Visibility(
                     visible: _con.catdetailstatus,
                     child: Container(
                         margin: EdgeInsets.only(top: 80, ),
                         child: CircularProgressIndicator()
                     )
                 ),
               ),
              _con.TimeSubCatItemList.length>0 && _con.catdetailstatus==false  ? Container(
                 height: _con.TimeSubCatItemList.length.toDouble()*160,
                 child: ListView.builder(
                   // scrollDirection: Axis.vertical,
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: _con.TimeSubCatItemList.length,
                   itemBuilder: (ctx, inditem) {
                     return Column(
                       children: <Widget>[
                         Column(
                           children: <Widget>[
                             GestureDetector(
                               onTap: () {
                                 _con.TimeSubCatItemList[inditem]['products_status'].toString()=="1" ?
                                 Navigator.push(context, MaterialPageRoute(
                                   builder: (context)=>EachItemDetailPage(
                                     page_id: _con.TimeSubCatItemList[inditem]["page_id"].toString(),
                                     typ: widget.typ.toString(),product_id: _con.TimeSubCatItemList[inditem]["kitchen_item_id"].toString(),)
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
                                   opacity: _con.TimeSubCatItemList[inditem]['products_status'].toString()=="0" ?  .2 : 1,
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
                                               Container(
                                                 height: 105.0,
                                                 width: 95.0,
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.all(
                                                         Radius.circular(10.0)),
                                                     image: DecorationImage(
                                                         image: CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                             _con.TimeSubCatItemList[inditem]["kitchen_item_image"][0]["source"].toString()+"?alt=media"),
                                                         fit: BoxFit.cover)),
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
                                                       Text( _con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString().length>15 ?  _con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString().substring(0,15)+"..."
                                                          : _con.TimeSubCatItemList[inditem]["kitchen_item_name"],
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
                                                               color: _con.TimeSubCatItemList[inditem]
                                                               ["products_type"].toString()=="0" ? Colors.green[600] : Colors.red[600]),
                                                           borderRadius:
                                                           BorderRadius.circular(
                                                               (2)),
                                                         ),
                                                         child: Icon(
                                                             Icons.brightness_1,
                                                             color:
                                                             _con.TimeSubCatItemList[inditem]
                                                             ["products_type"].toString()=="0" ? Colors.green[600] : Colors.red[600],
                                                             size: 8),
                                                       ),
                                                     ],
                                                   ),
                                                   SizedBox(
                                                     height: 3,
                                                   ),
                                                   Text(
                                                       "In " + widget.cat_item,
                                                       style: f14w
                                                   ),
                                                   SizedBox(
                                                     height: 3,
                                                   ),
                                                   Row(
                                                     children: <Widget>[
                                                       Text(
                                                           "5",
                                                           style: f14gB
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
                                                           " ("+_con.TimeSubCatItemList[inditem]
                                                           ["products_quantity"].toString()+minPic+")",
                                                           style: f14gB
                                                       ),
                                                     ],
                                                   ),
                                                   SizedBox(
                                                     height: 3,
                                                   ),
                                                   Row(
                                                     children: <Widget>[
                                                       Text(
                                                           "\u20B9 "+ _con.TimeSubCatItemList[inditem]["kitchen_item_amount"].toString(),
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
                                                                     _con.TimeSubCatItemList[inditem]["busprofileimage"]!=null ?
                                                                     _con.TimeSubCatItemList[inditem]["busprofileimage"]+"?alt=media" :
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
                                                                   _con.TimeSubCatItemList[inditem]["busname"],
                                                                   overflow: TextOverflow.ellipsis,
                                                                   style: f14w,
                                                                 ),
                                                                 Text( _con.TimeSubCatItemList[inditem]["busaddress"],
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
                                                       if(_con.TimeSubCatItemList[inditem]['products_status'].toString()=="1") { _con.AddtoPurchaseList(userid.toString(), _con.TimeSubCatItemList[inditem]
                                                       ["kitchen_item_id"].toString(),widget.typ.toString(),"1",
                                                           _con.TimeSubCatItemList[inditem]["kitchen_item_amount"].toString(), _con.TimeSubCatItemList[inditem]["page_id"].toString());
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
                                                     if(_con.TimeSubCatItemList[inditem]['products_status'].toString()=="1") { if (_con.TimeSubCatItemList[inditem]
                                                       ["is_favorite"]==true) {
                                                         print(" tap 111111111111111");
                                                         setState(() {
                                                           _con.TimeSubCatItemList[inditem]
                                                           ["is_favorite"]=false;
                                                         });
                                                       } else {
                                                         print(" tap 2222222222222222");
                                                         setState(() {
                                                           _con.TimeSubCatItemList[inditem]
                                                           ["is_favorite"]=true;
                                                         });
                                                       }
                                                       _con.addFavourite(_con.TimeSubCatItemList[inditem]
                                                       ["kitchen_item_id"].toString());}
                                                     },
                                                     child:_con.TimeSubCatItemList[inditem]
                                                     ["is_favorite"]==true
                                                         ? Icon(Icons.favorite,
                                                         color: Color(0xFFffd55e))
                                                         : Icon(Icons.favorite_border,
                                                         color: Colors.white),
                                                   ),
                                                 ],
                                               ),
                                               SizedBox(
                                                 height: 8,
                                               ),
                                               GestureDetector(
                                                 onTap:(){
                                                   if(_con.TimeSubCatItemList[inditem]['products_status'].toString()=="1") { if( _con.TimeSubCatItemList[inditem]
                                                   ["placeorder_type"].toString()=="0")
                                                  { _con.buyNow(context,userid.toString(), _con.TimeSubCatItemList[inditem]
                                                   ["kitchen_item_id"].toString(),widget.typ.toString(),"1",
                                                       _con.TimeSubCatItemList[inditem]["kitchen_item_amount"].toString(),
                                                       _con.TimeSubCatItemList[inditem]["page_id"].toString(),

                                                      _con.TimeSubCatItemList[inditem]["kitchen_item_name"],1,
                                                      _con.TimeSubCatItemList[inditem]['busname'],
                                                      _con.TimeSubCatItemList[inditem]['busaddress']
                                                  );}

                                                   if(_con.TimeSubCatItemList[inditem]
                                                   ["placeorder_type"].toString()=="1")
                                                   {
                                                     setState(() {
                                                       selectedDate = DateTime.now().add(Duration(days: 1));
                                                       listDate = selectedDate.toString().split(" ");
                                                       selectedTime = TimeOfDay.now();
                                                       quantity = 1;
                                                       total = _con.TimeSubCatItemList[inditem]["kitchen_item_amount"];
                                                       sel_ind = inditem;
                                                       var a =selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString().split(":");
                                                       print("dfgh "+a.toString());
                                                       if(int.parse(a[0])<=12)
                                                         timeF="am";
                                                       else
                                                         timeF="pm";
                                                     });
                                                     showModalBottomSheet(
                                                         backgroundColor:
                                                         Color(
                                                             0xFF1E2026),
                                                         context:
                                                         context,
                                                         clipBehavior: Clip
                                                             .antiAlias,
                                                         builder:
                                                             (
                                                             BuildContext
                                                             context) {
                                                           return StatefulBuilder(
                                                               builder: (
                                                                   BuildContext context, sss.StateSetter state) {
                                                                 return Padding(
                                                                   padding: const EdgeInsets.only( top: 10,),
                                                                   child: Wrap(
                                                                     children: [
                                                                       Padding(
                                                                         padding: const EdgeInsets.only(
                                                                             left: 12, right: 12,bottom: 5),
                                                                         child: Row(
                                                                           children: [
                                                                             Image.asset("assets/Template1/image/Foodie/icons/meal.png",
                                                                               height: 30,width: 30,color: Colors.white,),
                                                                             SizedBox(width: 10,),
                                                                             Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                                               children: [
                                                                                 Text("Pre Order Scheduled On",style: f16wB,),
                                                                                 SizedBox(height: 3,),
                                                                                 Text(DateFormat.yMMMEd().format(selectedDate).toString()+", "+
                                                                                     selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString(),style: f12w,)
                                                                               ],
                                                                             )
                                                                           ],
                                                                         ),
                                                                       ),
                                                                       Padding(
                                                                         padding: const EdgeInsets.only(
                                                                             left: 12, right: 12,bottom: 5,top: 5),
                                                                         child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                                           children: [
                                                                             GestureDetector(
                                                                               onTap: (){
                                                                                 _selectDate(context,state);
                                                                                 // Navigator.pop(context);
                                                                               },
                                                                               child: Container(
                                                                                 height: 30,
                                                                                 width: 120,
                                                                                 decoration: BoxDecoration(
                                                                                     color: Color(0xFF0dc89e),
                                                                                     borderRadius: BorderRadius.circular(8)
                                                                                 ),
                                                                                 child: Center(child: Text("Change Schedule",style: f14B,)),
                                                                               ),
                                                                             ),
                                                                           ],
                                                                         ),
                                                                       ),
                                                                       Padding(
                                                                         padding: const EdgeInsets.only(top: 5,bottom: 5),
                                                                         child: Container(
                                                                           color: Color(0xFF23252E),
                                                                           child: Padding(
                                                                             padding: const EdgeInsets.all(12.0),
                                                                             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                               children: [
                                                                                 Text("Item to Order",style: f16wB,),
                                                                                 Padding(
                                                                                   padding: const EdgeInsets.only(top: 10,bottom: 5),
                                                                                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                     children: [
                                                                                       Row(
                                                                                         children: [
                                                                                           Container(
                                                                                             height: 60.0,
                                                                                             width: 60.0,
                                                                                             decoration: BoxDecoration(
                                                                                                 image: DecorationImage(
                                                                                                     image: CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                                                                         _con.TimeSubCatItemList[inditem]["kitchen_item_image"][0]["source"]+"?alt=media"),
                                                                                                     fit: BoxFit.cover)),
                                                                                           ),
                                                                                           SizedBox(width: 7,),
                                                                                           Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                             children: [
                                                                                               Text(_con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString().length>14 ?
                                                                                               _con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString().substring(0,14)+"..." :
                                                                                               _con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString(), style: f15wB),
                                                                                               SizedBox(height: 3,),
                                                                                               Text(
                                                                                                 _con.TimeSubCatItemList[inditem]["busname"], style:f14wB,),
                                                                                               SizedBox(height: 3,),
                                                                                               Text("\u20B9 "+
                                                                                                   _con.TimeSubCatItemList[inditem]["kitchen_item_amount"].toString(), style:f14wB,),
                                                                                             ],
                                                                                           )
                                                                                         ],
                                                                                       ),
                                                                                       Container(
                                                                                         width: 112.0,
                                                                                         decoration:
                                                                                         BoxDecoration(
                                                                                             color: Color(
                                                                                                 0xFF1E2026)),
                                                                                         child: Row(
                                                                                           mainAxisAlignment:
                                                                                           MainAxisAlignment
                                                                                               .spaceAround,
                                                                                           children: <Widget>[
                                                                                             /// Decrease of value item
                                                                                             InkWell(
                                                                                               onTap: () {
                                                                                                 state(() {
                                                                                                   quantity = quantity - 1;
                                                                                                   quantity = quantity > 0 ? quantity : 0;

                                                                                                   total = quantity* _con.TimeSubCatItemList[inditem]["kitchen_item_amount"];
                                                                                                 });
                                                                                               },
                                                                                               child: Container(
                                                                                                 height: 30.0,
                                                                                                 width: 30.0,
                                                                                                 decoration:
                                                                                                 BoxDecoration(
                                                                                                   color: Color(
                                                                                                       0xFF1E2026),
                                                                                                 ),
                                                                                                 child: Center(
                                                                                                     child: Text(
                                                                                                       "-",
                                                                                                       style: TextStyle(
                                                                                                           color: Colors
                                                                                                               .white,
                                                                                                           fontWeight:
                                                                                                           FontWeight
                                                                                                               .w800,
                                                                                                           fontSize:
                                                                                                           16.0),
                                                                                                     )),
                                                                                               ),
                                                                                             ),
                                                                                             Padding(
                                                                                               padding: const EdgeInsets
                                                                                                   .symmetric(
                                                                                                   horizontal:
                                                                                                   18.0),
                                                                                               child: Text(
                                                                                                 quantity.toString(),
                                                                                                 style: TextStyle(
                                                                                                     color: Colors
                                                                                                         .white,
                                                                                                     fontWeight:
                                                                                                     FontWeight
                                                                                                         .w500,

                                                                                                     fontSize:
                                                                                                     16.0),
                                                                                               ),
                                                                                             ),

                                                                                             /// Increasing value of item
                                                                                             InkWell(
                                                                                               onTap: () {
                                                                                                 state(() {
                                                                                                   quantity = quantity + 1;
                                                                                                   total = quantity* _con.TimeSubCatItemList[inditem]["kitchen_item_amount"];
                                                                                                 });
                                                                                               },
                                                                                               child: Container(
                                                                                                 height: 30.0,
                                                                                                 width: 28.0,
                                                                                                 decoration: BoxDecoration(
                                                                                                     color: Color(
                                                                                                         0xFF1E2026)),
                                                                                                 child: Center(
                                                                                                     child: Text(
                                                                                                       "+",
                                                                                                       style: TextStyle(
                                                                                                           color: Colors
                                                                                                               .white,
                                                                                                           fontWeight:
                                                                                                           FontWeight
                                                                                                               .w500,
                                                                                                           fontSize:
                                                                                                           16.0),
                                                                                                     )),
                                                                                               ),
                                                                                             ),
                                                                                           ],
                                                                                         ),
                                                                                       )
                                                                                     ],
                                                                                   ),
                                                                                 ),
                                                                               ],
                                                                             ),
                                                                           ),
                                                                         ),
                                                                       ),
                                                                       Padding(
                                                                         padding: const EdgeInsets.only(top:10.0),
                                                                         child: GestureDetector(
                                                                           onTap: (){
                                                                             _con.Preorder(context,userid.toString(), _con.TimeSubCatItemList[inditem]
                                                                             ["kitchen_item_id"].toString(),widget.typ.toString(),quantity.toString(),_con.TimeSubCatItemList[inditem]["kitchen_item_amount"].toString(),
                                                                                 _con.TimeSubCatItemList[inditem]["page_id"].toString(),listDate[0].toString(),selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString(),

                                                                                 _con.TimeSubCatItemList[inditem]["kitchen_item_name"],1,
                                                                                 _con.TimeSubCatItemList[inditem]['busname'],
                                                                                 _con.TimeSubCatItemList[inditem]['busaddress']
                                                                             );
                                                                           },
                                                                           child: Container(
                                                                             height: 47,
                                                                             width: MediaQuery.of(context).size.width,
                                                                             color: Color(0xFFffd55e),
                                                                             child: Center(child: Text("Proceed To Cart",style: f16B,)),
                                                                           ),
                                                                         ),
                                                                       )


                                                                     ],
                                                                   ),
                                                                 );
                                                               });
                                                         });
                                                   }}
                                                 },
                                                 child: Container(
                                                   height: 25,
                                                   width: 80,
                                                   decoration: BoxDecoration(
                                                       color:  _con.TimeSubCatItemList[inditem]
                                                       ["placeorder_type"].toString()=="0" ?  Color(0xFFffd55e) : Color(0xFF0dc89e),
                                                       borderRadius: BorderRadius.circular(5)
                                                   ),
                                                   child: Center(
                                                     child: Text( _con.TimeSubCatItemList[inditem]
                                                     ["placeorder_type"].toString()=="0" ? "Buy Now" : "Pre Order", style: f14B),
                                                   ),
                                                 ),
                                               )
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
                               thickness: 1,
                             ),
                           ],
                         )
                       ],
                     );
                   },
                 ),
               ) : _con.catdetailstatus == false ? Center(child: Padding(
                padding: const EdgeInsets.only(top:100.0),
                child: Text("No Items",style: f15bB,),
              )):Container(height: 0,),
             ],
           ) :
           _con.statusTimeSubCat == false ? Center(child: Padding(
             padding: const EdgeInsets.only(top:170.0),
             child: Text("No Items",style: f15bB,),
           )):Container(height: 0,),
          ],
        ),
      ),
    );
  }
}

/* final double revealPercent;

  CircularRevealClipper({this.revealPercent});*/
class card3 extends StatefulWidget {
  card3(this.img, this.location, this.price, this.ratting, this.title, this.id);

  String img, title, location, ratting, price, id;

  @override
  _card3State createState() => _card3State();
}

class _card3State extends State<card3> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new FoodDetailT2(
                  title: this.widget.title,
                  id: this.widget.id,
                  image: this.widget.img,
                  location: this.widget.location,
                  price: this.widget.price,
                  owner: "Sofis Kitchen",
                  btn: "Follow Chef",
                ),
            transitionDuration: Duration(milliseconds: 600),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 10, right: 8, left: 8),
            child: Container(
              height: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 95.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: AssetImage(widget.img),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Vegetable Cutlet",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.green[600]),
                                    borderRadius: BorderRadius.circular((2)),
                                  ),
                                  child: Icon(Icons.brightness_1,
                                      color: Colors.green[600], size: 8),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "In Snacks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFffd55e),
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Ratings",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  "28",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Votes",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "\u20B9 15 ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  " (Min 5 Pcs)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                              errorListener: () =>
                                                  new Icon(Icons.error),
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(180.0))),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Rahul",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        Text("Kottayam",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11)),
                                      ],
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/Template1/image/Foodie/icons/add to basket.png",
                              height: 25,
                              width: 25,
                              color: Color(0xFFffd55e),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (s == "unlike") {
                                    s = "like";
                                  } else {
                                    s = "unlike";
                                  }
                                });
                              },
                              child: s == "unlike"
                                  ? Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 23,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Color(0xFFffd55e),
                                      size: 23,
                                    ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Color(0xFFffd55e)),
                          child: Center(
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13.0),
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
          Divider(
            color: Colors.black87,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class card extends StatefulWidget {
  card(this.img, this.location, this.price, this.ratting, this.title, this.id);

  String img, title, location, ratting, price, id;

  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new FoodDetailT2(
                  title: this.widget.title,
                  id: this.widget.id,
                  image: this.widget.img,
                  location: this.widget.location,
                  price: this.widget.price,
                  owner: "Sofis Kitchen",
                  btn: "Follow Chef",
                ),
            transitionDuration: Duration(milliseconds: 600),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 10, right: 8, left: 8),
            child: Container(
              height: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 100.0,
                              width: 95,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: AssetImage(widget.img),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
//                                 height: 22,/
                              margin: EdgeInsets.only(left: 11, top: 89),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  color: Color(0xFF0dc89e)),
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Text(
                                "Pre Order",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Vegetable Cutlet",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.green[600]),
                                    borderRadius: BorderRadius.circular((2)),
                                  ),
                                  child: Icon(Icons.brightness_1,
                                      color: Colors.green[600], size: 8),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "In Snacks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFffd55e),
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Ratings",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  "28",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Votes",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "\u20B9 15 ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  " (Min 5 Pcs)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                              errorListener: () =>
                                                  new Icon(Icons.error),
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(180.0))),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Rahul",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        Text("Kottayam",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11)),
                                      ],
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (s == "unlike") {
                                s = "like";
                              } else {
                                s = "unlike";
                              }
                            });
                          },
                          child: s == "unlike"
                              ? Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 23,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Color(0xFFffd55e),
                                  size: 23,
                                ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Image.asset(
                          "assets/Template1/image/Foodie/icons/add to basket.png",
                          height: 25,
                          width: 25,
                          color: Color(0xFFffd55e),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.black87,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass();
}

class SwitchWidgetClass extends State {
  bool switchControl = false;
  var textHolder = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        // textHolder = 'Switch is ON';
      });

      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        // textHolder = 'Switch is OFF';
      });

      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: .8,
          child: Switch(
            onChanged: toggleSwitch,
            value: switchControl,
            activeColor: Color(0xFFffd55e),
            activeTrackColor: Colors.grey,
            inactiveThumbColor: Color(0xFFffd55e),
            inactiveTrackColor: Colors.grey,
          )),
    ]);
  }
}
