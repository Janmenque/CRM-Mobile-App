import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InProgressProjectCard extends StatelessWidget {
  const InProgressProjectCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Image.asset("assets/projects/project_in_progress.png",
              height: 164.h, width: 159.w),
          Positioned(
            top: 50.h,
            bottom: 0.h,
            left: 00.w,
            right: 14.w,
            child: Text(
              "19",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xff336FC0),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 75.h,
            bottom: 0.h,
            left: 0.w,
            right: 10.w,
            child: Text(
              "In Progress",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xff336FC0),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
