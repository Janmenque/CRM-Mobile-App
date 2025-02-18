import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/monthly_overview_model.dart';

class MonthlyOverviewTable extends StatelessWidget {
  const MonthlyOverviewTable({
    super.key,
    required this.days,
    required this.timesheetData,
    required this.data,
  });

  final List<String> days;
  final List<TimesheetDatum> timesheetData;
  final Data? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          headingRowHeight: 40,
          columns: [
            const DataColumn(
              label: Text(
                'PROJECT / ACTIVITY',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ...days.map((day) => DataColumn(
              label: Text(
                day,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
          ],
          rows: timesheetData.map((item) {
            final dailyHours = item.dailyHours;
            final dailyHoursMap = dailyHours?.toJson() ?? {};
            return DataRow(
              cells: [
                DataCell(Text('${item.projectName ?? ""}\n${item.taskName ?? ""}')),
                ...days.map((day) {
                  final value = dailyHoursMap[day] ?? "0.00";
                  return DataCell(Text(value));
                }),
              ],
            );
          }).toList()
            ..add(
              DataRow(
                cells: [
                  const DataCell(Text('Sum', style: TextStyle(fontWeight: FontWeight.bold))),
                  ...data?.sum?.map((sum) => DataCell(Text(sum))) ?? [],
                ],
              ),
            )
            ..add(
              DataRow(
                cells: [
                  const DataCell(Text('Billable hours')),
                  ...data?.billable?.map((bill) => DataCell(Text(bill))) ?? [],
                ],
              ),
            )
            ..add(
              DataRow(
                cells: [
                  const DataCell(Text('Non-billable hours')),
                  ...data?.nonBillable?.map((nonBill) => DataCell(Text(nonBill))) ?? [],
                ],
              ),
            ),
        ),
      ),
    );
  }
}