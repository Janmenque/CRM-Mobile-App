import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/provider/coupon_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/view/create_coupon_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class CouponListScreen extends StatelessWidget {
  const CouponListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponListProvider>(
        builder: (context, provider, _) {
          final coupons = provider.couponListResponse?.data?.coupons;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Coupon List", style: TextStyle(fontWeight: FontWeight.bold),),
              actions: [
                InkWell(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CreateCouponScreen())),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
                    margin: EdgeInsets.symmetric( horizontal: 15.w),
                    decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(Icons.add, size: 16.sp, color: Colors.white,),
                  ),
                )

              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    provider.isLoading  ? const CustomListShimer() :
                    coupons?.isNotEmpty == true ?
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Coupons", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text("Total : ${coupons?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: coupons?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = coupons?[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 14,),
                                    Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                                    const SizedBox(height: 14,),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex : 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Coupon Code", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Coupon Type", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Discount Title", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Discount Type", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Zones", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Status", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex : 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.code ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.couponType ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.discountTitle ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.discountType ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.zone ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.status ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                            ],
                                          ),
                                        ),
                                      ],),],);}),
                        ],
                      ),
                    ) : const NoDataFoundWidget()
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
