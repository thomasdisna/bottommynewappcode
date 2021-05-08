import 'package:flutter/material.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocTaking extends StatefulWidget {
  @override
  _LocTakingState createState() => _LocTakingState();
}

class _LocTakingState extends State<LocTaking> {

  getUserLocation() async {
    try {
      print("loccc taking");
      var userloc = await locateUser();
      print("llooooocccc "+userloc.toString());
      setState(() {
        userLocation = userloc;
      });

      final coordinates = new Coordinates(userLocation.latitude, userLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("srdtfjcgvkbhlkn;ml ${first.featureName} : ${first.addressLine}");
      setState(() {
        location_address =first.addressLine;
      });
      print("addresss 11111 "+userLocation.toString());
      print("addresss 2222222 "+location_address.toString());
    } catch (e) {
      print("errrrrrrrr "+e.toString());
    }

  }

  Future<Position> locateUser() async {
    print("333333333");

   try{
     print("55555555555");
     var ab = Geolocator()
         .getCurrentPosition();
     print("sssssssss "+ab.toString());
     return ab;
   }catch(e){
     print("errrrr 4444444 "+e.toString());
   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ert"),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.grey,
          onPressed: (){
            getUserLocation();
          },
          child: Text("locaaa"),
        ),
      ),
    );
  }
}
