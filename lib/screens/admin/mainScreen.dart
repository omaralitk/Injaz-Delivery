// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';

import 'package:injaz_delivery/Screens/Admin/Lists/allOrders.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/driversList.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/ordersFromVendors.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/registerRequest.dart';
import 'package:injaz_delivery/Screens/Admin/testPage.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/vendorList.dart';

import 'package:injaz_delivery/Screens/homePage.dart';
import 'package:injaz_delivery/widget/Drawer/adminDrawer.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Boxes/box.dart';
import 'package:injaz_delivery/widget/Text/maxSmallBold.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

import '../../Screens/Admin/add/add_driver.dart';
import '../../Screens/Admin/add/add_order.dart';
import '../../Screens/Admin/add/add_vendor.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  // final String email;
  // final String password;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String userId;
  getUser() async {
    User? getUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      userId = getUser!.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getUser();
      getData();
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: AppColors.WhiteColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: BigText(color: AppColors.TextColor, text: 'Dashboard'),
            iconTheme: IconThemeData(
              color: AppColors.TextColor,
            ),
            backgroundColor: AppColors.mainColor,
          ),
          body: Container(
            color: AppColors.mainColor,
            child: Container(
              width: Dimensions.ScreenWidth,
              height: Dimensions.ScreenHieght,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.hieght20),
                      topRight: Radius.circular(Dimensions.hieght20))),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.hieght20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Box(
                        title: 'Add Vendor',
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddUser()));
                        }),
                        imageIcon: 'Assets/Images/addVendor.png',
                      ),
                      SizedBox(
                        width: Dimensions.size30,
                      ),
                      Box(
                        title: 'Vendors List',
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => VendorList())));
                        }),
                        imageIcon: 'Assets/Images/vendors.png',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.hieght20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Box(
                        title: 'Add Driver',
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => AddDriver())));
                        }),
                        imageIcon: 'Assets/Images/AddDriver.png',
                      ),
                      SizedBox(
                        width: Dimensions.size30,
                      ),
                      Box(
                        title: 'Drivers List',
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DriversList())));
                        }),
                        imageIcon: 'Assets/Images/drivers.png',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.hieght20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Box(
                        title: 'Check Orders',
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => AllOrders())));
                        }),
                        imageIcon: 'Assets/Images/checkOrders.png',
                      ),
                      SizedBox(
                        width: Dimensions.size30,
                      ),
                      Box(
                        title: 'Register Requests',
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Requests())));
                        }),
                        imageIcon: 'Assets/Images/registerRequest.png',
                      ),
                    ],
                  ),
                ],
              )),
            ),
          ),
          drawer: AdminDrawer(
              email: email.toString(),
              name: name.toString(),
              role: role.toString()),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.GreyColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AddOrder())));
            },
            child: Icon(
              Icons.add,
              size: Dimensions.size40,
              color: AppColors.mainColor,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat),
    );
  }
}
