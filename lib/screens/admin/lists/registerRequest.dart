// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, unnecessary_new, unused_import, file_names, unused_field, annotate_overrides, prefer_const_literals_to_create_immutables, duplicate_ignore, non_constant_identifier_names, prefer_final_fields
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/models/requests/approved_requested.dart';
import 'package:injaz_delivery/models/requests/caceled_requests.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/models/requests/all_requests.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final Routes = [
    Pinding(),
    ApprovedRequests(),
    CanceledRequests(),
  ];
  final db = FirebaseFirestore.instance;
  int _selectedIndex = 0;
  int _currentIndex = 0;
  late PageController _pageController;
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WhiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: AppColors.mainColor,
          title: BigText(
            color: AppColors.TextColor,
            text: 'Requests',
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          color: AppColors.TextColor,
          activeColor: AppColors.TextColor,
          backgroundColor: AppColors.mainColor,
          initialActiveIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            TabItem(icon: Icons.timer, title: 'Pinding'),
            TabItem(icon: Icons.check_circle_outline, title: 'Approved'),
            TabItem(icon: Icons.cancel_outlined, title: 'Canceled'),
          ],
        ),
        body: SizedBox.expand(child: Routes[_currentIndex]));
  }
}
