import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/no_internet_page.dart';
import 'package:founder_code_hr_app/utils/routes/routes.dart';
import 'package:founder_code_hr_app/view/bottom_pages_users/profile_screen.dart';
import 'package:founder_code_hr_app/view_model/add_emp_view_model.dart';
import 'package:founder_code_hr_app/view_model/auth_view_model.dart';
import 'package:founder_code_hr_app/view_model/break_view_model.dart';
import 'package:founder_code_hr_app/view_model/dashboard_provider.dart';
import 'package:founder_code_hr_app/view_model/location_view_model.dart';
import 'package:founder_code_hr_app/view_model/profile_view_model.dart';
import 'package:founder_code_hr_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import 'utils/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

double screenHeight = 0;
double screenWidth = 0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (kDebugMode) {
      print('Connectivity changed: $_connectionStatus');
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return _connectionStatus.contains(ConnectivityResult.none)
        ? const Directionality(
            textDirection: TextDirection.ltr, child: NoInternet())
        : MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => LocationProvider()),
              ChangeNotifierProvider(create: (context) => BreakProvider()),
              ChangeNotifierProvider(create: (context) => AddEmpViewModel()),
              ChangeNotifierProvider(create: (context) => LoginViewModel()),
              ChangeNotifierProvider(create: (context) => UserViewModel()),
              ChangeNotifierProvider(create: (context) => ProfileViewModel()),
              ChangeNotifierProvider(create: (context) => DashboardProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: appName,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColor.white10,
                useMaterial3: true,
              ),
              initialRoute: RoutesName.splashScreen,
              onGenerateRoute: (settings) {
                if (settings.name != null) {
                  return MaterialPageRoute(
                    builder: Routers.generateRoute(settings.name!),
                    settings: settings,
                  );
                }
                return null;
              },
              // home: SizeAndColorPage(),
            ),
          );
  }
}
