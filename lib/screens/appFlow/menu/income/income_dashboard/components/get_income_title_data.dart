import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class GetIncometitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            drawBelowEverything: false,
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (((value, meta) {
                  switch (value.toInt()) {
                    case 1:
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          "JAN",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    case 3:
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          "Fav",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    case 5:
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          "Mar",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    case 7:
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          "Apr",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    case 9:
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          "may",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    case 11:
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          "june",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                  }

                  return Text(
                    "",
                    style: TextStyle(fontSize: 11.sp, color: Colors.white),
                  );
                })))),
        leftTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        topTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        rightTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
      );
}
