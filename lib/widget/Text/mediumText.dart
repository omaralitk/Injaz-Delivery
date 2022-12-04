// ignore_for_file: file_names, must_be_immutable, import_of_legacy_library_into_null_safe, prefer_const_constructors_in_immutables
import 'package:flutter/cupertino.dart';
import 'package:injaz_delivery/constant/dimensions.dart';

class MediumText extends StatelessWidget {
  final Color color;
  final String text;
  //double size;

  MediumText({
    Key? key,
    required this.color,
    required this.text,
    // this.size = 18,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
        maxLines: 1,
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: 'Oswald',
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.size20,
          ),
        ));
    // // Text(
    // //   text,
    // //   maxLines: 1,
    //   style: TextStyle(
    //     fontFamily: 'Oswald',
    //     color: color,
    //     fontWeight: FontWeight.bold,
    //     fontSize: Dimensions.size20,
    //   ),
    // // );
  }
}
