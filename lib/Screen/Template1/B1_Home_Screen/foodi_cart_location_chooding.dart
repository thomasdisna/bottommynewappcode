import 'package:Butomy/Screen/Template1/B1_Home_Screen/CART-PAYMENTS-SCREENS/Payment-method-choosing.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_add_address_from_cart_deliveru.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_edit_location_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_location_add_page.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart' as repo;

class  FoodiCartAddressBookPage extends StatefulWidget {

  FoodiCartAddressBookPage({this.time,this.date,this.cartList});

  List cartList;
  String date;
  String time;

  @override
  _FoodiCartAddressBookPageState createState() => _FoodiCartAddressBookPageState();
}

class _FoodiCartAddressBookPageState extends StateMVC<FoodiCartAddressBookPage> {

  TimelineWallController _con;

  _FoodiCartAddressBookPageState() : super(TimelineWallController()) {
    _con = controller;
  }

  String apiKey = 'AIzaSyAm22_7Hj0aHN09DvP-VmaXSk64dm1WSfg';

  /*Navigator.push(context, MaterialPageRoute(builder: (context) =>PaymentChoosingScreen(
        date: widget.date,time: widget.time,
        firstname: _firstName.text,
        lastname: _lastName.text,
        email: _email.text,
        phone: _phone.text,
        address: _home.text,
        street: _street.text,
        city: _city.text,
        pincode: _postcode.text,
        cartList: widget.cartList,
      )));*/

  @override
  void initState() {
    _con.getAddressList(context,"1");
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
        title: Text("Choose a Delivery Address",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Color(0xFFffd55e),
                  size: 22.0,
                ),
                _circle(),
                Icon(
                  Icons.credit_card,
                  color: Colors.white70,
                  size: 21.0,
                ),
                _circle(),
                Icon(
                  Icons.check_circle,
                  color: Colors.white70,
                  size: 21.0,
                ),
              ],
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: Container(
                color: Color(0xFF23252E),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,),
                      child: Text(
                        "Order from "+widget.cartList[0]["business_name"].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Container(
                      height: widget.cartList[0]["products"].length.toDouble()*130,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.cartList[0]["products"].length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  left: 13.0,
                                  right: 13.0,
                                  bottom: 10.0),
                              /// Background Constructor for card
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(10.0),

                                          /// Image item
                                          child: Container(
                                              height: 80,width: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black12
                                                            .withOpacity(0.1),
                                                        blurRadius: 0.5,
                                                        spreadRadius: 0.1)
                                                  ]),
                                              child: CachedNetworkImage(
                                                imageUrl:  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F"+
                                                    widget.cartList[0]["products"][index]["products_image"][0]["source"].toString()+"?alt=media",
                                                fit: BoxFit.cover,
                                              ))),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0,
                                              left: 10.0,
                                              right: 5.0),
                                          child: Column(
                                            /// Text Information Item
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(top:5.0),
                                                child: Text(
                                                  widget.cartList[0]["products"][index]["products_name"].toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.white,
                                                      fontSize: 16.0),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 15.0),
                                                    child: Text(
                                                      widget.cartList[0]["products"][index]["customers_basket_quantity"].toString()+"  x  " +"\u20B9" +
                                                          widget.cartList[0]["products"][index]["final_price"].toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,

                                                          fontSize: 16.0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Tax (2.0%):",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            " \u20B9 " + ((cartTotal/100)*2).toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Delivery: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            " \u20B9 " + "4".toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:15,right: 15,bottom: 15),
                      child: Text("Total Amount: "+ (cartTotal+4+((cartTotal/100)*2)).toString(),style: f16bB,),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
                alignment: Alignment.centerLeft,
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[800],
                child: Padding(
                  padding: const EdgeInsets.only(left:12.0),
                  child: Text("SAVED ADDRESSES",style: f16wB,),
                )),
            SizedBox(height: 15,),
            _con.addressLIST.length>0 && _con.addressStatus==false ?  Container(height: _con.addressLIST.length.toDouble() * 110,
              child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                  itemCount: _con.addressLIST.length,
                  itemBuilder: (context, index){
                    // _con.addressLIST[index]["location_name"]=="Work" ? work_save=true : work_save=false;
                    // _con.addressLIST[index]["location_name"]=="Home" ? home_save=true : home_save=false;
                    print("sssssssssssssssssssssssss "+home_save.toString());
                    return Padding(
                      padding: const EdgeInsets.only(left:12,right: 12,bottom: 15),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>PaymentChoosingScreen(
                            locName: _con.addressLIST[index]["location_name"],
                            date: widget.date,time: widget.time,
                            firstname: NAME.toString(),
                            lastname: repo.AbtInfo["data"][0]
                            ["lastname"],
                            email: repo.AbtInfo["data"][0]
                            ["email"],
                            phone: repo.AbtInfo["data"][0]
                            ["mobile"],
                            address: _con.addressLIST[index]["location"],
                            street: _con.addressLIST[index]["house_number"],
                            city: _con.addressLIST[index]["landmark"],
                            pincode: "123456",
                            itemList: widget.cartList,
                          )));
                        },
                        child: Container(child: Column(
                          children: [
                            Row(
                              children: [ // Navigator.pop(context);
                                Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width:30,
                                      child: _con.addressLIST[index]["location_name"]=="Home" ?
                                      Image.asset("assets/Template1/image/Foodie/icons/home.png",height: 16,width: 16,color: Colors.grey,) :
                                      _con.addressLIST[index]["location_name"]=="Work" ?  Icon(Icons.work,color: Colors.grey,size: 18,) :
                                      Icon(Icons.location_on,color: Colors.grey,size: 18,),
                                    ),
                                    SizedBox(width: 15,),
                                    Container(
                                      width: MediaQuery.of(context).size.width-70,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(_con.addressLIST[index]["location_name"],style: f15wB,),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Text(_con.addressLIST[index]["location"],style: f14g,),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:15.0),
                              child: Divider(color: Colors.grey[700],),
                            )
                          ],
                        )),
                      ),
                    );
                  }),
            ) :
            _con.addressStatus == true ? Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Center(child: CircularProgressIndicator()),
            ) : Container(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () async {
            LocationResult result = await showLocationPicker(
              context, apiKey,
              // initialCenter: LatLng(10.023286, 76.311371),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
              myLocationButtonEnabled: true,
              // requiredGPS: true,
              layersButtonEnabled: true,
              // countries: ['AE', 'NG']
//                      resultCardAlignment: Alignment.bottomCenter,
              // desiredAccuracy: LocationAccuracy.best,
            );
            setState(()  {
              // print("%%%%%%%%%%%%%%%%%%%%%%%%%%%5 "+result.address_name);
              location = result.address;
              location_lat = result.latLng.latitude;
              location_long = result.latLng.longitude;
            });
            final coordinates = new Coordinates(userLocation.latitude, userLocation.longitude);
            var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
            var first = addresses.first;
            print("First addressline : "+first.addressLine+" adminArea : "+first.adminArea+" countryName : "
                +first.countryName+" postalCode : "+first.postalCode+" featureName : "+first.featureName+" locality : "+first.locality);
            print("location ##################### "+location);
            print("location lattttt ##################### "+location_lat.toString());
            print("location longggg ##################### "+location_long.toString());
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context) => LocationAddPageFromCart(location: location,lat: location_lat.toString(),
            //       long: location_long.toString(),loc_name: result.address_name,addressList: _con.addressLIST,
            //    address: location,city: first.locality,date: widget.date,itemList: widget.cartList,pincode: first.postalCode,
            //     street: first.featureName,time: widget.time,)
            // ));
          },
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF0dc89e)),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/Template1/image/Foodie/icons/add-item-plus.png",
                  height: 16,width: 16,color: Colors.white,),
                SizedBox(width: 10,),
                Text("Add New Address",style: f16wB,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget _circle() {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 18.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 7.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 2.0,
      ),
      SizedBox(
        width: 18.0,
      ),
    ],
  );
}