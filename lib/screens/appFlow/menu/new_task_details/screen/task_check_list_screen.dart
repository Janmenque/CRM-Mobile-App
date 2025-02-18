import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_task_model/task_check_staff_list_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_template_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_checklist_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';


class TaskCheckListScreen extends StatelessWidget {
  int taskId;
  TaskCheckListScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCheckListProvider>(
        builder: (context, provider, _) {
          final checkList = provider.taskCheckListResponse?.data?.data;
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
                          const Text("Check List", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

                          InkWell(
                            onTap: ()=> createTaskCheckList(context, provider, taskId ),
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
                    checkList?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: checkList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data  = checkList?[index];
                          return Card(
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
                                            Text("Created By", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Text("Assign Staff", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Text("Date Created ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Text("Description ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(": ${data?.createdBy?.name?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                            const SizedBox(height: 8,),
                                            Text(": ${data?.assignStaff?.name ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                            const SizedBox(height: 8,),
                                            Text(": ${data?.createdAt ?? "N/A"}", style: const TextStyle(fontSize: 12,  fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                            const SizedBox(height: 8,),
                                            Text(": ${data?.description ?? "N/A"}", style: const TextStyle(fontSize: 12,  fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                            const SizedBox(height: 8,),
                                          ],
                                        ),
                                      ),
                                    ],),
                                ],),
                            ),
                          );}) : const NoDataFoundWidget(),
                  ],
                ),
              )
          );
        }
    );
  }

  void createTaskCheckList(BuildContext parentContext, TaskCheckListProvider provider, int taskId) {
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
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<TaskCheckListProvider>(
                    builder: (_, provider, __) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 5),
                            const Text(
                              "Add CheckList",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            CustomDropdown<String>(
                              value: provider.checkListOption,
                              labelText: 'Select Checklist Option',
                              items: provider.checklistOptionList ?? [],
                              onChanged: (String? newValue) {
                                provider.selectCheckListOption(newValue!);
                              },
                              itemLabelBuilder: (String value) => value ?? '',
                            ),
                            const SizedBox(height: 14),
                            CustomDropdown<TaskCheckStaff>(
                              value: provider.taskCheckStaff,
                              labelText: 'Select Staff',
                              items: provider.taskCheckStaffListResponse?.data ?? [],
                              onChanged: (TaskCheckStaff? newValue) {
                                provider.selectStaff(newValue!);
                              },
                              itemLabelBuilder: (TaskCheckStaff value) => value.name ?? '',
                            ),
                            const SizedBox(height: 14),
                            provider.checkListOption == "Template" ?
                            CustomDropdown<TaskTemplate>(
                              value: provider.taskTemplate,
                              labelText: 'Select template',
                              items: provider.taskTemplateListResponse?.data ?? [],
                              onChanged: (TaskTemplate? newValue) {
                                provider.selectTaskTemplate(newValue!);
                              },
                              itemLabelBuilder: (TaskTemplate value) => value.description ?? '',
                            ) : const SizedBox(),
                            NewTextField(
                              labelText: "Description",
                              controller: provider.descriptionController,
                              maxLine: 3,
                            ) ,
                             Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                if (provider.taskCheckStaff == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Staff is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  else {
                                    provider.createTaskCheckList(context, taskId);
                                  }
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