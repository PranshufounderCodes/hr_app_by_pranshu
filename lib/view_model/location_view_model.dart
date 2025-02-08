import 'package:flutter/foundation.dart';
import 'package:founder_code_hr_app/repo/punch_repo.dart';
import 'package:founder_code_hr_app/utils/sneck_bar.dart';
import 'package:founder_code_hr_app/view_model/profile_view_model.dart';
import 'package:founder_code_hr_app/view_model/user_view_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider extends ChangeNotifier {
  bool isInRange = false;
  bool isLoading = true;
  bool isPermissionDenied = false;
  bool isProcessing = false;

  String punchInTime = "";
  String punchOutTime = "";
  String statusPunchIn = "";
  String statusPunchOut = "";

  final double staticLatitude = 26.9154509;
  final double staticLongitude = 80.9573848;
  final double rangeInMeters = 5.0;

  LocationProvider() {
    loadStoredData();
    checkAndTrackLocation();
  }

  Future<void> loadStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    statusPunchIn = prefs.getString('statusPunchIn') ?? "";
    statusPunchOut = prefs.getString('statusPunchOut') ?? "";

    notifyListeners();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('statusPunchIn', statusPunchIn);
    await prefs.setString('statusPunchOut', statusPunchOut);
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
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
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
    // hasPunchedIn = true;

    await saveData();

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
    // hasPunchedIn = false;

    await saveData();

    isProcessing = false;
    notifyListeners();
  }

  final _punchRepo = PunchRepo();

  // Punch Api

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> punchApi(context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setLoading(true);
    final profileViewmodel =
        Provider.of<ProfileViewModel>(context, listen: false).modelData;
    Map data = {
      "employee_id": userId,
      "punch_in_time":
          profileViewmodel!.data!.punchInStatus == 1 ? statusPunchIn : "",
      "punch_out_time":
          profileViewmodel.data!.punchInStatus == 2 ? statusPunchOut : "",
    };

    _punchRepo.punchApi(data).then((value) {
      if (value['success'] == true) {
        Provider.of<ProfileViewModel>(context, listen: false)
            .profileApi(context);
        setLoading(false);
        showCustomSnackBar(
          value['message'],
          context,
        );
      } else {
        showCustomSnackBar(
          value['message'],
          context,
        );
        setLoading(false);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}

//
// WidgetsBinding.instance.addPostFrameCallback((_) {
// if (locationProvider.isPermissionDenied) {
// // पहले से Provider instance ले लो
// final locationProviderRef = Provider.of<LocationProvider>(context, listen: false);
//
// showDialog(
// context: context,
// barrierDismissible: false, // Outside tap से dismiss ना हो
// builder: (context) => AlertDialog(
// title: const Text(
// "Location Permission Required!",
// style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
// ),
// content: const Text("Please grant location permission to continue."),
// actions: [
// TextButton(
// onPressed: () {
// Navigator.of(context).pop(); // डायलॉग बंद करें
// },
// child: const Text("Cancel"),
// ),
// ElevatedButton(
// onPressed: () async {
// Navigator.of(context).pop(); // पहले डायलॉग बंद करें
//
// await Future.delayed(Duration(milliseconds: 300)); // UI को stabilize करने के लिए छोटा delay
//
// await locationProviderRef.checkAndTrackLocation(); // अब Safe तरीके से call होगा
// },
// child: const Text("Grant Permission"),
// ),
// ],
// ),
// );
// }
// });
