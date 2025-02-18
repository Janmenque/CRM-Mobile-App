import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/all_leave_request_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_request_details/leave_request_details_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../leave_type/leave_type.dart';

class AllLeaveRequests extends StatelessWidget {
  const AllLeaveRequests({Key? key, this.bottomFav = false}) : super(key: key);

  final bool? bottomFav;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AllLeaveRequestProvider(),
      child: Consumer<AllLeaveRequestProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              floatingActionButton: bottomFav != true
                  ? FloatingActionButton(
                      heroTag: 'bottomFavFalse',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LeaveType()));
                      },
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  : null,
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  tr("all_leave_requests"),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appBarColor),
                ),
              ),
              body: Stack(
                children: [
                  provider.isLoading == true
                      ? provider.leaveTypeList!.data!.availableLeave!.isNotEmpty
                          ? ListView.builder(
                              itemCount: provider
                                  .leaveTypeList?.data?.availableLeave?.length,
                              itemBuilder: (BuildContext context, index) {
                                final data = provider.leaveTypeList?.data
                                    ?.availableLeave?[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6),
                                  child: Card(
                                    elevation: 4,
                                    child: TextButton(
                                      onPressed: () async {
                                        NavUtil.navigateScreen(
                                            context,
                                            LeaveRequestDetails(
                                              leaveRequestDetailsId: data!.id,
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 6),
                                        child: Stack(
                                          children: [
                                            const Positioned.fill(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.blueAccent,
                                                    size: 20,
                                                  )),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${data!.type} ${tr("leave_type")}",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      '${data.days} ${tr("days")}',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${data.applyDate}",
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color(int.parse(
                                                              data.colorCode ??
                                                                  "")),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 3.0,
                                                        ),
                                                        color: Color(int.parse(
                                                            data.colorCode ??
                                                                "")),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: DottedBorder(
                                                        color: Colors.white,
                                                        borderType:
                                                            BorderType.RRect,
                                                        radius: const Radius
                                                            .circular(5),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 3),
                                                        strokeWidth: 1,
                                                        child: Text(
                                                          '${data.status}',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                          :  Center(
                              child: Text(
                              tr("no_leave_requests_found"),
                              style: const TextStyle(
                                  color: Color(0x65555555),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ))
                      : const SizedBox(),
                  bottomFav == true
                      ? Positioned(
                          bottom: 80,
                          right: 20,
                          child: FloatingActionButton(
                            heroTag: 'bottomFavTrue',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LeaveType()));
                            },
                            child: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              )
          );
        },
      ),
    );
  }
}
