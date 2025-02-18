import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomListShimer extends StatelessWidget {
  const CustomListShimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: const Color(0xFFE8E8E8),
            highlightColor: Colors.white,
            child: Container(
              margin:  EdgeInsets.symmetric(horizontal :6.w, vertical: 5.h),
              height: 135.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(
                    10), // radius of 10// green as background color
              ),
            ),
          );
        });
  }
}
