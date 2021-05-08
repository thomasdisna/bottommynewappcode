class TimelineData {
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
  String Status;
  //Media image;

  TimelineData();
  TimelineData.fromJSON(Map<String,dynamic>jsonMap){
    id = jsonMap['id'].toString();
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
    Status = jsonMap['Status'].toString();
  }


  Map toMap(){
    var map = new Map<String,dynamic>() ;
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
    map["Status"] = Status;
    return map;

  }
}//class
