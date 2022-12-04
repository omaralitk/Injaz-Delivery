// ignore_for_file: unused_import, file_names, prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Boxes/requestBox.dart';

import '../../Screens/Admin/Details/request_details.dart';

class ApprovedRequests extends StatefulWidget {
  const ApprovedRequests({Key? key}) : super(key: key);

  @override
  State<ApprovedRequests> createState() => _ApprovedRequestsState();
}

class _ApprovedRequestsState extends State<ApprovedRequests> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.hieght30),
                topRight: Radius.circular(Dimensions.hieght30))),
        child: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('Requests')
              .where('Status', isEqualTo: 'Approved')
              .snapshots(),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            if (!snapshot.hasData) {
              // ignore: prefer_const_constructors
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              );
            } else
              // ignore: curly_braces_in_flow_control_structures
              return Padding(
                padding: EdgeInsets.only(top: Dimensions.hieght20),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final docId = data?[index].id;
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (() {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Requestdetails(
                                          docId: docId.toString(),
                                          status: data?[index]['Status'],
                                          name: data?[index]['Name'],
                                          busnissName: data?[index]
                                              ['Bussines Name'],
                                          phone: data?[index]['Phone Number'],
                                          note: data?[index]['Note']))));
                            }),
                            child: Container(
                              child: RequestBox(
                                title: data?[index]['Name'],
                                Status: data?[index]['Status'],
                              ),
                            ),
                          ));
                    }),
              );
          },
        ),
      ),
    );
  }
}
