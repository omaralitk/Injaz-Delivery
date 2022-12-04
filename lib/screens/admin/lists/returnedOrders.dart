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

import '../details/order_details.dart';

class ReturnedOrders extends StatefulWidget {
  const ReturnedOrders({Key? key}) : super(key: key);

  @override
  State<ReturnedOrders> createState() => _ReturnedOrdersState();
}

class _ReturnedOrdersState extends State<ReturnedOrders> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User userDetails;

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WhiteColor,
      appBar: AppBar(
        centerTitle: false,
        title: BigText(color: AppColors.TextColor, text: 'Returned Orders'),
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: InkWell(
          onTap: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => MainScreen())));
          }),
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.TextColor,
          ),
        ),
      ),
      body: Container(
        color: AppColors.mainColor,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.hieght30),
                  topRight: Radius.circular(Dimensions.hieght30))),
          child: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('Orders')
                .where('Status', isEqualTo: 'Returned')
                .snapshots(),
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => OrderDetails(
                                            orderId: doc.get('OrderId'),
                                            docId: doc_id,
                                            Agent: doc.get('Agent'),
                                            Driver: doc.get('Driver'),
                                            date: doc.get('Date'),
                                            location: doc.get('Location'),
                                            note: doc.get('Note'),
                                            phone: doc.get('Phone_Number'),
                                            status: doc.get('Status'),
                                            totalPrice:
                                                doc.get('TotalPrice')))));
                              },
                              title: MediumText(
                                text: doc.get('Agent'),
                                color: AppColors.TextColor,
                              ),
                              subtitle: MaxSmallText(
                                  color: AppColors.TextColor,
                                  text: '${doc.get('Phone_Number')}'),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Remove alert'),
                                      content: const Text(
                                          'Are you sure to remove this Order?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            db
                                                .collection('Orders')
                                                .doc(doc_id)
                                                .delete();
                                            Navigator.pop(context, 'OK');
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColors.SecondColor,
                                ),
                              )),
                        ),
                      );
                    }).toList(),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
