import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/hourly_statistics_list_model.dart';

class HourlyStaticsTable extends StatelessWidget {
  const HourlyStaticsTable({
    super.key, this.hourlyStaticsListResponse,
  });

  final HourlyStaticsListModel? hourlyStaticsListResponse;

  @override
  Widget build(BuildContext context) {
    final data = hourlyStaticsListResponse?.data;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          columns: const [
            DataColumn(label: Text('NAME', style: TextStyle(fontSize: 12))),
            DataColumn(label: Text('NORMAL TIME', style: TextStyle(fontSize: 12))),
            DataColumn(label: Text('SUM W/SALARY', style: TextStyle(fontSize: 12))),
            DataColumn(label: Text('ABSENCE W/PAY', style: TextStyle(fontSize: 12))),
            DataColumn(label: Text('NET TIME', style: TextStyle(fontSize: 12))),
            DataColumn(label: Text('PLUS TIME', style: TextStyle(fontSize: 12))),
            DataColumn(label: Text('FACT HOURS', style: TextStyle(fontSize: 12))),
            DataColumn(label: Text('ACTUAL DEGREE (%)', style: TextStyle(fontSize: 12))),
          ],
          rows: [
            ...data?.users?.map((user) => DataRow(
              cells: [
                DataCell(Text(user.name ?? "", style: const TextStyle(fontSize: 12))),
                DataCell(Text(user.dailyWorkingHours ?? "", style: const TextStyle(fontSize: 12))),
                DataCell(Text(user.sumWsalary ?? "", style: const TextStyle(fontSize: 12))),
                DataCell(Text(user.abscWorkPay ?? "", style: const TextStyle(fontSize: 12))),
                DataCell(Text(user.netTime ?? "", style: const TextStyle(fontSize: 12))),
                DataCell(Text(user.plusTime ?? "", style: const TextStyle(fontSize: 12))),
                const DataCell(Text("0.00", style: TextStyle(fontSize: 12))), // Fact Hours
                DataCell(Text(user.percentage ?? "", style: const TextStyle(fontSize: 12))),
              ],
            )) ?? [],

            if (data?.summary != null)
              DataRow(
                cells: [
                  const DataCell(Text('Sum', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataCell(Text(data?.summary?.dailyWorkingHours ?? "0.00", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataCell(Text(data?.summary?.sumWsalaryTotal ?? "0.00", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataCell(Text(data?.summary?.absWPayTotal ?? "0.00", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataCell(Text(data?.summary?.netTimeTotal ?? "0.00", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataCell(Text(data?.summary?.plusTimeTotal ?? "0.00", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  const DataCell(Text("0.00", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))), // Fact Hours
                  const DataCell(Text("0.00", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))), // Actual Degree
                ],
              ),
          ],
        ),
      ),
    );
  }
}