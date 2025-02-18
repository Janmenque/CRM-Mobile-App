import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTapBarButton extends StatelessWidget {
  const CustomTapBarButton(
      {Key? key,
      required this.buttonColor,
      required this.textColor,
      required this.buttonText,
      required this.borderColor,
      this.fontSize,
       this.verticalPadding})
      : super(key: key);

  final Color? buttonColor, textColor, borderColor;
  final String? buttonText;
  final double? verticalPadding, fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: verticalPadding ?? 2, horizontal: 14.w),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor!),
        borderRadius: BorderRadius.circular(18.r),
        color: buttonColor!,
      ),
      child: Text(
        buttonText ?? "",
        style: TextStyle(
          fontSize: fontSize ?? 12.sp,
          fontWeight: FontWeight.bold,
          color: textColor!,
          //color: Colors.white
        ),
      ).tr(),
    );
  }
}

class CustomTapBarButtonWithQuantity extends StatelessWidget {
  const CustomTapBarButtonWithQuantity(
      {super.key,
      required this.buttonColor,
      required this.textColor,
      required this.buttonText,
      required this.circleColor,
      required this.quantity,
      required this.verticalPadding,
      this.onTap});
  final Color? buttonColor, textColor, circleColor;
  final String? buttonText, quantity;
  final double? verticalPadding;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: verticalPadding!, horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: buttonColor!,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
              child: Text(
                quantity!,
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
            ),
            SizedBox(
              width: 04.w,
            ),
            Text(
              buttonText!,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: textColor!,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}

class CustomTapBarButtonWithDate extends StatelessWidget {
  const CustomTapBarButtonWithDate(
      {super.key,
      required this.buttonColor,
      required this.firstDate,
      required this.endData,
      required this.verticalPadding});
  final Color? buttonColor;
  final String? firstDate, endData;
  final double? verticalPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: verticalPadding!, horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: buttonColor!,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/task/calender.png",
            height: 18.h,
            width: 18.w,
          ),
          SizedBox(
            width: 04.w,
          ),
          Text(
            firstDate!,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(
            width: 04.w,
          ),
          Text(
            endData ?? "",
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

