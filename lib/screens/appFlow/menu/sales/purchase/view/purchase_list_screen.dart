import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/purchase/provider/purchase_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/purchase/view/create_purchase_screen.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class PurchaseListScreen extends StatelessWidget {
  const PurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseListProvider>(
        builder: (context, provider, _) {
          final purchases = provider.purchaseListResponse?.data?.purchases;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Purchase List", style: TextStyle(fontWeight: FontWeight.bold),),
              actions: [
                InkWell(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CreatePurchaseScreen())),
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
                    purchases?.isNotEmpty == true ?
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
                              const Text("Purchase", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text("Total : ${purchases?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: purchases?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = purchases?[index];
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
                                              Text("Date", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Reference", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Supplier", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("purchase status", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Grand Total", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Returned Amount", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Paid", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Due", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Payment Status", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex : 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 8),
                                              Text(": ${data?.date ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.referenceNo ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  AppColors.colorPrimary),),
                                              Text(": ${data?.supplier ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  AppColors.colorPrimary),),
                                              Text(": ${data?.purchaseStatus ?? ""}" , style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.grandTotal ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  AppColors.colorPrimary),),
                                              Text(": ${data?.returnedAmount ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  AppColors.colorPrimary),),
                                              Text(": ${data?.paid ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  AppColors.colorPrimary),),
                                              Text(": ${data?.due ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  AppColors.colorPrimary),),
                                              Text(": ${data?.paymentStatus ?? ""}" , style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorRed),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                );
                              }),
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
