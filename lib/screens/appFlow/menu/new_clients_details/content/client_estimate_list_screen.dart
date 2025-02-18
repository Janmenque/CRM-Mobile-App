
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_estimate_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/screen/client_create_estimate_screen.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';


class ClientEstimateListScreen extends StatelessWidget {
  int clientId;
  ClientEstimateListScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientEstimateListProvider>(
        builder: (context, provider, _) {
          final estimateList = provider.clientEstimateListResponse?.data?.data;
          return SingleChildScrollView(
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      margin: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Estimate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          InkWell(
                            onTap: ()=> NavUtil.navigateScreen(context,  ClientCreateEstimateScreen(clientId: clientId,)),
                            child: Container(
                              padding: const EdgeInsets.symmetric( horizontal: 10),
                              decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8)),
                              child: const Row(
                                children: [
                                  Icon(Icons.add, size: 14, color: Colors.white,),
                                  Text("Create", style: TextStyle(color: Colors.white, fontSize: 12),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    provider.isLoading ? const CustomListShimer() :
                    estimateList?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: estimateList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data = estimateList?[index];
                          return InkWell(
                            onTap: (){},
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Estimate Id", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Total Cost", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Discount", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Grand Total", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Date", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Approval Status", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.invoiceNo ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.totalCost ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.orderDiscount ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.grandTotal ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${provider.formatDate(provider.parseCustomDate(data?.createdAt.toString() ?? ""))}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.status?.name ?? ""}", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  provider.hexToColor(data?.status?.colorCode ?? "#000000"),),),

                                            ],
                                          ),
                                        ),
                                      ],),
                                  ],),
                              ),
                            ),
                          );}) : const NoDataFoundWidget(),
                  ],
                ),
              )
          );
        }
    );
  }
}
