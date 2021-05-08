import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import "dart:collection";

//throw UnimplementedError();

class QualityLinks {
  String videoId;

  QualityLinks(this.videoId);

  getQualitiesSync() {
    return getQualitiesAsync();
  }

  Future<SplayTreeMap> getQualitiesAsync() async {
    try {
      print("@@@@@@@@@ 11111111111");
      var response = await http
          .get('https://player.vimeo.com/video/' + videoId + '/config');
      print("@@@@@@@@@ 222222222222");
      print("zsxdcfgvbhnjkm ############"+jsonDecode(response.body).toString());
      var jsonData =
      jsonDecode(response.body)['request']['files']['progressive'];
      print("zsxdcfgvbhnjkm "+jsonDecode(response.body));
      SplayTreeMap videoList = SplayTreeMap.fromIterable(jsonData,
          key: (item) => "${item['quality']} ${item['fps']}",
          value: (item) => item['url']);
      return videoList;
    } catch (error) {
      print('=====> REQUEST ERROR 22222222222: $error');
      return null;
    }
  }
}