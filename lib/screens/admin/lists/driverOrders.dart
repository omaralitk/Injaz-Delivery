// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, file_names, unused_import, duplicate_import, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/models/admin/driver/all_driver_orders.dart';
import 'package:injaz_delivery/models/admin/driver/curr_driver_orders.dart';
import 'package:injaz_delivery/models/vendor/current_day_orders.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';
import 'package:intl/intl.dart';

class DriverOrders extends StatefulWidget {
  const DriverOrders({Key? key, required this.driver}) : super(key: key);
  final String driver;
  @override
  State<DriverOrders> createState() => _DriverOrdersState();
}

class _DriverOrdersState extends State<DriverOrders> {
  int _currentIndex = 0;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Routes = [
      CurrentDriverOrders(driver: widget.driver),
      AllDriverOrders(driver: widget.driver),
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        centerTitle: false,
        title: BigText(
            color: AppColors.TextColor, text: widget.driver + ' Orders'),
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: InkWell(
          onTap: (() {
            Navigator.pop(context);
          }),
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.TextColor,
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Routes[_currentIndex],
      ),
      bottomNavigationBar: ConvexAppBar(
        color: AppColors.TextColor,
        activeColor: AppColors.TextColor,
        backgroundColor: AppColors.mainColor,
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          TabItem(icon: Icons.content_paste, title: 'This Day'),
          TabItem(icon: Icons.list, title: 'All Days'),
        ],
      ),
    );
  }
}
