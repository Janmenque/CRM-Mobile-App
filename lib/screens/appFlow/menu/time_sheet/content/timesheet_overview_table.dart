import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_list_model.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';

class TimesheetOverViewTable extends StatelessWidget {
  const TimesheetOverViewTable({super.key, this.data});
  final TimesheetListModel? data;

  @override
  Widget build(BuildContext context) {
    final timesheetList = data?.data?.timeSheets ?? [];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('DATE', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('EMPLOYEE', style: TextStyle(fontSize: 12),) ),
            DataColumn(label: Text('PROJECT', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('TASK', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('HOURS', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('STATUS', style: TextStyle(fontSize: 12),)),
          ],

          rows: timesheetList.map((item) => DataRow(
            cells: [
              DataCell(Text(item.date.toString(), style: const TextStyle(fontSize: 12),), ),
              DataCell(Text(item.employee ?? "", style: const TextStyle(fontSize: 12), )),
              DataCell(Text(item.project ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.task ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.hours ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.comment ?? "", style: const TextStyle(fontSize: 12),)),
            ],
          ),
          ).toList(),
        )
      ),
    );
  }
}