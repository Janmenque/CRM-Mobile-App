
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/resource_plan_list_model.dart';

class ResourcePlanTable extends StatelessWidget {
  const ResourcePlanTable({
    super.key, required this.data,
  });

  final List<ResourcePlan> data;

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
            DataColumn(label: Text('PROJECT', style: TextStyle(fontSize: 12),) ),
            DataColumn(label: Text('TASK', style: TextStyle(fontSize: 12),) ),
            DataColumn(label: Text('START TIME', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('END TIME', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('DATE', style: TextStyle(fontSize: 12),)),
            DataColumn(label: Text('Comment', style: TextStyle(fontSize: 12),)),
          ],
          rows: data.map((item) => DataRow(
            cells: [
              DataCell(Text(item.employee ?? "", style: const TextStyle(fontSize: 12),), ),
              DataCell(Text(item.project ?? "", style: const TextStyle(fontSize: 12),), ),
              DataCell(Text(item.task ?? "", style: const TextStyle(fontSize: 12),), ),
              DataCell(Text(item.startDate ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.endDate ?? "", style: const TextStyle(fontSize: 12),)),
              DataCell(Text(item.date ?? "", style: const TextStyle(fontSize: 12), )),
              DataCell(Text(item.comments ?? "", style: const TextStyle(fontSize: 12, color: Colors.red),)),
            ],
          ),
          ).toList(),
        ),
      ),
    );
  }
}