// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, file_names, unused_import, duplicate_import, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/models/vendor/all_vendor_orders.dart';
import 'package:injaz_delivery/models/vendor/current_day_orders.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class VendorOrders extends StatefulWidget {
  const VendorOrders({Key? key, required this.agent}) : super(key: key);
  final String agent;
  @override
  State<VendorOrders> createState() => _VendorOrdersState();
}

class _VendorOrdersState extends State<VendorOrders> {
  int _selectedIndex = 0;
  int _currentIndex = 0;
  late PageController _pageController;
  final db = FirebaseFirestore.instance;
  late String current;
  DateTime datetime = DateTime.now();
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setState(() {
      current = convertDateTimeDisplay(datetime.toString());
      _pageController = PageController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Routes = [
      CurrentDay(agent: widget.agent),
      AllVendorOrders(agent: widget.agent),
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        centerTitle: false,
        title:
            BigText(color: AppColors.TextColor, text: widget.agent + ' Orders'),
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
