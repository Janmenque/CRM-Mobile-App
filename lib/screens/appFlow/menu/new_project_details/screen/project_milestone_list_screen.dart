
  import 'package:flutter/material.dart';
  import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_milestone_provider.dart';
  import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
  import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
  import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
  import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
  import 'package:provider/provider.dart';
  import '../../../../../utils/res.dart';


  class ProjectMilestoneScreen extends StatelessWidget {
    int projectId;
    ProjectMilestoneScreen({super.key, required this.projectId});

    @override
    Widget build(BuildContext context) {
      return Consumer<ProjectMilestoneProvider>(
          builder: (context, provider, _) {
            final milestones = provider.projectMilestoneListResponse?.data?.data;
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
                            const Text("Project MileStone", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            InkWell(
                             onTap: ()=> createProjectMilestone(context, provider, projectId ),

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
                      milestones?.isNotEmpty == true ?
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: milestones?.length ?? 0,
                          itemBuilder: (BuildContext context, int index){
                            final data  = milestones?[index];
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
                                                Text("Name ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                                Text("Start Date ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                                Text("End Date ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                                Text("Note ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                                Text("Status ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              ],
                                            ),
                                          ),

                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(": ${data?.name ?? "N/A"}", style: const TextStyle(fontSize: 12,  fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                Text(": ${provider.formatStartDate(provider.parseCustomStartDate(data?.startDate.toString() ?? ""))}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                Text(": ${provider.formatEndDate(provider.parseCustomEndDate(data?.endDate.toString() ?? ""))}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                Text(": ${data?.note ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),),
                                                Text(": ${data?.status?.name ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
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

    void createProjectMilestone(BuildContext parentContext, ProjectMilestoneProvider provider, int projectId) {
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
                    child: Consumer<ProjectMilestoneProvider>(
                      builder: (_, provider, __) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 5),
                              const Text(
                                "Add Milestone",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              NewTextField(
                                labelText: "Name",
                                controller: provider.milestoneNameController,
                              ),
                              NewTextField(
                                labelText: "Note",
                                controller: provider.milestoneNoteController,
                                maxLine: 3,
                              ),
                              CustomDropdown<String>(
                                value: provider.status,
                                labelText: 'Select Status',
                                items: provider.statusList?? [],
                                onChanged: (String? newValue) {
                                  provider.selectStatus(newValue!);
                                },
                                itemLabelBuilder: (String value) => value ?? '',
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => provider.selectStartDate(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.startDate ?? "Start Date",
                                        style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                                      ),
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              InkWell(
                                onTap: () => provider.selectEndDate(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.endDate ?? "End Date",
                                        style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                                      ),
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    provider.createProjectMilestone(context, projectId);
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
