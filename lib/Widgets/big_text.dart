import 'package:flutter/material.dart';
import 'package:quick_cuisine/Utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigText({super.key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.overFlow=TextOverflow.ellipsis,
    this.size = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: size==0? Dimensions.font20 : size,
        color: color,
        fontWeight: FontWeight.w400
      ),
    );
  }
}
