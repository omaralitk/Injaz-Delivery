// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/models/check_role.dart';
import 'package:injaz_delivery/Screens/Admin/mainScreen.dart';
import 'package:injaz_delivery/Screens/Driver/driverDashbourd.dart';
import 'package:injaz_delivery/Screens/homePage.dart';
import 'package:injaz_delivery/Screens/login.dart';

class CheckLogin {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    final userId = user?.uid;

    if (user != null) {
      Timer(Duration(seconds: 5), () {
        CheckRole().RoleManage(context);
      });
    } else {
      Timer(Duration(seconds: 5), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }
}
