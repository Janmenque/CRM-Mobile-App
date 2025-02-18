import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/edit_official_info_provider.dart';
import 'package:provider/provider.dart';

class EditOfficialInfo extends StatelessWidget {
  final ResponseOfficialInfo? officialInfo;
  final String? projectManagerName;

  const EditOfficialInfo({Key? key, this.officialInfo, this.projectManagerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditOfficialInfoProvider(officialInfo),
      child: Consumer<EditOfficialInfoProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title:  Text(tr("update_profile")),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      tr("name"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.nameTextController,
                      keyboardType: TextInputType.name,
                      decoration:  InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_name"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: provider.nameError != null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            provider.nameError ?? "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                    Visibility(
                        visible: provider.errorMessage != null &&
                            provider.nameError == null &&
                            provider.emailError == null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            provider.errorMessage ?? "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("email*"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:  InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_email"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: provider.emailError != null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            provider.emailError ?? "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("department"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        provider.getDepartmentData(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              provider.departmentObj?.title ??
                                  officialInfo?.data?.department ??
                                  tr("select_department"),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("designation"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        provider.getDesignationData(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              provider.designationObj?.title ??
                                  officialInfo?.data?.designation ??
                                  tr("select_department"),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("manager*"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        provider.getManagerData(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              provider.managerObj?.name ??
                                  officialInfo?.data?.manager ??
                                  tr("select_manager"),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: provider.managerIdError != null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            provider.managerIdError ?? "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("date_of_joining"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => provider.selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.joiningDateDb != null
                                  ? "${provider.joiningDateDb!.toLocal()}"
                                      .split(" ")[0]
                                  : tr("select_joining_date"),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Icon(Icons.date_range_outlined)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("employee_type"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, spreadRadius: 1),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint:  Text(
                            tr("enter_employee_type"),
                            style: const TextStyle(fontSize: 14),
                          ),
                          value: provider.employeeTypeValue,
                          icon: const Icon(
                            Icons.arrow_downward,
                            size: 20,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            provider.dropdownMenu(newValue);
                          },
                          items: provider.employmentTypeObj?.data?.types
                              ?.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("employee_id"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.employeeIdTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:  InputDecoration(
                        fillColor: Colors.red,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_employee_id"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("grade"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.gradeTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:  InputDecoration(
                        fillColor: Colors.red,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: tr("Enter Grade"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.updateOfficialInfo(context);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child:  Text(tr("save"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
