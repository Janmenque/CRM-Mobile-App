
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteProjectCard extends StatelessWidget {
  const CompleteProjectCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Image.asset("assets/projects/project_completed.png",
              height: 164.h, width: 159.w),
          Positioned(
            top: 50.h,
            bottom: 0.h,
            left: 00.w,
            right: 2.w,
            child: Text(
              "50",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xff6D349A),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 75.h,
            bottom: 0.h,
            left: 0.w,
            right: 2.w,
            child: Text(
              "Completed",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xff6D349A),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
