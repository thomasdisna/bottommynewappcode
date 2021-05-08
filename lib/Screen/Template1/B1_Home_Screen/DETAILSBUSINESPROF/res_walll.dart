import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/business_accountwall_detailPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class OtherRestaurantwall extends StatefulWidget {

  OtherRestaurantwall({this.pagid,this.timid,this.controo,this.contheight});
  String pagid,timid;
  double contheight;

  ScrollController controo;

  @override
  _BusinessRestaurantwall createState() => _BusinessRestaurantwall();
}
class _BusinessRestaurantwall extends StateMVC<OtherRestaurantwall> {
  var timlineId;
  HomeKitchenRegistration _con;
  _BusinessRestaurantwall() : super(HomeKitchenRegistration()) {
    _con = controller;
  }
  @override
  void initState() {
    // TODO: implement initState]
    _con.RestaurantgetAccountWallImage(widget.timid);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _con.RESTAccountWall.length>0 ? setState((){
      total_count=_con.RESTAccountWall.length.toInt();
    }) : null;
    return Scaffold(
        backgroundColor: Color(0xFF1E2026),
        body:Column(
          children: <Widget>[
            Center(
              child: Visibility(
                  visible: _con.RESTstatusAccWall,
                  child: Container(
                      margin: EdgeInsets.only(top: 100, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 5, right: 5),
              child: _con.RESTAccountWall.length>0 &&_con.RESTstatusAccWall == false?Container(
                  height: widget.contheight,
                  child:GridView.builder(
                      controller: widget.controo,
                      itemCount: _con.RESTAccountWall.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:3, childAspectRatio: 1),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 3, right: 3, bottom: 3, top: 3),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                  new BusAccountFoodWallPostDetailPage(id:widget.timid.toString(),sel_ind: index,total_ind: _con.RESTAccountWall.length.toInt(),),
                                  transitionDuration: Duration(milliseconds: 600),
                                  transitionsBuilder: (_, Animation<double> animation,
                                      __, Widget child) {
                                    return Opacity(
                                      opacity: animation.value,
                                      child: child,
                                    );
                                  }));
                            },
                            child: _con.RESTAccountWall[index]['post_images'].length > 0
                                ?
                            Container(clipBehavior: Clip.antiAlias,
                              height: 204,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl:  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                    _con.RESTAccountWall[
                                    index][
                                    "post_images"]
                                    [0]['source']
                                        .toString()
                                        .replaceAll(" ", "%20") +
                                    "?alt=media",fit: BoxFit.cover,
                                placeholder: (
                                    context,
                                    ind) =>
                                    Container(
                                      height: 204,
                                      width: 100,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 6.0,
                                                color: Colors.black12.withOpacity(0.1),
                                                spreadRadius: 2.0)
                                          ]),
                                      child: Image
                                          .asset(
                                        "assets/Template1/image/Foodie/post_dummy.jpeg",
                                        fit: BoxFit
                                            .cover,),
                                    ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 6.0,
                                        color: Colors.black12.withOpacity(0.1),
                                        spreadRadius: 2.0)
                                  ]),
                            )
                                : Container(
                              height: 0,
                            ),
                          ),
                        );
                      })
              )
                  :_con.RESTstatusAccWall == false ? Center(child: Padding(
                padding: const EdgeInsets.only(top:100.0),
                child: Text("No Posts",style: f16wB,),
              )):Container(height: 0,),
            ),
          ],
        ));
  }
}