// ignore_for_file: prefer_const_constructors, unnecessary_const, unnecessary_new, unused_field, unused_import, non_constant_identifier_names, unused_local_variable, unused_catch_clause, deprecated_member_use, curly_braces_in_flow_control_structures, await_only_futures, sort_child_properties_last
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/models/check_role.dart';
import 'package:injaz_delivery/Screens/Admin/mainScreen.dart';
import 'package:injaz_delivery/Screens/Driver/driverDashbourd.dart';
import 'package:injaz_delivery/Screens/forggetPass.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallBold.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences loginData;
  late bool newUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      if (loginData.getString('email') != '')
        newUser = true;
      else
        newUser = false;
    });
  }

  Future SignIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .whenComplete(() => CheckRole().RoleManage(context));
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WhiteColor,
      body: GestureDetector(
        onTap: (() {
          FocusScope.of(context).unfocus();
        }),
        child: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: Column(
          children: [
            Container(
              height: Dimensions.size80,
              color: AppColors.mainColor,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(-100)),
              ),
              width: Dimensions.ScreenWidth,
              height: Dimensions.ScreenHieght * 1 / 3.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.hieght10),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios))
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(color: Colors.black, text: 'Hello'),
                          SmallText(
                            text: 'Sign in to your account',
                            color: AppColors.TextColor,
                          )
                        ],
                      ),
                      Image.asset(
                        'Assets/Images/loginBack.png',
                        width: Dimensions.hieght200,
                        height: Dimensions.hieght200,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.mainColor,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.hieght350),
                    )),
                width: MediaQuery.of(context).size.width,
                height: Dimensions.ScreenHieght * 2 / 3,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: Dimensions.size70,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.size70),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size30),
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
                                // enabledBorder: OutlineInputBorder(
                                //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.hieght20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.size70),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: AppColors.mainColor,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),

                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                // enabledBorder: OutlineInputBorder(
                                //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.hieght10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.size80),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  ForggetPass())));
                                    },
                                    child: MaxSmallText(
                                        color: AppColors.TextColor,
                                        text: 'Forgget Password !'),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.hieght30,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final snackBar = SnackBar(
                                content: const Text(
                                    'This Email or Password is not correct'),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {
                                    setState(() {
                                      emailController.text.isEmpty;
                                      passwordController.text.isEmpty;
                                    });
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              if (_formKey.currentState!.validate()) {
                                try {
                                  SignIn();
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.hieght20,
                                  vertical: Dimensions.hieght10),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: Dimensions.size30,
                                    fontFamily: 'Oswald'),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff292b31),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.hieght20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
