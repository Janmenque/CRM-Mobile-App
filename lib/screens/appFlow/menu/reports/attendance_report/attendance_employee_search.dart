import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_employee/attendance_employee_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';

class AttendanceEmployeeSearch extends StatelessWidget {
  const AttendanceEmployeeSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceEmployeeProvider(),
      child: Consumer<AttendanceEmployeeProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF00CCFF),
                          AppColors.colorPrimary,
                        ],
                        begin: FractionalOffset(3.0, 0.0),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
                title: Text(
                  tr('search_employee_list'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appBarColor),
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: TextField(
                      decoration:  InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: tr("search"),
                        filled: true,
                        contentPadding: const EdgeInsets.all(0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      controller: provider.searchUserData,
                      onChanged: provider.textChanged,
                    ),
                  ),
                  provider.isLoading
                      ? provider.responseAllUser!.data!.users!.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                              itemCount: provider
                                      .responseAllUser?.data?.users?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    var allUserData = provider
                                        .responseAllUser?.data?.users?[index];
                                    Navigator.pop(context, allUserData);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300)),
                                    ),
                                    child: ListTile(
                                      title: Text(provider.responseAllUser?.data
                                              ?.users?[index].name ??
                                          ""),
                                      subtitle: Text(provider
                                              .responseAllUser
                                              ?.data
                                              ?.users?[index]
                                              .designation ??
                                          ""),
                                      leading: ClipOval(
                                        child: CachedNetworkImage(
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${provider.responseAllUser?.data?.users?[index].avatar}",
                                          placeholder: (context, url) => Center(
                                            child: Image.asset(
                                                "assets/images/placeholder_image.png"),
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
                            ))
                          : Expanded(
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/images/search_user.json',
                                      height: 300, width: 300),
                                   Text(
                                    tr('no_employee_list_found'),
                                    style: const TextStyle(
                                        color: Color(0x65555555),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  )
                                ],
                              )),
                            )
                      : const SizedBox(),
                ],
              ));
        },
      ),
    );
  }
}
