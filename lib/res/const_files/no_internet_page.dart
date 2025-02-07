
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:founder_code_hr_app/generated/assets.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

double width = 0.0;
double height = 0.0;

class _NoInternetState extends State<NoInternet> {
  bool _isLoading = false;
  Future<void> _checkConnectivity() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    final result = await Connectivity().checkConnectivity();

    setState(() {
      _isLoading = false;
    });

    if (result != ConnectivityResult.none) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && context.mounted) {
          Navigator.pushReplacementNamed(context, RoutesName.userDashboard);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No internet connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.lightWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.assetsNoInternet),
            spaceHeight20,
            const TextConst(
              title: "No Internet",
              color: AppColor.primary,
              fontSize: textFontSize23,
            ),
            spaceHeight20,
            TextConst(
              title: 'Please check connection again,\n or connect to Wi-Fi',
              color: AppColor.blackTemp.withOpacity(0.3),
              fontSize: textFontSize17,
            ),
            spaceHeight30,
            _isLoading
                ? const CircularProgressIndicator(
                    color: AppColor.primary,
                  )
                : ButtonConst(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    label: "Try Again",
                    onTap: _checkConnectivity,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.red,
                        offset: Offset(0, 0),
                        blurRadius: 4,
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
