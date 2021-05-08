class User {
  String id;
  String name;
  String surname;
  String email;
  String dob;
  String gender;
  String mobile;
  String password;
  String otp;
  String apiToken;
  String deviceToken;
  String status;
  String message;
  String userIdDetails;
  String current_location;
  String location_lat;
  String location_long;

  //Media image;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['data'].toString();
    name = jsonMap['name'].toString();
    surname = jsonMap['surname'].toString();
    email = jsonMap['email'].toString();
    dob = jsonMap['dob'].toString();
    gender = jsonMap['gender'].toString();
    mobile = jsonMap['mobile'].toString();
    password = jsonMap['password'].toString();
    otp = jsonMap['otp'].toString();
    apiToken = jsonMap['apiToken'].toString();
    deviceToken = jsonMap['deviceToken'].toString();
    status = jsonMap['status'].toString();
    message = jsonMap['message'].toString();
    location_lat = jsonMap['location_lat'].toString();
    location_long = jsonMap['location_long'].toString();
    userIdDetails = jsonMap['id'].toString();
    current_location = jsonMap['current_location'].toString();
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["surname"] = surname;
    map["email"] = email;
    map["dob"] = dob;
    map["gender"] = gender;
    map["mobile"] = mobile;
    map["password"] = password;
    map["otp"] = otp;
    map["apiToken"] = apiToken;
    map["deviceToken"] = deviceToken;
    map["status"] = status;
    map["message"] = message;
    map["current_location"] = current_location;
    map["location_lat"] = location_lat;
    map["location_long"] = location_long;
    map["id"] = userIdDetails;
    return map;
  }
} //class
