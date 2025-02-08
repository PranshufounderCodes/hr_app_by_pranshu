import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  static const LatLng staticLocation = LatLng(26.9154509, 80.9573848);
  LatLng? userLocation;
  bool isInRange = false;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
      ),
    ).listen((Position position) {
      LatLng newUserLocation = LatLng(position.latitude, position.longitude);
      double distance = Geolocator.distanceBetween(
        staticLocation.latitude,
        staticLocation.longitude,
        newUserLocation.latitude,
        newUserLocation.longitude,
      );

      setState(() {
        userLocation = newUserLocation;
        isInRange = distance <= 10.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: screenWidth,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColor.white10,
                ),
              ),
              spaceWidth10,
              const TextConst(
                title: "Live Map View",
                color: AppColor.white10,
                fontWeight: FontWeight.bold,
              ),

            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: Stack(
        children: [
          // Google Map
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: staticLocation,
                zoom: 18,
              ),
              markers: {
                // Office Location Marker (Green)
                Marker(
                  markerId: const MarkerId("static"),
                  position: staticLocation,
                  infoWindow: const InfoWindow(title: "Office Location"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                ),

                // User Location Marker (Red)
                if (userLocation != null)
                  Marker(
                    markerId: const MarkerId("user"),
                    position: userLocation!,
                    infoWindow: const InfoWindow(title: "Your Location"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  ),
              },
              circles: {
                // 10 Meter Range Circle
                Circle(
                  circleId: const CircleId("range"),
                  center: staticLocation,
                  radius: 10,
                  strokeWidth: 2,
                  strokeColor: Colors.blue,
                  fillColor: Colors.blue.withOpacity(0.2),
                ),
              },
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  const BoxShadow(color: Colors.black26, blurRadius: 5),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Your Live Location",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userLocation != null
                        ? "Lat: ${userLocation!.latitude}, Lng: ${userLocation!.longitude}"
                        : "Fetching location...",
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isInRange ? "🟢 Within Office Range" : "🔴 Outside Office Range",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isInRange ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
