import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:share/share.dart';

class BusinessRatingPage extends StatefulWidget {
  @override
  _BusinessRatingPageState createState() => _BusinessRatingPageState();
}

class _BusinessRatingPageState extends State<BusinessRatingPage> {
  Widget setAlert() {
    List<String> a = ["Edit,Delete,Share,Report"];
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 50),
      child: Container(
        height: 130,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text("Edit"),
            SizedBox(
              height: 18,
            ),
            Text("Delete"),
            SizedBox(
              height: 18,
            ),
            GestureDetector(
                onTap: () {
                  Share.share(
                      'check out my website https://protocoderspoint.com/');
                },
                child: Text("Share")),
            SizedBox(
              height: 18,
            ),
            Text("Report"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          brightness: Brightness.dark,
          elevation: 5,
          title: Text(
            "Ratings and Reviews",
            style: TextStyle(color: Colors.white),
          )),
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "4.5",
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 16,
                          ),
                          Icon(
                            Icons.star_half,
                            color: Color(0xFFffd55e),
                            size: 16,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("103,502,111", style: f15wB)
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("5", style: f15wB),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("4", style: f15wB),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("3",
                              style:
                              f15wB),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("2",
                              style:
                              f15wB),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("1",
                              style:
                              f15wB),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFffd55e),
                            size: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Divider(
              color: Colors.black87,
              thickness: 1,
            ),
            Container(
              height: MediaQuery.of(context).size.height+400,
              child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context,index) {return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
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
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Alex Fernadas",
                                        style: f15wB
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFffd55e),
                                          size: 13,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFffd55e),
                                          size: 13,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFffd55e),
                                          size: 13,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFffd55e),
                                          size: 13,
                                        ),
                                        Icon(
                                          Icons.star_border,
                                          color: Color(0xFFffd55e),
                                          size: 13,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      //title: Text('Country List'),
                                      content: setAlert(),
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.more_vert,size: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          child: Text(
                            "Its a good app, I truely it when they do random new things without giving the ability to just keep it how it was before.... With this new update stories fill almost half of your screen....",
                            style: f14w,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, bottom: 10, top: 15),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            // controller:,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "   Add a Comment",
                                hintStyle:
                                f14g),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black87,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              );} ,

              ),
            ),

          ],
        ),
      ),
    );
  }
}
