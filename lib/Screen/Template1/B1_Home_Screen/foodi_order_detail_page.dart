import 'dart:async';

import 'package:Butomy/Components/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

class FoodiUserOrderDetail extends StatefulWidget {

  FoodiUserOrderDetail({this.order});

  String order;

  @override
  _FoodiUserOrderDetailState createState() => _FoodiUserOrderDetailState();
}

class _FoodiUserOrderDetailState extends StateMVC<FoodiUserOrderDetail> {

  HomeKitchenRegistration _con;
  _FoodiUserOrderDetailState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.foodiOrderDetail(widget.order);
    // _onAddMarkerButtonPressed();
  }

  List<Polyline> _polyLine = [];

  getPoints() {
    return [
      LatLng(6.862472, 79.859482),
      LatLng(6.862258, 79.862325),
      LatLng(6.863121, 79.863644),
      LatLng(6.864538, 79.865039),
      LatLng(6.865124, 79.864546),
      LatLng(6.866451, 79.864667),
      LatLng(6.867303, 79.86544),
      LatLng(6.867899, 79.865826),
      LatLng(6.867867, 79.866727),
      LatLng(6.864884, 79.870333),
      LatLng(6.861859, 79.873112),
      LatLng(6.861593, 79.87499),
      LatLng(6.860837, 79.876427),

    ];
  }

  final Set<Marker> _markers = {};
  final Set<Polyline>_polyline={};

//add your lat and lng where you wants to draw polyline
  LatLng _lastMapPosition = LatLng(userLocation.latitude,userLocation.longitude);

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
        visible: true,



      ));
      _polyline.add(Polyline(
        polylineId: PolylineId(_lastMapPosition.toString()),
        visible: true,
        //latlng is List<LatLng>
        points: [
          LatLng(userLocation.latitude,userLocation.longitude),
          LatLng(9.9682, 76.3182),
        ],
        endCap: Cap.buttCap,
        startCap: Cap.roundCap,
        width: 2,
        color: Colors.black,
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Color(0xFF1E2026),
      appBar:  AppBar(
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
      body: _con.orderDetailStatus==false && _con.OrderDetail!=null ?
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12,),
              Container(
                  height: h/1.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[800],
                  child: GoogleMap(
                    polylines:_polyline,
                    markers: _markers,
                    mapType: MapType.normal,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(userLocation.latitude,userLocation.longitude),
                      zoom: 10.1,
                    ),zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      setState(() {
                        _markers.add(Marker(
                          // This marker id can be anything that uniquely identifies each marker.
                          markerId: MarkerId(_lastMapPosition.toString()),
                          //_lastMapPosition is any coordinate which should be your default
                          //position when map opens up
                          position: _lastMapPosition,
                          infoWindow: InfoWindow(
                            title: 'Really cool place',
                            snippet: '5 Star Rating',
                          ),
                          
                          icon: BitmapDescriptor.defaultMarkerWithHue(.2),
                          visible: true,
                        ));
                        _polyline.add(Polyline(
                          polylineId: PolylineId(_lastMapPosition.toString()),
                          visible: true,
                          //latlng is List<LatLng>
                          points: [
                            LatLng(userLocation.latitude,userLocation.longitude),
                            LatLng(9.9682, 76.3182),
                          ],
                          endCap: Cap.buttCap,
                          startCap: Cap.roundCap,
                          width: 2,
                          color: Colors.black,
                        ));
                      });
                    },
                    onCameraMove: null,
                    // circles: Set.from([Circle(
                    //     circleId: CircleId("1"),
                    //     center:/*currentLocation!=null ?  LatLng(currentLocation.latitude  ,  currentLocation.longitude) :*/
                    //     LatLng(double.parse(_con.ProductDetail["location_lat"]), double.parse(_con.ProductDetail["location_long"])),
                    //     radius: 90,strokeColor: Color(0xFF48c0d8),
                    //     strokeWidth: 3
                    // )]),
                  )),
              SizedBox(height: 20,),
              Container(color: Color(0xFF23252E),
                width: w,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10,bottom: 10),
                  child: Container(
                    width: w-130,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xFFffd55e),),
                                  child: Icon(
                                    Icons.done,
                                    size: 15.0,
                                  ),
                                ),
                                _circleBlue(),
                              ],
                            ),
                            SizedBox(width: 20,),
                            Container(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(width: w-86,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order Received",style: f14wB),

                                        Text(DateFormat.jm().format(DateTime.parse(
                                            _con.OrderDetail["order_date"])),style: f13w),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text("We're waiting for the "+_con.OrderDetail["business_name"]+" to confirm your order",style: f13w,),
                                  SizedBox(height: 5),
                                  Container(height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Center(
                                        child: MaterialButton(
                                          padding: EdgeInsets.only(left:5,right: 5),
                                          onPressed: (){},
                                          splashColor: Color(0xFF48c0d8),
                                          color: Color(0xFFffd55e),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Text("CHAT",style: f13,),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFFffd55e)),
                                  child: Icon(
                                    Icons.fastfood,
                                    size: 15.0,
                                  ),
                                ),
                                _circleGrey(4),
                              ],
                            ),
                            Container(width: w-86,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Scheduled for preparation",style: f14wB),
                                  SizedBox(height: 5,),
                                  Text("At "+DateFormat.yMMMEd().format(DateTime.parse(
                                      _con.OrderDetail["order_date"]))+"  "+DateFormat.jm().format(DateTime.parse(
                                      _con.OrderDetail["order_date"])),style: f13w),
                                ],
                              ),
                            ),

                          ],
                        ),

                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey),
                                  child: Icon(
                                    Icons.directions_car,
                                    size: 15.0,
                                  ),
                                ),
                                _circleGrey(5),
                              ],
                            ),
                            Container(width: w-86,
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Order Picked Up",style: f14wB),
                                      Container(height: 35,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                            child: MaterialButton(
                                              padding: EdgeInsets.only(left:5,right: 5),
                                              onPressed: (){},
                                              splashColor: Color(0xFF48c0d8),
                                              color: Color(0xFFffd55e),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(6)
                                              ),
                                              child: Text("TRACK ORDER",style: f13,),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: w-170,
                                          child: Text("Rahul Raj is in route to the "+_con.OrderDetail["business_name"]+" to pickup your order",style: f13w,)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(DateFormat.jm().format(DateTime.parse(
                                          _con.OrderDetail["order_date"])),style: f13w),
                                      SizedBox(height: 8,),
                                      Container(
                                        height: 40,width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(6)
                                        ),
                                      ),
                                      Container(height: 30,
                                        width: 80,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                            child: MaterialButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: (){},
                                              color: Color(0xFF48c0d8),
                                              splashColor: Color(0xFFffd55e),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(6)
                                              ),
                                              child: Text("CALL NOW",style: f11,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),

                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey),
                              child: Icon(
                                Icons.done_all,
                                size: 15.0,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(width: w-100,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Delivered",style: f14wB),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Text(DateFormat.jm().format(DateTime.parse(
                                              _con.OrderDetail["order_date"])),style: f13w),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Center(
                                        child: MaterialButton(
                                          padding: EdgeInsets.only(left:5,right: 5),
                                          onPressed: (){},
                                          splashColor: Color(0xFF48c0d8),
                                          color: Color(0xFFffd55e),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Text("REVIEW ORDER",style: f13,),
                                        ),
                                      ),
                                    ),
                                  )
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
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Cancellation",style: f16wB,),
                  Row(
                    children: [
                      Container(height: 35,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: MaterialButton(
                              padding: EdgeInsets.only(left:5,right: 5),
                              onPressed: (){},
                              splashColor: Color(0xFF48c0d8),
                              color: Color(0xFFffd55e),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Text("CANCEL",style: f13,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Text("25 Sec",style: f14w,)
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Center(child: Container(
                  width: w-130,
                  child: RichText(textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: "Note : ",
                      style: TextStyle(color: Colors.red[800],fontWeight: FontWeight.w500,fontSize: 12),
                      children: [
                        TextSpan(
                          text: "If you choose to cancel, you can do it within 60 seconds after "
                              "placing order. Post which you will be changed 100% cancellation fee.",
                           style: f12g,
                        )
                      ]
                    ),
                  ))),
              SizedBox(height: 20,),
              Text("ORDER DETAILS",style: f16wB,),
              SizedBox(height: 20,),
              Container(
                width: w,
                color: Color(0xFF23252E),
                child: Padding(
                  padding: const EdgeInsets.only(left:12,right: 12,top: 20,bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        height: _con.OrderDetail["products"].length.toDouble() * 20,
                        child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                            itemCount: _con.OrderDetail["products"].length,
                            itemBuilder: (context, item){
                              return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          border:
                                          Border.all(color:  /*_con.HomeKitchenTimeline[index]['products'][ind]
                                      ["products_type"].toString()=="0" ? Colors.green[600] :*/ Colors.red[600]),
                                          borderRadius: BorderRadius.circular((2)),
                                        ),
                                        child: Icon(Icons.brightness_1,
                                            color:  /*_con.HomeKitchenTimeline[index]['products'][ind]
                                        ["products_type"].toString()=="0" ? Colors.green[600] :*/ Colors.red[600], size: 8),
                                      ),
                                      SizedBox(width: 7,),
                                      Text(_con.OrderDetail["products"][item]["products_name"]+"    x    "+
                                          _con.OrderDetail["products"][item]["products_quantity"].toString(),style: f14w,)
                                    ],
                                  ),
                                  Text("\u20B9 "+_con.OrderDetail["products"][item]["final_price"].toString(),style: f14w,)
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Item Total",style: f14w,),
                          Text("\u20B9 "+((_con.OrderDetail["amount"]-_con.OrderDetail["delivery_charge"]-
                              _con.OrderDetail["tax"]).roundToDouble()).toString(),style: f14wB,),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery partner fee",style: f14wUL,),
                          Text("\u20B9 "+_con.OrderDetail["delivery_charge"].toString(),style: f14wB,),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Taxes",style: f14wUL,),
                          Text("\u20B9 "+_con.OrderDetail["tax"].toString(),style: f14wB,),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Applied Discount",style: f14wUL,),
                          Text("\u20B9 "+_con.OrderDetail["tax"].toString(),style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.greenAccent[700],
                            fontWeight: FontWeight.w500,
                          ),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(
                        color: Colors.grey[600],
                      ),
                      SizedBox(height: 10,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("PAID AMOUNT",style: f15wB,),
                          Text("\u20B9 "+_con.OrderDetail["amount"].toString(),style: f16wB,),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width:30,
                      child: Icon(Icons.work,color: Colors.white,size: 18,)),
                  SizedBox(width: 15,),
                  Container(
                    width:w-70,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Work",style: f15wB,),
                        SizedBox(height: 10,),
                        Text("Thirumala Peyad Malayinkeezu Rd, Kudamonbhagam, Thiruvannthapuram, Kerala 695006, India",style: f14g,),
                        SizedBox(height: 3,),
                        Text("Contact : +918086595642",style: f15wB,)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("PAYMENT INFORMATION",style: f16wB,),
              SizedBox(height: 20,),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                color: Color(0xFF23252E),
                child: Padding(
                  padding: const EdgeInsets.only(left:20,right: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Method",style: f15wB,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Card Payment",style: f14wB,),
                          SizedBox(height: 1,),
                          Row(
                            children: [
                              Image.asset("assets/Template1/image/Foodie/icons/visa.png",height: 22,),
                              SizedBox(width: 5,),
                              Text("xxxxxxxxxxx8296",style: f14w,),
                            ],
                          ),


                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              /*Text("PAYMENT INFORMATION",style: f16wB,),
              SizedBox(height: 20,),
              Container(
                width: w,
                color: Color(0xFF23252e),
                child: Padding(
                  padding: const EdgeInsets.only(left:12,right: 12,top: 20,bottom: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Payment Method",style: f16wB,),
                      SizedBox(
                        height: 6,
                      ),
                      Text(_con.OrderDetail["payment_method"].toString(),style: f13w,),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Billing Address",style: f16wB,),
                      SizedBox(
                        height: 6,
                      ),
                      Text(_con.OrderDetail["billing_company"],style: f14w,),
                      SizedBox(height: 3,),
                      Text(_con.OrderDetail["billing_street_address"],style: f14w,),
                      SizedBox(height: 3,),
                      Text(_con.OrderDetail["billing_city"],style: f14w,),
                      SizedBox(height: 3,),
                      Text(_con.OrderDetail["billing_postcode"],style: f14w,),
                      SizedBox(height: 3,),
                      Text(_con.OrderDetail["billing_state"]+", "+_con.OrderDetail["billing_country"],style: f14w,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("SHIPPING ADDRESS",style: f16wB,),
              SizedBox(height: 20,),
              Container(
                width: w,
                color: Color(0xFF23252e),
                child: Padding(
                  padding: const EdgeInsets.only(left:12,right: 12,top: 20,bottom: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_con.OrderDetail["billing_company"],style: f14w,),
                      SizedBox(height: 3,),
                      Text(_con.OrderDetail["billing_street_address"],style: f14w,),
                      SizedBox(height: 3,),
                      Text(_con.OrderDetail["billing_city"],style: f14w,),
                      SizedBox(height: 3,),
                      Text(_con.OrderDetail["billing_postcode"],style: f14w,),
                      SizedBox(height: 3,),
                      Text(_con.OrderDetail["billing_state"]+", "+_con.OrderDetail["billing_country"],style: f14w,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),*/
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}

Widget _circleBlue() {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      CircleAvatar(
          backgroundColor: Color(0xFF48c0d8),
          radius: 2.3
      ),

      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Color(0xFF48c0d8),
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Color(0xFF48c0d8),
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor:Color(0xFF48c0d8),
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Color(0xFF48c0d8),
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Color(0xFF48c0d8),
          radius: 2.3
      ),
      SizedBox(
        height: 10.0,
      ),
    ],
  );
}

Widget _circleGrey(cc) {
  return cc==4 ? Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
      ),
      SizedBox(
        height: 10.0,
      ),
    ],
  ) : Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),

      CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
      ),
      SizedBox(
        height: 5.0,
      ),
      CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 2.3
      ),
      SizedBox(
        height: 10.0,
      ),
    ],
  ) ;
}