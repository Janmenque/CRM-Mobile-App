import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/designation_list/designation_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/phonebook/phonebook_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class PhonebookScreen extends StatelessWidget {
  const PhonebookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final designationProvider = context.watch<DesignationProvider>();
    final allUserProvider = context.watch<PhonebookProvider>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title:  Text("Phonebook".tr(), style: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffEBEBEB)),
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
                                    hintText: "Search....".tr()),
                controller: allUserProvider.searchUserData,
                onChanged: allUserProvider.textChanged,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal :4.w, vertical: 4.h),
            child: SingleChildScrollView(
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
                            designationProvider
                                .designationList?.data?.designations?[index].id);
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
                  onTap: () async {
                    await allUserProvider.getPhonebookDetails(
                        allUserProvider.responseAllUser?.data?.members?[index].id,
                        allUserProvider.phonebookDetails,
                        context);
                  },
                  child: Container(
                           margin: EdgeInsets.symmetric(vertical: 1, horizontal: 14.w),
                           padding: EdgeInsets.symmetric(horizontal: 13.5.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r)),
                    child: ListTile(
                      title: Text(allUserProvider
                              .responseAllUser?.data?.members?[index].name ??
                          ""),
                      subtitle: Text(allUserProvider.responseAllUser?.data
                              ?.members?[index].designation ??
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
                      trailing: InkWell(
                        onTap: () {
                          FlutterPhoneDirectCaller.callNumber(allUserProvider
                                  .responseAllUser?.data?.members?[index].phone ??
                              "");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.phone,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
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
