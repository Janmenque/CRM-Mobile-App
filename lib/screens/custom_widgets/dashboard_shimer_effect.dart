import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimerEffect extends StatelessWidget {
  const DashboardShimerEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: GridView.count(  
              crossAxisCount: 2,
              childAspectRatio: 8 / 6,
              mainAxisSpacing: 2,
              children: List.generate(4, (index) {
            return Shimmer.fromColors(
              baseColor: const Color(0xFFE8E8E8),
              highlightColor: Colors.white,
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
          SizedBox(
            height: 2.h,
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
