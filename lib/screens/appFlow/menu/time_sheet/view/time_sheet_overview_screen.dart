import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/timesheet_overview_search_container.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/timesheet_overview_table.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/table_shimmer_list.dart';
import 'package:provider/provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/timesheet_overview_provider.dart';
import 'package:hrm_app/utils/res.dart';

class TimeSheetOverviewScreen extends StatelessWidget {
  const TimeSheetOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Time Sheets",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        
      ),
      body: Consumer<TimeSheetOverviewProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: SingleChildScrollView(
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // Search container
                  TimesheetOverviewSearchContainer(provider: provider,),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Schedule Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        InkWell(
                          onTap: ()=> createTimeSheet(context, provider, ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: AppColors.colorPrimary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ///table
                  provider.isLoading ? const TableShimmerList() :
                  provider.timesheetListResponse?.data?.timeSheets?.isNotEmpty == true ?
                  TimesheetOverViewTable(data: provider.timesheetListResponse) : const NoDataFoundWidget(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void createTimeSheet(BuildContext parentContext, TimeSheetOverviewProvider provider) {
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
                  child: Consumer<TimeSheetOverviewProvider>(
                    builder: (_, provider, __) {
                      return SingleChildScrollView(
                        child:  Column(
                          children: [
                            const Text("Add Timesheet", style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: () => provider.selectDateForCreate(context),
                              child: Container(
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
                                      provider.dateForCreateTimeSheet ?? "Select Date",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            CustomDropdown<TimesheetEmployee>(
                              value: provider.employee,
                              labelText: 'Select employee',
                              items: provider.timesheetRelatedResponse?.data?.employees ?? [],
                              onChanged: (TimesheetEmployee? newValue) {
                                provider.selectedEmployee(newValue!);
                              },
                              itemLabelBuilder: (TimesheetEmployee value) => value.name ?? '',
                            ),
                            const SizedBox(height: 12,),
                            CustomDropdown<TimesheetProject>(
                              value: provider.project,
                              labelText: 'Select project',
                              items: provider.timesheetRelatedResponse?.data?.projects ?? [],
                              onChanged: (TimesheetProject? newValue) {
                                provider.selectedProject(newValue!);
                              },
                              itemLabelBuilder: (TimesheetProject value) => value.name ?? '',
                            ),
                            const SizedBox(height: 12,),
                            CustomDropdown<TimesheetTask>(
                              value: provider.task,
                              labelText: 'Select task',
                              items: provider.timesheetTaskListResponse?.data ?? [],
                              onChanged: (TimesheetTask? newValue) {
                                provider.selectedTask(newValue!);
                              },
                              itemLabelBuilder: (TimesheetTask value) => value.name ?? '',
                            ),
                            const SizedBox(height: 12,),
                            // Start and End Time Selectors
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => provider.selectStartTime(context),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
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
                                Expanded(
                                  child: InkWell(
                                    onTap: () => provider.selectEndTime(context),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
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
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
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
                            NewTextField(controller: provider.noteController, labelText: "Note", maxLine: 3,),
                            Padding(
                              padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () => provider.createTimeSheet(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff5B58FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
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