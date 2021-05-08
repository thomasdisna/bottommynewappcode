import 'package:flutter/material.dart';
import 'helper/fetch_preview.dart';

class LinkPreview extends StatefulWidget {
  String data_url;
  LinkPreview({this.data_url});

  @override
  _LinkPreviewState createState() => _LinkPreviewState();
}

class _LinkPreviewState extends State<LinkPreview> {
  String url;
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Link Preview'),),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value){
              setState(() {
                url = value;
              });
            },
          ),
          RaisedButton(onPressed: (){
            FetchPreview().fetch(widget.data_url).then((res){
              setState(() {
                data = res;
              });
            });
          }, child: Text('Fetch'),),

          _buildPreviewWidget()
        ],
      ),
    );
  }

  _buildPreviewWidget() {
    if (data == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: Image.network(data['image'],fit: BoxFit.contain,)),
    );
  }
}
