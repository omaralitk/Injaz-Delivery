// ignore_for_file: must_be_immutable, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/returnedOrders.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';
import '../../Screens/Admin/Lists/ordersFromVendors.dart';
import '../../Screens/Admin/add/add_admin.dart';
import '../../Screens/homePage.dart';
import '../Text/bigText.dart';

class AdminDrawer extends StatefulWidget {
  AdminDrawer(
      {Key? key, required this.email, required this.name, required this.role})
      : super(key: key);
  String name;
  String role;
  String email;

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.GreyColor,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigText(color: AppColors.mainColor, text: widget.name),
              SmallText(color: AppColors.WhiteColor, text: widget.email),
              SmallText(color: AppColors.SecondColor, text: widget.role),
            ],
          )),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrdersFromVendors()));
            },
            title: SmallText(
                color: AppColors.WhiteColor, text: 'Orders From Vendors'),
            // ignore: prefer_const_constructors
            trailing: Icon(
              Icons.card_travel,
              color: AppColors.SecondColor,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReturnedOrders()));
            },
            title:
                SmallText(color: AppColors.WhiteColor, text: 'Returned Orders'),
            trailing: const Icon(
              Icons.cached,
              color: AppColors.SecondColor,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AddAdmin()));
            },
            title:
                SmallText(color: AppColors.WhiteColor, text: 'Add New Admin'),
            trailing: const Icon(
              Icons.add,
              color: AppColors.SecondColor,
            ),
          ),
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
