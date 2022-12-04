// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, await_only_futures, prefer_interpolation_to_compose_strings, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/models/vendor_dashboard/all_vendor_dashboard_orders.dart';
import 'package:injaz_delivery/models/vendor_dashboard/curr_vendor_dashboard_orders.dart';
import 'package:injaz_delivery/Screens/Vendor/ordersRequest.dart';
import 'package:injaz_delivery/Screens/Vendor/vendorAddOrder.dart';
import 'package:injaz_delivery/Screens/homePage.dart';
import 'package:injaz_delivery/widget/Drawer/vendorDrawer.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({Key? key}) : super(key: key);
  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      getUser();
      getData();
    });
  }

  String? userId;
  getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? getUser = await auth.currentUser;
    setState(() {
      userId = getUser!.uid;
    });
  }

  String? name;
  String? role;
  String? email;
  getData() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = await auth.currentUser;
    final userId = user?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      if (value['Uid'] == userId) {
        setState(() {
          name = value['Name'];
          role = value['Role'];
          email = value['Email'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Routes = [
      CurrentVendorDashboardOrders(agent: userId.toString()),
      AllVendorDashboardOrders(agent: userId.toString()),
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.WhiteColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.TextColor),
          centerTitle: true,
          title: BigText(
            text: name.toString() + ' Dashboard',
            color: AppColors.TextColor,
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: GestureDetector(
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: SizedBox.expand(
            child: Routes[_currentIndex],
          ),
        ),
        drawer: VendorDrawer(
          name: name.toString(),
          role: role.toString(),
          email: email.toString(),
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
      ),
    );
  }
}
