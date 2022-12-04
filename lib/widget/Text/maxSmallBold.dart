// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:injaz_delivery/constant/dimensions.dart';

class MaxSmallBold extends StatelessWidget {
  final Color color;
  final String text;

  MaxSmallBold({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Oswald',
            color: color,
            fontSize: Dimensions.size15),
      ),
    );
  }
}
