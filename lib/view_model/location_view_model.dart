import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class LocationProvider extends ChangeNotifier {
  bool isInRange = false;
  bool isLoading = true;
  bool isPermissionDenied = false;
  bool isProcessing = false;

  String punchInTime = "";
  String punchOutTime = "";
  String statusPunchIn = "NO Data";
  String statusPunchOut = "NO Data";

  bool hasPunchedIn = false;

  final double staticLatitude = 26.9154509;
  final double staticLongitude = 80.9573848;
  final double rangeInMeters = 10.0;

  LocationProvider() {
    checkAndTrackLocation();
  }

  Future<void> checkAndTrackLocation() async {
    isLoading = true;
    notifyListeners();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isPermissionDenied = true;
      isLoading = false;
      notifyListeners();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isPermissionDenied = true;
        isLoading = false;
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isPermissionDenied = true;
      isLoading = false;
      notifyListeners();
      return;
    }

    trackLocation();
  }

  void trackLocation() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
    ).listen((Position position) {
      double distance = Geolocator.distanceBetween(
        staticLatitude,
        staticLongitude,
        position.latitude,
        position.longitude,
      );

      bool newState = distance <= rangeInMeters;
      if (newState != isInRange) {
        isInRange = newState;
        notifyListeners();
      }
    });

    isLoading = false;
    isPermissionDenied = false;
    notifyListeners();
  }

  Future<void> punchIn() async {
    if (!isInRange) return;

    isProcessing = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    punchInTime =
        DateFormat('EEEE, dd MMM yyyy, hh:mm a').format(DateTime.now());
    statusPunchIn = punchInTime;
    hasPunchedIn = true;
    isProcessing = false;
    notifyListeners();
  }

  Future<void> punchOut() async {
    if (!isInRange) return;

    isProcessing = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    punchOutTime =
        DateFormat('EEEE, dd MMM yyyy, hh:mm a').format(DateTime.now());
    statusPunchOut = punchOutTime;
    hasPunchedIn = false;
    isProcessing = false;
    notifyListeners();
  }
}



// if (locationNotifier.isPermissionDenied) {
// return Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(
// "Location Permission Required!",
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.bold,
// color: Colors.red),
// ),
// SizedBox(height: 20),
// ElevatedButton(
// onPressed: () {
// Provider.of<LocationProvider>(context, listen: false)
//     .checkAndTrackLocation();
// },
// child: Text("Grant Permission"),
// ),
// ],
// ),
// );
// }