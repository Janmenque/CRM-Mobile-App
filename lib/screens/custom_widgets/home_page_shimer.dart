import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerEffect extends StatelessWidget {
  const HomeShimmerEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            children: List.generate(6, (index) {
              return Shimmer.fromColors(
                baseColor: const Color(0xFFE8E8E8),
                highlightColor: Colors.white,
                child: Container(
                  margin:  EdgeInsets.only(left: 12.w, right: 12.h, top: 10.h, bottom: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(
                        10), // radius of 10// green as background color
                  ),
                ),
              );
            }),
          ),
        ),

        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xFFE8E8E8),
                  highlightColor: Colors.white,
                  child: Container(
                    margin:  EdgeInsets.symmetric(horizontal :16.w, vertical: 5.h),
                    height: 155.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(
                          10), // radius of 10// green as background color
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
