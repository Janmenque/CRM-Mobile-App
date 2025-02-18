import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/deartment_list/department_provider.dart';
import 'package:provider/provider.dart';

class DepartmentList extends StatelessWidget {
  const DepartmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DepartmentProvider>();
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          tr("department"),
        ),
      ),
      body: ListView.builder(
        itemCount: provider.departmentList?.data?.departments?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pop(
                  context, provider.departmentList?.data?.departments?[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListTile(
                title: Text(
                    provider.departmentList?.data?.departments?[index].title ??
                        ""),
                subtitle:  Text(tr("department")),
                leading: ClipOval(
                  child: Image.network(
                    'https://www.w3schools.com/howto/img_avatar.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 12,
                  color: Colors.grey[300],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
