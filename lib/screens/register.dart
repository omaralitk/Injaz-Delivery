// ignore_for_file: unused_import, non_constant_identifier_names, avoid_print, prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  CollectionReference users = FirebaseFirestore.instance.collection('Requests');

  Future<void> addUser(
      {required String Name,
      required String BussName,
      required String Phone,
      String? Note}) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'Name': Name,
          'Bussines Name': BussName,
          'Phone Number': Phone,
          'Note': Note,
          'Status': 'Pinding'
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NameController = TextEditingController();
  final BussName = TextEditingController();
  final PhoneNumber = TextEditingController();
  final Note = TextEditingController();
  Future createUser(
      {required String Name,
      required String BussName,
      required String Phone,
      String? Note}) async {
    FirebaseFirestore.instance.collection("Requests").add({
      'Name': Name,
      'Bussines Name': BussName,
      'Phone Number': Phone,
      'Note': Note
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WhiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.TextColor),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: (() {
          FocusScope.of(context).unfocus();
        }),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.mainColor,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.hieght20),
                  child: Container(
                    width: Dimensions.ScreenWidth,
                    height: Dimensions.hieght200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Dimensions.ScreenWidth / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                  color: AppColors.TextColor, text: 'Register'),
                              SmallText(
                                  color: AppColors.TextColor,
                                  text:
                                      'Fill the form and we will contact you as soon as possible')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(
                                'Assets/Images/register.png',
                                height: Dimensions.hieght150,
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
              ),
              Container(
                color: AppColors.mainColor,
                child: Container(
                  width: Dimensions.ScreenWidth,
                  height: Dimensions.ScreenHieght * 2 / 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.hieght30),
                          topRight: Radius.circular(Dimensions.hieght30))),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.hieght20,
                            vertical: Dimensions.hieght20),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: Dimensions.hieght20,
                              ),
                              TextFormField(
                                controller: NameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Name ';
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Name',
                                  hintStyle: TextStyle(
                                      color: AppColors.TextColor,
                                      fontFamily: 'Oswald'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.size20),
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
                                controller: BussName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Business Name ';
                                  } else
                                    return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Bussines Name',
                                  hintStyle: TextStyle(
                                      color: AppColors.TextColor,
                                      fontFamily: 'Oswald'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.size20),
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
                                controller: PhoneNumber,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Phone Number ';
                                  } else
                                    return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Phone Number',
                                  hintStyle: TextStyle(
                                      color: AppColors.TextColor,
                                      fontFamily: 'Oswald'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.size20),
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
                                controller: Note,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: 'Note',
                                  hintStyle: TextStyle(
                                      color: AppColors.TextColor,
                                      fontFamily: 'Oswald'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.size20),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.mainColor,
                                  prefixIcon: Icon(
                                    Icons.note_add,
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
                                      addUser(
                                          Name: NameController.text,
                                          BussName: BussName.text,
                                          Phone: PhoneNumber.text,
                                          Note: Note.text);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Please Fill Form')));
                                    }
                                    NameController.clear();
                                    BussName.clear();
                                    PhoneNumber.clear();
                                    Note.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Thank you , We will contact you as soon as ')));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimensions.hieght10,
                                        horizontal: Dimensions.hieght20),
                                    child: BigText(
                                      text: 'Submit',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
