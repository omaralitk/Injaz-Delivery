// ignore_for_file: file_names, unused_import, prefer_const_constructors, duplicate_ignore, must_be_immutable, non_constant_identifier_names, annotate_overrides, curly_braces_in_flow_control_structures, deprecated_member_use, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';

class DriverOrderDetails extends StatefulWidget {
  DriverOrderDetails(
      {Key? key,
      required this.orderId,
      required this.docId,
      required this.Agent,
      required this.Driver,
      required this.date,
      required this.location,
      required this.note,
      required this.phone,
      required this.status,
      required this.totalPrice})
      : super(key: key);
  String docId;
  String orderId;
  String Agent;
  String date;
  String Driver;
  String location;
  String note;
  String phone;
  String totalPrice;
  String status;

  @override
  State<DriverOrderDetails> createState() => _DriverOrderDetailsState();
}

class _DriverOrderDetailsState extends State<DriverOrderDetails> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController agentController;
  late TextEditingController dateController;
  late TextEditingController driverController;
  late TextEditingController locationController;
  late TextEditingController phoneController;
  late TextEditingController totalPriceController;
  late TextEditingController noteController;
  late TextEditingController statusController;
  late String vendorValue;
  late String driverSelected = widget.Driver;
  late String agentValue;
  late String driverValue;
  late String statusSelected;
  late List<String> statusItems;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setState(() {
      statusItems = [
        'In Processing',
        'Completed',
        'Cancelled',
        'Delayed',
        'Refusal',
        'Returned'
      ];
      agentController = TextEditingController(text: widget.Agent);
      dateController = TextEditingController(text: widget.date);
      driverController = TextEditingController(text: widget.Driver);
      locationController = TextEditingController(text: widget.location);
      phoneController = TextEditingController(text: widget.phone);
      totalPriceController =
          TextEditingController(text: widget.totalPrice.toString());
      noteController = TextEditingController(text: widget.note);
      statusController = TextEditingController(text: widget.status);
      statusSelected = widget.status;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WhiteColor,
        appBar: AppBar(
          leading: IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.TextColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.mainColor,
          elevation: 0,
          title: Row(
            children: [
              BigText(color: AppColors.TextColor, text: 'Order Details')
            ],
          ),
        ),
        body: GestureDetector(
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: Container(
            color: AppColors.mainColor,
            child: Container(
                width: Dimensions.ScreenWidth,
                height: Dimensions.ScreenHieght,
                decoration: BoxDecoration(
                    color: AppColors.WhiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.hieght30),
                        topRight: Radius.circular(Dimensions.hieght30))),
                child: SingleChildScrollView(
                    child: Column(children: [
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
                                      controller: agentController,
                                      // initialValue: bussNameController.text,
                                      enabled: false,
                                      style: TextStyle(
                                        color: AppColors.WhiteColor,
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.bold,
                                      ),

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
                                          text: 'Agent : ',
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
                                      controller: dateController,
                                      // initialValue: bussNameController.text,
                                      enabled: false,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),

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
                                          text: 'Date : ',
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
                                      controller: driverController,
                                      // initialValue: bussNameController.text,
                                      enabled: false,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),

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
                                          text: 'Driver : ',
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
                                      enabled: false,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
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
                                          text: 'Location : ',
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
                                      enabled: false,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
                                      validator: ((value) {
                                        if (value == null)
                                          return 'Enter Phone';
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
                                      enabled: false,
                                      controller: totalPriceController,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
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
                                          text: 'Total Price : ',
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(),
                              Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: AppColors.TextColor,
                                ),
                                child: DropdownButtonFormField<String>(
                                  iconEnabledColor: AppColors.mainColor,
                                  style: TextStyle(
                                      color: AppColors.WhiteColor,
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.size18),
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
                                      text: 'Status : ',
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  items: statusItems.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  value: statusSelected,
                                  onChanged: (newValue) {
                                    setState(() {
                                      statusSelected = newValue.toString();
                                    });
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: noteController,
                                      enabled: true,
                                      style: TextStyle(
                                          color: AppColors.WhiteColor,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.bold),
                                      validator: ((value) {
                                        if (value == null)
                                          return 'Enter Note';
                                        else
                                          return null;
                                      }),
                                      decoration: InputDecoration(
                                        hintText: 'Not have any note',
                                        hintStyle: TextStyle(
                                            color: AppColors.TextColor,
                                            fontFamily: 'Oswald'),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefix: MediumText(
                                          text: 'Note : ',
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
                                        .collection('Orders')
                                        .doc(widget.docId)
                                        .update({'Driver': driverSelected});

                                    FirebaseFirestore.instance
                                        .collection('Orders')
                                        .doc(widget.docId)
                                        .update({
                                      'Location': locationController.text
                                    });

                                    FirebaseFirestore.instance
                                        .collection('Orders')
                                        .doc(widget.docId)
                                        .update({
                                      'Phone_Number': phoneController.text
                                    });
                                    FirebaseFirestore.instance
                                        .collection('Orders')
                                        .doc(widget.docId)
                                        .update({
                                      'TotalPrice': totalPriceController.text
                                    });
                                    FirebaseFirestore.instance
                                        .collection('Orders')
                                        .doc(widget.docId)
                                        .update({'Status': statusSelected});
                                    FirebaseFirestore.instance
                                        .collection('Orders')
                                        .doc(widget.docId)
                                        .update({'Note': noteController.text});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Order is updated')));
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]))),
          ),
        ));
  }
}
