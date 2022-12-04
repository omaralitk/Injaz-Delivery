// ignore_for_file: file_names, prefer_const_constructors, unused_import

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/models/check_login.dart.dart';
import 'package:injaz_delivery/Screens/Admin/mainScreen.dart';
import 'package:injaz_delivery/Screens/homePage.dart';
import 'package:injaz_delivery/Screens/loadPage.dart';
import 'package:injaz_delivery/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    CheckLogin().isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Dimensions.ScreenWidth,
      height: Dimensions.ScreenHieght,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Assets/Images/InjazLogo.png',
              width: Dimensions.hieght300,
            ),
            SizedBox(
              height: Dimensions.size30,
            ),
            CircularProgressIndicator(
              color: AppColors.mainColor,
            )
          ],
        ),
      ),
    );
  }
}
