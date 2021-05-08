import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Controllers/Home_Kitchen_Controller/homekitchen_controller.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/kitchen_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/restaurant_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/DETAILSBUSINESPROF/store_prof.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';
var qrData;

class BusinessQRCode extends StatefulWidget {

   BusinessQRCode({this.name,this.pic,this.memberdate,this.page_id,this.time_id,this.type});
   String page_id,time_id,memberdate,name,pic,type;

  @override
  State<StatefulWidget> createState() => _BusinessQRCodeState();
}

class _BusinessQRCodeState extends State<BusinessQRCode> with SingleTickerProviderStateMixin {
  GlobalKey globalKey = new GlobalKey();
  var arr;
  String _dataString;
  String _inputErrorText;
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TabController tabController;
  setHomeKitpageTime() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  void initState() {
    print("busines name : "+widget.name+" pic : "+widget.pic);
    super.initState();
    setState(() {
      _dataString = "Foodiz,"+widget.type+","+widget.page_id+","+widget.time_id+","+widget.memberdate+","+widget.name;
    });
    var txt = "Follow me on Foodies"+userNAME+"https://saasinfomedia.com/foodiz/public/post/"+userNAME;
    tabController = TabController(length: 2, vsync: this);
    qrData = "Foodiz,3";
    arr = _dataString.split(',');
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("dctfuviygbhjk "+scanData.toString());
      setState(() {
        qrText = scanData;
        arr = qrText.split(',');
      });
      if (qrText != "" && qrText.contains('Foodiz')) {
        controller?.pauseCamera();
        arr[1]=="1" ? Navigator.push(context, MaterialPageRoute(
            builder: (context) => KitchenProf(currentindex: 1,memberdate: arr[4],pagid: arr[2],
            timid: arr[3],))) : arr[1]=="2" ? Navigator.push(context, MaterialPageRoute(
            builder: (context) => StoreProf(currentindex: 1,memberdate: arr[4],pagid: arr[2],
              timid: arr[3],))) : arr[3] ? Navigator.push(context, MaterialPageRoute(
            builder: (context) => RestProf(currentindex: 1,memberdate: arr[4],pagid: arr[2],
              timid: arr[3],))) : null;
      } else {
        controller?.resumeCamera();
      }

    });
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      await Share.file(
          'Share QR Code', 'QR.png', pngBytes.buffer.asUint8List(), 'image/png', text: ' Follow me on Foodiz ! '+" "+widget.name+"\n https://saasinfomedia.com/foodiz/public/"+widget.name);
    } catch (e) {
      print("error"+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1E2026),
        appBar: AppBar( brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "My QRCode",
            style: TextStyle(color: Colors.white),
          ),
          // leading: new Container(height: 0,),
          centerTitle: true,
          backgroundColor: Color(0xFF1E2026),
          bottom: getTabBar(),
        ),
        body: SafeArea(child: getTabBarPages()));
  }

  Widget getTabBar() {
    return TabBar(
        controller: tabController,
        labelColor: Color(0xFFffd55e),
        labelStyle: f15wB,
        unselectedLabelColor: Colors.white,
        indicatorColor: Color(0xFFffd55e),
        tabs: [
          Tab(text: "My QRCode"),
          Tab(text: "QRCode Scanner"),
        ]);
  }

  Widget qrGenerator(String data) {
    return RepaintBoundary(
      key: globalKey,
      child: QrImage(
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
        data: data,
        version: QrVersions.auto,
      ),
    );
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 60,),
        child: Column(
          children: [
            Stack(alignment: Alignment.topCenter,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:40.0),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.grey[850]),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.name, style: f16wB),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Container(
                              height: 180,
                              width: 180,
                              // width: MediaQuery.of(context).size.width,
                              child: qrGenerator(_dataString),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.pic,
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(180.0))),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40,left: 105,right: 105),
              child: Container(
                height: 45,
                child: MaterialButton(
                  splashColor: Color(0xFF48c0d8),
                  height: 45,minWidth: 90,
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8),),
                  onPressed: () {_captureAndSharePng();},
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          SizedBox(width: 3),
                          Text("Share QR Code", style: f16wB,
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Color(0xFF48c0d8),
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Text('This is the result of scan: $qrText'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 30,
                        color: Color(0xFFffd55e),
                        margin: EdgeInsets.all(8),
                        child: RaisedButton(
                          color: Color(0xFFffd55e),
                          onPressed: () {
                            if (controller != null) {
                              controller.toggleFlash();
                              if (_isFlashOn(flashState)) {
                                setState(() {
                                  flashState = flashOff;
                                });
                              } else {
                                setState(() {
                                  flashState = flashOn;
                                });
                              }
                            }
                          },
                          child:
                          Text(flashState, style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      Container(
                        height: 30,
                        color: Color(0xFFffd55e),
                        margin: EdgeInsets.all(8),
                        child: RaisedButton(
                          color: Color(0xFFffd55e),
                          onPressed: () {
                            if (controller != null) {
                              controller.flipCamera();
                              if (_isBackCamera(cameraState)) {
                                setState(() {
                                  cameraState = frontCamera;
                                });
                              } else {
                                setState(() {
                                  cameraState = backCamera;
                                });
                              }
                            }
                          },
                          child:
                          Text(cameraState, style: TextStyle(fontSize: 12)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ]);
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  bool _isBackCamera(String current) {
    return backCamera == current;
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
