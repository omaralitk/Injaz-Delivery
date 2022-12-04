// ignore_for_file: must_be_immutable, unused_import

import 'package:flutter/material.dart';
import 'package:injaz_delivery/constant/app_colors.dart';
import 'package:injaz_delivery/constant/dimensions.dart';
import 'package:injaz_delivery/widget/Text/maxSmallText.dart';
import 'package:injaz_delivery/widget/Text/mediumText.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key? key, required this.name, required this.role})
      : super(key: key);
  String name;
  String role;
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: AppColors.mainColor),
          child: Column(
            children: [
              MediumText(color: AppColors.TextColor, text: widget.name),
              MaxSmallText(text: widget.role)
            ],
          ),
        )
      ],
    );
  }
}
