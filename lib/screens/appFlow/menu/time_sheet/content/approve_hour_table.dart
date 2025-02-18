import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/approve_hours_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/approve_hours_provider.dart';


class ApproveHourTable extends StatelessWidget {
  ApproveHoursProvider? provider;
  ApproveHourTable({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return IntrinsicWidth(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildTableContent(provider?.approveHourListResponse?.data ?? []),
                ),
              ),
            ),
          );
        },
      ),
    ) ;
  }
  List<Widget> buildTableContent(List<ApproveHour> approveHourList) {
    List<Widget> tableContent = [];
    tableContent.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
        child: const Row(
          children: [
            Expanded(child: Text("APPROVED", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(child: Text("GIVEN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(child: Text("TASK", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(child: Text("WORKING HOURS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(child: Text("ACTUAL HOURS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(child: Text("HOURLY RATE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(child: Text("ACTUAL AMOUNT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(child: Text("INVOICE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(child: Text("COMMENT/STATUS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          ],
        ),
      ),
    );

    // Add rows for each task
    for (var approveHour in approveHourList) {
      if (approveHour.timesheets != null && approveHour.timesheets!.isNotEmpty) {
        for (var timesheet in approveHour.timesheets!) {
          if (timesheet.tasks != null && timesheet.tasks!.isNotEmpty) {
            for (var task in timesheet.tasks!) {
              tableContent.add(
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Row(
                    children: [
                      Expanded(child: Text(task.isApproveHours == '1' ? "Yes" : "No")),
                      Expanded(child: Text(task.date?.toIso8601String().split('T').first ?? '-')),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(approveHour.projectName ?? '-', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                            Text(task.taskName ?? '-', style: const TextStyle(fontSize: 12),),
                          ],
                        ),
                      ),
                      Expanded(child: Text(task.workingHours ?? '-')),
                      Expanded(child: Text(task.actualHours ?? '-')),
                      Expanded(child: Text(task.hourlyRate ?? '-')),
                      Expanded(child: Text(task.approvedAmount ?? '-')),
                      const Expanded(child: Text("-")),
                      Expanded(child: Text(task.note ?? '-')),
                    ],
                  ),
                ),
              );
            }
          }
        }
      }
    }
    return tableContent;
  }
}