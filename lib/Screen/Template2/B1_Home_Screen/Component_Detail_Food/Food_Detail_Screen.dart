import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_chat.dart';
import 'package:Butomy/Screen/Template2/B1_Home_Screen/Component_Detail_Food/Gallery_Screen.dart';

class FoodDetailT2 extends StatefulWidget {
  String image, title, price, location, id,owner,btn;

  FoodDetailT2({this.image, this.title, this.price, this.location, this.id,this.owner,this.btn});

  @override
  _FoodDetailT2State createState() => _FoodDetailT2State();
}

class _FoodDetailT2State extends State<FoodDetailT2> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverAppBar(
              titleSpacing: 0,pinned: true,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Color(0xFF1E2026),
              brightness: Brightness.dark,
              elevation: 5,
              title: Image.asset(
                "assets/Template1/image/Foodie/logo.png",
                height: 35,
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10,right: 20,bottom: 15),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,

                                      fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5,),
                                Text("Served with onion + Tomato ketchup",style:f14w)
                              ],
                            ),
                            Image.asset("assets/Template1/image/Foodie/icons/share.png",height: 22,width: 22)
                          ],
                        ),
                      ),
                      Container(
                        height: 320.0,
                        child: new Carousel(
                          boxFit: BoxFit.cover,
                          dotColor: Colors.black26,
                          dotSize: 5.5,
                          dotSpacing: 16.0,
                          dotIncreasedColor: Color(0xFF48c0d8),
                          dotBgColor: Colors.transparent,
                          showIndicator: true,
                          overlayShadow: true,
                          overlayShadowColors: Colors.white.withOpacity(0.2),
                          overlayShadowSize: 0.9,
                          images: [
                            Image.asset(widget.image,fit: BoxFit.cover,),
                            AssetImage("assets/image/image_recipe/recipe5.png"),
                            AssetImage("assets/image/image_recipe/recipe23.jpg"),
                            AssetImage("assets/image/image_recipe/recipe7.png")                          ],
                        ),
                      ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20,top: 12),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 14.0,
                                  color: Colors.grey,
                                ),
                                Text(
                                  widget.location,
                                  style: f14gB,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "\u20B9 150",
                              style: f15yB,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 25,
                              width: 85,
                              decoration: BoxDecoration(
                                  color: Color(0xFFffd55e),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text("Buy Now", style: f14B),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Image.asset("assets/Template1/image/Foodie/icons/add to basket.png",color: Color(0xFFffd55e),height: 25,width: 25,)
                          ],
                        )

                      ],
                    ),
                  ),
                  Container(
                    height: 70.0,
                    width: double.infinity,
                    color: Colors.black12.withOpacity(0.01),
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  height: 38.0,
                                  width: 38.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      color: Color(0xFFF7D142)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/Template2/icon/ratting.png",
                                      height: 18.0,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "4.8",
                                      style: f14wB,
                                    ),
                                    Text(
                                      "Rattings",
                                      style: f14w
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  height: 38.0,
                                  width: 38.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50.0)),
                                      color: Color(0xFFF32956)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/Template2/icon/bookmark.png",
                                      height: 18.0,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "28",
                                      style: f14wB
                                    ),
                                    Text(
                                      "Bookmark",
                                      style: f14w
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          Row(
                            children: <Widget>[
                              Container(
                                  height: 38.0,
                                  width: 38.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      color: Color(0xFF5658D1)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/Template2/icon/photos.png",
                                      height: 18.0,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "9",
                                      style: f14wB
                                    ),
                                    Text(
                                      "Photos",
                                      style: f14w
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(width: 3,),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.owner,
                                  style: f15wB
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    Text("Kottayam",
                                        style: f12g)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                          new TimelineChatPage()));
                                },
                                child: Icon(
                                  Icons.chat,
                                  size: 22,
                                  color: Color((0xFFffd55e)),
                                )),
                          ],
                        ),
                        Container(
                          height: 25,
                          width: 85,
                          decoration: BoxDecoration(
                              color: Color(
                                  0xFF48c0d9),
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  2)),
                          child: Center(
                              child: Text(
                                widget.btn.substring(0,9)+"...",
                                style: f14B,
                              )),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                    child: Text(
                      "From the french countryside, to your doorstep. PAUL was founded in 1899 as a family bakery and patisserie. Savour a selection of viennosie Discover how to make superb spaghetti carbonaara. this cheesy pasta dish is an Italian favourite and with the right technique, you can make it perfect every time.",
                      style:f14g,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Related Post",
                                style: f16wB,
                              ),
                              Text(
                                "See all",
                                style: f14wB,
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 200.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            _relatedPost("assets/image/image_recipe/recipe10.jpg",
                                "Cheeses Guide", "87 Botsford", "4,3"),
                            _relatedPost("assets/image/image_recipe/recipe11.jpg",
                                "Garage Bar Seafood", "Gilison London", "4,1"),
                            _relatedPost("assets/image/image_recipe/recipe12.jpg",
                                "Spagheti Kilimanjaro", "Netherland", "4,2"),
                            _relatedPost("assets/image/image_recipe/recipe13.jpg",
                                "Gangtok Vegetable", "Nepal", "4,7"),
                            _relatedPost("assets/image/image_recipe/recipe14.jpg",
                                "Soup Caikaki", "Orlando", "4,5"),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                ])),
          ],
        ),
      ),
    );
  }
}

Widget _relatedPost(String image, title, location, ratting) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 110.0,
          width: 150.0,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              color: Colors.black12,
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
        Text(
          title,
          style:f15wB,
        ),
        SizedBox(
          height: 2.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 14.0,
              color: Colors.white70,
            ),
            Text(
              location,
              style: f14g,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.star,
              size: 15.0,
              color: Colors.yellow,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text("  "+
                ratting,
                style: f14w,
              ),
            ),
            SizedBox(
              width: 35.0,
            ),
          ],
        ),
      ],
    ),
  );
}
