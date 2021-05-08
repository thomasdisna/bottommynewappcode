import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/rating_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_chat.dart';
import 'package:Butomy/Screen/Template2/B1_Home_Screen/Component_Detail_Food/Food_Detail_Screen.dart';
class AccountFoodReviews extends StatefulWidget {
  ScrollController reviwcontro;

  AccountFoodReviews({this.reviwcontro});

  @override
  _AccountFoodReviewsState createState() => _AccountFoodReviewsState();
}

class _AccountFoodReviewsState extends State<AccountFoodReviews>
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
    var gridReview =
   SingleChildScrollView(
     controller: widget.reviwcontro,
     child:  Container(
       height: 280,
       child: ListView.builder(
         physics: NeverScrollableScrollPhysics(),
           itemCount: 1,primary: false,shrinkWrap: true,
           itemBuilder: (BuildContext context, int index) {
             return  Column(
               children: <Widget>[
                 Container(
                     height: 248,
                     width: MediaQuery.of(context).size.width,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(top:5.0),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Padding(
                                     padding:
                                     const EdgeInsets.only(left: 5, top: 10),
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
                                   Padding(
                                     padding: const EdgeInsets.only(top: 8),
                                     child: Container(
                                       child: Column(
                                         crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                         children: <Widget>[
                                           Text(
                                             "Sofis Kitchen",
                                             style: f15wB,
                                           ),
                                           Text("Kottayam",
                                               style: f13g),
                                         ],
                                       ),
                                     ),
                                   ),

                                   SizedBox(
                                     height: 15,
                                   ),
                                   SizedBox(
                                     width: 10,
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(top: 8),
                                     child: GestureDetector(
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
                                   ),

                                 ],
                               ),
                               Row(
                                 children: <Widget>[
                                   GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(
                                       builder: (context) => RatingPage()
                                   ));},
                                     child: Row(
                                       children: <Widget>[
                                         Padding(
                                           padding: const EdgeInsets.only(top: 8),
                                           child: Icon(
                                             Icons.star,
                                             color: Color(0xFFffd55e),
                                             size: 15,
                                           ),
                                         ),
                                         SizedBox(
                                           width: 8,
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(top: 10),
                                           child: Row(
                                             children: <Widget>[
                                               Text(
                                                 "4.1",
                                                 style: f14gB,
                                               ),
                                               Text(
                                                 " Ratings ",
                                                 style: f14g,
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   SizedBox(
                                     width: 8,
                                   ),
                                   GestureDetector(
                                     onTap: () {},
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 8,right: 5),
                                       child: Container(
                                         height: 23,
                                         width: 80,
                                         decoration: BoxDecoration(
                                             color: Color(0xFF48c0d9),
                                             borderRadius:
                                             BorderRadius.circular(2)),
                                         child: Center(
                                             child: Text(
                                               "Follow Chef",
                                               style: f13B,
                                             )),
                                       ),
                                     ),
                                   ),
                                 ],
                               )
                             ],
                           ),
                         ),
                         SizedBox(
                           height: 4.0,
                         ),
                         Container(
                           height: 60,
                           child: Padding(
                             padding: const EdgeInsets.only(left: 8,right: 8,top: 10),
                             child: Text("Best Food in the town presented for home functions and office parties and the cutlet is one of the best snacks...",
                               style:f14w),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(top: 0,bottom: 5),
                           child: Container(
                             height: 100,
                             child: ListView(
                                 scrollDirection: Axis.horizontal,
                                 children: <Widget>[
                                   card (
                                       "assets/image/image_recipe/recipe4.jpg",
                                       "87 Botsford",
                                       "200.00",
                                       "4.3",
                                       "Chicken Pasta",
                                       "999"),
                                   card(
                                       "assets/image/image_recipe/recipe5.png",
                                       "87 Botsford",
                                       "200.00",
                                       "4.3",
                                       "Chicken Pasta",
                                       "888"),
                                   card(
                                       "assets/image/image_recipe/recipe6.png",
                                       "87 Botsford",
                                       "200.00",
                                       "4.3",
                                       "Chicken Pasta",
                                       "777"),
                                   card(
                                       "assets/image/image_recipe/recipe7.png",
                                       "87 Botsford",
                                       "200.00",
                                       "4.3",
                                       "Chicken Pasta",
                                       "666"),
                                 ]),
                           ),
                         ),
                         Row(mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>[
                             GestureDetector(
                               onTap: (){Navigator.push(context, MaterialPageRoute(
                                 builder: (context)=>RatingPage()
                               ));},
                               child: Padding(
                                 padding: const EdgeInsets.only(right: 8,top:10,bottom: 6,left: 10),
                                 child: Text("View All Reviews",style: f14w),
                               ),
                             ),
                           ],
                         )
                       ],
                     )
                 ),
                 Divider(thickness: 1,color: Colors.black87,)
               ],
             );
           }
       ),
     ),
   );
    var _body = Padding(
      padding: const EdgeInsets.only(
      ),
      child: Column(
        children: <Widget>[
          gridReview,
        ],
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(scrollDirection: Axis.vertical, child: _body),
    );
  }
}

class card extends StatelessWidget {
  card(this.img, this.location, this.price, this.ratting, this.title, this.id);
  String img, title, location, ratting, price, id;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new FoodDetailT2(
                    title: this.title,
                    id: this.id,
                    image: this.img,
                    location: this.location,
                    price: this.price,
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
            child: Container(
              height: 90.0,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white12,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.black12.withOpacity(0.03),
                      spreadRadius: 10.0),
                ],
              ),
              child: Hero(
                tag: 'hero-tag-${this.id}',
                child: Container(
                  height: 80.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8.0)),
                      image: DecorationImage(
                          image: AssetImage(img),
                          fit: BoxFit.cover)),
                ),
              ),
            ),

          ),
        ),
      ],

    );
  }
}
