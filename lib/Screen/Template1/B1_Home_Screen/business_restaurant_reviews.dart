import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_business_page.dart';

var s = "unlike";
var b = "unmark";


class BusinessRestaurantReviews extends StatefulWidget {
  @override
  _BusinessRestaurantReviewsState createState() => _BusinessRestaurantReviewsState();
}

class _BusinessRestaurantReviewsState extends State<BusinessRestaurantReviews>
    with SingleTickerProviderStateMixin {
  TabController _tabContoller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabContoller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var gridReview = Container(
      height: MediaQuery.of(context).size.height+500,
      child: ListView.builder(
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: new Column(
              children: <Widget>[
                Container(
                  // color: Colors.white.withOpacity(0.5),
                  padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0,bottom: 2),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 35.0,
                                width: 35.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                        CachedNetworkImageProvider(
                                          "https://www.morpht.com/sites/morpht/files/styles/landscape/public/dalibor-matura_1.jpg?itok=gxCAhwAV",
                                          errorListener: () =>
                                          new Icon(Icons.error),
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(180.0))),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=> TimelineFoodWallDetailPage()
                                    ));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Varun Mohan Chempankulam",
                                        style: f15wB,
                                      ),
                                      Text("2hrs Ago",
                                          style: f10g),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, bottom: 8, right: 8, left: 8),
                        child: Container(
                          child: RichText(
                            text: TextSpan(
                                text:
                                'Best food in the world presented to you by ',
                                style: f14w,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Foodizwall',
                                      style: f14b),
                                  TextSpan(
                                      text: ' with ',
                                      style: f14w),
                                  TextSpan(
                                      text: 'Alex and 10 Others.',
                                      style: f14b),
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Container(
                          height: 204,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/Template1/image/Foodie/biriyani.jpg"),
                                  fit: BoxFit.cover),
                              color: Colors.black12,
                              borderRadius:
                              BorderRadius.all(Radius.circular(0.0)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black12.withOpacity(0.1),
                                    spreadRadius: 2.0)
                              ]),
                        ),
                      ),
                      Container(
                        child: Padding(
                            padding:
                            EdgeInsets.only(left: 5.0, right: 5.0),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.star,
                                              size: 14.0,
                                              color: Colors.yellow,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 13.0,
                                              color: Colors.yellow,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 14.0,
                                              color: Colors.yellow,
                                            ),
                                            Icon(
                                              Icons.star_half,
                                              size: 14.0,
                                              color: Colors.yellow,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              size: 14.0,
                                              color: Colors.yellow,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "5 ",
                                              style: f14wB,
                                            ),
                                            Text(
                                                "Ratings",
                                                style: f14w
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        GestureDetector(
                                            onTap: (){Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=> BusinessRatingPage()
                                            ));},
                                            child: Text("View all Reviews",style: f14w)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),

                    ],
                  ),
                ),
                Divider(color: Colors.black87,thickness: 1,),
              ],
            ),
          );
        },
      ),
    );

    var _body = gridReview;
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(child: _body),
    );
  }
}

