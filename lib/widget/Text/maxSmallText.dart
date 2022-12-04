// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:injaz_delivery/constant/dimensions.dart';

class MaxSmallText extends StatelessWidget {
  final Color color;
  final String text;

  MaxSmallText({
    Key? key,
    this.color = const Color(0xFF000000),
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
            fontFamily: 'Oswald',
            color: Color(0xFF000000),
            fontSize: Dimensions.size15),
      ),
    );
  }
}
