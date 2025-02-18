import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      drawBelowEverything: false,
      sideTitles: SideTitles(
      showTitles: false,
      
      getTitlesWidget: (((value, meta) {
        switch (value.toInt()){
          case 2 : 
           return Padding(
             padding:  EdgeInsets.only(top:8.h),
             child:  Text("JAN",  style: TextStyle(color: AppColors.black, fontSize: 12.sp, fontWeight: FontWeight.bold),),
           );
            case 6 : 
           return Padding(
              padding:  EdgeInsets.only(top:8.h),
             child:  Text("FAB",  style: TextStyle(color: AppColors.black, fontSize: 12.sp, fontWeight: FontWeight.bold),),
           );
            case 10 : 
           return Padding(
              padding:  EdgeInsets.only(top:8.h),
             child:  Text("Mar", style: TextStyle(color: AppColors.black, fontSize: 12.sp, fontWeight: FontWeight.bold),),
           );
        }
        
        return  Text("" ,style: TextStyle(fontSize: 11.sp,color: Colors.white),);
      }))
    
    )),

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