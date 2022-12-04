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

import '../../../Screens/Admin/Details/order_details.dart';

class AllDriverOrders extends StatefulWidget {
  const AllDriverOrders({Key? key, required this.driver}) : super(key: key);
  final String driver;
  @override
  State<AllDriverOrders> createState() => _AllDriverOrdersState();
}

class _AllDriverOrdersState extends State<AllDriverOrders> {
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
            .where('Driver', isEqualTo: widget.driver)
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
                                  builder: (context) => OrderDetails(
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
                        leading: IconButton(
                          onPressed: (() {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Remove alert'),
                                content: const Text(
                                    'Are you sure to remove this order?'),
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
                                          .doc(docId)
                                          .delete();
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }),
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.SecondColor,
                          ),
                        ),
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
