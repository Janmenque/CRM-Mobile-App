
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_list_provider.dart';
  import 'package:hrm_app/screens/appFlow/menu/lead/view/add_lead_screen.dart';
  import 'package:hrm_app/screens/appFlow/menu/lead/view/lead_view_screen.dart';
  import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
  import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
  import 'package:hrm_app/utils/res.dart';
  import 'package:provider/provider.dart';

  class LeadListScreen extends StatelessWidget {
    const LeadListScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Consumer<LeadListProvider>(
          builder: (context, provider, _) {
            final leads = provider.leadListResponse?.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Lead List", style: TextStyle(fontWeight: FontWeight.bold),),
                actions: [
                  InkWell(
                    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AddLeadScreen())),
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
                      leads?.isNotEmpty == true ?
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
                                const Text("Leads", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Text("Total : ${leads?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                              ],
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: leads?.length ?? 0,
                                itemBuilder: (BuildContext context, int index){
                                  final data = leads?[index];
                                  return InkWell(
                                    onTap: ()=>   Navigator.push(context, MaterialPageRoute(builder: (context) =>  LeadViewScreen(leadId: data?.id ?? 0,))),
                                    child: Column(
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
                                                  Text("Type", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                  Text("Source", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                  Text("Date", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                  Text("Name", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                  Text("Title", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                  Text("Company", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                  Text("Address", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                  Text("Next Followup", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                  Text("Status", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex : 5,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(": ${data?.leadType ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  Text(": ${data?.leadSource ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  Text(": ${data?.createdDate ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  Text(": ${data?.name ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  Text(": ${data?.title ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  Text(": ${data?.company ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  Text(": ${data?.address ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  Text(": ${data?.nextFollowUp ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  Text(": ${data?.leadStatus ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                ],
                                              ),
                                            ),
                                          ],),],),
                                  );}),
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
