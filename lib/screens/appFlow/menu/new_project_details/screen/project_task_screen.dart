
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/client_project_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_task_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_task_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';


class ProjectTaskScreen extends StatelessWidget {
  int projectId;
  ProjectTaskScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectTaskProvider>(
        builder: (context, provider, _) {
          final tasks = provider.projectTaskListResponse?.items;
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
                          const Text("Task", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          InkWell(
                            onTap: ()=> createProjectTask(context, provider, projectId ),

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
                    tasks?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tasks?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data  = tasks?[index];
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
                                              Text("Task Name ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Priority ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Status ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Start Date ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("End Date ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.name ?? "N/A"}", style: const TextStyle(fontSize: 12,  fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.priority ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.status ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),),
                                              Text(": ${provider.formatStartDate(provider.parseCustomStartDate(data?.startDate.toString() ?? ""))}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${provider.formatEndDate(provider.parseCustomEndDate(data?.endDate.toString() ?? ""))}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
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

  void createProjectTask(BuildContext parentContext, ProjectTaskProvider provider, int projectId) {
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
                  child: Consumer<ProjectTaskProvider>(
                    builder: (_, provider, __) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5),
                            const Text(
                              "Add Task",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            NewTextField(
                              labelText: "Task Name",
                              controller: provider.taskNameController,
                            ),
                            NewTextField(
                              labelText: "Task description",
                              controller: provider.taskDescriptionController,
                              maxLine: 3,
                            ),
                            CustomDropdown<Client>(
                              value: provider.client,
                              labelText: 'Select Client',
                              items: provider.crmClientListResponse?.data?.clients ?? [],
                              onChanged: (Client? newValue) {
                                provider.selectClient(newValue!);
                              },
                              itemLabelBuilder: (Client value) => value.name ?? '',
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                const Text(
                                  "Assign",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Card(
                                  elevation: 0,
                                  child: ListTile(
                                    onTap: () => provider.getAllUserData(context),
                                    title: Text(
                                      provider.allUserData?.name! ?? "Assign Members",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    subtitle: Text(
                                      provider.allUserData?.designation! ?? "",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(provider.allUserData?.avatar! ??
                                          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                                    ),
                                    trailing: const Icon(Icons.edit),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                    children: List.generate(
                                      provider.userNames.length,
                                          (index) => Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          gradient: const LinearGradient(
                                            colors: [AppColors.primaryColor, AppColors.primaryColor],
                                            begin: FractionalOffset(2.0, 0.0),
                                            end: FractionalOffset(0.0, 1.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp,
                                          ),
                                        ),
                                        child: Text(
                                          provider.userNames[index],
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  provider.createProjectTask(context, projectId);
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
