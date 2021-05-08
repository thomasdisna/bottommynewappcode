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

class QRCODE extends StatefulWidget {
  const QRCODE({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCODEState();
}

class _QRCODEState extends State<QRCODE> with SingleTickerProviderStateMixin {
  GlobalKey globalKey = new GlobalKey();
  var arr;
  String _dataString = "Foodiz,"+userid+","+NAME;
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
  getHome() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kit_page= prefs.getString('HK_page_id').toString();
    kit_tim= prefs.getString('HK_tim_id').toString();
  }
  void initState() {
    super.initState();
    getHome();
    setHomeKitpageTime();
    var txt = "Follow me on Foodies"+userNAME+"https://saasinfomedia.com/foodiz/public/post/"+userNAME;
    tabController = TabController(length: 2, vsync: this);
    qrData = "Foodiz,3";
    arr = _dataString.split(',');
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
          'Share QR Code', 'QR.png', pngBytes.buffer.asUint8List(), 'image/png', text: ' Follow me on Foodiz ! '+" "+NAME+"\n https://saasinfomedia.com/foodiz/public/"+userNAME);
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
        // backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        /*embeddedImage: AssetImage('assets/Template1/image/Foodie/icons/qr code ico.png',),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(25, 25),
        ),*/
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
                          Text(NAME, style: f16wB),
                          SizedBox(
                            height: 20,
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
                            userPIC,
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("ttttttttttttttttttttttt "+scanData.toString());
      setState(() {
        qrText = scanData;
        arr = qrText.split(',');
      });

      if (qrText != "" && qrText.contains('Foodiz')) {
        controller?.pauseCamera();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TimelineFoodWallDetailPage(
                  id: arr[1],
                )));
      } else {
        controller?.resumeCamera();

      }

    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
