import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/home/appreciate_teammate/apreciate_teamate_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/designation_list/designation_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AllDesignationWiseUser extends StatelessWidget {
  const AllDesignationWiseUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final designationProvider = context.watch<DesignationProvider>();
    final allUserProvider = context.watch<AppreciateTeammateProvider>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title:  Text(tr("employee_list")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  color : Colors.white,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon:  Icon(Icons.search),
                  //fillColor: AppColors.backgroundColor,
                  filled: true,
                  border: InputBorder.none
                ),
                controller: allUserProvider.searchUserData,
                onChanged: allUserProvider.textChanged,
              ),
            ),
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
                      elevation: 3,
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(designationProvider.designationList?.data
                                ?.designations?[index].title ??
                            ""),
                      ),
                      selected: allUserProvider.value == index,
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.primaryColor,
                      labelStyle: TextStyle(
                        color: allUserProvider.value == index
                            ? Colors.white
                            : AppColors.primaryColor,
                      ),
                      onSelected: (bool selected) {
                        allUserProvider.onSelected(
                            selected,
                            index,
                            designationProvider.designationList?.data?.designations?[index].id);
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
                    var allUserData = allUserProvider.responseAllUser?.data?.members?[index];
                    Navigator.pop(context, allUserData);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: ListTile(
                      title: Text(allUserProvider.responseAllUser?.data?.members?[index].name ?? ""),
                      subtitle: Text(allUserProvider.responseAllUser?.data?.members?[index].designation ?? ""),
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          imageUrl:
                              "${allUserProvider.responseAllUser?.data?.members?[index].avatar}",
                          placeholder: (context, url) => Center(
                            child: Image.asset("assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
          ),
        ],
      ),
    );
  }
}
