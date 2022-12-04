// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/models/check_login.dart.dart';

class Loding extends StatefulWidget {
  const Loding({Key? key}) : super(key: key);

  @override
  State<Loding> createState() => _LodingState();
}

class _LodingState extends State<Loding> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    CheckLogin().isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.WhiteColor,
      body: Center(
          child: CircularProgressIndicator(
        color: AppColors.mainColor,
      )),
    );
  }
}
