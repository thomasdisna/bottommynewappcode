import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_account_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_business_info.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_compliances.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_inventory.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_order_order_detail.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_partener_faqs.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_past_orders.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_point_of_contacts.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_preparation_time.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_reports.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_homekit_settings.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_business_order_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/qr_code.dart';
import 'package:Butomy/Screen/Template1/OnBoarding_Screen/bus_order_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'Business_HomeKitchen_Product_List_page.dart';
import 'package:intl/intl.dart';
import 'Search_Screen/Search_Screen_T1.dart';
import 'business_homekitchen_chat.dart';
import 'business_home_kitchen_new_entry.dart';
import 'business_home_kitchen_timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Components/widget_style.dart';
class BusinessHomeKitchenOrderPage extends StatefulWidget {
  BusinessHomeKitchenOrderPage({Key key,this.pagid,this.timid,this.memberdate})   : super(key: key);
  String pagid,timid,memberdate;

  @override
  _BusinessHomeKitchenOrderPageState createState() => _BusinessHomeKitchenOrderPageState();
}

class _BusinessHomeKitchenOrderPageState extends StateMVC<BusinessHomeKitchenOrderPage> {

  HomeKitchenRegistration _con;
  _BusinessHomeKitchenOrderPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  bool switchControlActInact = false;
  var textHolder = 'Switch is OFF';


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
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("PPPPPPPPPPPPP "+widget.pagid);
    _con.getBusinessOrderList(widget.pagid);
    _con.getOrderStatus();
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
      _con.getBusinessOrderList(widget.pagid);
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                visible: _con.orderStatus,
                child: Container(
                    padding: EdgeInsets.only(top: height/ 2.5, ),
                    child: CircularProgressIndicator()
                )
            ),
          ),
          _con.BusinessOrderList.length>0 && _con.orderStatus==false  ? Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(color: Colors.black,backgroundColor: Color(0xFF0dc89e),),
              onRefresh: _getData,
              controller: _refreshController,
              onLoading: _onLoading,
              child: ListView.builder(
                // scrollDirection: Axis.vertical,
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _con.BusinessOrderList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6.0,
                                color: Colors.black12.withOpacity(0.1),
                                spreadRadius: 2.0)
                          ]
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:15, top:  _con.BusinessOrderList[index]["order_status"].toString()=="6" ||_con.BusinessOrderList[index]["order_status"].toString()=="5" ? 0 : 12,),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("# "+_con.BusinessOrderList[index]["order_id"].toString(),style: f16B,),
                                    Row(
                                      children: [
                                        _con.BusinessOrderList[index]["order_status"].toString()=="6" ||
                                            _con.BusinessOrderList[index]["order_status"].toString()=="5" ? FlatButton(
                                          onPressed: (){},
                                          splashColor: Colors.grey[400],
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/Template1/image/Foodie/icons/Delivery-Warrior.png",height: 20,color:_con.BusinessOrderList[index]["order_status"].toString()=="6" ? Colors.green[400] : Colors.black,),
                                              SizedBox(width: 10,),
                                              Text("Track Driver",style:_con.BusinessOrderList[index]["order_status"].toString()=="6" ? f13GGB : f13B,)
                                            ],
                                          ),
                                        ) :Container(),

                                        Container(width: MediaQuery.of(context).size.width/2.8,
                                          color: _con.BusinessOrderList[index]["order_status"].toString()=="1"  ? Colors.orange[700] : _con.BusinessOrderList[index]["order_status"].toString()=="5" ?
                                          Colors.blue[700] : _con.BusinessOrderList[index]["order_status"].toString()=="6" ? Colors.green[400] : Colors.transparent,
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 20, top:  5,bottom: 5),
                                            child: Text(
                                              _con.BusinessOrderList[index]["order_status"].toString()=="1"  ? "NEW ORDER" :
                                              _con.BusinessOrderList[index]["order_status"].toString()=="5"  ?"PREPARING" :
                                              _con.BusinessOrderList[index]["order_status"].toString()=="6"  ? "READY" : "",
                                              style: f14wB,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(crossAxisAlignment : CrossAxisAlignment.start,
                                        children: [
                                          Text(DateFormat.yMMMd().format(DateTime.parse(
                                              _con.BusinessOrderList[index]["order_date"]))+"  |  "+DateFormat.jm().format(DateTime.parse(
                                              _con.BusinessOrderList[index]["order_date"])),style: f13,),
                                          SizedBox(height: 4,),
                                          Container(
                                            width: width-115,
                                            height:_con.BusinessOrderList[index]["products"].length.toDouble()* 20,
                                            child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: _con.BusinessOrderList[index]["products"].length,
                                                itemBuilder: (context,item){
                                                  return Container(
                                                      child: Text(_con.BusinessOrderList[index]["products"][item]["products_name"]+"  x  "
                                                          +_con.BusinessOrderList[index]["products"][item]["products_quantity"].toString(),style: f14,)
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                      Text("\u20B9"+_con.BusinessOrderList[index]["amount"].toString(),style: f18B,)
                                    ],
                                  ),
                                ),

                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _con.BusinessOrderList[index]["order_status"].toString()=="1" ||
                                        _con.BusinessOrderList[index]["order_status"].toString()=="5"?
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 3.0,),
                                      child: MaterialButton(height: 30,
                                        splashColor: Color(0xFF48c0d8),
                                        onPressed: (){
                                          _con.BusinessOrderList[index]["order_status"].toString()=="1" ?
                                          _con.updateOrderStatus(_con.BusinessOrderList[index]["order_id"].toString(), "5") :
                                          _con.BusinessOrderList[index]["order_status"].toString()=="5" ?
                                          _con.updateOrderStatus(_con.BusinessOrderList[index]["order_id"].toString(), "6") : null;
                                        setState(() {
                                          _con.BusinessOrderList[index]["order_status"].toString()=="1" ? _con.BusinessOrderList[index]["order_status"]=5:
                                          _con.BusinessOrderList[index]["order_status"].toString()=="5" ? _con.BusinessOrderList[index]["order_status"]=6 :null;
                                        });
                                          },
                                        color:_con.BusinessOrderList[index]["order_status"].toString()=="1" ? Colors.green[400] : Colors.yellow[700],
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 35, right: 35),
                                          child: Text(
                                            _con.BusinessOrderList[index]["order_status"].toString()=="1" ? "ACCEPT ORDER"
                                                :_con.BusinessOrderList[index]["order_status"].toString()=="5" ? "ORDER READY":
                                            "",
                                            style: f14wB,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ) : _con.BusinessOrderList[index]["order_status"].toString()=="6" ?
                                    Text("FOOD READY",style: f14GGB,) : Container(),
                                    MaterialButton(height: 25,
                                      splashColor: Color(0xFFffd55e),
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => FoodiOrderDetail(order: _con.BusinessOrderList[index]["order_id"].toString(),)
                                        ));
                                        /*Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => BuisnessOrderAkhil()
                                        ));*/
                                      },
                                      child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("View Details",style: TextStyle(color: Color(0xFF0dc89e)),),
                                          SizedBox(width: 2,),
                                          Icon(Icons.keyboard_arrow_right,color: Color(0xFF0dc89e),size: 22,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          _con.BusinessOrderList[index]["order_type"].toString()=="preorder" ?
                          Container(width: width,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(left:15,right: 15,bottom: 7,top: 7),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Pre Order Pickup Schedule",style: f14,),
                                    Text(DateFormat.yMMMd().format(DateTime.parse(
                                        _con.BusinessOrderList[index]["delivery_date"]))+"  "+DateFormat.jm().format(DateTime.parse(
                                        _con.BusinessOrderList[index]["delivery_date"])),style: f13,),
                                  ],
                                ),
                              )) : Container(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ) : _con.orderStatus == false ? Center(child: Padding(
            padding: EdgeInsets.only(top: height/ 2.5, ),
            child: Text("No Orders Yet...",style: f15bB,),
          )):Container(height: 0,),
        ],
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