// ignore_for_file: unused_import, file_names, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, unnecessary_import, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/profile_widget.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
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
      'Bussiness Name': BussinessController.text,
      'Location': locationcontroller.text,
      'Role': 'Vendor',
    });
  }

  //Add user details
  Future addUserDetails(
      String Name, String PhoneNumber, String Location) async {
    FirebaseFirestore.instance
        .collection('Users')
        .add({'Name': Name, 'Phone Number': PhoneNumber, 'Location': Location});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WhiteColor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
              BigText(color: AppColors.SecondColor, text: 'Vendor')
            ],
          ),
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.hieght30),
                    topRight: Radius.circular(Dimensions.hieght30)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.hieght20,
                        vertical: Dimensions.hieght20),
                    child: Column(
                      children: [
                        // ProfileWidget(
                        //   imagePath:
                        //       'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                        //   onClicked: () async {},
                        // ),
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
                          controller: BussinessController,
                          validator: ((value) {
                            if (value == null)
                              return 'Please Enter Bussiness Name';
                            else
                              return null;
                          }),
                          decoration: InputDecoration(
                            hintText: 'Enter Bussiness Name',
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
                        // DropdownButtonFormField(
                        //   onChanged: (value) => {
                        //     dropdownvalue = value,
                        //   },
                        //   decoration: InputDecoration(
                        //       prefixIcon: Icon(
                        //         Icons.accessibility_new,
                        //         color: Colors.black,
                        //       ),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.all(
                        //             Radius.circular(Dimensions.hieght20),
                        //           ),
                        //           borderSide: BorderSide.none),
                        //       filled: true,
                        //       hintStyle: TextStyle(
                        //           color: AppColors.TextColor, fontFamily: 'Oswald'),
                        //       hintText: "Add Role",
                        //       fillColor: AppColors.mainColor),
                        //   items:
                        //       items.map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        // ),
                        // SizedBox(
                        //   height: Dimensions.hieght10,
                        // ),
                        TextFormField(
                          controller: locationcontroller,
                          keyboardType: TextInputType.multiline,
                          validator: ((value) {
                            if (value != null)
                              return null;
                            else
                              return 'Please Insert Location';
                          }),
                          decoration: InputDecoration(
                            hintText: 'Insert Location',
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
                              Icons.location_on,
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
                                });

                                // Namecontroller.clear();
                                // BussinessController.clear();
                                // emailcontroller.clear();
                                // locationcontroller.clear();
                                // Passcontroller.clear();
                                // Phonecontroller.clear();
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
