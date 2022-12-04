// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, file_names

import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Boxes/requestBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';
import 'package:intl/intl.dart';

import '../../Screens/Admin/Details/order_details.dart';

class AllVendorOrders extends StatefulWidget {
  const AllVendorOrders({Key? key, required this.agent}) : super(key: key);
  final String agent;
  @override
  State<AllVendorOrders> createState() => _AllVendorOrdersState();
}

class _AllVendorOrdersState extends State<AllVendorOrders> {
  final db = FirebaseFirestore.instance;
  DateTime datetime = DateTime.now();
  late String currentDate;
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

//
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    setState(() {
      currentDate = convertDateTimeDisplay(datetime.toString());
    });
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
            .where('Agent', isEqualTo: widget.agent)
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => OrderDetails(
                                        orderId: doc.get('OrderId'),
                                        docId: docId,
                                        Agent: doc.get('Agent'),
                                        date: doc.get('Date'),
                                        Driver: doc.get('Driver'),
                                        location: doc.get('Location'),
                                        phone: doc.get('Phone_Number'),
                                        totalPrice: doc.get('TotalPrice'),
                                        status: doc.get('Status'),
                                        note: doc.get('Note'),
                                      ))));
                        },
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
