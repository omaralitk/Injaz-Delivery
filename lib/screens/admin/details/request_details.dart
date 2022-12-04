// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, must_be_immutable, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_new, await_only_futures, curly_braces_in_flow_control_structures, duplicate_ignore, unused_element, deprecated_member_use, sort_child_properties_last
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/Screens/Admin/Lists/registerRequest.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';

class Requestdetails extends StatefulWidget {
  String name;
  String busnissName;
  String phone;
  String note;
  String status;
  String docId;
  Requestdetails({
    Key? key,
    required this.docId,
    required this.status,
    required this.name,
    required this.busnissName,
    required this.phone,
    required this.note,
  }) : super(key: key);

  @override
  State<Requestdetails> createState() => _RequestdetailsState();
}

class _RequestdetailsState extends State<Requestdetails> {
  late List<String> statusList;
  String userId = '';
  getUser() async {
    User? getUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      userId = getUser!.uid;
    });
  }

  late Color color;
  late String dropValue = 'Pinding';
  changeColore() {
    if (widget.status == 'Pinding')
      setState(() {
        color = Colors.orange;
      });
    else if (widget.status == 'Approved')
      setState(() {
        color = Colors.green;
      });
    else
      setState(() {
        color = Colors.red;
      });
  }

  late String statusSelected;
  @override
  void initState() {
    setState(() {
      statusList = ['Approved', 'Pinding', 'Canceled'];
      getUser();
      changeColore();
      statusSelected = widget.status;
    });

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WhiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        title: Row(
          children: [
            BigText(color: AppColors.TextColor, text: widget.name),
            BigText(color: AppColors.SecondColor, text: ' Request')
          ],
        ),
      ),
      body: Container(
        color: AppColors.mainColor,
        child: GestureDetector(
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.WhiteColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.hieght30))),
            width: Dimensions.ScreenWidth,
            height: Dimensions.ScreenHieght,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.hieght20,
                      horizontal: Dimensions.hieght10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.GreyColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.hieght30))),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.hieght20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              MediumText(
                                  color: AppColors.mainColor, text: 'Name : '),
                              MediumText(
                                  color: AppColors.WhiteColor,
                                  text: widget.name)
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.hieght20,
                          ),
                          Row(
                            children: [
                              MediumText(
                                  color: AppColors.mainColor,
                                  text: 'Bussiness Name : '),
                              MediumText(
                                  color: AppColors.WhiteColor,
                                  text: widget.busnissName)
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.hieght20,
                          ),
                          Row(
                            children: [
                              MediumText(
                                  color: AppColors.mainColor,
                                  text: 'Phone Number : '),
                              MediumText(
                                  color: AppColors.WhiteColor,
                                  text: widget.phone)
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.hieght20,
                          ),
                          Row(
                            children: [
                              MediumText(
                                  color: AppColors.mainColor, text: 'Note : '),
                              MediumText(
                                  color: AppColors.WhiteColor,
                                  text: widget.note)
                            ],
                          ),
                          Row(
                            children: [
                              MediumText(
                                  color: AppColors.mainColor,
                                  text: 'Status : '),
                              Expanded(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: AppColors.TextColor,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    iconEnabledColor: AppColors.mainColor,
                                    style: TextStyle(
                                        color: AppColors.WhiteColor,
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.size18),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: AppColors.TextColor,
                                          fontFamily: 'Oswald'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.size20),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    items: statusList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: statusSelected,
                                    onChanged: (newValue) {
                                      setState(() {
                                        statusSelected = newValue.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.hieght10,
                          ),
                          ElevatedButton(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.size15,
                                    vertical: Dimensions.hieght5),
                                child: MediumText(
                                  text: 'Update',
                                  color: AppColors.TextColor,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Requests')
                                    .doc(widget.docId)
                                    .update({'Status': statusSelected});
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Request updated')));
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          FirebaseFirestore.instance
              .collection('Requests')
              .doc(widget.docId)
              .delete()
              .whenComplete(
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Requests())),
              );
        },
        child: Icon(Icons.delete),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
