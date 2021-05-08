import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ThumbVideoWidget extends StatefulWidget {

  final bool play;
  final String url;

  const ThumbVideoWidget({Key key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _ThumbVideoWidgetState createState() => _ThumbVideoWidgetState();
}


class _ThumbVideoWidgetState extends State<ThumbVideoWidget> {
  VideoPlayerController videoPlayerController;

  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      //       Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return new Container(
            height: 102,
            width: 100,
            child: Card(color: Color(0xFF1E2026),
              key: new PageStorageKey(widget.url),
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Chewie(
                    key: new PageStorageKey(widget.url),
                    controller: ChewieController(
                      videoPlayerController: videoPlayerController,

                      // Prepare the video to be played and display the first frame
                      autoInitialize: true,allowFullScreen: false,
                      looping: false,
                      autoPlay: false,showControls: false,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else {
          return Center(
            child: CircularProgressIndicator(),);
        }
      },
    );
  }
}


