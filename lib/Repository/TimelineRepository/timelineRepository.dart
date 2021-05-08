import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:Butomy/APIData/api.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Controllers/TimelineController/timelineWallController.dart';
import 'package:Butomy/Repository/UserLoginRepository/userRepository.dart';
import 'package:http/http.dart' as http;
import 'package:Butomy/Model/TimelineModel/timelineModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Butomy/Model/UserModel/userModel.dart';
var qDataNotf;
var flagNot=0;
List appUsers = [];
TimelineWallController obj;
TimelineData timeline_wall = new TimelineData();
User user = new User();

String status;
List post;
var dataUser;
var UserIdprefs;
var timedata;
var deldata1;
var AbtInfo;

Future getDistrictList(stateid) async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/districtlist?state_id="+stateid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['data'];
}

Future getStateList() async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/statelist"),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['data'];
}

Future signUp(name,surname,email,dob,gender,mobile,password,location_lat,location_long,token,state,district,locc,lastname) async {
  final String url = APIData.domainLink + "register";
  print("lllllllllllllllllllllllll "+lastname);
  final register = await http.post(url, body: {
    "name": name.toString(),
    "state": state.toString(),
    "district": district.toString(),
    "email": email.toString(),
    "password": password.toString(),
    "mobile": mobile.toString(),
    "gender": gender.toString(),
    "dob": dob.toString(),
    "username": surname.toString(),
    "current_location" : locc,
    "location_lat": location_lat.toString(),
    "location_long": location_long.toString(),
    "device_token": token.toString(),
    "lastname": lastname.toString(),
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future signIn(email,password) async {
  final String url = APIData.domainLink + "login";
  final register = await http.post(url, body: {
    "email": email.toString(),
    "password": password.toString(),
  });
  dataUser = json.decode(register.body);

  return dataUser;
}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserIdprefs = prefs.getString('userId');
}

Future Otp(ootp,userid) async {

  final String url = APIData.domainLink + "verifyotp";
  final otp = await http.post(url, body: {
    "userid": userid.toString(),
    "otp": ootp.toString(),
  });
  dataUser = json.decode(otp.body);


  return dataUser;
}

Future ResendOtp(userid) async {

  final String url = APIData.domainLink + "resendotp";
  final otp = await http.post(url, body: {
    "userid": userid.toString(),
  });
  dataUser = json.decode(otp.body);

  userid=dataUser['id'].toString();

  return dataUser;
}
//Registration
Future profileImage(avatarImage,userId) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/updateavatar";
  final register = await http.post(url, body: {
    "change_avatar":avatarImage.toString(),
    "userid":userId,
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future updateIdStatusRepoo(page_id,status) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/updateverifystatus";
  final register = await http.post(url, body: {
    "page_id":page_id.toString(),
    "status":status,
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future<User> logout() async {
  final response = await http.get(Uri.encodeFull("http"));
  var qData = json.decode(response.body);
  return qData['data'];
}


Future userListNamespace() async {
  // getUserId();
  final response = await http.get(
    Uri.encodeFull("https://saasinfomedia.com/foodiz/public/api/userlist"),
  );
  var qData = json.decode(response.body);


  /*List nameArr = qData;
  for (var i in nameArr) {
      appUsers.add(i["username"] +
          "#" +
          i["picture"].toString() +
          "#" +
          i["userid"].toString());

  }*/
  return qData;
}

Future<List> getTimeWall(user) async {
  getUserId();
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?memberid=" +
            user.toString()+"&pagecount="+starttim.toString()),
  );
  var qData = json.decode(response.body);
  return qData['posts'];
}

Future<List> getTimelineCommentList(postid, userid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/commentslist?user_id=" +
            userid +
            "&post_id=" +
            postid),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['comments'];
}

Future<List> getTimelineLike(postid, userid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewalllikes?post_id=" +
            postid.toString() +
            "&user_id=" +
            userid),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['likes'];
}

Future postTimelineCommentReplyList(postid, userid, desc, cmntid) async {
  // User.fromJSON(json.decode(response.body)['data']);
  final String url = APIData.domainLink + "post-comment";
  final register = await http.post(url, body: {
    "userid": userid,
    "post_id": postid,
    "description": desc,
    "comment_id": cmntid,
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future<List> getTimelineShare(postid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewallshares?post_id=" +
            postid.toString()+"&user_id="+userid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['shares'];
}

Future postTimelineCommentList(postid, userid, desc) async {
  // User.fromJSON(json.decode(response.body)['data']);
  final String url = APIData.domainLink + "post-comment";
  final register = await http.post(url, body: {
    "userid": userid,
    "post_id": postid,
    "description": desc,
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future deleteTimelineCommentList(commentid, userid) async {
  // User.fromJSON(json.decode(response.body)['data']);
  final String url =
      "https://saasinfomedia.com/foodiz/public/api/comment-delete";
  final register = await http.post(url, body: {
    "comment_id": commentid.toString(),
    "userid": userid.toString(),
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future reportTimelineWall(userid, post_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/report-post";

  final response = await http.post(url, body: {
    "userid": userid.toString(),
    "post_id": post_id.toString(),
  });
  var reportData = json.decode(response.body);
  if (reportData['status'] == "200") {
  } else {}
  return reportData;
}

Future deleteTimeWall(userid, post_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/post-delete";

  final response = await http.post(url, body: {
    "userid": userid.toString(),
    "post_id": post_id.toString(),
  });
  print("Delete status code : "+response.statusCode.toString());
  var deldata = json.decode(response.body);
  if (deldata['status'] == "200") {
  } else {}
  return deldata;
}

Future<List> likePostTimeline(userid, post_id) async {
  try {
    final String url = "https://saasinfomedia.com/foodiz/public/api/like-post";

    final response = await http.post(url, body: {
      "userid": userid.toString(),
      "memberid": userid.toString(),
      "post_id": post_id.toString(),
    });
    //deldata1 = json.decode(response.body);

    deldata1 = json.decode(response.body);
    if (deldata1['status'] == "200") {
    } else {}
    return deldata1["data"];
  } catch (e) {}
}

Future<List> likeOtherPostTimeline(userid, post_id) async {
  try {
    final String url = "https://saasinfomedia.com/foodiz/public/api/like-post";

    final response = await http.post(url, body: {
      "userid": userid.toString(),
      "memberid": userid.toString(),
      "post_id": post_id.toString(),
    });

    deldata1 = json.decode(response.body);
    if (deldata1['status'] == "200") {
    } else {}
    return deldata1["data"];
  } catch (e) {}
}

Future likeCommnetTimeline(userid, comment_id) async {
  // User.fromJSON(json.decode(response.body)['data']);
  final String url = APIData.domainLink + "like-comment";
  final register = await http.post(url, body: {
    "userid": userid.toString(),
    "comment_id": comment_id.toString(),
  });
  dataUser = json.decode(register.body);

  if (dataUser['status'] == "200") {
  } else {}
  return dataUser;
}

Future savePost(post_id, userid) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/savepost";
  final response = await http.post(url, body: {
    "post_id": post_id,
    "userid": userid,
    "memberid": userid,
  });
  var saveData = json.decode(response.body);
  if (saveData['status'] == 200) {
  } else {}
  return saveData;
}

Future editProf(userid, email, mobile, gender, dob, foodpref, name, username,favdish,loc,lat,long,lastname,bio,emailshow,mobshow,locshow,stateshow,distshow,dobshow) async {
  // User.fromJSON(json.decode(response.body)['data']);
  final String url = APIData.domainLink + "profileedit";
  final register = await http.post(url, body: {
    "user_id": userid.toString(),
    "lastname": lastname.toString(),
    "name": name.toString(),
    "surname": username.toString(),
    "email_show": emailshow.toString(),
    "mobile_show": mobshow.toString(),
    "location_show": locshow.toString(),
    "state_show": stateshow.toString(),
    "district_show": distshow.toString(),
    "dob_show": dobshow.toString(),
    "email": email.toString(),
    "bio": bio.toString(),
    "mobile": mobile.toString(),
    "gender": gender.toString(),
    "dob": dob.toString(),
    "food_preference": foodpref.toString(),
    "favourite_dishes": favdish,
    "current_location": loc,
    "location_lat": lat,
    "location_long": long,
  });
  dataUser = json.decode(register.body);
  if (dataUser['status'] == "200") {
  } else {
  }
  return dataUser;
}

Future<List> getFollowersList(userid,parentid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/followerslist?userid=" +
            userid.toString()+"&parentid="+parentid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['followers'];
}

Future<List> getParticularPost(postid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?post_id=" +
            postid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['posts'];
}

Future notificationList(userid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/allNotifications?user_id=" +
            userid.toString()),
  );
  qDataNotf = json.decode(
    response.body,
  );

  return qDataNotf;
}
Future notificationReadAll(userid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/notificationreadall?user_id=" +
            userid.toString()),
  );
  flagNot = 1;
  qDataNotf = json.decode(
    response.body,
  );

  return qDataNotf;
}


/*
Future<List> notificationList(userid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/allNotifications?user_id=" +
            userid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['data'];
}
*/

Future getFollowingList(userid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/followeringlist?userid=" +
            userid.toString()+"&parentid="),
  );
  var qData = json.decode(
    response.body,
  );
  return qData;
}

Future getOtherFollowingList(userid,uss) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/followeringlist?userid=" +
            userid.toString()+"&parentid="+uss),
  );
  var qData = json.decode(
    response.body,
  );
  return qData;
}

Future getTimeSearch(desc) async {
  // getUserId();
  print("searchh 333333333333 ");
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/searchtimelinewall?search_type=8&description=" +
            desc.toString()+"&user_id="+userid.toString()),
  );
  var qData = json.decode(response.body);
  print("searchh 44444444444444444444  "+qData.toString());
  return qData;
}

Future<List> getAccWall(userid) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?userid=" +
            userid.toString()),
  );
  var qData = json.decode(response.body);

  return qData['posts'];
}

Future FollowerRepo(userid, followerid) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/followuser";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);

  return dataUser;
}

Future<List> getAccWallVideos(timid, type, acc) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?timeline_id=" +
            timid.toString() +
            "&accountid=" +
            acc.toString() +
            "&type=" +
            type));
  var qData = json.decode(response.body);
  return qData['posts'];
}

Future<List> getPersonPost(tim, acc) async {
  print("ttyymm "+tim.toString());
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?timeline_id=" +
            tim.toString() +
            "&accountid=" +
            acc.toString()),
  );
  var qData = json.decode(response.body);
  return qData['posts'];
}

Future TimelineDescPost1(userid, description,pic,title,desc,site,link) async {
  print("urlll 55555555555555555555555555 : "+urlPost.toString());
  print("urlll 66666666666666666666666666666 : "+pic.toString());
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "url_image": pic.toString(),
    "url_title": title.toString(),
    "url_desc": desc.toString(),
    "url_site": site.toString(),
    "url_link": link.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}


Future TimelineDescPost2(userid, description,loc,lat,long,pic,title,desc,site,link) async {
  print("urlll 3333333333333333333 : "+pic.toString());

  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "post_location": loc.toString(),
    "post_lat": lat.toString(),
    "post_lng": long.toString(),
    "url_image": pic.toString(),
    "url_title": title.toString(),
    "url_desc": desc.toString(),
    "url_site": site.toString(),
    "url_link": link.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future EditPostTimDesc(description, post) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/editpost";
  final responseFollow = await http.post(url, body: {
    "post_id": post.toString(),
    "description": description.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future EditPostTimImage(description, postid,img,type) async {

  List<int> imageBytes = img.readAsBytesSync();
  String baseimage = base64Encode(imageBytes);
  final String url = "https://saasinfomedia.com/foodiz/public/api/editpost";
  final responseFollow = await http.post(url, body: {
    "post_id": post.toString(),
    "description": description.toString(),
    "post_image": baseimage,
    "type": type.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future EditPostTimVideo( description,postid, video) async {

  final String url = "https://saasinfomedia.com/foodiz/public/api/editpost";
  final responseFollow = await http.post(url, body: {
    "post_id": postid.toString(),
    "description": description.toString(),
    "video": video.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future TimelineWallPost1(userid, description, image, type,loc,lat,long) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "post_image": image,
    "type": type.toString(),
    "post_location": loc.toString(),
    "post_lat": lat.toString(),
    "post_lng": long.toString(),
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future TimelineWallPost2(userid, description, image, type,) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "post_image": image,
    "type": type.toString(),

    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future foodieBlogRepo(userid, title,desc, type,imageList,utube,location,locLat,locLong) async {

  var dataPost ={} ;

  dataPost["userid"] = userid;

  if(title.toString()!="" && title!= null) {
    dataPost["post_title"]=title;
  }

  if(desc.toString()!="" && desc!= null) {
    dataPost["description"]=desc;
  }

  if(type.toString()!="" && type!= null) {
    dataPost["type"]=type;
  }

  if(imageList.toString()!="" && imageList!= null) {
    dataPost["post_image"]=imageList;
  }

  if(utube.toString()!="" && utube!= null) {
    dataPost["video"]=utube;
    dataPost["video_type"] = "youtube";
  }

  if(location.toString()!="" && location!= null) {
    dataPost["post_location"]=location;
    dataPost["post_lat"]=locLat.toString();
    dataPost["post_lng"]=locLong.toString();
  }

print("Final Data -> "+dataPost.toString());
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: dataPost);
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future foodieBlogVideoRepo(userid, title,desc, type,imageList,video,location,locLat,locLong) async {
  print("_blogImageWithVideoUpload");
  var uri = Uri.parse("https://saasinfomedia.com/vimeo/public/createvideopost");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = await http.MultipartFile.fromPath("video", video);
  request.files.add(multipartFile);
  request.fields['userid'] = userid.toString();
  request.fields['video_type'] = "video";

  if(title.toString()!="" && title!= null){
    request.fields['post_title'] = title.toString();
  }

  if(desc.toString()!="" && desc!= null) {
    request.fields['description'] = desc.toString();}

  if(type.toString()!="" && type!= null){
    request.fields['type'] = type.toString();
  }

  if(imageList.toString()!="" && imageList!= null){
    request.fields['post_image'] = imageList.toString();
  }

  if(location.toString()!="" && location!= null) {
    request.fields['post_location'] = location.toString();
    request.fields['post_lat'] = locLat.toString();
    request.fields['post_lng'] = locLong.toString();
  }
  http.Response response = await http.Response.fromStream(await request.send());

  print("codeeeee "+response.statusCode.toString());

  var RegData = json.decode(response.body);
  if(response.statusCode==200){
    print(response.toString());
    print("Video uploaded "+RegData.toString());
  }else{
    print("Video upload failed "+RegData.toString());
  }
  return RegData;
}

Future BlogPost1(userid, description, image, type,_location,lat,lng,title) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "post_image": image,
    "type" : "image",
    "post_type": "Blog",
    "post_title" : title,
    "post_location": _location.toString(),
    "post_lat": lat.toString(),
    "post_lng": lng.toString(),
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future BlogPost2(userid, description, image, type,title) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "post_image": image,
    "post_type": "Blog",
    "post_title" : title,
    "type" : "image",
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future BlogPost3(userid, description, image, type,title,video) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "post_image": image,
    "post_type": "Blog",
    "type" : "image",
    "video": video.toString(),
    "video_type" : "youtube",
    "post_title" : title,
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}
Future BlogPost4(userid, description, image, type,_location,lat,lng,title,video) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "post_image": image,
    "post_type": "Blog",
    "type" : "image",
    "post_title" : title,
    "video": video.toString(),
    "video_type" : "youtube",
    "post_location": _location.toString(),
    "post_lat": lat.toString(),
    "post_lng": lng.toString(),
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future foodieVideoPost(userid, description, video,_location,lat,lng) async {

  var uri = Uri.parse("https://saasinfomedia.com/vimeo/public/createvideopost");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = await http.MultipartFile.fromPath("video", video);
  request.files.add(multipartFile);
  request.fields['userid'] = userid.toString();

  if(description!=null && description!=""){
    request.fields['description'] = description.toString();
  }

  if(_location!=null && _location!=""){
    request.fields['post_location'] = _location.toString();
    request.fields['post_lat'] = lat.toString();
    request.fields['post_lng'] = lng.toString();
  }
  //StreamedResponse response = await request.send();
  http.Response response = await http.Response.fromStream(await request.send());
  var RegData = json.decode(response.body);
  if(response.statusCode==200){
    print(response.toString());
    print("Video uploaded "+RegData.toString());
  }else{
    print("Video upload failed "+RegData.toString());
  }
  return RegData;
}

Future TimelineOwnVideoPost2(userid, description, video,ext) async {
  var uri = Uri.parse("https://saasinfomedia.com/vimeo/public/createvideopost");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = await http.MultipartFile.fromPath("video", video);
  request.files.add(multipartFile);
  request.fields['userid'] = userid.toString();
  request.fields['description'] = description.toString();
  //StreamedResponse response = await request.send();
  http.Response response = await http.Response.fromStream(await request.send());
  var RegData = json.decode(response.body);
  if(response.statusCode==200){
    print(response.toString());
    print("Video uploaded "+RegData.toString());
  }else{
    print("Video upload failed "+RegData.toString());
  }
  return RegData;
}

Future postBlogimageOwnVideoPost(userid, description, image, type, title,video,_location,lat,lng) async {
  var uri = Uri.parse("https://saasinfomedia.com/vimeo/public/createvideopost");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = await http.MultipartFile.fromPath("video", video);
  request.files.add(multipartFile);
  request.fields['userid'] = userid.toString();
  request.fields['description'] = description.toString();
  request.fields['type'] = type.toString();
  request.fields['post_image'] = image.toString();
  request.fields['post_title'] = title.toString();
  request.fields['post_location'] = _location.toString();
  request.fields['post_lat'] = lat.toString();
  request.fields['post_lng'] = lng.toString();
  //StreamedResponse response = await request.send();
  http.Response response = await http.Response.fromStream(await request.send());
  var RegData = json.decode(response.body);
  if(response.statusCode==200){
    print(response.toString());
    print("Video uploaded "+RegData.toString());
  }else{
    print("Video upload failed "+RegData.toString());
  }
  return RegData;
}

Future postBlogimageOwnVideoPost2(userid, description, image, type, title,video,) async {
  var uri = Uri.parse("https://saasinfomedia.com/vimeo/public/createvideopost");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = await http.MultipartFile.fromPath("video", video);
  request.files.add(multipartFile);
  request.fields['userid'] = userid.toString();
  request.fields['description'] = description.toString();
  request.fields['type'] = type.toString();
  request.fields['post_image'] = image.toString();
  request.fields['post_title'] = title.toString();
  //StreamedResponse response = await request.send();
  http.Response response = await http.Response.fromStream(await request.send());
  var RegData = json.decode(response.body);
  if(response.statusCode==200){
    print(response.toString());
    print("Video uploaded "+RegData.toString());
  }else{
    print("Video upload failed "+RegData.toString());
  }
  return RegData;
}


Future postBlogOwnVideoPost(userid, description, type, title,video,_location,lat,lng) async {
  var uri = Uri.parse("https://saasinfomedia.com/vimeo/public/createvideopost");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = await http.MultipartFile.fromPath("video", video);
  request.files.add(multipartFile);
  request.fields['userid'] = userid.toString();
  request.fields['description'] = description.toString();
  request.fields['type'] = type.toString();
  request.fields['post_title'] = title.toString();
  request.fields['post_location'] = _location.toString();
  request.fields['post_lat'] = lat.toString();
  request.fields['post_lng'] = lng.toString();
  //StreamedResponse response = await request.send();
  http.Response response = await http.Response.fromStream(await request.send());
  var RegData = json.decode(response.body);
  if(response.statusCode==200){
    print(response.toString());
    print("Video uploaded "+RegData.toString());
  }else{
    print("Video upload failed "+RegData.toString());
  }
  return RegData;
}

Future postBlogOwnVideoPost2(userid, description, type, title,video,) async {
  var uri = Uri.parse("https://saasinfomedia.com/vimeo/public/createvideopost");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = await http.MultipartFile.fromPath("video", video);
  request.files.add(multipartFile);
  request.fields['userid'] = userid.toString();
  request.fields['description'] = description.toString();
  request.fields['type'] = type.toString();
  request.fields['post_title'] = title.toString();
  //StreamedResponse response = await request.send();
  http.Response response = await http.Response.fromStream(await request.send());
  var RegData = json.decode(response.body);
  if(response.statusCode==200){
    print(response.toString());
    print("Video uploaded "+RegData.toString());
  }else{
    print("Video upload failed "+RegData.toString());
  }
  return RegData;
}

Future foodieYoutubePost(userid, description, video,_location,lat,lng) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  var data ={};
  data["userid"] = userid;
  if(description!= "" && description!=null){
    data["description"] = description;
  }

  if(video!= "" && video!=null){
    data["video"] = video;
    data["video_type"] = "youtube";
  }

  if(_location!= "" && _location!=null){
    data["post_location"] = _location.toString();
    data["post_lat"] = lat.toString();
    data["post_lng"] = lng.toString();
  }

  final responseFollow = await http.post(url, body: data);
  print("Videoo upload sattus "+responseFollow.statusCode.toString());
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future TimelineUTubeVideoPost2(userid, description, video,) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "video": video.toString(),
    "video_type" : "youtube",

  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future BlogVideoPost1(userid, description, video, cat,_location,lat,lng) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "video": video.toString(),
    "category": cat.toString(),
    "post_location": _location.toString(),
    "post_lat": lat.toString(),
    "post_lng": lng.toString(),

  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future BlogVideoPost2(userid, description, video, cat,) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createpost";
  final responseFollow = await http.post(url, body: {
    "userid": userid.toString(),
    "description": description.toString(),
    "video": video.toString(),
    "category": cat.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future<List> FollowSearchRepo(desc,userId) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/usersearch?name="+desc.toString()+"&userid="+userId.toString()),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future<List> FollowingSearchRepo(desc,userId) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/usersearch?name="+desc.toString()+"&userid="+userId.toString()),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future<List> LikFoodiSearchRepo(desc,userId) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/usersearch?name="+desc.toString()+"&userid="+userId.toString()),
  );
  var qData = json.decode(response.body);
  return qData;
}



Future<List> savePostRepo(useridInfo) async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/gettimelinewall?type=savedpost&userid=" +
            useridInfo.toString()),
  );
  saveInfo = json.decode(response.body);
  return saveInfo["posts"];
}

Future OtherAboutInfo(useridInfo, parentidInfo) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getuserinfo?userid=" +
            useridInfo.toString() +
            "&parentid=" +
            parentidInfo.toString()),
  );

 var  abtInfo = json.decode(response.body);

  return abtInfo;
}

Future OtherAboutInfo1(useridInfo) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getuserinfo?userid=" +
            useridInfo.toString()),
  );

   AbtInfo = json.decode(response.body);
  return AbtInfo;
}

Future GetIDSRepooo(useridInfo) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getids?user_id=" +
            useridInfo.toString()),
  );
 var  data = json.decode(response.body);
  return data;
}

Future shareTimPost(user, desc, post) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/share-post";
  final register = await http.post(url, body: {
    "userid": user.toString(),
    "description": desc.toString(),
    "post_id": post.toString(),
  });
  dataUser = json.decode(register.body);
  return dataUser;
}


Future UserNametoID(username) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getuserid?username=" +
            username.toString()),
  );

  var abtInfo = json.decode(response.body);
  var namerr=abtInfo["data"][0]["id"].toString();
  return namerr;
}

Future username_Email_validation_Repoo(username,email) async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/uservalidation?username=" +
            username.toString()+"&email="+email.toString()),
  );
  var data = json.decode(response.body);
  print("response account validation "+data.toString());
  return data;
}

Future AddPurchaseListRepoo(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/addtopurchaselist";
  final response = await http.post(url, body: {
    "user_id":user_id.toString(),
    "products_id":products_id.toString(),
    "business_type":business_type.toString(),
    "customers_basket_quantity": customers_basket_quantity.toString(),
    "final_price": final_price.toString(),
    "business_page_id": page_id.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future<List> getAccWallImage(timid) async {
  final response = await http.get(Uri.encodeFull("https://saasinfomedia.com/foodiz/public/api/gettimelinewall?type=image"+"&timeline_id="+timid.toString()));
  var qData = json.decode(response.body);
  return qData['posts'];
}

Future GetPurchaseListRepoo(user_id) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getpurchaselist?user_id="+
            user_id.toString()),
  );
  var ProdData = json.decode(response.body);
  return ProdData;
}

Future PageFollower(pageId,userId) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/followpage";
  final responseFollow = await http.post(url, body: {
    "page_id": pageId.toString(),
    "follower_id": userId.toString(),
  });
 var dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future<List> categoryListRepo(parentId) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/getcategories?parent_id="+parentId.toString()),
  );
  var category = json.decode(response.body);
  return category["data"];
}

Future FoodiMarketRepoo1(pageid, description, image, type,loc,lat,long,itemname,price,catid) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproduct";
  final responseFollow = await http.post(url, body: {
    "page_id":pageid.toString(),
    "timeline_id":Market_timid.toString(),
    "user_id":userid.toString(),
    "post_image": image.toString(),
    "description": description.toString(),
    "products_name": itemname.toString(),
    "products_price": price.toString(),
    "products_description": description.toString(),
    "business_type": "6",
    "type" : "image",
    "post_type": "business",
    "category_ids": catid.toString(),
    "post_location": loc.toString(),
    "post_lat": lat.toString(),
    "post_lng": long.toString(),
    "is_feature": "0",
    "products_type": "0",
    "products_status": '1',
    "products_quantity": "1",
    "products_dp": "2",
    "products_profit":"100",
    "products_weight_unit":"5",
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future FoodiMarketRepoo2(pageid, description, image, type,itemname,price,catid) async {
  print("callll 6666666666666666");
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproduct";
  final responseFollow = await http.post(url, body: {
    "page_id":pageid.toString(),
    "user_id":userid.toString(),
    "timeline_id":Market_timid.toString(),
    "post_image": image.toString(),
    "description": description.toString(),
    "products_name": itemname.toString(),
    "products_price": price.toString(),
    "products_description": description.toString(),
    "business_type": "6",
    "type" : "image",
    "post_type": "business",
    "category_ids": catid.toString(),
    "is_feature": "0",
    "products_type": "0",
    "products_status": '1',
    "products_quantity": "1",
    "products_dp": "2",
    "products_profit":"98",
    "products_weight_unit":"5",
    // "post_type": type.toString(),
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future FoodiBankRepoo1(pageid, description, image, type,loc,lat,long,itemname,price,catid) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproduct";
  final responseFollow = await http.post(url, body: {
    "page_id":pageid.toString(),
    "timeline_id":Foodbank_timid.toString(),
    "user_id":userid.toString(),
    "post_image": image.toString(),
    "description": description.toString(),
    "products_name": itemname.toString(),
    "products_price": price.toString(),
    "products_description": description.toString(),
    "business_type": "4",
    "type" : "image",
    "post_type": "business",
    "category_ids": catid.toString(),
    "post_location": loc.toString(),
    "post_lat": lat.toString(),
    "post_lng": long.toString(),
    "is_feature": "0",
    "products_type": "0",
    "products_status": '1',
    "products_quantity": "1",
    "products_dp": "2",
    "products_profit":"100",
    "products_weight_unit":"5",
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future FoodiBankRepoo2(pageid, description, image, type,itemname,price,catid) async {
  print("callll 6666666666666666");
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproduct";
  final responseFollow = await http.post(url, body: {
    "page_id":pageid.toString(),
    "user_id":userid.toString(),
    "timeline_id":Foodbank_timid.toString(),
    "post_image": image.toString(),
    "description": description.toString(),
    "products_name": itemname.toString(),
    "products_price": price.toString(),
    "products_description": description.toString(),
    "business_type": "4",
    "type" : "image",
    "post_type": "business",
    "category_ids": catid.toString(),
    "is_feature": "0",
    "products_type": "0",
    "products_status": '1',
    "products_quantity": "1",
    "products_dp": "2",
    "products_profit":"98",
    "products_weight_unit":"5",
    // "post_type": type.toString(),
    // "follower_id": followerid.toString(),
  });
  dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future<List> getAccountBlogRepoo(timeline) async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/gettimelinewall?type=Blog&timeline_id="+timeline.toString()),
  );
  var category = json.decode(response.body);
  return category["posts"];
}

Future addLocationRepooo(loc_name,address,lat,long,landmark,houseno,locmain) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/savelocation";
  final responseFollow = await http.post(url, body: {
    "location_name": loc_name.toString(),
    "location_main": locmain.toString(),
    "location": address.toString(),
    "location_lat": lat.toString(),
    "location_long": long.toString(),
    "user_id": userid.toString(),
    "landmark": landmark.toString(),
    "house_number": houseno.toString(),
  });
  var dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future editLocationRepooo(loc_name,address,lat,long,landmark,houseno,locmain,savedaddress_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/editsavelocation";
  final responseFollow = await http.post(url, body: {
    "savedaddress_id": savedaddress_id.toString(),
    "location_name": loc_name.toString(),
    "location_main": locmain.toString(),
    "location": address.toString(),
    "location_lat": lat.toString(),
    "location_long": long.toString(),
    "user_id": userid.toString(),
    "landmark": landmark.toString(),
    "house_number": houseno.toString(),
  });
  var dataUser = json.decode(responseFollow.body);
  return dataUser;
}


Future<List> getAddressListRepoo() async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/getsavelocation?user_id="+userid.toString()),
  );
  var category = json.decode(response.body);
  return category["data"];
}

Future deleteAddressRepoo(id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/deletesavelocation";
  final responseFollow = await http.post(url, body: {
    "savedaddress_id": id.toString(),

  });
  var dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future addFoodBankProductRepo(image,description,itemname,qty,pickup,
    loc,loc_lat,loc_long,listing_days,show_user_days) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproductfoodbank";
  final responseFollow = await http.post(url, body: {
    "page_id":Foodbank_pageid.toString(),
    "user_id":userid.toString(),
    "timeline_id":Foodbank_timid.toString(),
    "post_image": image.toString(),
    "description": description.toString(),
    "products_name": itemname.toString(),
    "products_price": "200".toString(),
    "products_description": description.toString(),
    "business_type": "4",
    "type" : "image",
    "post_type": "business",
    // "category_ids": catid.toString(),
    "is_feature": "0",
    "products_type": "0",
    "products_status": '1',
    "products_quantity": qty.toString(),
    "products_dp": "3",
    "products_profit": "98",
    "products_weight_unit":"5",
    " pickup_time": pickup.toString(),
    "location": loc.toString(),
    "location_lat": loc_lat.toString(),
    "location_long": loc_long.toString(),
    "listing_days": listing_days.toString(),
    "show_users": show_user_days.toString(),
  });
  var dataUser = json.decode(responseFollow.body);
  return dataUser;
}

Future addFoodiMarketProductRepo(image,description,itemname,qty,
    loc,loc_lat,loc_long,listing_days,price,cat_id,tags,availability) async {

  print("paaag "+Market_pageid.toString()+" "+Market_timid.toString()+" "+cat_id.toString());
  final String url = "https://saasinfomedia.com/foodiz/public/api/createproductfoodmarket";
  final responseFollow = await http.post(url, body: {
    "page_id":Market_pageid.toString(),
    "user_id":userid.toString(),
    "timeline_id":Market_timid.toString(),
    "post_image": image.toString(),
    "description": description.toString(),
    "products_name": itemname.toString(),
    "products_price": price.toString(),
    "products_description": description.toString(),
    "business_type": "6",
    "type" : "image",
    "post_type": "business",
    "category_ids": cat_id.toString(),
    "is_feature": "0",
    "products_type": "0",
    "products_status": '1',
    "products_quantity": qty.toString(),
    "products_dp": "3",
    "products_profit": "98",
    "products_weight_unit":"5",
    "location": loc.toString(),
    "location_lat": loc_lat.toString(),
    "location_long": loc_long.toString(),
    "listing_days": listing_days.toString(),
    "products_tag": tags.toString(),
    "products_availability": availability.toString(),
  });
  var dataUser = json.decode(responseFollow.body);
  return dataUser;
}


Future getSuggestionList() async {
  final response = await http.get(
    Uri.encodeFull(
        "https://saasinfomedia.com/foodiz/public/api/suggestionlist"),
  );
  var prodData = json.decode(response.body);
  print("EEEEEEEEe "+prodData.toString());
  print("EEEEEEEEe 22222"+prodData["data"].toString());
  return prodData;
}

Future buynoww(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/buynow";
  final response = await http.post(url, body: {
    "user_id":user_id.toString(),
    "products_id":products_id.toString(),
    "business_type":business_type.toString(),
    "customers_basket_quantity": customers_basket_quantity.toString(),
    "final_price": final_price.toString(),
    "business_page_id": page_id.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future clearCart() async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/clearcart";
  final response = await http.post(url, body: {
    "user_id":userid.toString(),
  });
  var UploadedData = json.decode(response.body);
  return UploadedData;
}

Future editProfToken(token) async {
  final String url = APIData.domainLink + "profileedit";
  final register = await http.post(url, body: {
    "user_id": userid.toString(),
    "device_token": token.toString(),
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future foodiRequestVerification(id_proof,known_as,known_category) async {

  final String url = APIData.domainLink + "userrequestverification";
  final register = await http.post(url, body: {
    "userid": userid.toString(),
    "id_proof": id_proof.toString(),
    "known_as": known_as.toString(),
    "known_category": known_category.toString(),
  });
  dataUser = json.decode(register.body);
  return dataUser;
}

Future<List> getFullVideos() async {
  final response = await http.get(
    Uri.encodeFull(
        "http://saasinfomedia.com/foodiz/public/api/gettimelinewall?userid=" +
            userid.toString()+"&type=fullvideo&memberid="+userid.toString()),
  );
  var qData = json.decode(
    response.body,
  );
  return qData['posts'];
}

Future updateViewCountOfPost(postid) async {
  final String url = "https://saasinfomedia.com/foodiz/public/api/postview";
  final responseFollow = await http.post(url, body: {
    "post_id": postid.toString(),

  });
  var dataUser = json.decode(responseFollow.body);
  return dataUser;
}
