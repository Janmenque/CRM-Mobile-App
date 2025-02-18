
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/stock_management/provider/stock_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/stock_management/view/add_stcok.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/title_with_length.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StockManagementListScreen extends StatelessWidget {
  const StockManagementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StockListProvider>(
        builder: (context, provider, _) {
          final stocks = provider.stockManagementListResponse?.data?.stockList;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Stock Management List", style: TextStyle(fontWeight: FontWeight.bold),),
              actions: [
                InkWell(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AddStockScreen())),
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
                    TitleAndLength(title: "Stocks", length: stocks?.length ?? 0,),
                    const SizedBox(height: 14,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          provider.isLoading ? const CustomListShimer() :
                          stocks?.isNotEmpty == true ?
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: stocks?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = stocks?[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 14,),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex : 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Date", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Reference", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text("Warehouse", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black,),)
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex : 6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.date ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.referenceNo ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.warehouse ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14,),
                                    Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),

                                  ],
                                );
                              }) : const NoDataFoundWidget(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}