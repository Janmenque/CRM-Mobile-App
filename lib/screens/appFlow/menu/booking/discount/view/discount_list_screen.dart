import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/discount/provider/discount_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/discount/view/create_discount_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class DiscountListScreen extends StatelessWidget {
  const DiscountListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscountListProvider>(
        builder: (context, provider, _) {
          final discounts = provider.discountListResponse?.data?.discounts;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Discount List", style: TextStyle(fontWeight: FontWeight.bold),),
              actions: [
                InkWell(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CreateDiscountScreen())),
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
                    discounts?.isNotEmpty == true ?
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
                              const Text("Discount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text("Total : ${discounts?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: discounts?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = discounts?[index];
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
                                              Text("Title", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Discount Type", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Zone", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Payment Status", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex : 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.title ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
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
