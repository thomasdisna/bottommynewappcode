import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'add_form_22.dart';

var categid, categ;
var subcategid, subCatg;
bool showImage;

class AddIt extends StatefulWidget {
  @override
  _AddItState createState() => _AddItState();
}

class _AddItState extends StateMVC<AddIt> {
  File imageFile;

  Future<Null> _pickImage(val) async {
    imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    if (imageFile != null) {
      val(() {});
      _cropImage(val);
    }
  }

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

  _AddItState() : super(HomeKitchenRegistration()) {
    _con = controller;
  }

  TextEditingController _subCatName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      showImage = false;
      categ = "Select Category";
      subCatg = "Select sub Category";
    });
    _con.getKitchenCategories(1);
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
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Center(child: Text("To begin adding products", style: f15w,)),
              SizedBox(height: 20,),
              Center(child: Text("Find your products in", style: f16wB,)),
              SizedBox(height: 2,),
              Center(child: Text("Foodizwall catalog", style: f15wB,)),
              SizedBox(height: 30,),
              Text("Category", style: f14w,),
              SizedBox(height: 5,),
              // GestureDetector(
              //   onTap: () {
              //     showDialog(
              //         context: context,
              //         child: Padding(
              //           padding: const EdgeInsets.only(top: 170),
              //           child: Dialog(
              //             child: Container(
              //               height: _con.KitchenCategories.length.toDouble() * 40,
              //               color: Color(0xFF1E2026),
              //               child: ListView.builder(
              //                   itemCount: _con.KitchenCategories.length,
              //                   itemBuilder: (context, ind) {
              //                     return GestureDetector(
              //                         onTap: () {
              //                           setState(() {
              //                             categ = _con.KitchenCategories[ind]["name"]
              //                                 .toString();
              //                             categid = _con.KitchenCategories[ind]["id"]
              //                                 .toString();
              //                             Navigator.pop(context);
              //                           });
              //                           _con.getSubCategories(
              //                               categid.toString());
              //                         },
              //                         child: Padding(
              //                           padding: const EdgeInsets.only(
              //                               top: 12, bottom: 12, left: 20),
              //                           child: Text(_con.KitchenCategories[ind]["name"]
              //                               .toString(), style: f14w,),
              //                         ));
              //                   }
              //               ),
              //             ),
              //           ),
              //         ));
              //   },
              //   child: Container(
              //     height: 45,
              //     width: MediaQuery
              //         .of(context)
              //         .size
              //         .width,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(6),
              //         border: Border.all(color: Colors.white)
              //     ),
              //     alignment: Alignment.centerLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(categ, style: f14w,),
              //     ),
              //   ),
              // ),
              SizedBox(height: 15,),
              Text("Sub Category", style: f14w,),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (BuildContext context,
                                sss.StateSetter setState) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Dialog(
                                  child: Container(
                                    color: Color(0xFF1E2026),
                                    height: _con.Subcategories.length
                                        .toDouble() * 40 +
                                        52,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                        builder: (
                                                            BuildContext context,
                                                            sss.StateSetter state) {
                                                          return Dialog(
                                                            backgroundColor: Color(
                                                                0xFF1E2026),
                                                            child: Container(
                                                              height: 375,
                                                              color: Color(
                                                                  0xFF1E2026),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 40,
                                                                    color: Color(
                                                                        0xFF0dc89e),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceAround,
                                                                      children: [
                                                                        Center(
                                                                            child: Text(
                                                                              "Suggest a Sub Category",
                                                                              style: f16wB,)),
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            Navigator
                                                                                .pop(
                                                                                context);
                                                                          },
                                                                          child: Container(
                                                                            height: 17,
                                                                            width: 17,
                                                                            decoration: BoxDecoration(
                                                                                border: Border
                                                                                    .all(
                                                                                    color: Colors
                                                                                        .white),
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    2)),
                                                                            child: Center(
                                                                              child: Icon(
                                                                                Icons
                                                                                    .close,
                                                                                color: Colors
                                                                                    .white,
                                                                                size: 15,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 12,
                                                                        right: 12),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          "Category",
                                                                          style: f14w,),
                                                                        SizedBox(
                                                                          height: 5,),
                                                                        Container(
                                                                          height: 45,
                                                                          /*width: MediaQuery.of(context).size.width,*/
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius
                                                                                  .circular(
                                                                                  6),
                                                                              border: Border
                                                                                  .all(
                                                                                  color: Colors
                                                                                      .grey)
                                                                          ),
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child: Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                8.0),
                                                                            child: Text(
                                                                              categ,
                                                                              style: f14w,),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height: 20,),
                                                                        Text(
                                                                          "Sub Category",
                                                                          style: f14w,),
                                                                        SizedBox(
                                                                          height: 5,),
                                                                        Container(
                                                                            height: 45,
                                                                            // width: MediaQuery.of(context).size.width,
                                                                            alignment: Alignment
                                                                                .centerLeft,
                                                                            child: TextField(
                                                                              controller: _subCatName,
                                                                              style: f14w,
                                                                              decoration: InputDecoration(
                                                                                contentPadding: EdgeInsets
                                                                                    .only(
                                                                                    top: 6,
                                                                                    left: 8),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius
                                                                                      .all(
                                                                                      Radius
                                                                                          .circular(
                                                                                          6)),
                                                                                  borderSide: BorderSide(
                                                                                      width: 1,
                                                                                      color: Color(
                                                                                          0xFF48c0d8)),
                                                                                ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius
                                                                                      .all(
                                                                                      Radius
                                                                                          .circular(
                                                                                          6)),
                                                                                  borderSide: BorderSide(
                                                                                      width: 1,
                                                                                      color: Colors
                                                                                          .grey),
                                                                                ),
                                                                              ),
                                                                            )
                                                                        ),
                                                                        SizedBox(
                                                                          height: 15,),
                                                                        Center(
                                                                          child: imageFile !=
                                                                              null
                                                                              ? Stack(
                                                                            alignment: Alignment
                                                                                .topRight,
                                                                            children: [
                                                                              Container(
                                                                                  height: 90,
                                                                                  width: 100,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius
                                                                                        .circular(
                                                                                        6),
                                                                                  ),
                                                                                  child: Image
                                                                                      .file(
                                                                                    imageFile,
                                                                                    fit: BoxFit
                                                                                        .cover,)
                                                                              ),
                                                                              Padding(
                                                                                padding:
                                                                                const EdgeInsets
                                                                                    .only(
                                                                                    top: 4,
                                                                                    right: 4),
                                                                                child:
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    state(() {
                                                                                      imageFile =
                                                                                      null;
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                      height: 23,
                                                                                      width: 23,
                                                                                      decoration: BoxDecoration(
                                                                                          color: Color(
                                                                                              0xFFffd55e),
                                                                                          borderRadius:
                                                                                          BorderRadius
                                                                                              .circular(
                                                                                              100)),
                                                                                      child: Center(
                                                                                          child: Icon(
                                                                                            Icons
                                                                                                .clear,
                                                                                            size: 18,
                                                                                          ))),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                              : GestureDetector(
                                                                            onTap: () {
                                                                              _pickImage(
                                                                                  state);
                                                                            },
                                                                            child: Container(
                                                                              height: 90,
                                                                              width: 100,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    6),
                                                                                border: Border
                                                                                    .all(
                                                                                    color: Colors
                                                                                        .grey),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment
                                                                                    .center,
                                                                                children: [
                                                                                  Image
                                                                                      .asset(
                                                                                    "assets/Template1/image/Foodie/icons/add_image.png",
                                                                                    color: Colors
                                                                                        .white,
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
                                                                          height: 15,),
                                                                        Center(
                                                                          child: GestureDetector(
                                                                            onTap: () {
                                                                              Navigator
                                                                                  .pop(
                                                                                  context);
                                                                              _con
                                                                                  .HomekitchenAddSubCategory(
                                                                                  _subCatName
                                                                                      .text,
                                                                                  categid,
                                                                                  "image","","","",""
                                                                              );
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (
                                                                                      context) {
                                                                                    return StatefulBuilder(
                                                                                        builder: (
                                                                                            BuildContext context,
                                                                                            sss.StateSetter state) {
                                                                                          return Dialog(
                                                                                            child: Container(
                                                                                              height: 170,
                                                                                              color: Color(
                                                                                                  0xFF1E2026),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment
                                                                                                    .center,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    "Thank you for Your suggession\nOur support team will contact"
                                                                                                        "\nfor category Approval",
                                                                                                    style: f15wB,
                                                                                                    textAlign: TextAlign
                                                                                                        .center,),
                                                                                                  SizedBox(
                                                                                                    height: 30,),
                                                                                                  GestureDetector(
                                                                                                    onTap: () {
                                                                                                      Navigator
                                                                                                          .pop(
                                                                                                          context);
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      height: 30,
                                                                                                      width: 80,
                                                                                                      decoration: BoxDecoration(
                                                                                                          color: Color(
                                                                                                              0xFF0dc89e),
                                                                                                          borderRadius: BorderRadius
                                                                                                              .circular(
                                                                                                              6)
                                                                                                      ),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                            "Close",
                                                                                                            style: f15wB,)),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        });
                                                                                  });
                                                                            },
                                                                            child: Container(
                                                                              height: 30,
                                                                              width: 80,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius
                                                                                      .circular(
                                                                                      6),
                                                                                  color: Color(
                                                                                      0xFF0dc89e)
                                                                              ),
                                                                              child: Center(
                                                                                  child: Text(
                                                                                    "Save",
                                                                                    style: f15wB,)),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
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
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
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
                                                    color: Color(0xFF0dc89e),)
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: _con.Subcategories.length
                                                .toDouble() * 40,
                                            child: ListView.builder(
                                                itemCount: _con.Subcategories
                                                    .length,
                                                itemBuilder: (context, ind1) {
                                                  return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          subCatg = _con
                                                              .Subcategories[ind1]["name"]
                                                              .toString();
                                                          subcategid = _con
                                                              .Subcategories[ind1]["id"]
                                                              .toString();
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            top: 8, bottom: 8),
                                                        child: Text(_con
                                                            .Subcategories[ind1]["name"]
                                                            .toString(),
                                                          style: f14w,),
                                                      ));
                                                }
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      });
                },
                child: Container(
                  height: 45,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white)
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(subCatg, style: f14w,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddForm22()
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(height: 38,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                color: Color(0xFF48c0d8),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Center(child: Text("Next", style: f16wB,)),
          ),
        ),
      ),
    );
  }
}
