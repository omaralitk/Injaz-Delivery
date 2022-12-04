// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, file_names, unnecessary_import, unused_import, must_be_immutable, await_only_futures, unused_local_variable, annotate_overrides, deprecated_member_use, non_constant_identifier_names, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/vendorList.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/vendorOrders.dart';
import 'package:injaz_delivery/Screens/Admin/testPage.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallBold.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class VendorDetails extends StatefulWidget {
  // User user;
  VendorDetails(
      {Key? key,
      required this.doc_id,
      required this.name,
      required this.businessName,
      required this.email,
      required this.phone,
      required this.location})
      : super(key: key);
  String doc_id;
  String name;
  String businessName;
  String phone;
  String email;
  String location;
  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String userId = '';
  getUser() async {
    User? getUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      userId = getUser!.uid;
    });
  }

  Future<void> updateUserData(Map<String, dynamic> values) async {
    String id = values['id'];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(values);
  }

  getOrders() {
    FirebaseFirestore db = FirebaseFirestore.instance
        .collection('Orders')
        .doc()
        .get() as FirebaseFirestore;
  }

  late TextEditingController nameController;
  late TextEditingController bussNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  late TextEditingController locationController;
  final db = FirebaseFirestore.instance;
  late String name;
  late String bussName;
  late String email;
  late String phone;
  late String location;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getUser();
    nameController = TextEditingController(text: widget.name);
    bussNameController = TextEditingController(text: widget.businessName);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    locationController = TextEditingController(text: widget.location);
    name = widget.name;
    bussName = widget.businessName;
    email = widget.email;
    phone = widget.phone;
    location = widget.location;

    super.initState();
  }

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
        elevation: 0.0,
        backgroundColor: AppColors.mainColor,
        title: Row(
          children: [
            BigText(color: AppColors.TextColor, text: widget.name),
            BigText(color: AppColors.SecondColor, text: ' Details'),
          ],
        ),
      ),
      body: Container(
        color: AppColors.mainColor,
        child: GestureDetector(
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: Container(
            width: Dimensions.ScreenWidth,
            height: Dimensions.ScreenHieght,
            decoration: BoxDecoration(
                color: AppColors.WhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.hieght30),
                    topRight: Radius.circular(Dimensions.hieght30))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dimensions.hieght20),
                    child: Container(
                      width: Dimensions.ScreenWidth,
                      decoration: BoxDecoration(
                          color: AppColors.GreyColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.hieght30))),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.hieght5,
                              vertical: Dimensions.hieght20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: nameController,
                                      enabled: true,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
                                      validator: ((value) {
                                        if (value == null)
                                          return 'Enter Name';
                                        else
                                          return null;
                                      }),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: AppColors.TextColor,
                                            fontFamily: 'Oswald'),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefix: MediumText(
                                          text: 'Name : ',
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: bussNameController,
                                      // initialValue: bussNameController.text,
                                      enabled: true,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
                                      validator: ((value) {
                                        if (value == null)
                                          return 'Enter Business Name';
                                        else
                                          return null;
                                      }),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: AppColors.TextColor,
                                            fontFamily: 'Oswald'),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefix: MediumText(
                                          text: 'Business Name : ',
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: emailController,
                                      enabled: false,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
                                      validator: ((value) {
                                        if (value == null)
                                          return 'Enter Business Name';
                                        else
                                          return null;
                                      }),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: AppColors.TextColor,
                                            fontFamily: 'Oswald'),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefix: MediumText(
                                          text: 'Email : ',
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: phoneController,
                                      enabled: true,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
                                      validator: ((value) {
                                        if (value == null)
                                          return 'Enter Phone Number';
                                        else
                                          return null;
                                      }),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: AppColors.TextColor,
                                            fontFamily: 'Oswald'),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefix: MediumText(
                                          text: 'Phone : ',
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: locationController,
                                      enabled: true,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
                                      validator: ((value) {
                                        if (value == null)
                                          return 'Enter Location';
                                        else
                                          return null;
                                      }),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: AppColors.TextColor,
                                            fontFamily: 'Oswald'),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefix: MediumText(
                                          text: 'location : ',
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.hieght30,
                              ),
                              ElevatedButton(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.size15,
                                        vertical: Dimensions.hieght5),
                                    child: MediumText(
                                      text: 'Update',
                                      color: AppColors.TextColor,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.doc_id)
                                        .update({
                                      'Location': locationController.text
                                    });
                                    Navigator.pop(context, 'OK');

                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.doc_id)
                                        .update(
                                            {'Phone': phoneController.text});
                                    Navigator.pop(context, 'OK');

                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.doc_id)
                                        .update(
                                            {'Email': emailController.text});
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.doc_id)
                                        .update(
                                            {'Phone': phoneController.text});
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.doc_id)
                                        .update({
                                      'Bussiness Name': bussNameController.text
                                    });
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.doc_id)
                                        .update({'Name': nameController.text});
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                VendorList())));
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.size50,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.size25),
                      child: ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.size15),
                          child: MediumText(
                            text: 'Go to ' + widget.name + "'s" + ' Orders',
                            color: AppColors.TextColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      VendorOrders(agent: widget.name))));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
