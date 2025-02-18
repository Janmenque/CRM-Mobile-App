import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_overview_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class ProjectOverviewScreen extends StatelessWidget {
  final int projectId;
  const ProjectOverviewScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return  Consumer<ProjectOverViewProvider>(
      builder: (context, provider, _) {
        final projectOverView = provider.projectOverviewDetailsResponse?.data;
        return SingleChildScrollView(
          child:
              provider.isLoading ? const CustomListShimer() :
          projectOverView != null ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const SizedBox(height: 14,),
              const SizedBox(height: 14,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                    projectOverView.status?.id != 27
                        ? InkWell(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                title: Text("${projectOverView.name} "),
                                content: const Text(
                                    "Is Your Project Complete ? "),
                                actions: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5),
                                    decoration: BoxDecoration(
                                        color:
                                        AppColors.colorPrimary,
                                        borderRadius:
                                        BorderRadius.circular(
                                            8)),
                                    child: InkWell(
                                      onTap: () => provider.getProjectStatus(projectOverView.id, context),
                                      child: const Text('Yes', style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5),
                                    decoration: BoxDecoration(
                                        color:
                                        AppColors.colorPrimary,
                                        borderRadius:
                                        BorderRadius.circular(
                                            8)),
                                    child: InkWell(
                                      onTap: () => Navigator.pop(
                                          context, 'No'),
                                      child: const Text(
                                        'No',
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.colorPrimary,
                            ),
                            borderRadius:
                            BorderRadius.circular(5)),
                        child: Text(
                          "Update Project Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp),
                        ),
                      ),
                    )
                        : Row(
                      children: [
                        Image.asset(
                          "assets/task/check.png",
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Project Complete",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 14,),
             Container(
               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
               margin: const EdgeInsets.symmetric( horizontal: 12),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(8)
               ),
               child:Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       Expanded(
                         child: Container(
                           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                           decoration: BoxDecoration(
                               color: const Color(0xffe3e3e3ff),
                               borderRadius: BorderRadius.circular(8)
                           ),
                           child:  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   const Icon(Icons.check_circle, size:14,),
                                   const SizedBox(width : 06),
                                   Text("Tasks ${projectOverView.taskRight ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                 ],
                               ),
                               const SizedBox(height: 10,),
                               Text(projectOverView.progressRightWithStatus ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                             ],
                           ),
                         ),
                       ),
                       const SizedBox(width: 14,),
                       Expanded(
                         child: Container(
                           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                           decoration: BoxDecoration(
                               color: const Color(0xffe3e3e3ff),
                               borderRadius: BorderRadius.circular(8)
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   const Icon(Icons.calendar_month_sharp, size:14,),
                                   const SizedBox(width : 06),
                                   Text("Days left ${projectOverView.daysLeft ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                 ],
                               ),
                               const SizedBox(height: 10,),
                               Text(projectOverView.daysLeftProgressWithStatus ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                             ],
                           ),
                         ),
                       )
                     ],
                   ),
                   const SizedBox(height: 20,),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       Expanded(
                         child: Container(
                             padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                             decoration: BoxDecoration(
                                 color: const Color(0xffe3e3e3ff),
                                 borderRadius: BorderRadius.circular(8)
                             ),
                             child: Center(child: Text("Total: ${projectOverView.totalExpenses ?? ""}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),))),
                       ),
                       const SizedBox(width: 14,),
                       Expanded(
                         child: Container(
                             padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                             decoration: BoxDecoration(
                                 color: const Color(0xffe3e3e3ff),
                                 borderRadius: BorderRadius.circular(8)
                             ),
                             child: Center(child: Text("Build : ${projectOverView.billedExpenses ?? ""}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange),))),
                       ),
                       const SizedBox(width: 14,),
                       Expanded(
                         child: Container(
                             padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                             decoration: BoxDecoration(
                                 color: const Color(0xffe3e3e3ff),
                                 borderRadius: BorderRadius.circular(8)
                             ),
                             child: Center(child: Text("Un billed :${projectOverView.unbilledExpenses ?? ""}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.red),))),
                       ),
                     ],
                   )
                 ],
               ) ,
             ),
              const SizedBox(height: 14,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                margin: const EdgeInsets.symmetric( horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child:  Row(
                  children: [
                    const Expanded(
                     flex: 3,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Title", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                         SizedBox(height: 4,),
                         Text("Client", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                         SizedBox(height: 4,),
                         Text("Billing Type", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                         SizedBox(height: 4,),
                         Text("Total Rate", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                         SizedBox(height: 4,),
                         Text("Status", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                         SizedBox(height: 4,),
                         Text("Start Date", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                         SizedBox(height: 4,),
                         Text("Deadline", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                         SizedBox(height: 4,),
                         Text("Goal", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                       ],
                     ),
                                        ),
                    Expanded(
                     flex: 6,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(": ${projectOverView.name ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black),),
                         const SizedBox(height: 4,),
                         Text(": ${projectOverView.client?.name ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black),),
                         const SizedBox(height: 4,),
                         Text(": ${projectOverView.billingType ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black),),
                         const SizedBox(height: 4,),
                         projectOverView.totalRate != null ?
                         Text(": \$ ${projectOverView.totalRate.toString() ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black),) :
                         const Text(": N/A", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black),),
                         const SizedBox(height: 4,),
                         Text(": ${projectOverView.status?.name ?? ""}", style: const  TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black),),
                         const SizedBox(height: 4,),
                          Text(": ${projectOverView.startDate ?? ""}", style: const  TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color:   AppColors.black),),
                         const SizedBox(height: 4,),
                         Text(": ${projectOverView.endDate ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color:   AppColors.black),),
                         const SizedBox(height: 4,),
                         Text(": ${projectOverView.goal ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color:   AppColors.black),),
                       ],
                     ),
                    )
                  ],
                ),
              )
            ],
          ) : const NoDataFoundWidget(),
        );
      }
    );
  }
}
