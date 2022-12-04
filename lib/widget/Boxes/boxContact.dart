// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import, must_be_immutable, prefer_const_constructors
// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/bigText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';

class BoxContact extends StatefulWidget {
  final VoidCallback onClicked;
  String imageIcon;
  String title;

  BoxContact({
    Key? key,
    required this.onClicked,
    required this.imageIcon,
    required this.title,
  }) : super(key: key);
  @override
  State<BoxContact> createState() => _BoxContactState();
}

class _BoxContactState extends State<BoxContact> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClicked,
      child: Container(
        width: Dimensions.hieght150,
        height: Dimensions.hieght200,
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.hieght20)),
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
                  child: Image.asset(
                    widget.imageIcon,
                    width: Dimensions.size70,
                    height: Dimensions.size70,
                  ),
                ),
              ),
            ),
            Container(
              height: Dimensions.size40,
              width: Dimensions.hieght150,
              child: Center(
                child: MediumText(
                  text: widget.title,
                  color: AppColors.TextColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
