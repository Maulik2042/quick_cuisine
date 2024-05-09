import 'package:flutter/material.dart';
import 'package:quick_cuisine/Widgets/small_text.dart';

import '../Utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  // double iconSize;
  IconAndTextWidget({super.key, required this.icon, required this.text, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor,size: Dimensions.iconSize24),
        SizedBox(width: 5),
        SmallText(text: text),
      ],
    );
  }
}
