import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/view/auth_view/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                image: const DecorationImage(
                    image: AssetImage('assets/img.png'), fit: BoxFit.fill)),
          ),
          spaceHeight15,
          const Center(
            child: TextConst(
              title:
                  "𝓕𝓸𝓾𝓷𝓭𝓮𝓻 𝓒𝓸𝓭𝓮 𝓣𝓮𝓬𝓱𝓷𝓸𝓵𝓸𝓰𝔂\n𝓟𝓿𝓽 𝓛𝓽𝓭 ",
              fontSize: 25,
            ),
          )
        ],
      ),
    );
  }
}
