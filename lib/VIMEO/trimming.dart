import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/New_Entry_Form.dart';
import 'package:Butomy/VIMEO/final_video.dart';
import 'package:video_trimmer/trim_editor.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:video_trimmer/video_viewer.dart';

class TrimmerView extends StatefulWidget {
  final Trimmer _trimmer;
  String typ;
  TrimmerView(this._trimmer,this.typ);
  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String _value;

    await widget._trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
        .then((value) {
      setState(() {
        _progressVisibility = false;
        _value = value;
      });
    });

    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 5,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF1E2026),
          brightness: Brightness.dark,
          titleSpacing: 0,
          title: Text("Video Edit",style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
              splashColor: Color(0xFFffd55e),
              onPressed: _progressVisibility
                  ? null
                  : () async {
                setState(() {

                });
                _saveVideo().then((outputPath) {
                  print('OUTPUT PATH: $outputPath');
                  setState(() {
                    videooooWid = File(outputPath);
                    videoooooooooooo = VideoPlayerController.file( File(outputPath))
                      ..initialize().then((_) {
                        setState(() {
                          videoooooooooooo.pause();
                        });
                      });
                  });
                  Navigator.pop(context);

                 /* Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => AddNewEntries(videooo: outputPath,vid_show: true,typpp: widget.typ,),
                    ),
                  );*/
                });
              },
              icon: Icon(Icons.check,color: Color(0xFF48c0d8),size: 30,),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Builder(
            builder: (context) => Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Visibility(
                      visible: _progressVisibility,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    SizedBox(height: 3,),
                    Center(
                      child: TrimEditor(fit: BoxFit.cover,
                        viewerHeight: 50.0,
                        viewerWidth: MediaQuery.of(context).size.width,
                        maxVideoLength: Duration(seconds: 60),
                        onChangeStart: (value) {
                          _startValue = value;
                        },
                        onChangeEnd: (value) {
                          _endValue = value;
                        },
                        onChangePlaybackState: (value) {
                            _isPlaying = value;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Stack(alignment: Alignment.center,
                      children: [
                        VideoViewer(),
                        FlatButton(
                          child: _isPlaying
                              ? Icon(
                            Icons.pause,
                            size: 80.0,
                            color: Colors.white,
                          )
                              : Icon(
                            Icons.play_arrow,
                            size: 80.0,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            bool playbackState =
                            await widget._trimmer.videPlaybackControl(
                              startValue: _startValue,
                              endValue: _endValue,
                            );
                            setState(() {
                              _isPlaying = playbackState;
                            });
                          },
                        )
                      ],
                    ),



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}