// ignore_for_file: prefer_const_constructors, file_names, curly_braces_in_flow_control_structures, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/models/requests/all_requests.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      // bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      //   selectedIndex: currentPageIndex,
      //   backgroundColor: Colors.green,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       icon: Icon(Icons.list),
      //       label: 'All Requests',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.check_circle),
      //       label: 'Aprroved',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.cancel),
      //       label: 'Rejected',
      //     ),
      //   ],
      // ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.hieght30),
                topRight: Radius.circular(Dimensions.hieght30))),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('Orders').snapshots(),
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
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((doc) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.hieght10,
                          vertical: Dimensions.hieght5),
                      child: Container(
                        width: Dimensions.ScreenWidth - 10,
                        height: Dimensions.size70,
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
      ),

      // <Widget>[
      //   AllRequests(),
      //   Container(
      //     color: Colors.green,
      //     alignment: Alignment.center,
      //     child: const Text('Page 2'),
      //   ),
      //   Container(
      //     color: Colors.blue,
      //     alignment: Alignment.center,
      //     child: const Text('Page 3'),
      //   ),
      // ][currentPageIndex],
    );
  }
}
