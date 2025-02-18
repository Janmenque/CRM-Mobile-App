

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcommingProjectCard extends StatelessWidget {
  const UpcommingProjectCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Image.asset("assets/projects/project_upcomming.png",
              height: 164.h, width: 159.w),
          Positioned(
            top: 50.h,
            bottom: 0.h,
            left: 00.w,
            right: 10.w,
            child: Text(
              "17",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 75.h,
            bottom: 0.h,
            left: 0.w,
            right: 8.w,
            child: Text(
              "Upcomming",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
