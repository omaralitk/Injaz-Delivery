// ignore_for_file: file_phones, duplicate_import, unused_import, unused_local_variable

import 'package:flutter/material.dart';
// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

import '../../../Screens/Admin/Details/order_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final db = FirebaseFirestore.instance;
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        centerTitle: false,
        title: Container(
          decoration: BoxDecoration(
            // ignore: prefer_const_literals_to_create_immutables

            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.hieght10)),
            color: AppColors.WhiteColor,
          ),
          height: Dimensions.size40,
          width: Dimensions.ScreenWidth / 1.5,
          child: TextFormField(
            onChanged: ((value) {
              setState(() {
                phone = value;
              });
            }),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                fontFamily: 'Oswald',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.size20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.WhiteColor,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.GreyColor,
              ),
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
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
            stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
            builder: (context, snapshots) {
              final dataId = snapshots.data?.docs;
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        String docId = dataId![index].id;
                        var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;

                        if (phone.isEmpty) {
                          return ListTile(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetails(
                                          orderId: data['OrderId'],
                                          docId: docId,
                                          Agent: data['Agent'],
                                          Driver: data['Driver'],
                                          date: data['Date'],
                                          location: data['Location'],
                                          note: data['Note'],
                                          phone: data['Phone_Number'],
                                          status: data['Status'],
                                          totalPrice: data['TotalPrice'])));
                            }),
                            title: Text(
                              data['Agent'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['Phone_Number'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        if (data['Phone_Number']
                            .toString()
                            .toLowerCase()
                            .startsWith(phone.toLowerCase())) {
                          return ListTile(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetails(
                                          orderId: data['OrderId'],
                                          docId: docId,
                                          Agent: data['Agent'],
                                          Driver: data['Driver'],
                                          date: data['Date'],
                                          location: data['Location'],
                                          note: data['Note'],
                                          phone: data['Phone_Number'],
                                          status: data['Status'],
                                          totalPrice: data['TotalPrice'])));
                            }),
                            trailing: data[''],
                            title: Text(
                              data['Agent'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['Phone_Number'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return Container();
                      });
            },
          )),
    );
  }
}
