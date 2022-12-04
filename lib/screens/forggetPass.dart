// ignore_for_file: unused_import, file_names, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, unnecessary_import, curly_braces_in_flow_control_structures, deprecated_member_use, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/Admin/mainScreen.dart';
import 'package:injaz_delivery/Screens/login.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/profile_widget.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class ForggetPass extends StatefulWidget {
  const ForggetPass({Key? key}) : super(key: key);

  @override
  State<ForggetPass> createState() => _ForggetPassState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController emailcontroller = TextEditingController();
String? email;
final auth = FirebaseAuth.instance;

class _ForggetPassState extends State<ForggetPass> {
  Future resetPass() async {
    try {
      await auth.sendPasswordResetEmail(email: emailcontroller.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Reset password email sent')));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WhiteColor,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: BigText(
            text: "Forgget Password",
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: AppColors.mainColor,
        ),
        body: Container(
          color: AppColors.mainColor,
          child: Container(
            height: Dimensions.ScreenHieght,
            width: Dimensions.ScreenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.hieght20),
                    topRight: Radius.circular(Dimensions.hieght20))),
            child: Center(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.hieght20,
                      vertical: Dimensions.hieght20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        onChanged: (value) {
                          email = value;
                        },
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
                              color: AppColors.TextColor, fontFamily: 'Oswald'),
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
                        height: Dimensions.hieght30,
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
                              resetPass();
                              emailcontroller.clear();
                            } else
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please enter your email ')));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.hieght10,
                                horizontal: Dimensions.hieght20),
                            child: BigText(
                              text: 'Reset',
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
