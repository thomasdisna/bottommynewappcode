import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Data_Model/lunch.dart';
import 'package:Butomy/Screen/Template2/B1_Home_Screen/Component_Detail_Food/Food_Detail_Screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'Each_Item_Detail_view_page.dart';
import 'Search_Screen/Search_Screen_T1.dart';

class BusinessHomeKitchenMenu extends StatefulWidget {
  BusinessHomeKitchenMenu({this.pagid,this.timid,this.controo});
  String pagid,timid;
  ScrollController controo;

  @override
  _BusinessHomeKitchenMenuState createState() =>
      _BusinessHomeKitchenMenuState();
}

var s = "unlike";
String temp = "5 Pcs + 2 Tomato Ketchup";
List<String> catArr = ["All","Snacks","Cakes","Meals"];
List categoryAll = ["All"];
class _BusinessHomeKitchenMenuState extends StateMVC<BusinessHomeKitchenMenu> {
  HomeKitchenRegistration _con;
  _BusinessHomeKitchenMenuState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  int currentind;

  String cat_item;
  List<bool> splashcolor = List.filled(1000, false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.HomeKitchenProductList("1",widget.pagid,widget.timid);
    _con.getPageMenu(widget.pagid);
    setState(() {
      currentind=0;
      sel =1;
    });
    print("4444444444444444 "+_con.KitchenCategories.toString());
    // _con.getKitchenCategories("1");
    // _con.BusinessTimelineCategoryWiseListMenu("1",_con.KitchenCategories[0]["id"].toString(),widget.pagid);
    // _con.HomeKitchenProductList("1",widget.pagid,widget.timid);

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

  List<bool> _checked = List.filled(1000, false);



  @override
  Widget build(BuildContext context) {
    if(_con.MENULIST.length>0 )
{    _con.MENULIST[main_currentind]["pro_count"] ==0 ? null :
_con.BusinessTimelineSubCategoryItemListMenu("1",_con.MENULIST[main_currentind]["subcategory"][currentind]["id"].toString(),widget.pagid);
}
    var _foodList = Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 5, right: 5, left: 5, bottom: 15),
            child: Container(height: 35,
              width: MediaQuery.of(context).size.width,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 32,
                        width: 193,
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
                                  width: 112,
                                  decoration: BoxDecoration(
                                      color:sel==2 ? Colors.black : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: Text("Recommended",style: f14w ,)),
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
                                                          title: Text(ind==0 ? "Meals": ind==1 ? "Cakes" : ind==2 ? "Snacks" : "Diet Food",style: f15w,),
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
            // height: 115.0,
            child: sel==1   ? Column(
              children: [
                _con.statusHKItem==true ? Container(
                  height: 115.0,
                  child: Center(
                    child: Visibility(
                        visible: _con.statusHKItem,
                        child: CircularProgressIndicator()
                    ),
                  ),
                ) : Container(),
    _con.HKProductList.length>0 && _con.statusHKItem==false  ?
    Container(height: 115.0,alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    itemCount: _con.HKProductList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, popInd) {
                      return InkWell(
                        onTap: () {
                          _con.HKProductList[popInd]['products_status'].toString()=="1" ?
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>EachItemDetailPage(typ: "1",
                                page_id: _con.HKProductList[popInd]["page_id"].toString(),
                                product_id: _con.HKProductList[popInd]["kitchen_item_id"].toString(),)
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
                          opacity:_con.HKProductList[popInd]['products_status'].toString()=="1" ? 1 : .2,
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
                                        _con.HKProductList[popInd]["kitchen_item_image"][0]["source"]+"?alt=media",
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
                                  child: Text(_con.HKProductList[popInd]["kitchen_item_name"].toString().length>20 ?
                                  _con.HKProductList[popInd]["kitchen_item_name"].toString().substring(0,20)+"..." :
                                  _con.HKProductList[popInd]["kitchen_item_name"],textAlign: TextAlign.center,
                                    style: f14wB,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },

                  )
                ) : _con.statusHKItem==false ?
    Container(
      padding: EdgeInsets.only(top: 150),
        child: Center(child: Text("No Items",style: f16bB,))) : Container(),
              ],
            ) :
            sel ==2 ?
            Center(child: Text("Recommended Items",style: f16wB,))
                : Container(),

          ),
        ],
      ),
    );
    var _category = _con.MENULIST.length>0  && _con.statusCart ==false? Column(
      children: [
        Container(
          height: 30,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:_con.MENULIST.length,

                itemBuilder: (BuildContext context, int index) {

                  return _con.MENULIST[index]["pro_count"] ==0 ? Container() : GestureDetector(
                      onTap: () {
                        setState(() {
                          main_currentind=index;
                          currentind=0;
                          MenuSubCat = _con.MENULIST[index]["subcategory"].length >0 ?_con.MENULIST[index]["subcategory"] : [];
                        });
                        // _con.BusinessTimelineCategoryWiseListMenu("1",_con.KitchenCategories[index]["id"].toString(),widget.pagid);
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left: index==0 ? 0 : 3,right: 3),
                        child: Container(
                            decoration: BoxDecoration(
                                color: main_currentind==index ? Color(0xFFffd55e) : Color(0xFF23252E),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                              child: Text(_con.MENULIST[index]["name"],style: main_currentind==index ? f16B : f16wB,),
                            )),
                      ));
                }
            ),
          ),
        ),
        MenuSubCat.length>0 ?  Divider(
          color: Colors.black87,
          thickness: 1,
        ) : Container(),
      ],
    )

        :_con.statusCart ==false ? Text("No Data",style: f16bB,) : Container();

    var _body = Column(
      children: <Widget>[
        _foodList,
        MenuSubCat.length>0 ?  Divider(
          color: Colors.black87,
          thickness: 1,
        ) : Container(),
        _category,
        Container( height: 133,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: MenuSubCat.length,
              itemBuilder: (context,inddd){
            return GestureDetector(
              onTap: (){
                setState(() { currentind=inddd;});
                _con.BusinessTimelineSubCategoryItemListMenu("1",MenuSubCat[inddd]["id"].toString(),widget.pagid);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: currentind==inddd ? Color(0xFF23252E) : Colors.transparent,
                  boxShadow:currentind==inddd ? <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 2,
                    ),
                  ] : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left:12,right: 12,bottom: 5),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/"+ MenuSubCat[inddd]["categories_image"].toString()+"?alt=media"),
                        radius: 36,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 80,
                        child: Text(
                        MenuSubCat[inddd]["name"].toString(),
                          style: currentind==inddd ? f15bB : f15wB,textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        MenuSubCat.length>0 ? Divider(
          color: Colors.black87,
          thickness: 1,
        ) : Container(),
        _con.catdetailstatus ==true ? Center(
          child: Visibility(
              visible: _con.catdetailstatus,
              child: Container(
                  margin: EdgeInsets.only(top: 80, ),
                  child: CircularProgressIndicator()
              )
          ),
        ) : Container(),
        _con.TimeSubCatItemList.length>0 && _con.catdetailstatus==false  ? Container(
          height: _con.TimeSubCatItemList.length.toDouble()*165,
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
                                typ: "1",product_id: _con.TimeSubCatItemList[inditem]["kitchen_item_id"].toString(),)
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
                              height: 135.0,
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
                                                Text(_con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString().length>14 && userid.toString()!= _con.TimeSubCatItemList[inditem]["user_id"].toString() ?  _con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString().substring(0,14)+"..."
                                                    : userid.toString()== _con.TimeSubCatItemList[inditem]["user_id"].toString() && _con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString().length>23 ? _con.TimeSubCatItemList[inditem]["kitchen_item_name"].toString().substring(0,23)+"..." : _con.TimeSubCatItemList[inditem]["kitchen_item_name"],
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
                                                "In " + _con.TimeSubCatItemList[inditem]
                                                ["products_category"][0]["parent_category_name"],
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
                                            userid.toString()!= _con.TimeSubCatItemList[inditem]["user_id"].toString() ?
                                            GestureDetector(
                                              onTap:(){
                                                if(_con.TimeSubCatItemList[inditem]['products_status'].toString()=="1")  { _con.AddtoPurchaseList(userid.toString(), _con.TimeSubCatItemList[inditem]
                                                ["kitchen_item_id"].toString(),"1","1",
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
                                            ) : Container(height: 0,),
                                            userid.toString()!= _con.TimeSubCatItemList[inditem]["user_id"].toString() ? SizedBox(
                                              width: 15,
                                            ) : Container(height: 0,),
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
                                        userid.toString()!= _con.TimeSubCatItemList[inditem]["user_id"].toString() ?  GestureDetector(
                                          onTap:(){
                                            if(_con.TimeSubCatItemList[inditem]['products_status'].toString()=="1") { if(_con.TimeSubCatItemList[inditem]
                                            ["placeorder_type"].toString()=="0")
                                            {_con.buyNow(context,userid.toString(), _con.TimeSubCatItemList[inditem]
                                            ["kitchen_item_id"].toString(),"1","1",
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
                                                                      ["kitchen_item_id"].toString(),"1",quantity.toString(),_con.TimeSubCatItemList[inditem]["kitchen_item_amount"].toString(),
                                                                          _con.TimeSubCatItemList[inditem]["page_id"].toString(),listDate[0].toString(),selectedTime.toString().
                                                                          replaceAll("TimeOfDay(", "").replaceAll(")", "").toString(),

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
                                        ) : Container(height: 0,),
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
        ) : _con.catdetailstatus == false ?
       /* Center(child: Padding(
          padding: const EdgeInsets.only(top:100.0),
          child: Text("No Items",style: f15bB,),
        ))*/ Container():Container(height: 0,),
      ],
    );

    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        controller: widget.controo,
        scrollDirection: Axis.vertical,
        child: _body,
      ),
    );
  }
}

class cardLunch extends StatelessWidget {
  lunch _lunch;

  cardLunch(this._lunch);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new FoodDetailT2(
              title: _lunch.title,
              id: _lunch.id,
              image: _lunch.image,
              location: _lunch.location,
              price: _lunch.price,
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
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5,
          top: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60.0,
              width: 80.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(_lunch.image), fit: BoxFit.cover),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.black12.withOpacity(0.1),
                        spreadRadius: 2.0)
                  ]),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80,
                  child: Text(
                    _lunch.title,
                    textAlign: TextAlign.center,
                    style: f14w,
                  ),
                ),
              ],
            ),
          ],
        ),
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
              height: 110.0,
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
                          width: 90.0,
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
                                    widget.title,
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
                              style: f14w,
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
                                    style: f14gB
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                    "Ratings",
                                    style: f14g
                                ),
                                SizedBox(width: 3),
                                Text(
                                  "28",
                                  style: f14gB,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Votes",
                                  style: f14g,
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
                                  style: f14wB,
                                ),
                                Text(
                                  " (Min 5 Pcs)",
                                  style: f11w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              temp.substring(0, 18) + "...",
                              style: f14g,
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
                        Container(
                          height: 25.0,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              color: Color(0xFF0dc89e)),
                          child: Center(
                            child: Text(
                              "Pre Order",
                              style: f14,
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

class card2 extends StatefulWidget {
  card2(this.img, this.location, this.price, this.ratting, this.title, this.id);

  String img, title, location, ratting, price, id;

  @override
  _card2State createState() => _card2State();
}

class _card2State extends State<card2> {
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
              height: 110.0,
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
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: AssetImage(widget.img),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              // height: 40,
                              margin: EdgeInsets.only(top: 0,
                                  bottom: 78
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                  color: Colors.red[500]),
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Center(
                                child: Text(
                                  "Hot Deal",
                                  style: f12wB,
                                ),
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
                                    widget.title,
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
                                style: f14w
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
                                    style: f14wB
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                    "Ratings",
                                    style:f14w
                                ),
                                SizedBox(width: 3),
                                Text(
                                    "28",
                                    style: f14wB
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                    "Votes",
                                    style: f14w
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                    "\u20B9 30 ",
                                    style: f14wBLT
                                ),
                                Text(
                                  "  \u20B9 15 ",
                                  style: f14wB,
                                ),
                                Text(
                                    " (Min 5 Pcs)",
                                    style: f11w
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                temp.substring(0, 18) + "...",
                                style: f14g
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
                        Container(
                          height: 25.0,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              color: Color(0xFF0dc89e)),
                          child: Center(
                            child: Text(
                              "Pre Order",
                              style: f14,
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
              height: 110.0,
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
                          width: 90.0,
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
                                    widget.title,
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
                                style: f14w
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
                                    style: f14wB
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                    "Ratings",
                                    style: f14w
                                ),
                                SizedBox(width: 3),
                                Text(
                                    "28",
                                    style: f14wB
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                    "Votes",
                                    style: f14w
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
                                    style: f14wB
                                ),
                                Text(
                                    " (Min 5 Pcs)",
                                    style: f11w
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                temp.substring(0, 18) + "...",
                                style: f14g
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
                                style: f14
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
