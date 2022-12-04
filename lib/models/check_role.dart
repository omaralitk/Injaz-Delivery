// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, duplicate_ignore, file_names, non_constant_identifier_names, await_only_futures, unused_import, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/ordersFromVendors.dart';
import 'package:injaz_delivery/Screens/Admin/mainScreen.dart';
import 'package:injaz_delivery/Screens/Driver/driverDashbourd.dart';
import 'package:injaz_delivery/Screens/Vendor/vendorDashboard.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class CheckRole {
  void RoleManage(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    final userId = user?.uid;
    if (user != null) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                  width: Dimensions.hieght100,
                  height: Dimensions.hieght100,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.mainColor))),
            );
          });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) {
        if (value['Role'] == 'Admin')
          // ignore: curly_braces_in_flow_control_structures
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => MainScreen())));
        else if (value['Role'] == 'Driver')
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: ((context) => DriverDashboard())),
          );
        else
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => VendorDashboard())));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: SmallText(
              color: AppColors.WhiteColor,
              text: 'Email or Password is not correct ! Please try again')));
    }
  }
}
