
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/time_sheet_report_list_model.dart';

class TimesheetReportTable extends StatelessWidget {
  const TimesheetReportTable({
    super.key, required this.data,
  });

  final List<TimeSheetReport> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('EMPLOYEE', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('DATE', style: TextStyle(fontSize: 12),) ),
            DataColumn(label: Text('START TIME', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('END TIME', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('ATTENDANCE TIME', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('WORKING HOUR', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('APPROVED HOUR', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('ATTENDANCE STATUS', style: TextStyle(fontSize: 12),)),
          ],
          rows: data.map((item) => DataRow(
            cells: [
              DataCell(Text(item.employeeName ?? "", style: const TextStyle(fontSize: 12),), ),
              DataCell(Text(item.date ?? "", style: const TextStyle(fontSize: 12), )),
              DataCell(Text(item.startTime ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.endTime ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.attendance ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.workingHours ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.approvedHours ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.status ?? "", style: const TextStyle(fontSize: 12),)),
            ],
          ),
          ).toList(),
        ),
      ),
    );
  }
}