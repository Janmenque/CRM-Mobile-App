import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/designation_list/designation_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:provider/provider.dart';

class DesignationList extends StatelessWidget {
  const DesignationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DesignationProvider>();
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          tr("designation")
        ),
      ),
      body:
      provider.designationList?.data?.designations != null ?
      ListView.builder(
        itemCount: provider.designationList?.data?.designations?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              var departmentObj =
                  provider.designationList?.data?.designations?[index];
              Navigator.pop(context, departmentObj);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListTile(
                title: Text(provider
                        .designationList?.data?.designations?[index].title ??
                    ""),
                subtitle:  Text(tr("project_manager")),
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
      ) : const CustomListShimer()
    );
  }
}
