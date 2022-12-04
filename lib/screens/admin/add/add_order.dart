// ignore_for_file: unused_import, file_names, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, unnecessary_import, curly_braces_in_flow_control_structures, deprecated_member_use, unnecessary_new, prefer_typing_uninitialized_variables, avoid_print, await_only_futures, body_might_complete_normally_nullable, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/models/vendor_user.dart';
import 'package:injaz_delivery/Screens/Admin/Details/vendorDetails.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/profile_widget.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';
import 'package:intl/intl.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final db = FirebaseFirestore.instance;
  final NoteController = TextEditingController();
  final Passcontroller = TextEditingController();
  final PriceController = TextEditingController();
  final locationcontroller = TextEditingController();
  final Phonecontroller = TextEditingController();
  // final DeliveryController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool show = true;
  int orderNumber = 1;
  DateTime datetime = DateTime.now();
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  var vendorSelected;
  var driverSelected;
  late String vendorValue;
  late String driverValue;
  late String agentId;
  late String driverId;
  List<String> items = [];
  Future addOrder() async {
    FirebaseAuth user = await FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('Orders').add({
      'Agent': vendorSelected,
      'Phone_Number': Phonecontroller.text,
      'Location': locationcontroller.text,
      'TotalPrice': PriceController.text,
      'OrderId': 'InjazOrder-' + orderNumber.toString(),
      'Driver': driverSelected,
      'Note': NoteController.text,
      'Date': convertDateTimeDisplay(datetime.toString()),
      'Status': 'In Processing',
      'AgentId': agentId,
      'DriverId': driverId
    }).whenComplete(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Order Added Successfilly'))));
    orderNumber++;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
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
        title: Row(
          children: [
            BigText(
              text: "Add ",
              color: Colors.black,
            ),
            BigText(color: AppColors.SecondColor, text: 'Order')
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
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('Role', isEqualTo: 'Vendor')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator(
                              color: AppColors.mainColor,
                            );
                          } else {
                            List<DropdownMenuItem> agents = [];
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data!.docs[i];
                              agentId = snap.get('Uid');
                              agents.add(DropdownMenuItem(
                                child: Text('${snap.get('Name')}'),
                                value: '${snap.get('Name')}',
                              ));
                            }
                            return DropdownButtonFormField<dynamic>(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.hieght20),
                                        ),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: AppColors.TextColor,
                                        fontFamily: 'Oswald'),
                                    hintText: "Agent",
                                    fillColor: AppColors.mainColor),
                                items: agents,
                                onChanged: ((value) async {
                                  setState(() {
                                    vendorSelected = value;
                                  });
                                }));
                          }
                        },
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
                              color: AppColors.TextColor, fontFamily: 'Oswald'),
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
                              color: AppColors.TextColor, fontFamily: 'Oswald'),
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
                        controller: PriceController,
                        keyboardType: TextInputType.number,
                        validator: ((value) {
                          if (value == null)
                            return 'Enter Price';
                          else
                            return null;
                        }),
                        decoration: InputDecoration(
                          hintText: 'Enter Price',
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
                            Icons.money,
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
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('Role', isEqualTo: 'Driver')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator(
                              color: AppColors.mainColor,
                            );
                          } else {
                            List<DropdownMenuItem> vendors = [];
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data!.docs[i];
                              vendors.add(DropdownMenuItem(
                                onTap: () {
                                  driverValue = snap.get('Uid').toString();
                                },
                                child: Text('${snap.get('Name')}'),
                                value: '${snap.get('Name')}',
                              ));
                            }
                            return DropdownButtonFormField<dynamic>(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.hieght20),
                                        ),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: AppColors.TextColor,
                                        fontFamily: 'Oswald'),
                                    hintText: "Driver",
                                    fillColor: AppColors.mainColor),
                                items: vendors,
                                onChanged: ((value) async {
                                  setState(() {
                                    driverSelected = value;
                                    driverId = driverValue;
                                  });
                                }));
                          }
                        },
                      ),
                      SizedBox(
                        height: Dimensions.hieght10,
                      ),
                      TextFormField(
                        controller: NoteController,
                        validator: (value) {
                          if (value == '') NoteController.text = '  ';
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Note',
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
                            Icons.note,
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
                              addOrder().whenComplete(() => {
                                    PriceController.clear(),
                                    NoteController.clear(),
                                    locationcontroller.clear(),
                                    Passcontroller.clear(),
                                    Phonecontroller.clear(),
                                    vendorSelected = null,
                                    driverSelected = null,
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
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
