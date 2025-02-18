import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/daily_leave/daily_leave_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/daily_leave_details/daily_leave_details_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class DailyLeave extends StatefulWidget {
  const DailyLeave({Key? key}) : super(key: key);

  @override
  State<DailyLeave> createState() => _DailyLeaveState();
}

class _DailyLeaveState extends State<DailyLeave> with TickerProviderStateMixin {
  late AnimationController controller;
  bool gestureUp = false;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        animationBehavior: AnimationBehavior.normal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyLeaveProvider(controller, context),
      child: Consumer<DailyLeaveProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title:  Text(tr("daily_leave")),
            ),
            body: ListView(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.deferToChild,
                    onVerticalDragCancel: () {
                      controller.reset();
                    },
                    onHorizontalDragCancel: () {
                      controller.reset();
                    },
                    onTapDown: (_) {
                      controller.forward();
                    },
                    onTapUp: (_) {
                      if (controller.status == AnimationStatus.forward) {
                        controller.reverse();
                        controller.value;
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 175,
                          width: 175,
                          child: CircularProgressIndicator(
                            // strokeWidth: 5,
                            value: 1.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        Container(
                          height: 185,
                          width: 185,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            value: controller.value,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF4358BE)),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                              child: Container(
                            height: 170,
                            width: 170,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    AppColors.colorPrimary,
                                    Color(0xFF00CCFF)
                                  ],
                                  begin: FractionalOffset(1.0, 0.0),
                                  end: FractionalOffset(0.0, 3.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Image.asset(
                                      "assets/images/tap_figer.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "Apply Daily \n Leave",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                        )
                      ],
                    ),
                  ),
                ),

                ///current date
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey)),
                  child: provider.isHr == true
                      ? currentMonthDate(provider, context)
                      : currentDate(provider, context),
                ),

                ///Select employee from HR Panel
                Visibility(
                  visible: provider.isHr ?? false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: OutlinedButton(
                      onPressed: () => provider.getAllUserData(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          Text(provider.allUserData?.name ?? tr("select_employee")),
                    ),
                  ),
                ),

                buildApprovedTile(
                    earlyLeaveTap: () => NavUtil.navigateScreen(
                        context,
                        DailyLeaveDetailsScreen(
                          title: tr("early_leave"),
                          leaveStatus: tr("approved"),
                          leaveType: 'early_leave',
                          employeeId: provider.allUserData?.id,
                          date: provider.monthYear,
                          onCallBack: () => provider.getDailySummery(),
                        )),
                    lateLeaveTap: () => NavUtil.navigateScreen(
                        context,
                        DailyLeaveDetailsScreen(
                          title: tr("late_arrive"),
                          leaveStatus: tr("approved"),
                          leaveType: 'late_arrive',
                          employeeId: provider.allUserData?.id,
                          date: provider.monthYear,
                          onCallBack: () => provider.getDailySummery(),
                        )),
                    headTitle: tr("approved"),
                    earlyValue:
                        provider.dailyLeaveSummary?.data?.approved?.earlyLeave,
                    lateValue:
                        provider.dailyLeaveSummary?.data?.approved?.lateArrive,
                    color: 0xFF00FF35),
                buildApprovedTile(
                    earlyLeaveTap: () => NavUtil.navigateScreen(
                        context,
                        DailyLeaveDetailsScreen(
                            title: tr("early_leave"),
                            leaveStatus: tr("rejected"),
                            leaveType: 'early_leave',
                            employeeId: provider.allUserData?.id,
                            date: provider.monthYear,
                            onCallBack: () => provider.getDailySummery())),
                    lateLeaveTap: () => NavUtil.navigateScreen(
                        context,
                        DailyLeaveDetailsScreen(
                            title: tr("late_arrive"),
                            leaveStatus: tr("rejected"),
                            leaveType: 'late_arrive',
                            employeeId: provider.allUserData?.id,
                            date: provider.monthYear,
                            onCallBack: () => provider.getDailySummery())),
                    headTitle: tr("rejected"),
                    earlyValue:
                        provider.dailyLeaveSummary?.data?.rejected?.earlyLeave,
                    lateValue:
                        provider.dailyLeaveSummary?.data?.rejected?.lateArrive,
                    color: 0xFFFF0A1C),
                buildApprovedTile(
                    earlyLeaveTap: () => NavUtil.navigateScreen(
                          context,
                          DailyLeaveDetailsScreen(
                              title: tr("early_leave"),
                              leaveStatus: 'pending',
                              leaveType: 'early_leave',
                              employeeId: provider.allUserData?.id,
                              date: provider.monthYear,
                              onCallBack: () => provider.getDailySummery()),
                        ),
                    lateLeaveTap: () => NavUtil.navigateScreen(
                      context,
                      DailyLeaveDetailsScreen(
                          title: tr("late_arrive"),
                          leaveStatus: 'pending',
                          leaveType: 'late_arrive',
                          employeeId: provider.allUserData?.id,
                          date: provider.monthYear,
                          onCallBack: () => provider.getDailySummery()),
                    ),
                    headTitle: tr("Pending"),
                    earlyValue:
                        provider.dailyLeaveSummary?.data?.pending?.earlyLeave,
                    lateValue:
                        provider.dailyLeaveSummary?.data?.pending?.lateArrive,
                    color: 0xFFF69E2C),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildApprovedTile(
      {String? headTitle,
      int? earlyValue,
      int? lateValue,
      int? color,
      Function()? earlyLeaveTap, lateLeaveTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headTitle!,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Column(
            children: [
              ListTile(
                onTap: earlyLeaveTap,
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                dense: true,
                leading: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(color ?? 0xFFFFFF))),
                title: const Text('Early Leave'),
                trailing: Text('${earlyValue ?? 0}'),
              ),
              ListTile(
                onTap: lateLeaveTap,
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                dense: true,
                leading: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(color ?? 0xFFFFFF))),
                title: const Text('Late Arrive'),
                trailing: Text('${lateValue ?? 0}'),
              ),
            ],
          )
        ],
      ),
    );
  }

  InkWell currentDate(DailyLeaveProvider provider, context) {
    return InkWell(
      onTap: () {
        provider.selectDate(context);
      },
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                provider.selectDate(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleLeft,
                size: 30,
                color: AppColors.colorPrimary,
              )),
          const Spacer(),
          Center(
              child: Text(
            provider.showMonth ?? "",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )),
          const Spacer(),
          IconButton(
              onPressed: () {
                provider.selectDate(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 30,
                color: AppColors.colorPrimary,
              )),
        ],
      ),
    );
  }

  ///current month date for hr
  InkWell currentMonthDate(DailyLeaveProvider provider, context) {
    return InkWell(
      onTap: () {
        provider.selectMonthDate(context);
      },
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                provider.selectMonthDate(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleLeft,
                size: 30,
                color: AppColors.colorPrimary,
              )),
          const Spacer(),
          Center(
              child: Text(
            provider.showMonth ?? "",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )),
          const Spacer(),
          IconButton(
              onPressed: () {
                provider.selectMonthDate(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 30,
                color: AppColors.colorPrimary,
              )),
        ],
      ),
    );
  }
}
