import 'dart:collection';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/custom_widgets/custom_buttom.dart';
import 'package:hrm_app/screens/appFlow/home/appreciate_teammate/apreciate_teamate_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/designation_list/designation_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/home/crm_home_model.dart';

class MultiSelectEmployee extends StatefulWidget {
  const MultiSelectEmployee({Key? key}) : super(key: key);

  @override
  State<MultiSelectEmployee> createState() => _MultiSelectEmployeeState();
}

class _MultiSelectEmployeeState extends State<MultiSelectEmployee> {
  HashSet<Members> selectedItem = HashSet();
  bool isMultiSelectionEnabled = false;
  List<int> userIds = [];
  List<String> userNames = [];

  @override
  Widget build(BuildContext context) {
    final designationProvider = context.watch<DesignationProvider>();
    final allUserProvider = context.watch<AppreciateTeammateProvider>();
    return Scaffold(
       backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        
         elevation: 0,
        leading: isMultiSelectionEnabled
            ? IconButton(
                onPressed: () {
                  selectedItem.clear();
                  isMultiSelectionEnabled = false;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black,
                ))
            : null,
        title:  Text(tr("select_employee"), style: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Padding(
                padding:
                     EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.h),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffEBEBEB)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                     maxLines: 1,
                              cursorColor: const Color(0xff5B58FF),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(8.sp),
                                      height: 29.h,
                                      width: 29.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff5B58FF)),
                                      child: Image.asset(
                                        "assets/task/search_bar.png",
                                        height: 11.h,
                                        width: 11.w,
                                      ),
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                      color: const Color(0xffCED1DA),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                  hintText: "Search...."),
                    controller: allUserProvider.searchUserData,
                    onChanged: allUserProvider.textChanged,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(tr('long_press_to_select_employee'.tr()),style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: AppColors.colorDeepRed),),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Wrap(
                    spacing: 10,
                    children: List<Widget>.generate(
                      designationProvider
                              .designationList?.data?.designations?.length ??
                          0,
                      (int index) {
                        return ChoiceChip(
                          elevation: 2,
                          label: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(designationProvider.designationList
                                    ?.data?.designations?[index].title ??
                                ""),
                          ),
                          selected: allUserProvider.value == index,
                          backgroundColor: Colors.white,
                          selectedColor:  AppColors.primaryColor,
                          labelStyle: TextStyle(
                            color: allUserProvider.value == index
                                ? Colors.white
                                : AppColors.primaryColor,
                          ),
                          onSelected: (bool selected) {
                            allUserProvider.onSelected(
                                selected,
                                index,
                                designationProvider.designationList?.data
                                    ?.designations?[index].id);
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      allUserProvider.responseAllUser?.data?.members?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        doMultiSelection(allUserProvider
                            .responseAllUser!.data!.members![index]);
                      },
                      onLongPress: () {
                        isMultiSelectionEnabled = true;
                        doMultiSelection(allUserProvider
                            .responseAllUser!.data!.members![index]);
                      },
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 14.w),
                           padding: EdgeInsets.symmetric(horizontal: 13.5.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r)),
                            child: ListTile(
                              title: Text(allUserProvider.responseAllUser?.data
                                      ?.members?[index].name ??
                                  ""),
                              subtitle: Text(allUserProvider.responseAllUser
                                      ?.data?.members?[index].designation ??
                                  ""),
                              leading: ClipOval(
                                child: CachedNetworkImage(
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${allUserProvider.responseAllUser?.data?.members?[index].avatar}",
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
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Visibility(
                                visible: isMultiSelectionEnabled,
                                child: Icon(
                                  selectedItem.contains(allUserProvider
                                          .responseAllUser!.data!.members![index])
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

  void doMultiSelection(Members user) {
    if (isMultiSelectionEnabled) {
      if (selectedItem.contains(user)) {
        selectedItem.remove(user);
      } else {
        selectedItem.add(user);
      }
      setState(() {});
    } else {
      // Other Logic
    }
  }
}
