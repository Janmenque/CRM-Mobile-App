import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/resource_plan_multiselect_employee_list.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/allocate_resource_provider.dart';
import 'package:provider/provider.dart';

class CreateResourcePlanScreen extends StatelessWidget {
  const CreateResourcePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Allocate Resource"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AllocateResourceProvider(),
        child: Consumer<AllocateResourceProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child:  Column(
                        children: [
                          const SizedBox(height: 4,),
                          ResourcePlanMultiselectEmployeeList(provider: provider),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child:  CustomDropdown<TimesheetProject>(
                                  value: provider.project,
                                  labelText: 'Select Project',
                                  items: provider.timesheetRelatedResponse?.data?.projects ?? [],
                                  onChanged: (TimesheetProject? newValue) {
                                    provider.selectedProject(newValue!);
                                  },
                                  itemLabelBuilder: (TimesheetProject value) => value.name ?? '',
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child:  CustomDropdown<TimesheetTask>(
                                  value: provider.task,
                                  labelText: 'Select Task',
                                  items: provider.timesheetTaskListResponse?.data ?? [],
                                  onChanged: (TimesheetTask? newValue) {
                                    provider.selectedTask(newValue!);
                                  },
                                  itemLabelBuilder: (TimesheetTask value) => value.name ?? '',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height:14),
                          Row(
                            children: [
                              Expanded(
                                child:InkWell(
                                  onTap: () => provider.selectStartDate(context),
                                  child:  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey, width: 1),),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          provider.startDate ?? "Start Date",
                                          style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                                        const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child:InkWell(
                                  onTap: () => provider.selectEndDate(context),
                                  child:  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey, width: 1),),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          provider.endDate ?? "End Date",
                                          style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => provider.selectStartTime(context),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                      // margin: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            provider.startTime != null
                                                ? provider.startTime!.format(context)
                                                : "Start Time",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Icon(Icons.access_time, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => provider.selectEndTime(context),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                      // margin: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            provider.endTime != null
                                                ? provider.endTime!.format(context)
                                                : "End Time",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Icon(Icons.access_time, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Text(
                              provider.formattedDuration,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          NewTextField(labelText: "Comments", controller: provider.commentController, maxLine: 3,),
                          Padding(
                            padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                provider.createAllocateResource(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff5B58FF),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                "Save",
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
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  /// Helper Widget for Time Selection
  Widget buildTimeContainer(String text, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 6),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Row(

        children: [
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold))),
          const Icon(Icons.access_time, color: Colors.grey, size: 14,),
        ],
      ),
    );
  }
}