import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Butomy/Model/UserModel/userModel.dart';
User currentUser = new User();

Future<User>login(User user)async{
  // User.fromJSON(json.decode(response.body)['data']);
}
Future<User> notificationMethod() async{
  final response = await http.get(Uri.encodeFull("http"));
  var qData = json.decode(response.body);
  return qData['data'];
}
