import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/Business_HomeKitchen_Product_List_page.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'business_homekitchen_bottom_bar.dart';

List IMAGELIST = [];
var categid, categ;
var subcategid, subCatg, subCatImg, subcategtype;
bool showImage;
bool ShowBody;
bool subcataddalert = false;

class BusinessHomeKitchenAddItemPage extends StatefulWidget {
  BusinessHomeKitchenAddItemPage({this.pagid, this.timid, this.memberdate});

  String pagid, timid, memberdate;

  @override
  _BusinessHomeKitchenAddItemPageState createState() =>
      _BusinessHomeKitchenAddItemPageState();
}

class _BusinessHomeKitchenAddItemPageState
    extends StateMVC<BusinessHomeKitchenAddItemPage> {
  File imageFile;

  Future<Null> _pickImage(val) async {
    imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    if (imageFile != null) {
      val(() {});
      _cropImage(val);
    }
  }

  bool hot_deal;
  int sel;
  int servicecharge = 3;
  int product_cost = 0;
  var distance_value;
  var quantity_value;
  var gst;

  Future<Null> _cropImage(val) async {
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
      val(() {
        imageFile = croppedFile;
        showImage = true;
      });
    }
  }

  HomeKitchenRegistration _con;

  _BusinessHomeKitchenAddItemPageState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  TextEditingController _subCatName = TextEditingController();
  TextEditingController _displayName = TextEditingController();
  TextEditingController _subTitle = TextEditingController();
  TextEditingController _discountPrice = TextEditingController();
  TextEditingController _discountPercentage = TextEditingController();
  TextEditingController _systemcharge = TextEditingController();
  TextEditingController _earnings = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _packing = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _discountPrice.text = "0";
      _price.text = "0";
      _packing.text = "0";
      _con.KitchenCategories = KitCat;
      imageList = [];
      hot_deal = false;
      showImage = false;
      ShowBody = false;
      categ = "Select Category";
      subCatg = "Select Sub Category";
    });
  }

  Future getImageFromCamera(BuildContext context) async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      imageFile = File(file.path);
    });
    _cropImage2();
  }

  Future<Null> _cropImage2() async {
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

  int discount = 0;
  int amount = 0;

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
    });
  }

  void getFileList() async {
    imageList.clear();
    for (int i = 0; i < images.length; i++) {
      var path2 =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      //var path = await images[i].filePath;
      var file = await getImageFileFromAsset(path2);
      imageList.add(file);
    }
  }

  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://foodizwall.appspot.com');

  StorageUploadTask _uploadTask;

  _startUpload() {
    for (var i = 0; i < imageList.length; i++) {
      var nows = DateTime.now();
      String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
      setState(() {
        IMAGELIST.add(filePath);
        _uploadTask = _storage.ref().child(filePath).putFile(imageList[i]);
      });
    }
    _imagUpload();
  }

  var categrynewimg;

  _startCatImageUpload() {
    var nows = DateTime.now();
    String filePath = '${nows.microsecondsSinceEpoch.toString()}.png';
    setState(() {
      categrynewimg = filePath.toString();
      _uploadTask = _storage.ref().child(filePath).putFile(imageFile);
    });
    _SubCatimagUpload();
  }

  var selected_category;
  var selected_category_id;

  _SubCatimagUpload() {
    _con.HomekitchenAddSubCategory(_subCatName.text, selected_category_id,
        categrynewimg.toString(), context, widget.pagid, widget.timid, "1");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => bottomNavBarHomeKitchen(
                  memberdate: widget.memberdate,
                  pagid: widget.pagid,
                  timid: widget.timid,
                  currentIndex: 3,
                  upld: false,
                )));
    setState(() {
      subcataddalert = true;
    });
    // _con.HomeKitchenAddItem("22",IMAGELIST.join(",").toString(),_proddesc.text,"image",_name.text,_price.text,_proddesc.text,hot_deal?"1":"0",switchControlBuyPre?"1":0,"1",_values.join(",").toString(),"business",active?"1":"0");

    return Container(
      height: 0,
    );
  }

  _imagUpload() {
    Fluttertoast.showToast(
      msg: "Adding Product",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    _con.HomeKitchenAddItem(
        context,
        userid.toString(),
        IMAGELIST.join(",").toString(),
        subCatg,
        "image",
        _displayName.text,
        _price.text,
        subCatg,
        hot_deal ? "1" : "0",
        switchControlBuyPre ? "1" : 0,
        "1",
        subcategid.toString(),
        "business",
        "1",
        quantity_value.toString(),
        servicecharge.toString(),
        _earnings.text,
        distance_value.toString(),
        widget.pagid,
        widget.timid,
        widget.memberdate,
        _subTitle.text,
        _discountPrice.text,
        ((int.parse(_discountPrice.text) / int.parse(_price.text)) * 100)
            .toString(),
        _packing.text,
        gst.toString());
    IMAGELIST = [];
    imageList = [];
    return Container();
  }

  var _time1, _time2;

  Future<Null> _selectTime1(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.teal,
                primaryColorDark: Color(0xFF0dc89e),
                accentColor: Color(0xFF0dc89e),
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        var selectedTime = picked;
        _time1 = selectedTime
            .toString()
            .replaceAll("TimeOfDay(", "")
            .replaceAll(")", "");
      });
  }

  Future<Null> _selectTime2(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.teal,
                primaryColorDark: Color(0xFF0dc89e),
                accentColor: Color(0xFF0dc89e),
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        var selectedTime = picked;
        _time2 = selectedTime
            .toString()
            .replaceAll("TimeOfDay(", "")
            .replaceAll(")", "");
      });
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
        centerTitle: true,
        title: Text(
          "Add Product",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xFF1E2026),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                "To begin adding products",
                style: f15w,
              )),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                "Find your products in",
                style: f16wB,
              )),
              SizedBox(
                height: 2,
              ),
              Center(
                  child: Text(
                "Foodizwall catalog",
                style: f15wB,
              )),
              SizedBox(
                height: 25,
              ),
              Text(
                "Category",
                style: f14w,
              ),
              SizedBox(
                height: 5,
              ),
              /*GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 170),
                        child: Dialog(
                          child: Container(
                            height: _con.KitchenCategories.length.toDouble() * 40,
                            color: Color(0xFF1E2026),
                            child: ListView.builder(
                                itemCount: _con.KitchenCategories.length,
                                itemBuilder: (context, ind) {
                                  return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          categ = _con.KitchenCategories[ind]["name"]
                                              .toString();
                                          categid = _con.KitchenCategories[ind]["id"]
                                              .toString();
                                          Navigator.pop(context);
                                        });
                                        _con.getSubCategories(
                                            categid.toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, bottom: 12, left: 20),
                                        child: Text(_con.KitchenCategories[ind]["name"]
                                            .toString(), style: f14w,),
                                      ));
                                }
                            ),
                          ),
                        ),
                      ));
                },
                child: Container(
                  height: 45,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey)
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(categ, style: f14w,),
                  ),
                ),
              ),*/
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[800], width: 1),
                      borderRadius: BorderRadius.circular(6)),
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton(
                      value: selected_category,
                      hint: Text(
                        "Select Category",
                        style: f14w,
                      ),
                      dropdownColor: Color(0xFF1E2026),
                      iconEnabledColor: Colors.grey,
                      iconSize: 25,
                      elevation: 16,
                      isExpanded: true,
                      style: f14w,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selected_category = newValue;
                        });
                      },
                      items: _con.KitchenCategories.map((item) {
                        return DropdownMenuItem(
                          value: item["name"],
                          onTap: () {
                            setState(() {
                              selected_category_id = item["id"].toString();
                            });
                            _con.getSubCategories(
                                selected_category_id.toString());
                          },
                          child: Text(item["name"]),
                        );
                      }).toList(),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                "Sub Category",
                style: f14w,
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, sss.StateSetter state) {
                          return Dialog(
                            child: Container(
                              color: Color(0xFF1E2026),
                              height:
                                  _con.Subcategories.length.toDouble() * 40 +
                                      52,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      sss.StateSetter state) {
                                                return Dialog(
                                                  backgroundColor:
                                                      Color(0xFF1E2026),
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      height: 375,
                                                      color: Color(0xFF1E2026),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            color: Color(
                                                                0xFF0dc89e),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Center(
                                                                    child: Text(
                                                                  "Suggest a Sub Category",
                                                                  style: f16wB,
                                                                )),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 17,
                                                                    width: 17,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color: Colors.grey[
                                                                                800],
                                                                            width:
                                                                                1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(2)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 12),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Category",
                                                                  style: f14w,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color: Colors.grey[
                                                                                800],
                                                                            width:
                                                                                1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6)),
                                                                    height: 45,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10),
                                                                      child:
                                                                          DropdownButton(
                                                                        value:
                                                                            selected_category,
                                                                        hint:
                                                                            Text(
                                                                          "Select Category",
                                                                          style:
                                                                              f14w,
                                                                        ),
                                                                        dropdownColor:
                                                                            Color(0xFF1E2026),
                                                                        iconEnabledColor:
                                                                            Colors.grey,
                                                                        iconSize:
                                                                            25,
                                                                        elevation:
                                                                            16,
                                                                        isExpanded:
                                                                            true,
                                                                        style:
                                                                            f14w,
                                                                        underline:
                                                                            Container(
                                                                          height:
                                                                              0,
                                                                        ),
                                                                        onChanged:
                                                                            (newValue) {
                                                                          state(
                                                                              () {
                                                                            selected_category =
                                                                                newValue;
                                                                          });
                                                                        },
                                                                        items: _con.KitchenCategories.map(
                                                                            (item) {
                                                                          return DropdownMenuItem(
                                                                            value:
                                                                                item["name"],
                                                                            onTap:
                                                                                () {
                                                                              state(() {
                                                                                selected_category_id = item["id"].toString();
                                                                              });
                                                                              _con.getSubCategories(selected_category_id.toString());
                                                                            },
                                                                            child:
                                                                                Text(item["name"]),
                                                                          );
                                                                        }).toList(),
                                                                      ),
                                                                    )),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Text(
                                                                  "Sub Category",
                                                                  style: f14w,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Container(
                                                                    height: 45,
                                                                    // width: MediaQuery.of(context).size.width,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          _subCatName,
                                                                      style:
                                                                          f14w,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding: EdgeInsets.only(
                                                                            top:
                                                                                6,
                                                                            left:
                                                                                8),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(6)),
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: Color(0xFF48c0d8)),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(6)),
                                                                          borderSide: BorderSide(
                                                                              color: Colors.grey[800],
                                                                              width: 1),
                                                                        ),
                                                                      ),
                                                                    )),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Center(
                                                                  child: imageFile !=
                                                                          null
                                                                      ? Stack(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          children: [
                                                                            Container(
                                                                                height: 90,
                                                                                width: 100,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(6),
                                                                                ),
                                                                                child: Image.file(
                                                                                  imageFile,
                                                                                  fit: BoxFit.cover,
                                                                                )),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 4, right: 4),
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  state(() {
                                                                                    imageFile = null;
                                                                                  });
                                                                                },
                                                                                child: Container(
                                                                                    height: 23,
                                                                                    width: 23,
                                                                                    decoration: BoxDecoration(color: Color(0xFFffd55e), borderRadius: BorderRadius.circular(100)),
                                                                                    child: Center(
                                                                                        child: Icon(
                                                                                      Icons.clear,
                                                                                      size: 18,
                                                                                    ))),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      : GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            _pickImage(state);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                90,
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(6),
                                                                              border: Border.all(color: Colors.grey[800], width: 1),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Image.asset(
                                                                                  "assets/Template1/image/Foodie/icons/add_image.png",
                                                                                  color: Colors.white,
                                                                                  height: 30,
                                                                                  width: 30,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 3,
                                                                                ),
                                                                                Text(
                                                                                  "Add Photo",
                                                                                  style: f14w,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                // Center(
                                                                //   child:
                                                                //       GestureDetector(
                                                                //     onTap: () {
                                                                //       showDialog(
                                                                //           context:
                                                                //               context,
                                                                //           child:
                                                                //               Dialog(
                                                                //             child:
                                                                //                 Container(
                                                                //               height: 170,
                                                                //               color: Color(0xFF1E2026),
                                                                //               child: Column(
                                                                //                 mainAxisAlignment: MainAxisAlignment.center,
                                                                //                 children: [
                                                                //                   Text(
                                                                //                     "Thank you for Your suggession\nOur support team will contact"
                                                                //                     "\nfor category Approval",
                                                                //                     style: f15wB,
                                                                //                     textAlign: TextAlign.center,
                                                                //                   ),
                                                                //                   SizedBox(
                                                                //                     height: 30,
                                                                //                   ),
                                                                //                   GestureDetector(
                                                                //                     onTap: () {
                                                                //                       Navigator.pop(context);
                                                                //                       Navigator.pop(context);
                                                                //                     },
                                                                //                     child: Container(
                                                                //                       height: 30,
                                                                //                       width: 80,
                                                                //                       decoration: BoxDecoration(color: Color(0xFF0dc89e), borderRadius: BorderRadius.circular(6)),
                                                                //                       child: Center(
                                                                //                           child: Text(
                                                                //                         "Close",
                                                                //                         style: f15wB,
                                                                //                       )),
                                                                //                     ),
                                                                //                   ),
                                                                //                 ],
                                                                //               ),
                                                                //             ),
                                                                //           ));
                                                                //       _startCatImageUpload();
                                                                //     },
                                                                //     child:
                                                                //         Container(
                                                                //       height:
                                                                //           30,
                                                                //       width: 80,
                                                                //       decoration: BoxDecoration(
                                                                //           borderRadius: BorderRadius.circular(
                                                                //               6),
                                                                //           color:
                                                                //               Color(0xFF0dc89e)),
                                                                //       child: Center(
                                                                //           child: Text(
                                                                //         "Save",
                                                                //         style:
                                                                //             f15wB,
                                                                //       )),
                                                                //     ),
                                                                //   ),
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, right: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Suggest New Sub Category',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/Template1/image/Foodie/icons/add-item-plus.png",
                                              height: 20,
                                              width: 20,
                                              color: Color(0xFF0dc89e),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height:
                                          _con.Subcategories.length.toDouble() *
                                              40,
                                      child: ListView.builder(
                                          itemCount: _con.Subcategories.length,
                                          itemBuilder: (context, ind1) {
                                            return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    subCatImg = _con
                                                        .Subcategories[ind1]
                                                            ["categories_image"]
                                                        .toString();
                                                    subCatg = _con
                                                        .Subcategories[ind1]
                                                            ["name"]
                                                        .toString();

                                                    subcategid = _con
                                                        .Subcategories[ind1]
                                                            ["id"]
                                                        .toString();
                                                    subcategtype = _con
                                                        .Subcategories[ind1]
                                                            ["id"]
                                                        .toString();
                                                    ShowBody = true;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8, bottom: 8),
                                                  child: Text(
                                                    _con.Subcategories[ind1]
                                                            ["name"]
                                                        .toString(),
                                                    style: f14w,
                                                  ),
                                                ));
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      });
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey[800], width: 1)),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      subCatg,
                      style: f14w,
                    ),
                  ),
                ),
              ),
              ShowBody == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              /* crossAxisAlignment: CrossAxisAlignment.start*/
                              children: <Widget>[
                                Container(
                                  height: 55,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              "https://firebasestorage.googleapis.com/v0/b/foodizwall.appspot.com/o/thumbs%2F" +
                                                      subCatImg +
                                                      "?alt=media"
                                                  ),
                                          fit: BoxFit.cover),
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color:
                                                Colors.black12.withOpacity(0.1),
                                            spreadRadius: 2.0)
                                      ]),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          subCatg.toString(),
                                          style: f14w,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          height: 14,
                                          width: 14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: subcategtype == "1"
                                                      ? Colors.red[600]
                                                      : Colors
                                                          .greenAccent[700]),
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                          child: Icon(
                                            Icons.brightness_1,
                                            color: subcategtype == "1"
                                                ? Colors.red[600]
                                                : Colors.greenAccent[700],
                                            size: 8,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "In " + categ.toString(),
                                      style: f12w,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ShowBody = false;
                                      categ = "Select Category";
                                      subCatg = "Select Sub Category";
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF0dc89e),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Center(
                                            child: Icon(
                                          Icons.clear,
                                          size: 16,
                                        ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 10),
                                  child: Container(
                                    height: 25,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFffd55e),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                      child: Text(
                                        "Selected",
                                        style: f14B,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Divider(
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Item Name",
                          style: f14w,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: Colors.grey[200], width: 1),
                              color: Colors.grey[700]),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              subCatg,
                              style: f14wB,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Display Name",
                          style: f14w,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            /* decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)
                ),*/
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: _displayName,
                              style: f14w,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 6, left: 8),
                                hintText: "Write a name to display...",
                                hintStyle: f14g,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF48c0d8)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(
                                      color: Colors.grey[800], width: 1),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sub Title Description",
                          style: f14w,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              border:
                                  Border.all(color: Colors.grey[800], width: 1),
                            ),
                            width: MediaQuery.of(context).size.width,
                            /* decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)
                ),*/
                            alignment: Alignment.topCenter,
                            child: TextField(
                              minLines: null,
                              maxLines: null,
                              expands: true,
                              controller: _subTitle,
                              style: f14w,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(top: 6, left: 8),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                              Row(
                                children: [
                                  Text(
                                    "Hot Deal",
                                    style: f15w,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white70,
                                    ),
                                    child: Checkbox(
                                        value: hot_deal,
                                        checkColor: Colors.black,
                                        activeColor: Color(0xFF48c0d8),
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            hot_deal = newValue;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Price",
                                  style: f14wB,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "(Including GST)",
                                  style: f11w,
                                ),
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 90,
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    amount = int.parse(val);
                                  });
                                },
                                style: f14w,
                                controller: _price,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixText: "\u20B9 ",
                                  prefixStyle: f14w,
                                  contentPadding:
                                      EdgeInsets.only(top: 6, left: 8),
                                  hintText: "0",
                                  hintStyle: f14w,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFF48c0d8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(
                                        color: Colors.grey[800], width: 1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discounted Price",
                                  style: f14wB,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "(Including GST)",
                                  style: f11w,
                                ),
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 90,
                              child: TextField(
                                style: f14w,
                                controller: _discountPrice,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixText: "\u20B9 ",
                                  prefixStyle: f14w,
                                  contentPadding:
                                      EdgeInsets.only(top: 6, left: 8),
                                  hintText: "0",
                                  hintStyle: f14w,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFF48c0d8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(
                                        color: Colors.grey[800], width: 1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount Percentage",
                              style: f14wB,
                            ),
                            Container(
                              height: 30,
                              width: 90,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                border: Border.all(
                                    color: Colors.grey[200], width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  int.parse(_discountPrice.text) > 0
                                      ? ((int.parse(_discountPrice.text) /
                                                      int.parse(_price.text)) *
                                                  100)
                                              .toString() +
                                          "%"
                                      : "0%",
                                  style: f14w,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Packaging Price",
                                      style: f14wB,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "(Including All TAxes)",
                                      style: f11w,
                                    ),
                                  ],
                                ),
                                FlatButton(
                                    splashColor: Colors.grey[600],
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                backgroundColor:
                                                    Color(0xFF1E2026),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.white,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0))),
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                content: StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      sss.StateSetter state) {
                                                    return SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        161,
                                                                    child: Text(
                                                                      "Packaging Charge Guide",
                                                                      style:
                                                                          f15GB,
                                                                    )),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20,
                                                                    ))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        3.8,
                                                                    child: Text(
                                                                      "Item Price",
                                                                      style:
                                                                          f12w,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      "Maximum Packaging Charge",
                                                                      style:
                                                                          f13w,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
                                                              thickness: .5,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _packing.text =
                                                                      "5";
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3.2,
                                                                      child:
                                                                          Text(
                                                                        "<50",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3.2,
                                                                      child:
                                                                          Text(
                                                                        "5",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
                                                              thickness: .5,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _packing.text =
                                                                      "7";
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3.2,
                                                                      child:
                                                                          Text(
                                                                        "50 - 150",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3,
                                                                      child:
                                                                          Text(
                                                                        "7",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
                                                              thickness: .5,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _packing.text =
                                                                      "10";
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3.2,
                                                                      child:
                                                                          Text(
                                                                        "151 - 300",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3,
                                                                      child:
                                                                          Text(
                                                                        "10",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
                                                              thickness: .5,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _packing.text =
                                                                      "15";
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3.2,
                                                                      child:
                                                                          Text(
                                                                        "301 - 500",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3,
                                                                      child:
                                                                          Text(
                                                                        "15",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
                                                              thickness: .5,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _packing.text =
                                                                      "20";
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3.2,
                                                                      child:
                                                                          Text(
                                                                        "500+",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3,
                                                                      child:
                                                                          Text(
                                                                        "20",
                                                                        style:
                                                                            f14w,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ));
                                          });
                                    },
                                    child: Text(
                                      "Guide",
                                      style: f14GB,
                                    ))
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 90,
                              child: TextField(
                                readOnly: true,
                                controller: _packing,
                                //
                                style: f14w,
                                // contronSubmitted : (val){
                                //                           //   setState(() {
                                //                           //     product_cost= int.parse(val) + servicecharge;
                                //                           //   });
                                //                           // },oller: _earnings,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  /*prefixText: "\u20B9 ",prefixStyle: f14w,*/
                                  contentPadding:
                                      EdgeInsets.only(top: 6, left: 8),
                                  // hintText: ,
                                  hintStyle: f14w,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFF48c0d8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(
                                        color: Colors.grey[800], width: 1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "GST\u002A",
                              style: f14wB,
                            ),
                            Container(
                              height: 30,
                              width: 90,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[800], width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DropdownButton(
                                  value: gst,
                                  hint: Text(
                                    "Select",
                                    style: f14g,
                                  ),
                                  dropdownColor: Color(0xFF1E2026),
                                  iconEnabledColor: Colors.grey,
                                  iconSize: 25,
                                  elevation: 16,
                                  isExpanded: true,
                                  style: f14w,
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      gst = newValue;
                                    });
                                    print("TTTTTTTTTTTTTTTt " + gst);
                                  },
                                  items: GST.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item + "%"),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              border:
                                  Border.all(color: Colors.grey[200], width: 1),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Final Pricing",
                                      style: f18WB,
                                    ),
                                    Text(
                                      int.parse(_price.text)>0 && int.parse(_packing.text)>0 && int.parse(_discountPrice.text)>0 ? "\u20B9"+((/*int.parse(_price.text)*/-int.parse(_discountPrice.text))+int.parse(_packing.text)).toString()
                                          : "\u20B90",
                                      style: f18yB,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Price + Packaging + GST",
                                      style: f12wB,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Please ensure the item matches the price in your menu to\navoid rejection of changes",
                                  style: f11w,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Min  Qty", style: f14wB),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey[800], width: 1)),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: DropdownButton(
                                      value: quantity_value,
                                      hint: Text(
                                        "Select",
                                        style: f14g,
                                      ),
                                      dropdownColor: Color(0xFF1E2026),
                                      iconEnabledColor: Colors.grey,
                                      iconSize: 25,
                                      elevation: 16,
                                      isExpanded: true,
                                      style: f14w,
                                      underline: Container(
                                        height: 0,
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          quantity_value = newValue;
                                        });
                                      },
                                      items: Quantity.map((item) {
                                        return DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Self Delivery\nDistance",
                                  style: f14wB,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey[800], width: 1)),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: DropdownButton(
                                      value: distance_value,
                                      hint: Text(
                                        "Select",
                                        style: f14g,
                                      ),
                                      dropdownColor: Color(0xFF1E2026),
                                      iconEnabledColor: Colors.grey,
                                      iconSize: 25,
                                      elevation: 16,
                                      isExpanded: true,
                                      style: f14w,
                                      underline: Container(
                                        height: 0,
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          distance_value = newValue;
                                        });
                                      },
                                      items: Distance.map((item) {
                                        return DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Container(
                                              height: 80,
                                              width: 110,
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.file(
                                                imageList[ind],
                                                fit: BoxFit.cover,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 93.0, top: 5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageList.removeAt(ind);
                                                    });
                                                  },
                                                  child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFFffd55e),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                            : Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      //size:50,
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            getImageFromCamera(context);
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
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              loadAssets();
                                            },
                                            child: Text("Upload from gallery",
                                                style: f15wB)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        /* Text("Item Timings",style: f18WB,),
                  SizedBox(height: 3,),
                  Text("Please specify the timings when this item will be available on Butomy.",style: f15wB,),

                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.white60,
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          value: 0,toggleable: true,
                          groupValue: sel,
                          onChanged: (int val){
                            setState(() {
                              sel = val;
                            });
                          },
                          activeColor: Color(0xFFffd55e),
                          title:Text(
                            "Item is available at all times when kitchen / restaurant is open on Butomy",
                            style: f14w,
                          ) ,
                        ),
                        RadioListTile(
                          value: 1,toggleable: true,
                          groupValue: sel,
                          onChanged: (int val){
                            setState(() {
                              sel = val;
                            });
                          },
                          activeColor: Color(0xFFffd55e),
                          title:Text(
                            "Item is available at same time for all days of the week",
                            style: f14w,
                          ) ,
                        ),
                        sel == 1 ? Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white10,
                              child: Padding(
                                padding: const EdgeInsets.only(top:8,bottom: 8),
                                child: Row(
                                  children: [
                                    SizedBox(width: 30,),
                                    Container(
                                        width: MediaQuery.of(context).size.width/5.25,
                                        child: Text("Days",style: f14w,)),
                                    Container(
                                        width: MediaQuery.of(context).size.width/4.4,
                                        child: Text("Start",style: f14w,)),
                                    Container(
                                        width: MediaQuery.of(context).size.width/4,
                                        child: Text("End",style: f14w,))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  SizedBox(width: 30,),
                                  Container(
                                      width: MediaQuery.of(context).size.width/5.25,
                                      child: Text("All Days",style: f13w,)),
                                  GestureDetector(
                                    onTap: (){
                                      _selectTime1(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/4.4,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 33,width: 75,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: Colors.white)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                  ))
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom:4.0),
                                                    child: Text(_time1!=null ? _time1.toString().split(":")[0] :"",style: f14w,),
                                                  ),
                                                ),
                                              ),
                                              Text(":",style: f16wB,),
                                              Container(
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(
                                                        color: Colors.white
                                                    ))
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom:4.0),
                                                    child: Text(_time1!=null ? _time1.toString().split(":")[1] :"",style: f14w,),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      _selectTime2(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/5,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 33,width: 75,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: Colors.white)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(
                                                        color: Colors.white
                                                    ))
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom:4.0),
                                                    child: Text(_time2!=null ? _time2.toString().split(":")[0] :"",style: f14w,),
                                                  ),
                                                ),
                                              ),
                                              Text(":",style: f16wB,),
                                              Container(
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(
                                                        color: Colors.white
                                                    ))
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom:4.0),
                                                    child: Text(_time2!=null ? _time2.toString().split(":")[1] :"",style: f14w,),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                 */ /* IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.delete_outline,color: Colors.white,size: 20,
                                  )),*/ /*


                                ],),
                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.add_circle_outline,color: Colors.white,size: 25,
                                    )),
                              ],
                            )
                          ],
                        ) : Container(),
                        RadioListTile(
                          value: 2,toggleable: true,
                          groupValue: sel,
                          onChanged: (int val){
                            setState(() {
                              sel = val;
                            });
                          },
                          activeColor: Color(0xFFffd55e),
                          title:Text(
                            "Item is available at different times during different days of the week",
                            style: f14w,
                          ) ,
                        ),
                        sel == 2 ? Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white10,
                              child: Padding(
                                padding: const EdgeInsets.only(top:8,bottom: 8),
                                child: Row(
                                  children: [
                                    SizedBox(width: 30,),
                                    Container(
                                        width: MediaQuery.of(context).size.width/5.25,
                                        child: Text("Days",style: f14w,)),
                                    Container(
                                        width: MediaQuery.of(context).size.width/4.4,
                                        child: Text("Start",style: f14w,)),
                                    Container(
                                        width: MediaQuery.of(context).size.width/4,
                                        child: Text("End",style: f14w,))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(children: [
                              SizedBox(width: 30,),
                              Container(
                                  width: MediaQuery.of(context).size.width/5.25,
                                  child: Text("Monday",style: f13w,)),
                              GestureDetector(
                                onTap: (){
                                  _selectTime1(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/4.4,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _selectTime2(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/5,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                               IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.delete_outline,color: Colors.white,size: 20,
                                      )),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.add_circle_outline,color: Colors.white,size: 25,
                                  )),


                            ],),
                            Row(children: [
                              SizedBox(width: 30,),
                              Container(
                                  width: MediaQuery.of(context).size.width/5.25,
                                  child: Text("Tuesday",style: f13w,)),
                              GestureDetector(
                                onTap: (){
                                  _selectTime1(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/4.4,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _selectTime2(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/5,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.delete_outline,color: Colors.white,size: 20,
                                  )),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.add_circle_outline,color: Colors.white,size: 25,
                                  )),


                            ],),
                            Row(children: [
                              SizedBox(width: 30,),
                              Container(
                                  width: MediaQuery.of(context).size.width/5.25,
                                  child: Text("Wednesday",style: f13w,)),
                              GestureDetector(
                                onTap: (){
                                  _selectTime1(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/4.4,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _selectTime2(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/5,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.delete_outline,color: Colors.white,size: 20,
                                  )),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.add_circle_outline,color: Colors.white,size: 25,
                                  )),


                            ],),
                            Row(children: [
                              SizedBox(width: 30,),
                              Container(
                                  width: MediaQuery.of(context).size.width/5.25,
                                  child: Text("Thursday",style: f13w,)),
                              GestureDetector(
                                onTap: (){
                                  _selectTime1(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/4.4,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _selectTime2(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/5,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.delete_outline,color: Colors.white,size: 20,
                                  )),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.add_circle_outline,color: Colors.white,size: 25,
                                  )),


                            ],),
                            Row(children: [
                              SizedBox(width: 30,),
                              Container(
                                  width: MediaQuery.of(context).size.width/5.25,
                                  child: Text("Friday",style: f13w,)),
                              GestureDetector(
                                onTap: (){
                                  _selectTime1(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/4.4,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _selectTime2(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/5,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.delete_outline,color: Colors.white,size: 20,
                                  )),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.add_circle_outline,color: Colors.white,size: 25,
                                  )),


                            ],),
                            Row(children: [
                              SizedBox(width: 30,),
                              Container(
                                  width: MediaQuery.of(context).size.width/5.25,
                                  child: Text("Saturday",style: f13w,)),
                              GestureDetector(
                                onTap: (){
                                  _selectTime1(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/4.4,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _selectTime2(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/5,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.delete_outline,color: Colors.white,size: 20,
                                  )),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.add_circle_outline,color: Colors.white,size: 25,
                                  )),


                            ],),
                            Row(children: [
                              SizedBox(width: 30,),
                              Container(
                                  width: MediaQuery.of(context).size.width/5.25,
                                  child: Text("Sunday",style: f13w,)),
                              GestureDetector(
                                onTap: (){
                                  _selectTime1(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/4.4,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time1!=null ? _time1.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _selectTime2(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/5,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 33,width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 5,top: 4),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[0] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                          Text(":",style: f16wB,),
                                          Container(
                                            width: 25,
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(
                                                    color: Colors.white
                                                ))
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:4.0),
                                                child: Text(_time2!=null ? _time2.toString().split(":")[1] :"",style: f14w,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.delete_outline,color: Colors.white,size: 20,
                                  )),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.add_circle_outline,color: Colors.white,size: 25,
                                  )),


                            ],),
                          ],
                        ) : Container(),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),*/
                        Text(
                          "Items will be active after Approval in 24 hrs in item list.",
                          style: f14w,
                        ),
                        SizedBox(
                          height: 2,
                        )
                      ],
                    )
                  : Container(
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 40,
          child: MaterialButton(
            height: 40,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: Color(0xFF48c0d8),
            splashColor: Color(0xFFffd55e),
            onPressed: () {
              _startUpload();
            },
            child: Center(
                child: Text(
              "Add",
              style: f16B,
            )),
          ),
        ),
      ),
    );
  }
}
