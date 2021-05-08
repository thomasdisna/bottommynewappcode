import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoThumbWidget extends StatefulWidget {

  final bool play;
  final String url;

  const VideoThumbWidget({Key key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _VideoThumbWidgetState createState() => _VideoThumbWidgetState();
}


class _VideoThumbWidgetState extends State<VideoThumbWidget> {
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
    //    widget.videoPlayerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return new Container(
            height: 250,
            child: Card(color: Color(0xFF1E2026),
              key: new PageStorageKey(widget.url),
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Chewie(
                    key: new PageStorageKey(widget.url),
                    controller: ChewieController(showControls: false,
                      videoPlayerController: videoPlayerController,
                      aspectRatio: 3 / 2,
                      // Prepare the video to be played and display the first frame
                      autoInitialize: true,allowFullScreen: false,
                      looping: false,
                      autoPlay: false,
                      // Errors can occur for example when trying to play a video
                      // from a non-existent URL
                     /* errorBuilder: (context, errorMessage) {
                        return Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },*/
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


