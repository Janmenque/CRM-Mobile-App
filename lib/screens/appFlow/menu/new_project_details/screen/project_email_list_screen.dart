
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_email_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';


class ProjectEmailScreen extends StatelessWidget {
  int projectId;
  ProjectEmailScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectEmailProvider>(
        builder: (context, provider, _) {
          final emails = provider.projectEmailListResponse?.data?.data;
          return SingleChildScrollView(
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(" Emails", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          InkWell(
                            onTap: ()=> createProjectMail(context, provider, projectId ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                    emails?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: emails?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data  = emails?[index];
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
                                              Text("To ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("CC ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Subject ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Message ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                             ],
                                          ),
                                        ),

                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.to ?? "N/A"}", style: const TextStyle(fontSize: 12,  fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.cc ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.subject ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),),
                                              Text(": ${data?.message ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
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

  void createProjectMail(BuildContext parentContext, ProjectEmailProvider provider, int projectId) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<ProjectEmailProvider>(
                    builder: (_, provider, __) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5),
                            const Text(
                              "Add Email",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            NewTextField(
                              labelText: "Subject",
                              controller: provider.subjectController,
                            ),
                            NewTextField(
                              labelText: "To",
                              controller: provider.toMailController,
                            ),
                            NewTextField(
                              labelText: "CC",
                              controller: provider.ccMailController,
                            ),
                            NewTextField(
                              labelText: "Message",
                              controller: provider.messageController,
                              maxLine: 3,
                            ),
                            const SizedBox(height: 8),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  provider.createProjectMail(context, projectId);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff5B58FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text(
                                  "Create",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}