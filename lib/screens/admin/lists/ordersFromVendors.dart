// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, file_names, unused_import, unused_local_variable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/Admin/Details/vendorDetails.dart';
import 'package:injaz_delivery/Screens/Admin/mainScreen.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallBold.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

import '../add/add_order_from_request.dart';

class OrdersFromVendors extends StatefulWidget {
  const OrdersFromVendors({Key? key}) : super(key: key);

  @override
  State<OrdersFromVendors> createState() => _OrdersFromVendorsState();
}

class _OrdersFromVendorsState extends State<OrdersFromVendors> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User userDetails;
  final db = FirebaseFirestore.instance;
  void getUserData() {
    final data =
        db.collection('users').where('Role', isEqualTo: 'Vendor').snapshots();
  }

  late String doc_id;
  getId() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("users").doc();
    DocumentSnapshot docSnap = await docRef.get();
    doc_id = docSnap.reference.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        centerTitle: false,
        title: BigText(color: AppColors.TextColor, text: 'Orders from vendors'),
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: InkWell(
          onTap: (() {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => MainScreen())));
          }),
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.TextColor,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.hieght30),
                topRight: Radius.circular(Dimensions.hieght30))),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('Vendor Orders').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              );
            } else
              return Padding(
                padding: EdgeInsets.only(top: Dimensions.hieght20),
                child: ListView(
                  children: snapshot.data!.docs.map((doc) {
                    var doc_id = doc.id;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.hieght10,
                          vertical: Dimensions.hieght10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.hieght20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => AddOrderFromRequest(
                                          docId: doc_id,
                                          note: doc.get('Note'),
                                          agent: doc.get('Agent'),
                                          id: doc.get('AgentId'),
                                          phone: doc.get('Phone_Number'),
                                          location: doc.get('Location'),
                                          price: doc.get('TotalPrice'),
                                        ))));
                          },
                          title: MediumText(
                            text: doc.get('Agent'),
                            color: AppColors.TextColor,
                          ),
                          subtitle: MaxSmallText(
                              color: AppColors.TextColor,
                              text: '${doc.get('Location')}'),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
          },
        ),
      ),
    );
  }
}
