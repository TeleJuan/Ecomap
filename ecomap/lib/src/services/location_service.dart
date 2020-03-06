import 'dart:async';

import 'package:ecomap/src/datasmodels/user_location.dart';
import 'package:location/location.dart';

class LocationService{
  UserLocation _currentLocation; 

  Location location = Location();

  StreamController<UserLocation> _locationController = 
    StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream =>_locationController.stream;

  LocationService(){
    location.requestPermission().then((granted){
      if(granted){
        location.onLocationChanged().listen((locationData){
          if(locationData!=null){
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude));
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async{
    try{
      var userLocation = await location.getLocation();
        _currentLocation = UserLocation(
          latitude: userLocation.latitude ,
          longitude: userLocation.longitude
        );
    }catch(e){
      print(e);
    }

    return _currentLocation;
  }
}