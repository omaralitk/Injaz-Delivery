// ignore_for_file: must_be_immutable, file_names, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/widget/Text/maxSmallBold.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';
import '../../Screens/Admin/Lists/ordersFromVendors.dart';
import '../../Screens/homePage.dart';
import '../Text/bigText.dart';

class DriverDrawer extends StatefulWidget {
  DriverDrawer(
      {Key? key, required this.email, required this.name, required this.role})
      : super(key: key);
  String name;
  String role;
  String email;

  @override
  State<DriverDrawer> createState() => _DriverDrawerState();
}

class _DriverDrawerState extends State<DriverDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.GreyColor,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(color: AppColors.mainColor, text: widget.name),
              MaxSmallBold(color: AppColors.WhiteColor, text: widget.email),
              MaxSmallBold(color: AppColors.SecondColor, text: widget.role),
            ],
          )),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            title: SmallText(color: AppColors.WhiteColor, text: 'Log Out'),
            trailing: const Icon(
              Icons.logout,
              color: AppColors.SecondColor,
            ),
          ),
        ],
      ),
    );
  }
}
