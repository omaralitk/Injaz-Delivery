// ignore_for_file: unused_import, file_names, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, unnecessary_import, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/Admin/mainScreen.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/profile_widget.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final emailcontroller = TextEditingController();
  final Passcontroller = TextEditingController();
  final Namecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final Phonecontroller = TextEditingController();
  final BussinessController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Object? dropdownvalue;
  bool show = true;

  //SignUp Function
  Future SignUp() async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailcontroller.text, password: Passcontroller.text);
    User? user = result.user;
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      'Uid': user?.uid,
      'Name': Namecontroller.text,
      'Email': emailcontroller.text,
      'Phone': Phonecontroller.text,
      'Role': 'Admin',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WhiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Row(
            children: [
              BigText(
                text: "Add ",
                color: Colors.black,
              ),
              BigText(color: AppColors.SecondColor, text: 'Admin')
            ],
          ),
          elevation: 0,
          backgroundColor: AppColors.mainColor,
        ),
        body: GestureDetector(
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: Container(
            color: AppColors.mainColor,
            child: Container(
              height: Dimensions.ScreenHieght,
              width: Dimensions.ScreenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.hieght20),
                      topRight: Radius.circular(Dimensions.hieght20))),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.hieght20,
                        vertical: Dimensions.hieght20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.hieght20,
                        ),
                        TextFormField(
                          controller: Namecontroller,
                          validator: ((value) {
                            if (value == null)
                              return 'Enter Name';
                            else
                              return null;
                          }),
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(
                                color: AppColors.TextColor,
                                fontFamily: 'Oswald'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.mainColor,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.hieght10,
                        ),
                        TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          validator: ((value) {
                            if (value != null)
                              return null;
                            else
                              return 'Please Enter Email';
                          }),
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(
                                color: AppColors.TextColor,
                                fontFamily: 'Oswald'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.mainColor,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.hieght10,
                        ),
                        TextFormField(
                          controller: Phonecontroller,
                          keyboardType: TextInputType.number,
                          validator: ((value) {
                            if (value != null)
                              return null;
                            else
                              return 'Please Phone Number';
                          }),
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
                            hintStyle: TextStyle(
                                color: AppColors.TextColor,
                                fontFamily: 'Oswald'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.mainColor,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.hieght10,
                        ),
                        TextFormField(
                          obscureText: show,
                          controller: Passcontroller,
                          validator: ((value) {
                            if (value != null)
                              return null;
                            else
                              return 'Please Insert Password';
                          }),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: AppColors.TextColor,
                                fontFamily: 'Oswald'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.mainColor,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  show = !show;
                                });
                              },
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.hieght40,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff292b31),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.hieght20)),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SignUp().whenComplete(() {
                                  Namecontroller.clear();
                                  emailcontroller.clear();
                                  BussinessController.clear();
                                  Phonecontroller.clear();
                                  locationcontroller.clear();
                                  Passcontroller.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Admin Added Successfully ')));
                                });
                              } else
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Please Fill All Sections in Form')));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.hieght10,
                                  horizontal: Dimensions.hieght20),
                              child: BigText(
                                text: 'Add',
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
