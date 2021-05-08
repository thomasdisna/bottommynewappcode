import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../business_accountwall_detailPage.dart';


class OtherKitchenWall extends StatefulWidget {

  OtherKitchenWall({this.pagid,this.timid,this.contro,this.contheight});
  String pagid,timid;
  ScrollController contro;
  double contheight;

  @override
  _BusinessHomekitchenKitchenwall createState() => _BusinessHomekitchenKitchenwall();
}


class _BusinessHomekitchenKitchenwall extends StateMVC<OtherKitchenWall> {
  var timlineId;
  HomeKitchenRegistration _con;
  _BusinessHomekitchenKitchenwall() : super(HomeKitchenRegistration()) {
    _con = controller;
  }
  @override
  void initState() {
    // TODO: implement initState]
    _con.getAccountWallImage(widget.timid);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _con.AccountWall.length>0 ? setState((){
      total_count=_con.AccountWall.length.toInt();
    }) : null;
    return Scaffold(
        backgroundColor: Color(0xFF1E2026),
        body:Column(
          children: <Widget>[
            Center(
              child: Visibility(
                  visible: _con.statusAccWall,
                  child: Container(
                      margin: EdgeInsets.only(top: 100, ),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 5, right: 5),
              child: _con.AccountWall.length>0 &&_con.statusAccWall == false?Container(
                  height: widget.contheight,
                  child:GridView.builder(
                      controller: widget.contro,
                      itemCount: _con.AccountWall.length,
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
                                  new BusAccountFoodWallPostDetailPage(id: widget.timid.toString(),sel_ind: index,total_ind: _con.AccountWall.length.toInt(),),
                                  transitionDuration: Duration(milliseconds: 600),
                                  transitionsBuilder: (_, Animation<double> animation,
                                      __, Widget child) {
                                    return Opacity(
                                      opacity: animation.value,
                                      child: child,
                                    );
                                  }));
                            },
                            child: _con.AccountWall[index]['post_images'].length > 0
                                ?
                            Container(clipBehavior: Clip.antiAlias,
                              height: 204,
                              width: 100,
                              child: CachedNetworkImage(
                              imageUrl:  "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                    _con.AccountWall[
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
                  :_con.statusAccWall == false ? Center(child: Padding(
                padding: const EdgeInsets.only(top:100.0),
                child: Text("No Posts",style: f16wB,),
              )):Container(height: 0,),
            ),
          ],
        ));
  }
}