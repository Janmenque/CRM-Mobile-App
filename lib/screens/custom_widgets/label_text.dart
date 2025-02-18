import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LavelText extends StatelessWidget {
  const LavelText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color.fromARGB(255, 83, 83, 83),
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    ).tr();
  }
}
