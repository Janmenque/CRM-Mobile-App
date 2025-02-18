import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/schedule_overview_model.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/schedule_overview_provider.dart';


class ScheduleOverviewTable extends StatelessWidget {
  ScheduleOverProvider? provider;
  ScheduleOverviewTable({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return IntrinsicWidth(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildTableContent(provider?.scheduleOverviewResponse?.data?.timesheets ?? []),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  List<Widget> buildTableContent(List<Timesheet> timesheets) {
    List<Widget> tableContent = [];
    double totalWorkingHours = 0.0;
    double totalApprovedHours = 0.0;
    double totalAmount = 0.0;
    tableContent.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 800),
          child: const Row(
            children: [
              Expanded(child: Text("DATE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
              Expanded(child: Text("TASK", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 12))),
              Expanded(child: Text("HOURS", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 12))),
              Expanded(child: Text("CHARGEABLE HOURS", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 12))),
              Expanded(child: Text("HOURLY RATE", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 12))),
              Expanded(child: Text("INVOICE AMOUNT", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 12))),
              Expanded(child: Text("INVOICE", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 12))),
              Expanded(child: Text("COMMENT/STATUS", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 12))),
            ],
          ),
        ),
      ),
    );

    for (var timesheet in timesheets) {
      totalWorkingHours += double.tryParse(timesheet.projectTotalWorkingHours ?? '0') ?? 0.0;
      totalApprovedHours += double.tryParse(timesheet.projectTotalApprovedHours ?? '0') ?? 0.0;
      totalAmount += double.tryParse(timesheet.projectTotalAmount ?? '0') ?? 0.0;
      tableContent.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 800),
            child: Row(
              children: [
                const Expanded(child: Text("-")),
                Expanded(
                  child: Text(
                    timesheet.projectName ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const Expanded(child: Text("-")),
                const Expanded(child: Text("-")),
                const Expanded(child: Text("-")),
                const Expanded(child: Text("-")),
                const Expanded(child: Text("-")),
                const Expanded(child: Text("-")),
              ],
            ),
          ),
        ),
      );

      // Add tasks
      if (timesheet.tasks != null && timesheet.tasks!.isNotEmpty) {
        tableContent.add(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 800),
              child: const Row(
                children: [
                  Expanded(child: Text("-")),
                  Expanded(
                    child: Text("Activity Summary", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: Text("-")),
                  Expanded(child: Text("-")),
                  Expanded(child: Text("-")),
                  Expanded(child: Text("-")),
                  Expanded(child: Text("-")),
                  Expanded(child: Text("-")),
                ],
              ),
            ),
          ),
        );

        for (var task in timesheet.tasks!) {
          tableContent.add(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 800),
                child: Row(
                  children: [
                    Expanded(child: Text(task.date?.toIso8601String().split('T').first ?? '-')),
                    Expanded(child: Text(task.taskName ?? '-')),
                    Expanded(child: Text(task.workingHours ?? '-')),
                    Expanded(child: Text(task.approvedHours ?? '-')),
                    Expanded(child: Text(task.hourlyRate ?? '-')),
                    Expanded(child: Text(task.amount ?? '-')),
                    const Expanded(child: Text('-')),
                    Expanded(child: Text(task.note?.toString() ?? '-')),
                  ],
                ),
              ),
            ),
          );
        }

        tableContent.add(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 800),
              child: Row(
                children: [
                  const Expanded(child: Text("-")),
                  const Expanded(child: Text("Sum", style: TextStyle(fontWeight: FontWeight.bold)),),
                  Expanded(child: Text(timesheet.projectTotalWorkingHours ?? '-')),
                  Expanded(child: Text(timesheet.projectTotalApprovedHours ?? '-')),
                  const Expanded(child: Text("-")),
                  Expanded(child: Text(timesheet.projectTotalAmount ?? '-')),
                  const Expanded(child: Text("-")),
                  const Expanded(child: Text("-")),
                ],
              ),
            ),
          ),
        );
      }
    }

    // Add total row across all projects
    tableContent.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black))),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 800),
          child: Row(
            children: [
              const Expanded(child: Text("-")),
              const Expanded(child: Text("Total all project NOK", style: TextStyle(fontWeight: FontWeight.bold)),),
              Expanded(child: Text(totalWorkingHours.toStringAsFixed(2))),
              Expanded(child: Text(totalApprovedHours.toStringAsFixed(2))),
              const Expanded(child: Text("-")),
              Expanded(child: Text(totalAmount.toStringAsFixed(2))),
              const Expanded(child: Text("-")),
              const Expanded(child: Text("-", style: TextStyle(fontSize: 12),)),
            ],
          ),
        ),
      ),
    );
    return tableContent;
  }
}