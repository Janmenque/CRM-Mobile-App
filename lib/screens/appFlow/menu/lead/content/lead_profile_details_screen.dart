import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/leads_profile_view_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class LeadProfileDetailsScreen extends StatelessWidget {
  int leadId;
  LeadProfileDetailsScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadsProfileViewProvider>(
      builder: (context, provider, _) {
        final data = provider.leadsProfileViewResponse?.data;
        return
          provider.isLoading ? const CustomListShimer() :
          data != null ?
          SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex : 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text("Name", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Company", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Phone", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Email", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Source", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Type", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Lead Status", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Created At", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Author", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(" : ${data.name ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.company ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.phone ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.email ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.leadSource ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.leadType ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.leadStatus ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.createdDate ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.author ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14,),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex : 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Title", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                             Text("Details", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                          ],
                        ),
                      ),
                      Expanded(
                        flex : 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(" : ${data.title ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            const Text(" : N/A", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14,),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex : 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Company Site", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Next Follow Up", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Address", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Address ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                          ],
                        ),
                      ),
                      Expanded(
                        flex : 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(" : ${data.website ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.nextFollowUp ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.address ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(" : ${data.address ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ) : const NoDataFoundWidget();
      }
    );
  }
}
