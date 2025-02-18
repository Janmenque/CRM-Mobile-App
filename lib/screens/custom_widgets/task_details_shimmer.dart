import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TaskDetailsShimmerEffect extends StatelessWidget {
  const TaskDetailsShimmerEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE8E8E8),
          highlightColor: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(
                  6), // radius of 10// green as background color
            ),
          ),
        ),
      ],
    );
  }
}
