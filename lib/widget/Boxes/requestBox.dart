// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import, must_be_immutable, prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names
// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';
import 'package:injaz_delivery/widget/Text/smallText.dart';

class RequestBox extends StatefulWidget {
  String title;
  String Status;
  RequestBox({
    Key? key,
    required this.title,
    required this.Status,
  }) : super(key: key);
  @override
  State<RequestBox> createState() => _RequestBoxState();
}

class _RequestBoxState extends State<RequestBox> {
  late Color color;
  changeColore() {
    if (widget.Status == 'Pinding')
      setState(() {
        color = Colors.orange;
      });
    else if (widget.Status == 'Approved')
      setState(() {
        color = Colors.green;
      });
    else
      setState(() {
        color = Colors.red;
      });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setState(() {
      changeColore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.hieght150,
      height: Dimensions.hieght200,
      decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.hieght20)),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(-1, 3)),
          ]),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('Assets/Images/boxback.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.hieght20),
                      topRight: Radius.circular(Dimensions.hieght20))),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(
                    color: Colors.white,
                    text: widget.title,
                  ),
                ],
              )),
            ),
          ),
          Container(
            height: Dimensions.size40,
            width: Dimensions.hieght150,
            child: Center(child: MediumText(color: color, text: widget.Status)),
          )
        ],
      ),
    );
  }
}
