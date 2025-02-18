import 'dart:collection';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/custom_widgets/custom_buttom.dart';
import 'package:hrm_app/data/model/response_department_list.dart';
import 'package:provider/provider.dart';
import '../my_account/tab/office_tab/edit_official_info/deartment_list/department_provider.dart';

class MultiSelectDepartment extends StatefulWidget {
  const MultiSelectDepartment({Key? key}) : super(key: key);

  @override
  State<MultiSelectDepartment> createState() => _MultiSelectDepartmentState();
}

class _MultiSelectDepartmentState extends State<MultiSelectDepartment> {
  HashSet<Department> selectedItem = HashSet();
  bool isMultiSelectionEnabled = false;
  List<int> userIds = [];
  List<String> userNames = [];
  @override
  Widget build(BuildContext context) {
   final departmentProvider = context.watch<DepartmentProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: isMultiSelectionEnabled
            ? IconButton(
            onPressed: () {
              selectedItem.clear();
              isMultiSelectionEnabled = false;
              setState(() {});
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ))
            : null,
        title: Text(tr("select_department")),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Long press to select department", textAlign: TextAlign.center,  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount:
                  departmentProvider.departmentList?.data?.departments?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        doMultiSelection(departmentProvider.departmentList?.data?.departments?[index]);
                      },
                      onLongPress: () {
                        isMultiSelectionEnabled = true;
                        doMultiSelection(departmentProvider.departmentList?.data?.departments?[index]);
                      },
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey.shade300)),
                            ),
                            child: ListTile(
                              title: Text(departmentProvider.departmentList?.data?.departments?[index].title ??
                                  ""),
                              subtitle: Text(tr("department")),
                              leading: ClipOval(
                                child: CachedNetworkImage(
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                  "http://test.24hourworx.com/public/static/blank_small.png",
                                  placeholder: (context, url) => Center(
                                    child: Image.asset(
                                        "assets/images/placeholder_image.png"),
                                  ),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Visibility(
                                visible: isMultiSelectionEnabled,
                                child: Icon(
                                  selectedItem.contains(departmentProvider.departmentList?.data?.departments?[index])
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  size: 26,
                                  color: const Color(0xFF5DB226),
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: isMultiSelectionEnabled,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: CustomButton(
                title: isMultiSelectionEnabled
                    ? getSelectedItemCount()
                    : tr("select_employee"),
                clickButton: () {
                  setState(() {
                    Navigator.pop(context, selectedItem);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );

  }

  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ? "${selectedItem.length} ${tr("item_selected")}"
        : tr("no_item_selected");
  }

  void doMultiSelection(Department? department) {
    if (isMultiSelectionEnabled) {
      if (selectedItem.contains(department)) {
        selectedItem.remove(department);
      } else {
        selectedItem.add(department!);
      }
      setState(() {});
    } else {
      // Other Logic
    }
  }
}
