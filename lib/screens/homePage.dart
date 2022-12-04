// ignore_for_file: prefer_const_constructors, file_names, unused_import, prefer_const_literals_to_create_immutables, must_call_super, avoid_returning_null_for_void, curly_braces_in_flow_control_structures

import 'package:carousel_images/carousel_images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_media_slider/carousel_media.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/contactus.dart';
import 'package:injaz_delivery/Screens/login.dart';
import 'package:injaz_delivery/Screens/Admin/mainScreen.dart';
import 'package:injaz_delivery/Screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> listImages = [
    Image.asset('Assets/Images/slide1.png'),
    Image.asset('Assets/Images/slide2.png'),
    Image.asset('Assets/Images/slide3.png'),
    Image.asset('Assets/Images/slide4.png'),
  ];
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        leading: Text(''),
        leadingWidth: 0,
        // leading: Text(''),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Injaz ',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: Dimensions.size30,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Delivery',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.size30,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      CarouselSlider(
                          items: listImages,
                          options: CarouselOptions(
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 1500),
                            autoPlayCurve: Curves.decelerate,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          )),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.hieght10,
                    right: Dimensions.hieght10,
                    bottom: Dimensions.hieght10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width - Dimensions.hieght20,
                    height: Dimensions.hieght150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: AppColors.mainColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login  ",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: Dimensions.size40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Oswald'),
                        ),
                        Image.asset(
                          'Assets/Images/login.png',
                          height: Dimensions.hieght100,
                          width: Dimensions.hieght100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: Dimensions.hieght150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: AppColors.mainColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Register ",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Dimensions.size40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Oswald'),
                            ),
                            Text(
                              "with us",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.size30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Oswald'),
                            ),
                          ],
                        ),
                        Image.asset(
                          'Assets/Images/register.png',
                          height: Dimensions.hieght100,
                          width: Dimensions.hieght100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactUs()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: Dimensions.hieght150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: AppColors.mainColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Contact  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.size30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Oswald'),
                            ),
                            Text(
                              "Us",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Dimensions.size40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Oswald'),
                            ),
                          ],
                        ),
                        Image.asset(
                          'Assets/Images/Contact.png',
                          height: Dimensions.hieght150,
                          width: Dimensions.hieght150,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.hieght30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
