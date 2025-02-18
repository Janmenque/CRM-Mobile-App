import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/home/appreciate_teammate/apreciate_teamate_provider.dart';
import 'package:hrm_app/screens/appFlow/home/appreciate_teammate/create_appreciate/create_appreciate_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/designation_list/designation_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AppreciateTeammate extends StatelessWidget {
  const AppreciateTeammate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final designationProvider = context.watch<DesignationProvider>();
    final allUserProvider = context.watch<AppreciateTeammateProvider>();
    return Scaffold(
      appBar: AppBar(
        title:  Text(tr("appreciate_teammate")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextField(
              decoration:  InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: tr('search'),
                filled: true,
                contentPadding: const EdgeInsets.all(0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
              controller: allUserProvider.searchUserData,
              onChanged: allUserProvider.textChanged,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
                    selectedColor: AppColors.colorPrimary,
                    labelStyle: TextStyle(
                      color: allUserProvider.value == index
                          ? Colors.white
                          : AppColors.colorPrimary,
                    ),
                    onSelected: (bool selected) {
                      allUserProvider.onSelected(
                          selected,
                          index,
                          designationProvider
                              .designationList?.data?.designations?[index].id);
                    },
                  );
                },
              ).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  allUserProvider.responseAllUser?.data?.members?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    NavUtil.navigateScreen(
                        context,
                        CreateAppreciateScreen(
                          appreciateId: allUserProvider
                              .responseAllUser?.data?.members?[index].id,
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: ListTile(
                      title: Text(allUserProvider
                              .responseAllUser?.data?.members?[index].name ??
                          ""),
                      subtitle: Text(allUserProvider.responseAllUser?.data
                              ?.members?[index].designation ??
                          ""),
                      leading:  ClipOval(
                        child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          imageUrl: "${allUserProvider.responseAllUser?.data?.members?[index].avatar}",
                          placeholder: (context, url) => Center(
                            child: Image.asset("assets/images/ic_loader.gif"),
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
