import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/res.dart';
import 'components/purchase_details_all_cart.dart';

class PurchaseDetails extends StatelessWidget {
  const PurchaseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Purchase Details",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PurchaseInfo(),
                  SizedBox(
                    height: 36.h,
                  ),
                  const SupplierInfoCart(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Ordered Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  const OrderSummaryContainer(),
                  const OrderSummaryContainer(),
                  const OrderSummaryContainer(),
                  const OrderSummaryContainer(),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: const BoxDecoration(
                        color: Color(0xffF8F8F8),
                        border: Border.symmetric(
                          horizontal: BorderSide(color: Colors.grey, width: 2),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Sub Total: \$339.00",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5B58FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    child: Text(
                      "Print Invoice",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    child: Text(
                      "Download Invoice",
                      style: TextStyle(
                          color: const Color(0xff5B58FF),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
