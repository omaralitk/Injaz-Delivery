// ignore_for_file: file_names, duplicate_import, unused_import, non_constant_identifier_names, prefer_final_fields, unused_field

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/models/admin/all_main_orders.dart';
import 'package:injaz_delivery/models/admin/current_day_main_orders.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/search.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);
  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  final Routes = [
    CurrentDayMainOrders(),
    AllMainOrders(),
  ];
  final db = FirebaseFirestore.instance;
  int _selectedIndex = 0;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WhiteColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                });
              },
              icon: Icon(Icons.search, color: AppColors.TextColor))
        ],
        centerTitle: false,
        title: BigText(color: AppColors.TextColor, text: 'All Orders'),
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SizedBox.expand(
          child: Routes[_currentIndex],
        ),
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
