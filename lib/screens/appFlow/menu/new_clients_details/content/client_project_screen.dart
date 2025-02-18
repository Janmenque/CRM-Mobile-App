import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_project_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';


class ClientProjectListScreen extends StatelessWidget {
  int clientId;
  ClientProjectListScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProjectProvider>(
      builder: (context, provider, _) {
        final projects = provider.clientProjectListResponse?.data?.data?.projects;
        return SingleChildScrollView(
            child:  Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Projects", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      InkWell(
                        onTap: ()=> createClientProject(context, provider, clientId ),

                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            children: [
                              Icon(Icons.add, size: 14, color: Colors.white,),
                              Text("Create", style: TextStyle(color: Colors.white, fontSize: 12),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric( horizontal: 12),
                  child:
                  provider.isLoading ? const CustomListShimer() :
                      projects?.isNotEmpty == true ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: projects?.length ?? 0,
                      itemBuilder: (BuildContext context, int index){
                        final data  = projects?[index];
                        List<Widget> users = [];
                        for (int i = 0; i < data!.members!.length; i++) {
                          users.add(Positioned(
                            left: i * 15, top: 0.0, bottom: 0.0,
                            child: InkWell(
                              onTap: (){
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title:  Text("Name : ${data.members!.elementAt(i).name ?? ""}"),
                                    content: Text("Designation : ${data.members!.elementAt(i).designation}\nDepartment : ${data.members!.elementAt(i).department ?? ""}\nPhone : ${data.members!.elementAt(i).phone ?? ""}\nemail : ${data.members!.elementAt(i).email ?? ""}"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                width: 30.0.w,
                                decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage('${data.members!.elementAt(i).avatar}'))),
                                child: const SizedBox.shrink(),
                              ),
                            ),
                          ));
                        }
                        return InkWell(
                          onTap: (){},
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 12),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex : 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           Text("Project Name", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                           Text("Priority", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                           Text("Status", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                          Text("Date Range", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                          Text("Assign Members ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(": ${data.title ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                          Text(": ${data.priority ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                          Text(": ${data.status ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                          Text(": ${data.dateRange ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20.0 * users.length,
                                                height: 40.0.h,
                                                child: Stack(children: users),
                                              ),
                                              (data.actualCount ?? 0) > 3
                                                  ? Container(
                                                padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 7.w),
                                                decoration: const BoxDecoration(color: Color(0xff00606F), shape: BoxShape.circle),
                                                child: Text(
                                                  ": ${data.usersCount.toString()}+",
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                ).tr(),
                                              ) :  const SizedBox()
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],),
                              ],),
                          ),
                        ));}) : const NoDataFoundWidget(),
                ),
              ],
            )
        );
      }
    );
  }


  void createClientProject(BuildContext parentContext, ClientProjectProvider provider, int clientId) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // 80% of the screen width
                  padding: const EdgeInsets.all(16.0), // Add padding if needed
                  child: Consumer<ClientProjectProvider>(
                    builder: (_, provider, __) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 5),
                            const Text(
                              "Add Project",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            NewTextField(
                              labelText: "Project Name",
                              controller: provider.projectNameController,
                            ),
                            NewTextField(
                              labelText: "Project description",
                              controller: provider.projectDescriptionController,
                              maxLine: 3,
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () => provider.selectStartDate(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      provider.startDate ?? "Start Date",
                                      style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            InkWell(
                              onTap: () => provider.selectEndDate(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      provider.endDate ?? "End Date",
                                      style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                Text(
                                  "Assign",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Card(
                                  elevation: 0,
                                  child: ListTile(
                                    onTap: () => provider.getAllUserData(context),
                                    title: Text(
                                      provider.allUserData?.name! ?? "Assign Members",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    subtitle: Text(
                                      provider.allUserData?.designation! ?? "",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(provider.allUserData?.avatar! ??
                                          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                                    ),
                                    trailing: const Icon(Icons.edit),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                    children: List.generate(
                                      provider.userNames.length,
                                          (index) => Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          gradient: const LinearGradient(
                                            colors: [AppColors.primaryColor, AppColors.primaryColor],
                                            begin: FractionalOffset(2.0, 0.0),
                                            end: FractionalOffset(0.0, 1.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp,
                                          ),
                                        ),
                                        child: Text(
                                          provider.userNames[index],
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  provider.createClientProject(context, clientId);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff5B58FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text(
                                  "Create",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

}
