// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, file_names, unnecessary_import, unused_import, must_be_immutable, await_only_futures, unused_local_variable, annotate_overrides, sized_box_for_whitespace, deprecated_member_use, sort_child_properties_last, prefer_interpolation_to_compose_strings
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/driverOrders.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/vendorOrders.dart';
import 'package:injaz_delivery/Screens/Admin/testPage.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallBold.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class DriverDetails extends StatefulWidget {
  // User user;
  DriverDetails({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.docId,
  }) : super(key: key);
  String name;

  String phone;
  String email;
  String docId;
  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String userId = '';
  late String name;
  late String phone;
  getUser() async {
    User? getUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      userId = getUser!.uid;
    });
  }

  late TextEditingController nameController;

  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late TextEditingController location;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getUser();
    nameController = TextEditingController(text: widget.name);

    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
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
      body: GestureDetector(
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
                                    initialValue: widget.name,
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
                                    onChanged: ((value) {
                                      setState(() {
                                        name = value;
                                      });
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
                                    initialValue: widget.email,
                                    enabled: false,
                                    style: TextStyle(
                                        color: AppColors.WhiteColor,
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.bold),
                                    validator: ((value) {
                                      if (value == null)
                                        return 'Enter Email';
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
                                    initialValue: widget.phone,
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
                                    onChanged: ((value) {
                                      setState(() {
                                        phone = value;
                                      });
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
                                      .doc(widget.docId)
                                      .update({
                                    'Name': name,
                                    'Phone': phone
                                  }).whenComplete(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Driver details updated')));
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
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
                                    DriverOrders(driver: widget.name))));
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
    );
  }
}
