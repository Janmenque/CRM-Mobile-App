import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressIndeccatorWithPersentage extends StatelessWidget {
  const ProgressIndeccatorWithPersentage({super.key, this.activeContainerWidth, this.deActivetContainerWidth, this.persentageTextHeight, this.containerHeight, this.persentageActiveColor, this.persentageDisebleColor, this.persentage});
 
 final Color? persentageActiveColor, persentageDisebleColor;
 final double? activeContainerWidth, deActivetContainerWidth, containerHeight, persentageTextHeight;
 final String? persentage;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
              color: persentageActiveColor
            ),
            height: containerHeight ?? 4.h,
            width: activeContainerWidth,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
              color: persentageDisebleColor
            ),
            height: containerHeight ?? 4.h,
            width: deActivetContainerWidth ,
          ),
          SizedBox(
            width: 9.w ,
          ),
          Text(
            persentage ?? "",
            style: TextStyle(color: Colors.black, fontSize:  persentageTextHeight ?? 11.h, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
