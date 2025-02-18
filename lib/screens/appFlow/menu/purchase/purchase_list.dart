import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/purchase/add_purchase.dart';
import 'package:hrm_app/screens/appFlow/menu/purchase/purchase_details.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/res.dart';

import 'components/purchase_list_cart.dart';

class PurchaseList extends StatelessWidget {
  const PurchaseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Purchase List",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 11.5.h, horizontal: 13.5.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/Group.png",
                        height: 17.24.h,
                        width: 17.24.w,
                      ),
                      SizedBox(
                        width: 9.24.w,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff4A43EC),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPurchase()));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                      color: const Color(0xff5B58FF),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Icon(
                    Icons.add,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PurchaseDetails()));
            },
            child: const PurchaseListCart(
              buletPoint: Color(
                0xffFC990F,
              ),
              title: "Johnson & Johnson",
              invoice: "Invoice#0234",
              amount: "\$999.00",
            ),
          ),
          const PurchaseListCart(
            buletPoint: Color(
              0xff08C008,
            ),
            title: "The Walt Disney",
            invoice: "Invoice#0234",
            amount: "\$999.00",
          ),
          const PurchaseListCart(
            buletPoint: Color(
              0xffFC990F,
            ),
            title: "Johnson & Johnson",
            invoice: "Invoice#0234",
            amount: "\$999.00",
          ),
        ]),
      ),
    );
  }
}
