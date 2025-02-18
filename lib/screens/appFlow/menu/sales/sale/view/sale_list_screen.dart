
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/view/create_pos_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sale/provider/sale_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sale/view/add_sale_screen.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class SaleListScreen extends StatelessWidget {
  const SaleListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SaleListProvider>(
        builder: (context, provider, _) {
          final products = provider.saleListResponse?.data?.products;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Sale List", style: TextStyle(fontWeight: FontWeight.bold),),
              actions: [
                InkWell(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AddSaleScreen())),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
                    margin: EdgeInsets.symmetric( horizontal: 15.w),
                    decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(Icons.add, size: 16.sp, color: Colors.white,),
                  ),
                )
              ],
              // actions: [
              //   InkWell(
              //       onTap: ()=> NavUtil.navigateScreen(context,const CreatePosScreen() ),
              //       child: Icon(Icons.add))
              // ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    provider.isLoading  ? const CustomListShimer() :
                    products?.isNotEmpty == true ?
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Sale", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text("Total : ${products?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = products?[index];
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
                                              Text("Date", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Reference", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Biller", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Customer", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Sale Status", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Payment Status ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Delivery Status", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Grand Total", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Returned Amount", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Paid", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Due", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex : 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.date ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.referenceNo ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.biller ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.customer ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.saleStatus ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.due ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),),
                                              Text(": ${data?.deliveryStatus ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.brown),),
                                              Text(": ${data?.grandTotal ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.returnedAmount ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.paid ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(":  ${data?.due ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
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
