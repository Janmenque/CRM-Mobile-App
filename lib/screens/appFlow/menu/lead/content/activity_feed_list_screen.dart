import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_activity_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';


class LeadActivityListScreen extends StatelessWidget {
  const LeadActivityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadActivityProvider>(
      builder: (context, provider, _) {
      final leadActivityList = provider.leadActivityListResponse?.data;
        return SingleChildScrollView(
            child:  Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Activity Feed", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 14,),
                  Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                  const SizedBox(height: 14,),
                  leadActivityList != null ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: leadActivityList.length ?? 0,
                      itemBuilder: (BuildContext context, int index){
                        final data = leadActivityList[index];
                        return InkWell(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width : double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                    color: const Color(0xffF5F5F5),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.message_outlined, size: 14, color: Colors.grey),
                                        Text(data.date ?? "N/A", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Text(data.status ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor),),
                                    ),
                                    const Text("Lead Create Successfully", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),),
                                    Text("Lead created by ${data.author ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );}) : const SizedBox(),
                ],
              ),
            )
        );
      }
    );
  }
}
