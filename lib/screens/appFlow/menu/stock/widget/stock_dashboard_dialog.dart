import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/add_product/add_product.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/brand_list/add_brand_form/add_brand_form.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/category_list/add_category_form/add_category_form.dart';
import 'package:hrm_app/screens/custom_widgets/horizontal_divider.dart';

class StockDashboardDialog extends StatelessWidget {
  const StockDashboardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddCategoryForm()));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 15.h,
                        width: 15.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFFAF00)),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Text(
                        "Add Category",
                        style: TextStyle(
                            color: const Color(0xff6B6B6B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
              const  HorizontalDivider(dividerColor:  Color(0xffECECEC)),
                SizedBox(
                  height: 12.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddProductScreen()));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 15.h,
                        width: 15.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff00606F)),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Text(
                        "Add Product",
                        style: TextStyle(
                            color: const Color(0xff6B6B6B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
              const  HorizontalDivider(dividerColor:  Color(0xffECECEC)),
                SizedBox(
                  height: 12.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddBrandForm()));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 15.h,
                        width: 15.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff38CE3C)),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Text(
                        "Add Brand",
                        style: TextStyle(
                            color: const Color(0xff6B6B6B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
