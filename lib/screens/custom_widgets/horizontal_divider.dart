import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key? key,
    required this.dividerColor,
    this.height

 
  }) : super(key: key);

 final Color dividerColor;
final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
            height: height ?? 1,
            color: dividerColor,
            width: MediaQuery.of(context).size.width,
          );
  }
}



