import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/employee_model/employee_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_timer_provider.dart';

class MultiselectEmployees extends StatelessWidget {
  TaskTimerProvider provider;
  MultiselectEmployees({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              showCategoryMultiSelectDialog(context, provider.crmEmployeeListResponse?.data?.employees ?? [], provider);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Employee',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        const SizedBox( height: 6,),
        provider.selectedEmployeeList.isNotEmpty ?
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            "Selected Employees:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ) : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            provider.selectedEmployeeList.map((e) => e.name).join(", "),
          ),
        ),
      ],
    );
  }

  void showCategoryMultiSelectDialog(BuildContext context, List<Employee> items, TaskTimerProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Select Employee") ,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items.map((employee) {
                    return CheckboxListTile(
                      title: Text(employee.name!),
                      value: provider.selectedEmployeeList.any((selected) => selected.id == employee.id),
                      onChanged: (bool? value) {
                        provider.toggleEmployee(employee);
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

}
