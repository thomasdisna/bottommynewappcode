class Validations {
  String validateName(String value) {
    if (value.isEmpty) return 'Name is required!!!';
    /*final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters !!!';*/
    return null;
  }

  String validateSurName(String value) {
    if (value.isEmpty) return 'Surname is required!!!';
    return null;
  }

  String validateFirstName(String value) {
    if (value.isEmpty) return 'Firstname is required!!!';
    return null;
  }
  String validateLastName(String value) {
    if (value.isEmpty) return 'Lastname is required!!!';
    return null;
  }

  String validateAddr(String value) {
    if (value.isEmpty) return 'Address is required!!!';
    /*final RegExp nameExp = new RegExp(r'[a-zA-Z0-9._]$');
    if (!nameExp.hasMatch(value))
      return 'Please enter a Username !!!';*/
    return null;
  }

  String validateUserName(String value) {
    if (value.isEmpty) return 'Username is required!!!';
    if (value.contains(" ")) return "Enter a valid username!!!";
    /*final RegExp nameExp = new RegExp(r'[a-zA-Z0-9._]$');
    if (!nameExp.hasMatch(value))
      return 'Please enter a Username !!!';*/
    return null;
  }

  String validateFSSAINum(String value) {
    if (value.isEmpty) return 'FSSAI number is required!!!';
    return null;
  }

  String validateAccountname(String value) {
    if (value.isEmpty) return 'Account name is required!!!';
    return null;
  }

  String validateBankname(String value) {
    if (value.isEmpty) return 'Bank name is required!!!';
    return null;
  }

  String validateaccountnum(String value) {
    if (value.isEmpty) return 'Account number is required!!!';
    return null;
  }

  String validateifsccode(String value) {
    if (value.isEmpty) return 'IFSC code is required!!!';
    return null;
  }

  String validatebranchname(String value) {
    if (value.isEmpty) return 'Branch name is required!!!';
    return null;
  }

  String validatePlace(String value) {
    if (value.isEmpty) return 'Place is required!!!';
    return null;
  }

  String validatePincode(String value) {
    if (value.isEmpty) return 'Pincode is required!!!';
    return null;
  }

  String validateCity(String value) {
    if (value.isEmpty) return 'City is required!!!';
    return null;
  }

  String validateStreet(String value) {
    if (value.isEmpty) return 'Street is required!!!';
    return null;
  }

  String validateEmail(String value) {
    if(value.isEmpty) return "Email is required !!!";
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regex.hasMatch(value))
      return 'please Enter Valid Email !!!';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Please enter a password !!!';
    RegExp regex = new RegExp(r"^(?=.*?[a-zA-Z])(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$");
    if (!regex.hasMatch(value))
      return 'please enter valid password !!!';
    else
    return null;
  }

  String validateLogPassword(String value) {
    if (value.isEmpty) return 'Please enter a password !!!';
    return null;
  }

  String validateLocation(String value) {
    if (value.isEmpty) return 'Please choose a location !!!';
    return null;
  }

  String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit !!!';
    else
      return null;
  }

  String validateDOB(String value) {
    if (value.isEmpty)
      return 'please choose your DOB !!!';
    else
      return null;
  }

  String validateConfirmPassord(String value,String val2) {
    if (value!=val2)
      return "Password Not Match !!!";
    else

      return null;
  }

}
