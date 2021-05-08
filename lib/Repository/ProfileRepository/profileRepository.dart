import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Butomy/Model/ProfileModel/profileModel.dart';
 ProfileData currentUser = new ProfileData();

Future<ProfileData>login(ProfileData user)async{
  // User.fromJSON(json.decode(response.body)['data']);
}
Future<ProfileData> Method() async{
  final response = await http.get(Uri.encodeFull("http"));
  var qData = json.decode(response.body);
  return qData['data'];
}
