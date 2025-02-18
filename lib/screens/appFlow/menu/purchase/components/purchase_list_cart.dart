import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class PurchaseListCart extends StatelessWidget {
  final Color? buletPoint;
  final String? title, invoice, amount;
  const PurchaseListCart(
      {Key? key, this.buletPoint, this.amount, this.invoice, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.0.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: buletPoint,
              radius: 12,
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        invoice!,
                        style: TextStyle(
                            color: AppColors.lightGrey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            amount!,
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "12/10/2022",
                            style: TextStyle(
                                color: AppColors.lightGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(
                          0xff717171,
                        ),
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
