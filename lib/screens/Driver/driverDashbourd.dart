// ignore_for_file: file_names, prefer_const_constructors, unused_import, await_only_futures, non_constant_identifier_names, unused_element, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/models/admin/driver/all_driver_orders.dart';
import 'package:injaz_delivery/models/admin/driver/curr_driver_orders.dart';
import 'package:injaz_delivery/models/driver_dashboard/driver_all_orders.dart';
import 'package:injaz_delivery/models/driver_dashboard/orders_at_day.dart';
import 'package:injaz_delivery/Screens/homePage.dart';
import 'package:injaz_delivery/widget/Drawer/driverDrawer.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({Key? key}) : super(key: key);

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
      getUser();
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
      OrdersAtDay(driverId: userId.toString()),
      DriverAllOrders(driverId: userId.toString()),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
        drawer: DriverDrawer(
          email: email.toString(),
          role: role.toString(),
          name: name.toString(),
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
