import 'dart:convert';
import 'package:Butomy/APIData/api.dart';
import 'package:Butomy/Model/UserModel/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
var saveInfo;
var UserIdprefs;
User currentUser = new User();
var dataUser;

Future signUp(name,surname,email,dob,gender,mobile,password,current_location,location_lat,location_long,token) async {
  final String url = APIData.domainLink + "register";


  final register = await http.post(url, body: {
    "name": name.toString(),
    "email": email.toString(),
    "password": password.toString(),
    "mobile": mobile.toString(),
    "gender": gender.toString(),
    "dob": dob.toString(),
    "username": surname.toString(),
    "current_location": current_location.toString(),
    "location_lat": location_lat.toString(),
    "location_long": location_long.toString(),
    "device_token": token.toString(),
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


Future<User> logout() async {
  final response = await http.get(Uri.encodeFull("http"));
  var qData = json.decode(response.body);
  return qData['data'];
}



