// ignore_for_file: file_names, duplicate_import

import 'package:flutter/material.dart';
// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

import '../details/driver_details.dart';

class DriversList extends StatefulWidget {
  const DriversList({Key? key}) : super(key: key);

  @override
  State<DriversList> createState() => _DriversListState();
}

class _DriversListState extends State<DriversList> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WhiteColor,
      appBar: AppBar(
        centerTitle: false,
        title: BigText(color: AppColors.TextColor, text: 'Drivers List'),
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
        color: AppColors.mainColor,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.hieght30),
                  topRight: Radius.circular(Dimensions.hieght30))),
          child: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('users')
                .where('Role', isEqualTo: 'Driver')
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => DriverDetails(
                                            docId: docId,
                                            name: doc.get('Name'),
                                            email: doc.get('Email'),
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
                            subtitle: SmallText(
                                color: AppColors.TextColor,
                                text: '${doc.get('Phone')}'),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Remove alert'),
                                      content: const Text(
                                          'Are you sure to remove this driver?'),
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
                                                .doc(docId)
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
                                )),
                          ),
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
