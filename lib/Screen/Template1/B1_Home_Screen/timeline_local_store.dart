import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Data_Model/lunch.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/FIREBASE/Fire_Contro/utils.dart';
import 'package:Butomy/FIREBASE/chatroom.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/store_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/food_bank_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/category_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_home_kitchen.dart';
import 'package:Butomy/Screen/Template2/B1_Home_Screen/Component_Detail_Food/Food_Detail_Screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'Each_Item_Detail_view_page.dart';

class TimelineLocalStoree extends StatefulWidget {

  ScrollController stocontroo;

  TimelineLocalStoree({this.stocontroo});

  @override
  _TimelineLocalStoreeState createState() => _TimelineLocalStoreeState();
}

var s = "unlike";

class _TimelineLocalStoreeState extends StateMVC<TimelineLocalStoree>
    with SingleTickerProviderStateMixin {
  TabController _tabContoller;
  HomeKitchenRegistration _con;

  _TimelineLocalStoreeState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  List<bool> splashcolor = List.filled(1000, false);
  List<bool> _checked = List.filled(1000, false);

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
  void initState() {
    _con.StoreTimelineWalls1("2");
    _con.FoodiMarketTimelineWalls1();
    _con.getFavouriteList();
    // _con.getStoreCategories("2");
    // TODO: implement initState
    super.initState();
    setState(() {
      _con.StoreCategories = Stocat;
      _con.LocalStoreTimeline = STOREDATA;
      _con.TimFoodMarket = TimMARKET;
      _con.popStoreList= popStore;
      _con.FavouriteList= favouriteList;
      sel=1;
    });

    // _con.getStoreCategories("2");
    _tabContoller = TabController(length: 2, vsync: this);
  }
  
  
  Future<void> _getData() async {
    setState(() {
      _con.StoreTimelineWalls1("2");
    });
  }

  Future<void> _getData2() async {
    setState(() {
      _con.FoodiMarketTimelineWalls1();
    });
  }


  @override
  Widget build(BuildContext context) {
    
    var width = MediaQuery.of(context).size.width;
    
    _con.getPurchaseList(userid.toString());
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: RefreshIndicator(
        onRefresh: _getData,
        backgroundColor: Color(0xFF0dc89e),
        color: Colors.black,
        child: SingleChildScrollView(
          controller: widget.stocontroo,
          child: _con.LocalStoreTimeline.length > 0 ||
              _con.StoreCategories.length > 0 ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 0),
                child: Container(
                  height: 120,
                  child: ListView.separated(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: _con.StoreCategories.length,
                    separatorBuilder: (BuildContext context,
                        int index) {
                      return SizedBox(
                        width: 20,
                      );
                    },
                    itemBuilder: (BuildContext context,
                        int index) =>
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) =>
                                    Category_Detail(typ: 2,
                                      image: "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/" +
                                          _con
                                              .StoreCategories[index]["categories_image"]
                                              .toString() +
                                          "?alt=media",
                                      cat_item: _con
                                          .StoreCategories[index]["name"]
                                          .toString(),
                                      cat_id: _con
                                          .StoreCategories[index]["id"],)
                            ));
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 74,
                                width: 74,clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                child:
                                CachedNetworkImage(
                                  imageUrl:"https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/"
                                      +_con.StoreCategories[index]["categories_image"].toString()+"?alt=media",fit: BoxFit.cover,
                                  placeholder:  (
                                      context,
                                      ind) =>
                                      Image
                                          .asset(
                                        "assets/Template1/image/Foodie/post_dummy.jpeg",
                                        fit: BoxFit
                                            .cover,),),//dummy image
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(_con
                                  .StoreCategories[index]["name"]
                                  .toString(), style: f15wB,),

                            ],
                          ),
                        ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Divider(
                color: Colors.black87,
                thickness: 7,
              ),
              Container(
                height: 183,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, right: 5, left: 5, bottom: 15),
                      child: Container(height: 35,
                        width: width,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 32,
                                  width: 260,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:3,right: 3),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              sel=1;
                                            });
                                          },
                                          child: Container(
                                            height: 26,
                                            width: 75,
                                            decoration: BoxDecoration(
                                                color:sel==1 ? Colors.black : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text("Popular",style: f14w ,)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              sel=2;
                                            });
                                          },
                                          child: Container(
                                            height: 26,
                                            width: 95,
                                            decoration: BoxDecoration(
                                                color:sel==2 ? Colors.black : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text("Order Again",style: f14w ,)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              sel=3;
                                            });
                                          },
                                          child: Container(
                                            height: 26,
                                            width: 84,
                                            decoration: BoxDecoration(
                                                color:sel==3 ? Colors.black : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text("Favourites",style: f14w ,)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (BuildContext context,
                                              sss.StateSetter state) {
                                            return Dialog(
                                              child: Container(
                                                color: Colors.grey[800],
                                                height: 200,width: 100,
                                                child: Theme(
                                                  data: Theme.of(context).copyWith(
                                                    unselectedWidgetColor: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 12, right: 12),
                                                    child: Center(
                                                      child: ListView.builder(
                                                          itemCount: 4,
                                                          itemBuilder: (context,ind){
                                                            return Column(
                                                              children: [
                                                                Container(height: 35,
                                                                  child: CheckboxListTile(activeColor: Color(0xFF0dc89e),
                                                                    value: _checked[ind],checkColor: Colors.black,
                                                                    onChanged: (bool value) {
                                                                      state(() {
                                                                        _checked[ind] = value;
                                                                      });
                                                                    },
                                                                    title: Text(ind==0 ? "Fruits": ind==1 ? "Fish" : ind==2 ? "Meat" : "Milks",style: f15w,),
                                                                  ),
                                                                ),
                                                                ind==3 ? Row(mainAxisAlignment : MainAxisAlignment.end,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top:15,bottom: 15),
                                                                      child: FlatButton(
                                                                        onPressed: (){
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: Text("APPLY",style: f14GB,),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ) : Container()
                                                              ],
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    });
                              },
                              child: Row(
                                children: [
                                  Text("View All",style: f13w,),
                                  SizedBox(width: 3,),
                                  Icon(
                                    Icons.filter_list,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),),
                    ),
                    Container(alignment: Alignment.centerLeft,
                      height: 115.0,
                      child: sel==1 ? ListView.builder(
                        itemCount: _con.popStoreList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, popInd) {
                          return InkWell(
                            onTap: () {
                              _con.popStoreList[popInd]['products_status'].toString()=="1" ?
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>EachItemDetailPage(typ: "1",
                                    page_id: _con.popStoreList[popInd]["page_id"].toString(),
                                    product_id: _con.popStoreList[popInd]["kitchen_item_id"].toString(),)
                              )) :  Fluttertoast.showToast(msg: "Product not available !!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 35,
                                backgroundColor: Color(0xFF48c0d8),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                            child: Opacity(
                              opacity:_con.popStoreList[popInd]['products_status'].toString()=="1" ? 1 : .2,
                              child: Padding(
                                padding: const EdgeInsets.only(left:6.0,right: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(clipBehavior: Clip.antiAlias,
                                      height: 75.0,
                                      width: 95.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 6.0,
                                                color: Colors.black12.withOpacity(0.1),
                                                spreadRadius: 2.0)
                                          ]),
                                      child: CachedNetworkImage(
                                        imageUrl:"https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                            _con.popStoreList[popInd]["kitchen_item_image"][0]["source"]+"?alt=media",
                                        fit: BoxFit.cover,
                                        placeholder:  (
                                            context,
                                            ind) =>
                                            Image
                                                .asset(
                                              "assets/Template1/image/Foodie/post_dummy.jpeg",
                                              fit: BoxFit
                                                  .cover,),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(width: 95,
                                      child: Text(_con.popStoreList[popInd]["kitchen_item_name"].toString().length>20 ?
                                      _con.popStoreList[popInd]["kitchen_item_name"].toString().substring(0,20)+"..." :
                                      _con.popStoreList[popInd]["kitchen_item_name"],textAlign: TextAlign.center,
                                        style: f14wB,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                      ) : sel ==2 ?
                      Center(child: Text("Order again List",style: f16wB,))
                          : Container(
                        child: _con.FavouriteList.length > 0 ? ListView.builder(
                          itemCount: _con.FavouriteList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, favInd) {
                            return InkWell(
                              onTap: () {
                                _con.FavouriteList[favInd]['products_status'].toString()=="1" ?
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>EachItemDetailPage(typ: "1",
                                      page_id: _con.FavouriteList[favInd]["page_id"].toString(),
                                      product_id: _con.FavouriteList[favInd]["kitchen_item_id"].toString(),)
                                )) :  Fluttertoast.showToast(msg: "Product not available !!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 35,
                                  backgroundColor: Color(0xFF48c0d8),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                              child: Opacity(
                                opacity:_con.FavouriteList[favInd]['products_status'].toString()=="1" ? 1 : .2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:6.0,right: 6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(clipBehavior: Clip.antiAlias,
                                        height: 75.0,
                                        width: 95.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 6.0,
                                                  color: Colors.black12.withOpacity(0.1),
                                                  spreadRadius: 2.0)
                                            ]),
                                        child: CachedNetworkImage(
                                          imageUrl:"https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                              _con.FavouriteList[favInd]["kitchen_item_image"][0]["source"]+"?alt=media",
                                          fit: BoxFit.cover,
                                          placeholder:  (
                                              context,
                                              ind) =>
                                              Image
                                                  .asset(
                                                "assets/Template1/image/Foodie/post_dummy.jpeg",
                                                fit: BoxFit
                                                    .cover,),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(width: 95,
                                        child: Text(_con.FavouriteList[favInd]["kitchen_item_name"].toString().length>20 ?
                                        _con.FavouriteList[favInd]["kitchen_item_name"].toString().substring(0,20)+"..." :
                                        _con.FavouriteList[favInd]["kitchen_item_name"],textAlign: TextAlign.center,
                                          style: f14wB,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },

                        ) : Center(child: Text("No Favourites Added",style: f16wB,)),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black87,
                thickness: 7,
              ),
              Container(
                height: UserStore.toDouble() * 242,
                child: ListView.builder(
                  itemCount: _con.LocalStoreTimeline.length,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    kitDate = DateTime.parse(
                        _con
                            .LocalStoreTimeline[index]['created_at']);
                    Daatee = DateFormat.yMMMd().format(kitDate);
                    return _con
                        .LocalStoreTimeline[index]["products"]
                        .length > 0 ? Container(
                        height: 240,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 4),
                                            child: Container(
                                              height: 35.0,
                                              width: 35.0,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                      _con
                                                          .LocalStoreTimeline[index]['picture'] !=
                                                          null
                                                          ?
                                                      CachedNetworkImageProvider(
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"
                                                            + _con
                                                            .LocalStoreTimeline[index]['picture']
                                                            .toString() +
                                                            "?alt=media",
                                                        errorListener: () =>
                                                        new Icon(
                                                            Icons
                                                                .error),
                                                      )
                                                          : CachedNetworkImageProvider(
                                                        "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                            "icu.png" +
                                                            "?alt=media",
                                                        errorListener: () =>
                                                        new Icon(
                                                            Icons
                                                                .error),
                                                      ),
                                                      fit: BoxFit
                                                          .cover),
                                                  border: Border
                                                      .all(
                                                      color: _con
                                                          .LocalStoreTimeline[index]['picture'] ==
                                                          null
                                                          ? Color(
                                                          0xFF48c0d8)
                                                          : Colors
                                                          .transparent),
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius
                                                          .circular(
                                                          180.0))),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets
                                                .only(
                                                top: 6, left: 6),
                                            child: Container(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (
                                                              context) =>
                                                              StoreProf(
                                                                currentindex: 1,
                                                                memberdate: Daatee
                                                                    .toString(),
                                                                pagid: _con
                                                                    .LocalStoreTimeline[index]['page_id']
                                                                    .toString(),
                                                                timid: _con
                                                                    .LocalStoreTimeline[index]['timeline_id']
                                                                    .toString(),)
                                                      ));
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <
                                                      Widget>[
                                                    Text(
                                                      _con
                                                          .LocalStoreTimeline[index]['business_name'],
                                                      style: f15wB,
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    _con.LocalStoreTimeline[index]['business_address'] !=null ? Row(
                                                      children: <
                                                          Widget>[
                                                        Icon(
                                                          Icons
                                                              .location_on,
                                                          color: Colors
                                                              .grey,
                                                          size: 14,
                                                        ),
                                                        Text(
                                                            _con.LocalStoreTimeline[index]['business_address'],
                                                            style: f12g)
                                                      ],
                                                    ) : Container(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 15),
                                      userid.toString() != _con
                                          .LocalStoreTimeline[index]["user_id"]
                                          .toString() ? Padding(
                                        padding: const EdgeInsets
                                            .only(top: 8),
                                        child: GestureDetector(
                                            onTap: () {
                                              try {
                                                String chatID = makeChatId(
                                                    timelineIdFoodi
                                                        .toString(),
                                                    _con
                                                        .LocalStoreTimeline[index]["timeline_id"]
                                                        .toString());
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatRoom(
                                                                timelineIdFoodi.toString(),
                                                                NAME,
                                                                _con
                                                                    .LocalStoreTimeline[
                                                                index]
                                                                [
                                                                'device_token']
                                                                    .toString(),
                                                                _con
                                                                    .LocalStoreTimeline[
                                                                index]
                                                                [
                                                                'timeline_id']
                                                                    .toString(),
                                                                chatID,
                                                                _con
                                                                    .LocalStoreTimeline[
                                                                index]
                                                                [
                                                                'username']
                                                                    .toString(),
                                                                _con
                                                                    .LocalStoreTimeline[
                                                                index]
                                                                [
                                                                'business_name']
                                                                    .toString(),
                                                                "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+_con
                                                                    .LocalStoreTimeline[
                                                                index]
                                                                ['picture']
                                                                    .toString()
                                                                    .replaceAll(
                                                                    " ",
                                                                    "%20") +
                                                                    "?alt=media",
                                                                "")));
                                              } catch (e) {
                                                print(e.message);
                                              }
                                            },
                                            child: Icon(
                                              Icons.chat,
                                              size: 22,
                                              color: Color(
                                                  (0xFFffd55e)),
                                            )),
                                      ) : Container(),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets
                                        .only(top: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        /* Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RatingPage()));*/
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            color: Color(
                                                (0xFFffd55e)),
                                            size: 14,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                right: 2),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                    " " + _con
                                                        .LocalStoreTimeline[index]["rating"]
                                                        .toString() +
                                                        " ",
                                                    style: f14gB
                                                ),
                                                Text(
                                                    "Ratings",
                                                    style: f14g
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5.0),
                                child: Container(
                                  height: 145,
                                  child: ListView.builder(
                                    itemCount: _con
                                        .LocalStoreTimeline[index]["products"]
                                        .length,
                                    scrollDirection: Axis
                                        .horizontal,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                        padding: const EdgeInsets
                                            .all(5.0),
                                        child: InkWell(
                                          onTap: () {
                                            _con.LocalStoreTimeline[index]['products'][ind]['products_status'].toString() == "1"
                                                ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EachItemDetailPage(typ: "2",
                                                          page_id: _con
                                                              .LocalStoreTimeline[index]["page_id"].toString(),
                                                          product_id: _con
                                                              .LocalStoreTimeline[index]["products"][ind]["kitchen_item_id"]
                                                              .toString(),)
                                                ))
                                                : Fluttertoast
                                                .showToast(
                                              msg: "Product not available !!!",
                                              toastLength: Toast
                                                  .LENGTH_SHORT,
                                              gravity: ToastGravity
                                                  .TOP,
                                              timeInSecForIosWeb: 35,
                                              backgroundColor: Color(
                                                  0xFF48c0d8),
                                              textColor: Colors
                                                  .white,
                                              fontSize: 16.0,
                                            );
                                            /* Navigator.of(context).push(PageRouteBuilder(
                                              pageBuilder: (_, __, ___) => new FoodDetailT2(
                                                title: this.widget.title,
                                                id: this.widget.id,
                                                image: this.widget.img,
                                                location: this.widget.location,
                                                price: this.widget.price,
                                                owner: "Arya Bhavan",
                                                btn: "Follow Restaurant",
                                              ),
                                              transitionDuration: Duration(milliseconds: 600),
                                              transitionsBuilder:
                                                  (_, Animation<double> animation, __, Widget child) {
                                                return Opacity(
                                                  opacity: animation.value,
                                                  child: child,
                                                );
                                              }));*/
                                          },
                                          child: Opacity(
                                            opacity: _con
                                                .LocalStoreTimeline[index]['products'][ind]['products_status']
                                                .toString() == "0"
                                                ? .2
                                                : 1,
                                            child: Container(
                                              height: 135.0,
                                              width: 280,
                                              decoration: BoxDecoration(
                                                color: Color(
                                                    0xFF1E2026),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors
                                                          .black
                                                          .withOpacity(
                                                          0.6),
                                                      blurRadius: 6.0,
                                                      spreadRadius: 0.0)
                                                ],
                                                borderRadius: BorderRadius
                                                    .all(Radius
                                                    .circular(
                                                    5.0)),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 5.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <
                                                        Widget>[
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: <
                                                            Widget>[
                                                          Column(
                                                            children: <
                                                                Widget>[
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 10.0),
                                                                child: Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      height: 95.0,
                                                                      width: 100.0,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .all(
                                                                              Radius
                                                                                  .circular(
                                                                                  10.0)),
                                                                          image: DecorationImage(
                                                                              image: CachedNetworkImageProvider(
                                                                                  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                                                      _con
                                                                                          .LocalStoreTimeline[index]['products'][ind]
                                                                                      ["kitchen_item_image"][0]["source"] +
                                                                                      "?alt=media"),
                                                                              fit: BoxFit
                                                                                  .cover)),
                                                                    ),
                                                                    _con
                                                                        .LocalStoreTimeline[index]['products'][ind]
                                                                    ["kitchen_hotdeal_status"]
                                                                        .toString() ==
                                                                        "1"
                                                                        ? Container(
                                                                      // height: 40,
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                          top: 0,
                                                                          bottom: 71),
                                                                      padding: EdgeInsets
                                                                          .symmetric(
                                                                          horizontal: 8,
                                                                          vertical: 3),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .only(
                                                                              bottomRight: Radius
                                                                                  .circular(
                                                                                  10),
                                                                              topLeft: Radius
                                                                                  .circular(
                                                                                  10)),
                                                                          color: Colors
                                                                              .red[500]),
                                                                      alignment: AlignmentDirectional
                                                                          .bottomCenter,
                                                                      child: Center(
                                                                        child: Text(
                                                                            "Hot Deal",
                                                                            style: f12wB
                                                                        ),
                                                                      ),
                                                                    )
                                                                        : Container(),
                                                                    /*ind == "0" || ind=="2" ? Container(
//                                 height: 22,/
                                                                    margin: EdgeInsets.only(left: 11, top: 84),
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 10, vertical: 3),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius.all(Radius.circular(2)),
                                                                        color: Color(0xFF0dc89e)),
                                                                    alignment: AlignmentDirectional.bottomCenter,
                                                                    child: Center(
                                                                      child: Text(
                                                                          "Pre Order",
                                                                          style: f14B
                                                                      ),
                                                                    ),
                                                                  ) :*/
                                                                    GestureDetector(
                                                                      onTap: (){
                                                                      if(_con.LocalStoreTimeline[index]['products'][ind]['products_status'].toString() == "1"){if(_con.LocalStoreTimeline[index]['products'][ind]
                                                                      ["placeorder_type"].toString()=="0")
                                                                      {_con.buyNow(context,userid.toString(),_con.LocalStoreTimeline[index]['products'][ind]
                                                                      ["kitchen_item_id"].toString(),"1","1",_con.LocalStoreTimeline[index]['products'][ind]
                                                                      ["kitchen_item_amount"].toString(),_con.LocalStoreTimeline[index]["page_id"].toString(),

                                                                          _con.LocalStoreTimeline[index]['products'][ind]["kitchen_item_name"],1,
                                                                          _con.LocalStoreTimeline[index]['business_name'],
                                                                          _con.LocalStoreTimeline[index]['business_address']
                                                                      );}

                                                                      if(_con.LocalStoreTimeline[index]['products'][ind]
                                                                      ["placeorder_type"].toString()=="1"){
                                                                        setState(() {
                                                                          selectedDate = DateTime.now().add(Duration(days: 1));
                                                                          listDate = selectedDate.toString().split(" ");
                                                                          selectedTime = TimeOfDay.now();
                                                                          quantity = _con.LocalStoreTimeline[index]['products'][ind]
                                                                          ["products_quantity"];
                                                                          total = _con.LocalStoreTimeline[index]['products'][ind]
                                                                          ["kitchen_item_amount"];
                                                                          sel_ind = ind;
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
                                                                                                                            _con.LocalStoreTimeline[index]['products'][ind]
                                                                                                                            ["kitchen_item_image"][0]["source"]+"?alt=media"),
                                                                                                                        fit: BoxFit.cover)),
                                                                                                              ),
                                                                                                              SizedBox(width: 7,),
                                                                                                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Text(_con.LocalStoreTimeline[index]['products'][ind]["kitchen_item_name"].toString().length>14 ?
                                                                                                                  _con.LocalStoreTimeline[index]['products'][ind]["kitchen_item_name"].toString().substring(0,14)+"..." :
                                                                                                                  _con.LocalStoreTimeline[index]['products'][ind]
                                                                                                                  ["kitchen_item_name"].toString(), style: f15wB),
                                                                                                                  SizedBox(height: 3,),
                                                                                                                  Text(
                                                                                                                    _con.LocalStoreTimeline[index]['business_name'], style:f14wB,),
                                                                                                                  SizedBox(height: 3,),
                                                                                                                  Text("\u20B9 "+
                                                                                                                      _con.LocalStoreTimeline[index]['products'][ind]
                                                                                                                      ["kitchen_item_amount"].toString(), style:f14wB,),
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

                                                                                                                      total = quantity* _con.LocalStoreTimeline[index]['products'][ind]["kitchen_item_amount"];
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
                                                                                                                      total = quantity* _con.LocalStoreTimeline[index]['products'][ind]["kitchen_item_amount"];
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
                                                                                                _con.Preorder(context,userid.toString(),_con.LocalStoreTimeline[index]['products'][ind]
                                                                                                ["kitchen_item_id"].toString(),"2",quantity.toString(),_con.LocalStoreTimeline[index]['products'][ind]
                                                                                                ["kitchen_item_amount"].toString(),_con.LocalStoreTimeline[index]["page_id"].toString(),listDate[0].toString(),
                                                                                                    selectedTime.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "").toString(),

                                                                                                    _con.LocalStoreTimeline[index]['products'][ind]["kitchen_item_name"],1,
                                                                                                    _con.LocalStoreTimeline[index]['business_name'],
                                                                                                    _con.LocalStoreTimeline[index]['business_address']
                                                                                                );
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 47,
                                                                                                width: width,
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
                                                                      }
                                                                      }
                                                                    },
                                                                      child: Container(
//height: 22,/
                                                                        margin: EdgeInsets.only(left: 11, top: 84),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: 10, vertical: 3),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                            BorderRadius.all(Radius.circular(2)),
                                                                            color:  _con.LocalStoreTimeline[index]['products'][ind]
                                                                            ["placeorder_type"].toString()=="0" ? Color(0xFFffd55e) : Color(0xFF0dc89e)),
                                                                        alignment: AlignmentDirectional.bottomCenter,
                                                                        child: Center(
                                                                          child: Text(
                                                                              _con.LocalStoreTimeline[index]['products'][ind]
                                                                              ["placeorder_type"].toString()=="0" ?  "Buy Now" : "Pre Order",
                                                                              style: f14B
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                top: 5),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                            _con
                                                                                .LocalStoreTimeline[index]['products'][ind]["kitchen_item_name"]
                                                                                .toString()
                                                                                .length >
                                                                                14
                                                                                ?
                                                                            _con
                                                                                .LocalStoreTimeline[index]['products'][ind]["kitchen_item_name"]
                                                                                .toString()
                                                                                .substring(
                                                                                0,
                                                                                14) +
                                                                                "..."
                                                                                :
                                                                            _con
                                                                                .LocalStoreTimeline[index]['products'][ind]
                                                                            ["kitchen_item_name"]
                                                                                .toString(),
                                                                            style: f15wB
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Container(
                                                                          height: 15,
                                                                          width: 15,
                                                                          decoration: BoxDecoration(
                                                                            border:
                                                                            Border
                                                                                .all(
                                                                                color: _con
                                                                                    .LocalStoreTimeline[index]['products'][ind]
                                                                                ["products_type"]
                                                                                    .toString() ==
                                                                                    "0"
                                                                                    ? Colors
                                                                                    .green[600]
                                                                                    : Colors
                                                                                    .red[600]),
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                (2)),
                                                                          ),
                                                                          child: Icon(
                                                                              Icons
                                                                                  .brightness_1,
                                                                              color: _con
                                                                                  .LocalStoreTimeline[index]['products'][ind]
                                                                              ["products_type"]
                                                                                  .toString() ==
                                                                                  "0"
                                                                                  ? Colors
                                                                                  .green[600]
                                                                                  : Colors
                                                                                  .red[600],
                                                                              size: 8),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    /* Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) => RatingPage()));*/
                                                                  },
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[   Text(
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
                                                                          " ("+_con.LocalStoreTimeline[index]['products'][ind]
                                                                          ["products_quantity"].toString()+minPic+")",
                                                                          style: f14gB
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                        "\u20B9 " +
                                                                            _con
                                                                                .LocalStoreTimeline[index]['products'][ind]
                                                                            ["kitchen_item_amount"]
                                                                                .toString(),
                                                                        style: f14wB
                                                                    ),

                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 13),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          if(_con.LocalStoreTimeline[index]['products'][ind]['products_status'].toString() == "1"){ _con
                                                                              .AddtoPurchaseList(
                                                                              userid
                                                                                  .toString(),
                                                                              _con
                                                                                  .LocalStoreTimeline[index]['products'][ind]
                                                                              ["kitchen_item_id"]
                                                                                  .toString(),
                                                                              "2",
                                                                              "1",
                                                                              _con
                                                                                  .LocalStoreTimeline[index]['products'][ind]
                                                                              ["kitchen_item_amount"]
                                                                                  .toString(),
                                                                              _con
                                                                                  .LocalStoreTimeline[index]["page_id"]
                                                                                  .toString());
                                                                          setState(() {
                                                                            splashcolor[index] =
                                                                            true;
                                                                          });}
                                                                        },
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/Template1/image/Foodie/icons/shopping-basket.png",
                                                                          height: 24,
                                                                          width: 24,
                                                                          color: splashcolor[index]
                                                                              ? Color(
                                                                              0xFF48c0d8)
                                                                              : Color(
                                                                              0xFFffd55e),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 70,
                                                                      ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if(_con.LocalStoreTimeline[index]['products'][ind]['products_status'].toString() == "1"){  if (_con.LocalStoreTimeline[index]['products'][ind]
                                                    ["is_favorite"]==true) {
                                                      print(" tap 111111111111111");
                                                      setState(() {
                                                        _con.LocalStoreTimeline[index]['products'][ind]
                                                        ["is_favorite"]=false;
                                                      });
                                                    } else {
                                                      print(" tap 2222222222222222");
                                                      setState(() {
                                                        _con.LocalStoreTimeline[index]['products'][ind]
                                                        ["is_favorite"]=true;
                                                      });
                                                    }
                                                    _con.addFavourite(_con.LocalStoreTimeline[index]['products'][ind]
                                                    ["kitchen_item_id"].toString());}
                                                  },
                                                  child: _con.LocalStoreTimeline[index]['products'][ind]
                                                  ["is_favorite"]==true
                                                      ? Icon(Icons.favorite,
                                                      color: Color(0xFFffd55e))
                                                      : Icon(Icons.favorite_border,
                                                      color: Colors.white),
                                                ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
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
                                      );
                                    },
                                  ),
                                )
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              color: Colors.black87,
                              thickness: 7,
                            ),
                          ],
                        )) : Container();
                  },
                ),
              ),
            ],
          ) :
          Padding(
            padding: const EdgeInsets.only(top: 180.0),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFF48c0d8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
