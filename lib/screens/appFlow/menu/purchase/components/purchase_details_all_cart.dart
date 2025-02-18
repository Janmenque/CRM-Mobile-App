import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class SupplierInfoCart extends StatelessWidget {
  const SupplierInfoCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Supplier Info",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            fontSize: 16.sp,
          ),
        ),
        const Divider(),
        const InfoCart(title: "Name :", subtitle: "Invoice#0234"),
        const InfoCart(title: "Gamil :", subtitle: "debra.holt@example.com"),
        const InfoCart(title: "Phone :", subtitle: "(302) 555-0107"),
        const InfoCart(
            title: "Address :",
            subtitle: "8502 Preston Rd. Inglewood,\nMaine 98380"),
      ],
    );
  }
}

class PurchaseInfo extends StatelessWidget {
  const PurchaseInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Purchase Info",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            fontSize: 16.sp,
          ),
        ),
        const Divider(),
        const InfoCart(title: "reference :", subtitle: "Invoice#0234"),
        SizedBox(
          height: 16.h,
        ),
        Row(
          children: [
            Text(
              "Payment Status :",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              width: 24.w,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffFC990F).withOpacity(0.4)),
              child: Text(
                "Pending",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffFC990F),
                  fontSize: 12.sp,
                ),
              ),
            )
          ],
        ),
        const InfoCart(title: "Total Amount :", subtitle: "\$999.00"),
      ],
    );
  }
}

class InfoCart extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const InfoCart({Key? key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Text(
            subtitle!,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.lightGrey,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummaryContainer extends StatelessWidget {
  const OrderSummaryContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.0.h),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 4, 16),
        decoration: const BoxDecoration(color: Color(0xffF8F8F8)),
        child: Row(
          children: [
            Image.asset(
              "assets/stocks/watch_img.png",
              height: 60.h,
            ),
            SizedBox(
              width: 16.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Apple iPhone 13 Pro",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                RichText(
                  text: TextSpan(
                      text: "Qty:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightGrey,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: ' 01',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            fontSize: 14.sp,
                          ),
                        )
                      ]),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "\$39.00",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
