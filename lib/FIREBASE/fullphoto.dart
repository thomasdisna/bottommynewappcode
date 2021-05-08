import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullPhoto extends StatefulWidget {
  final String url,name;

  FullPhoto({Key key,@required this.url,this.name}) : super(key: key);
  @override State createState() => new _FullPhoto();
}

class _FullPhoto extends State<FullPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2026),
        brightness: Brightness.dark,
        elevation: 5,
        title:  Text(widget.name==NAME ? "You" : widget.name,style: TextStyle(color: Colors.white),),
      ),
      body: GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.url),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 1.5,
                    );
                  },
                  itemCount: 1,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                      ),
                    ),
                  ),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ],
            )
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}