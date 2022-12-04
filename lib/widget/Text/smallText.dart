// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:injaz_delivery/constant/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color color;
  final String text;

  SmallText({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      text: TextSpan(
        text: text,
        style: TextStyle(
            fontFamily: 'Oswald', color: color, fontSize: Dimensions.size20),
      ),
    );
  }
}
