import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleAndAddContent extends StatelessWidget {
  const TitleAndAddContent({
    super.key, this.onTap, this.title
  });
  final Function()? onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13.5.w, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r)),
            child: Text(title ?? "Create")
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
            decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8.r)),
            child: Icon(Icons.add, size: 16.sp, color: Colors.white,),
          ),
        )
      ],
    );
  }
}