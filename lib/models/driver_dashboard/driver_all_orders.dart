// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, file_names

import 'package:injaz_delivery/constant/dimensions.dart';

import 'package:injaz_delivery/Screens/Driver/driverOrderDetails.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Boxes/requestBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';
import 'package:intl/intl.dart';

class DriverAllOrders extends StatefulWidget {
  const DriverAllOrders({Key? key, required this.driverId}) : super(key: key);
  final String driverId;
  @override
  State<DriverAllOrders> createState() => _DriverAllOrdersState();
}

class _DriverAllOrdersState extends State<DriverAllOrders> {
  final db = FirebaseFirestore.instance;

//
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.hieght30),
              topRight: Radius.circular(Dimensions.hieght30))),
      child: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('Orders')
            .where('DriverId', isEqualTo: widget.driverId)
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
                  String docId = doc.id;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.hieght10,
                        vertical: Dimensions.hieght5),
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
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DriverOrderDetails(
                                      orderId: doc.get('OrderId'),
                                      docId: docId,
                                      Agent: doc.get('Agent'),
                                      Driver: doc.get('Driver'),
                                      date: doc.get('Date'),
                                      location: doc.get('Location'),
                                      note: doc.get('Note'),
                                      phone: doc.get('Phone_Number'),
                                      status: doc.get('Status'),
                                      totalPrice: doc.get('TotalPrice'))));
                        }),
                        title: MediumText(
                          text: doc.get('Location'),
                          color: AppColors.TextColor,
                        ),
                        subtitle: SmallText(
                            color: AppColors.TextColor,
                            text: '${doc.get('Status')}'),
                        trailing: SmallText(
                            color: AppColors.TextColor,
                            text: '${doc.get('Driver')}'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
        },
      ),
    );
  }
}
