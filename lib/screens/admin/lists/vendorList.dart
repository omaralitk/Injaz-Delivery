// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, file_names, unused_import, unused_local_variable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/Admin/Details/vendorDetails.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallBold.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class VendorList extends StatefulWidget {
  const VendorList({Key? key}) : super(key: key);

  @override
  State<VendorList> createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  late User userDetails;

  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        centerTitle: false,
        title: BigText(color: AppColors.TextColor, text: 'Vendors List'),
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: InkWell(
          onTap: (() {
            Navigator.pop(context);
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
          stream: db
              .collection('users')
              .where('Role', isEqualTo: 'Vendor')
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => VendorDetails(
                                            doc_id: doc_id,
                                            location: doc.get('Location'),
                                            email: doc.get('Email'),
                                            name: doc.get('Name'),
                                            businessName:
                                                doc.get('Bussiness Name'),
                                            phone: doc.get('Phone'),
                                          ))));
                            },
                            leading: CircleAvatar(
                              radius: Dimensions.hieght30,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                  'Assets/Images/vindorsListPic.png'),
                            ),
                            title: MediumText(
                              text: doc.get('Name'),
                              color: AppColors.TextColor,
                            ),
                            subtitle: MaxSmallText(
                                color: AppColors.TextColor,
                                text: '${doc.get('Bussiness Name')}'),
                            trailing: IconButton(
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Remove alert'),
                                    content: const Text(
                                        'Are you sure to remove this vendor?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          db
                                              .collection('users')
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
    );
  }
}
