// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, curly_braces_in_flow_control_structures, sized_box_for_whitespace
import 'dart:io';

import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/homePage.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Boxes/boxContact.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  void launchWhatsApp({
    required int phone,
    required String message,
  }) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  final List<String> listImages = [
    'Assets/Images/back2.jpeg',
    'Assets/Images/back3.jpeg',
    'Assets/Images/back1.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: Dimensions.size80,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.hieght10, top: Dimensions.size50),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.size20,
                  right: Dimensions.size20,
                  top: Dimensions.hieght20),
              child: Container(
                width: Dimensions.ScreenWidth,
                height: Dimensions.hieght200,
                child: Row(
                  children: [
                    Container(
                      height: Dimensions.hieght180,
                      width: Dimensions.ScreenWidth / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                              color: AppColors.TextColor, text: 'Contact Us'),
                          RichText(
                            // ignore: unnecessary_new
                            text: new TextSpan(
                              text: 'Do not hesitate to contact us',
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  color: AppColors.TextColor,
                                  fontSize: Dimensions.size20),
                            ),
                          ),
                          // SmallText(
                          //     color: AppColors.TextColor,
                          //     text: 'Do not hesitate to contact us')
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            'Assets/Images/vectorContact.png',
                          ),
                          SizedBox(
                            height: Dimensions.size20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: Dimensions.ScreenWidth,
              height: Dimensions.ScreenHieght * 2 / 3.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.size50),
                      topRight: Radius.circular(Dimensions.size50))),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.size50,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoxContact(
                            imageIcon: 'Assets/Images/phone.png',
                            title: 'Call Us',
                            onClicked: () {
                              FlutterPhoneDirectCaller.callNumber('0777664484');
                            },
                          ),
                          SizedBox(
                            width: Dimensions.hieght20,
                          ),
                          BoxContact(
                            imageIcon: 'Assets/Images/whatsapp.png',
                            title: 'WhatsApp',
                            onClicked: () {
                              launchWhatsApp(
                                  phone: 00962777664484, message: '');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.hieght20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoxContact(
                            imageIcon: 'Assets/Images/website.png',
                            title: 'Our Website',
                            onClicked: () async {
                              Uri url = Uri.parse('https://goonlinejo.com');
                              await launchUrl(url);
                            },
                          ),
                          SizedBox(
                            width: Dimensions.hieght20,
                          ),
                          BoxContact(
                            imageIcon: 'Assets/Images/email.png',
                            title: 'Send Email',
                            onClicked: () {
                              launch(
                                  "mailto:<info@goonlinejo.com>?subject=<Contact with Injaz Delivery>&body=<>");
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
