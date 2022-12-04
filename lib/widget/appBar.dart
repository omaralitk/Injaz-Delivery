// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';

class AppBarSection extends StatefulWidget {
  AppBarSection({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);
  String title1;
  String title2;

  @override
  State<AppBarSection> createState() => _AppBarSectionState();
}

class _AppBarSectionState extends State<AppBarSection> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Injaz ',
            style: TextStyle(
                color: Colors.red,
                fontSize: Dimensions.size30,
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Delivery',
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.size30,
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: AppColors.mainColor,
      elevation: 0,
    );
  }
}
