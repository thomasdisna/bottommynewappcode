
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Butomy/VIMEO/trimming.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:vimeoplayer/vimeoplayer.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Trimmer _trimmer = Trimmer();


  File _video;

  Future getVideoGallery() async{
    var imageFile = await ImagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      _video = imageFile;
    });

    await _trimmer.loadVideo(videoFile: imageFile);


    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return TrimmerView(_trimmer,"");
        }));
  }

  Future getVideoCamera() async{
    var imageFile = await ImagePicker.pickVideo(source: ImageSource.camera);
    setState(() {
      _video = imageFile;
    });
  }

  int status =1;

  var video_id ="";

  Future uploadVideo(File videoFile) async{
    var uri = Uri.parse("https://saasinfomedia.com/vimeo/public/videoupload");
    var request = new MultipartRequest("POST", uri);

    var multipartFile = await MultipartFile.fromPath("video", videoFile.path);
    request.files.add(multipartFile);
    //StreamedResponse response = await request.send();
    http.Response response = await http.Response.fromStream(await request.send());
    var RegData = json.decode(response.body);
    if(response.statusCode==200){
      print(response.toString());
      print("Video uploaded");
      setState(() {
        status = 1;
        video_id = RegData['vimeo_id'].toString().replaceAll("/videos/", "");
        print("Vimeo ID : "+video_id.toString());
      });
    }else{
      print("Video upload failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image"),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _video==null
                ? new Text("No video selected!")
                : new Text("video is selected"),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.video_library),
                  onPressed: getVideoGallery,
                ),
                RaisedButton(
                  child: Icon(Icons.videocam),
                  onPressed: getVideoCamera,
                ),
                RaisedButton(
                  child: Text("UPLOAD video"),
                  onPressed:(){
                    uploadVideo(_video);
                  },
                ),
              ],
            ),
            SizedBox(height: 30,),
            status==1 ? Text("Vimeoo Video") : Container(),
            SizedBox(height: 20,),
           VimeoPlayer(id: "522718775",autoPlay: false,)
            //522658657 --> vimeo uploaded code
            //395212534 --> sample
            //522660517
          ],
        ),
      ),
    );
  }
}