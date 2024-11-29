import 'package:geolocator/geolocator.dart';

Future<Position> permissionCheck() async {
  LocationPermission locationPermission;
  //location service or gps enabled check .if this is enebled we will proced further.if not then the program will stop and show the error
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Future.error("Location Service disables.Turn on the GPS");
  }

  //then we will check if we can access the users position explicitly
  locationPermission = await Geolocator.checkPermission();
  // if the position is denied by the user at first then we will request the user to allow us to access permission
  if (locationPermission == LocationPermission.denied) {
    locationPermission = await Geolocator.requestPermission();
    // if the permission is still denied then we will show error
    if (locationPermission == LocationPermission.denied) {
      Future.error("location position disabled");
    }
  }

  ////then we will check if the user has permanently denied the permission access
  if (locationPermission == LocationPermission.deniedForever) {
    Future.error("Location permission denied permanently");
  }

  //if everything is allowed and enebled then we will return position of user
  return await Geolocator.getCurrentPosition();
}
