import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
List<File> imageList;
bool hot_deal=false;
class AddForm22 extends StatefulWidget {
  @override
  _AddForm22State createState() => _AddForm22State();
}

class _AddForm22State extends State<AddForm22> {

  @override
  void initState() {
    super.initState();
   /* _con.getCategories("3");*/
    setState(() {
      imageList = [];
    });
  }

  bool switchControlBuyPre = false;

  void toggleBuyPre(bool value) {
    if (switchControlBuyPre == false) {
      setState(() {
        switchControlBuyPre = true;
      });
    } else {
      setState(() {
        switchControlBuyPre = false;
      });
    }
  }
  File imageFile;

  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      imageFile = File(file.path);
    });
    _cropImage();
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        compressQuality: 20,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color(0xFF1E2026),
            activeControlsWidgetColor: Color(0xFF48c0d8),
            toolbarWidgetColor: Color(0xFF48c0d8),
            cropGridColor: Color(0xFFffd55e),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        imageList.add(imageFile);
        imageFile = null;
      });
    }
  }

  List<Asset> images = List<Asset>();

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarTitleColor: "#48c0d8",
          actionBarColor: "#1E2026",
          actionBarTitle: "Choose Photos ",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {}
    if (!mounted) return;
    setState(() {
      images = resultList;
      getFileList();
      //print("image list : "+images.length.toString());
    });
  }

  void getFileList() async {
    imageList.clear();
    for (int i = 0; i < images.length; i++) {
      var path2 =
      await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var file = await getImageFileFromAsset(path2);
      imageList.add(file);
    }
  }

  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
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
        title: Text("Add Item New"),
      ),
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:12,right: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Center(child: Text("To begin adding products",style: f15w,)),
              SizedBox(height: 15,),
              Center(child: Text("Find your products in",style: f16wB,)),
              SizedBox(height: 2,),
              Center(child: Text("Foodizwall catalog",style: f15wB,)),
              SizedBox(height: 25,),
              Text("Category",style: f14w,),
              SizedBox(height: 5,),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)
                ),alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Snacks",style: f14w,),
                ),
              ),
              SizedBox(height: 15,),
              Text("Sub Category",style: f14w,),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.only(top:300.0),
                          child: SimpleDialog(
                            backgroundColor:
                            Color(0xFF1E2026),
                            children: <Widget>[
                              SimpleDialogOption(
                                onPressed: () {
                                },
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Suggest New Sub Category',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Image.asset("assets/Template1/image/Foodie/icons/add-item-plus.png",
                                      height: 20,width: 20,color: Color(0xFF0dc89e),)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                },
                                child: const Text(
                                    'Unnakaya',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                },
                                child: const Text(
                                    'Beef Cutlet',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                },
                                child: const Text(
                                    'Onion Vada',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey)
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Veg. Cutlet",style: f14w,),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                   /* crossAxisAlignment: CrossAxisAlignment.start*/
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/Template1/image/Foodie/snack.jpg"),
                                fit: BoxFit.cover),
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12.withOpacity(0.1),
                                  spreadRadius: 2.0)
                            ]),
                      ),
                      SizedBox(width: 10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                "Vegetable Cutlet",
                                style: f14w,
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.greenAccent[700]),
                                    borderRadius:
                                    BorderRadius.circular(2)),
                                child: Icon(
                                  Icons.brightness_1,
                                  color:  Colors.greenAccent[700],
                                  size: 8,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 3,),
                          Text(
                            "In Snacks",
                            style: f12w,
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFffd55e),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Center(
                        child: Text(
                          "Selected", style: f14B,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3,),
              Divider(color: Colors.grey[600],),
              SizedBox(height: 5,),
              Text("Item Name",style: f14w,),
              SizedBox(height: 5,),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white),
                    color: Colors.grey[700]
                ),alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Vegetable Cutlet",style: f14wB,),
                ),
              ),
              SizedBox(height: 20,),
              Text("Display Name",style: f14w,),
              SizedBox(height: 5,),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
               /* decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white)
                ),*/
                  alignment: Alignment.centerLeft,
                child: TextField(
                  style: f14w,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 6,left: 8),
                    hintText: "Write a name to display...",
                    hintStyle: f14g,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(width: 1,color: Color(0xFF48c0d8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(width: 1,color: Colors.white),
                    ),
                  ),
                )
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Veg",
                    style: f14w,
                  ),
                  Transform.scale(
                      scale: .9,
                      child: Switch(
                        onChanged: toggleBuyPre,
                        value: switchControlBuyPre,
                        activeColor: Color(0xFF48c0d8),
                        activeTrackColor: Colors.grey,
                        inactiveThumbColor: Color(0xFFffd55e),
                        inactiveTrackColor: Colors.grey,
                      )),
                  Text(
                    "Non-Veg",
                    style: f14w,
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hot Deal",style: f15w,),
                  SizedBox(width: 10,),
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white70,
                    ),
                    child: Checkbox(value: hot_deal,
                        checkColor: Colors.black,
                        activeColor: Color(0xFF48c0d8),
                        onChanged:(bool newValue){
                          setState(() {
                            hot_deal = newValue;
                          });
                        }),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("System Charge",style: f14wB,),
                  Container(
                    height: 30,
                    width: 90,
                    child: TextField(
                      style: f14w,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[700],
                        contentPadding: EdgeInsets.only(top: 6,left: 8),
                        hintText: "\u20B9 2.25",
                        hintStyle: f14w,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1,color: Color(0xFF48c0d8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1,color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Earnings",style: f14wB,),
                  Container(
                    height: 30,
                    width: 90,
                    child: TextField(
                      style: f14w,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[700],
                        filled: true,
                        contentPadding: EdgeInsets.only(top: 6,left: 8),
                        hintText: "\u20B9 12.75",
                        hintStyle: f14w,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1,color: Color(0xFF48c0d8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1,color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Pricing",style: f14wB,),
                  Container(
                    height: 30,
                    width: 90,
                    child: TextField(
                      style: f14w,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 6,left: 8),
                        hintText: "\u20B9 15.00",
                        hintStyle: f14w,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1,color: Color(0xFF48c0d8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1,color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Divider(color: Colors.grey[600],),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Min  Qty",style: f14wB),
                      SizedBox(width: 10,),
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          style: f14w,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 6,left: 8),
                            hintText: "5",
                            hintStyle: f14w,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(width: 1,color: Color(0xFF48c0d8)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(width: 1,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Unit",style: f14wB),
                      SizedBox(width: 10,),
                      Container(height: 30,width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)
                        ),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("5km",style:f14w),
                              Icon(Icons.arrow_drop_down,color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
              imageList.length > 0
                  ? Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageList.length,
                    itemBuilder: (context, ind) {
                      return Stack(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(
                                left: 15,
                                right: 15),
                            child: Container(
                              height: 80,
                              width: 110,
                              clipBehavior:
                              Clip.antiAlias,
                              child: Image.file(
                                imageList[ind],
                                fit: BoxFit.cover,
                              ),
                              decoration:
                              BoxDecoration(
                                borderRadius:
                                BorderRadius.all(
                                    Radius
                                        .circular(
                                        5.0)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                    left: 93.0,
                                    top: 5),
                                child:
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imageList
                                          .removeAt(
                                          ind);
                                    });
                                  },
                                  child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: Color(
                                              0xFFffd55e),
                                          borderRadius:
                                          BorderRadius.circular(
                                              100)),
                                      child: Center(
                                          child: Icon(
                                            Icons.clear,
                                            size: 18,
                                          ))),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
              )
                  :  Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      //size:50,
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 70,
                    ),
                    SizedBox(width: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap:(){
                            getImageFromCamera(context);
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Color(0xFFffd55e),
                                borderRadius:
                                BorderRadius.circular(8)),
                            child: Center(
                                child: Text("Take a Photo",
                                    style: f14B)),
                          ),
                        ),
                         SizedBox(height: 10,),
                        GestureDetector(
                            onTap: (){
                              loadAssets();
                              Navigator.pop(context);
                            },
                            child: Text("Upload from gallery", style: f15wB)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Center(child: Text("Item will be active after Approval",style: f15wB,)),
              SizedBox(height: 3,),
              Center(child: Text("in 2 working days in Item list.",style: f15wB,)),
              SizedBox(height: 5,),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  GestureDetector(
        onTap: (){

        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(height: 35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFF48c0d8),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Center(child: Text("Submit",style: f16wB,)),
          ),
        ),
      ),
    );
  }
}
