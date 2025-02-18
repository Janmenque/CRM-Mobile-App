import 'package:custom_timer/custom_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/screens/appFlow/home/break_time/break_report/break_report_screen.dart';
import 'package:hrm_app/screens/appFlow/home/break_time/break_time_provder.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BreakTime extends StatefulWidget {
  final String? diffTimeHome;
  final int? hourHome;
  final int? secondsHome;
  final int? minutesHome;
  final CustomTimerController? customTimerController;

  const BreakTime(
      {super.key,
        this.diffTimeHome,
        this.hourHome,
        this.minutesHome,
        this.secondsHome,
        this.customTimerController});

  @override
  State<BreakTime> createState() => _BreakTimeState();
}

class _BreakTimeState extends State<BreakTime>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController controller;
  late BreakTimeProvider provider;
  late final CustomTimerController controllerBreakTimer;

  @override
  void initState() {
    super.initState();
    controllerBreakTimer = CustomTimerController(
        vsync: this,
        begin: widget.diffTimeHome!.isNotEmpty
            ? Duration(
            hours: widget.hourHome!,
            minutes: widget.minutesHome!,
            seconds: widget.secondsHome!)
            : const Duration(hours: 0, minutes: 0, seconds: 0),
        end: const Duration(days: 1),
        initialState: CustomTimerState.reset,
        interval: CustomTimerInterval.milliseconds);
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (kDebugMode) {
          print("resumed");
        }
        provider.getBaseSetting(controllerBreakTimer);
        provider.breakHistoryApi();
        provider.getAttendance(controller, controllerBreakTimer, context,
            widget.hourHome, widget.secondsHome, widget.minutesHome);
        // Handle this case

        break;
      case AppLifecycleState.inactive:
        if (kDebugMode) {
          print("inactive");
        }
        // Handle this case
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print("inactive");
        }
        // Handle this case
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print("detached");
        }
        // Handle this case
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => BreakTimeProvider(
            controller,
            context,
            widget.hourHome,
            widget.minutesHome,
            widget.secondsHome,
            controllerBreakTimer),
        child: Consumer<BreakTimeProvider>(
          builder: (context, provider, _) {
            this.provider = provider;
            return WillPopScope(
              onWillPop: () {
                if (provider.checkStatus == "break_in") {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBreak(
                          title: tr("warning"),
                          subTitle: tr(
                              "once_you_break_start_you_can_not_go_back_till_you_back"),
                          onGoBack: () {
                            provider.getBreakTimeApi(
                                "back",
                                provider.controllerBreakTimer,
                                widget.hourHome,
                                widget.minutesHome,
                                widget.secondsHome,
                                context);
                            Navigator.pop(context, false);
                          },
                        );
                      });
                } else {
                  Navigator.pop(context, false);
                }

                return Future(() => false);
              },
              child: Scaffold(
                appBar: AppBar(
                  flexibleSpace: provider.checkStatus == "break_in"
                      ? Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFE8356C),
                            AppColors.colorPrimary,
                          ],
                          begin: FractionalOffset(1.0, 0.0),
                          end: FractionalOffset(1.0, 3.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                  )
                      : Container(
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
                    tr("break_time"),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.appBarColor),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        NavUtil.navigateScreen(
                            context, const BreakReportScreen());
                      },
                      child: Row(
                        children: [
                          Lottie.asset(
                            'assets/images/ic_report_lottie.json',
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      provider.isLoading == true
                          ? Visibility(
                          visible: provider
                              .responseBreakHistory?.data?.hasBreak ==
                              true,
                          child: Text.rich(
                            TextSpan(
                              // default text style
                              children: [
                                const TextSpan(
                                    text: 'You have already taken ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Color(0xFF555555))),
                                TextSpan(
                                    text: provider.responseBreakHistory
                                        ?.data?.totalBreakTime
                                        .toString() ??
                                        "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.redAccent)),
                                const TextSpan(
                                    text: ' break',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Color(0xFF555555))),
                              ],
                            ),
                          ))
                          : Shimmer.fromColors(
                        baseColor: const Color(0xFFE8E8E8),
                        highlightColor: Colors.white,
                        child: Container(
                            height: 16,
                            width: 280,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E8E8),
                              borderRadius: BorderRadius.circular(
                                  10), // radius of 10// green as background color
                            )),
                      ),
                      provider.isLoading == true
                          ? Visibility(
                          visible: provider
                              .responseBreakHistory?.data?.hasBreak ==
                              false,
                          child: Text(
                            tr("you_have_not_taken_a_break"),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xFF555555)),
                          ))
                          : Shimmer.fromColors(
                        baseColor: const Color(0xFFE8E8E8),
                        highlightColor: Colors.white,
                        child: Container(
                            height: 16,
                            width: 280,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E8E8),
                              borderRadius: BorderRadius.circular(
                                  10), // radius of 10// green as background color
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      provider.isLoading == true
                          ? CustomTimer(
                        controller: provider.controllerBreakTimer,
                        builder: (state, time) {
                          return Text(
                              "${time.hours}:${time.minutes}:${time.seconds}",
                              style: const TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: "digitalNumber"));
                        },
                      ) : Shimmer.fromColors(
                        baseColor: const Color(0xFFE8E8E8),
                        highlightColor: Colors.white,
                        child: Container(
                            height: 50,
                            width: 190,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E8E8),
                              borderRadius: BorderRadius.circular(
                                  5), // radius of 10// green as background color
                            )),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: GestureDetector(
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
                              if (controller.status ==
                                  AnimationStatus.forward) {
                                controller.reverse();
                                controller.value;
                              }
                            },
                            child: provider.isLoading == true
                                ? Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  height: 175,
                                  width: 175,
                                  child: CircularProgressIndicator(
                                    // strokeWidth: 5,
                                    value: 1.0,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                                Container(
                                  height: 185,
                                  width: 185,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      const BorderRadius.all(
                                        Radius.circular(100.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.deepPurple
                                              .withOpacity(0.1),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: const Offset(0, 3),
                                        )
                                      ]),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5,
                                    value: controller.value,
                                    valueColor: AlwaysStoppedAnimation<
                                        Color>(
                                        provider.checkStatus == "break_in"
                                            ? const Color(0xFFE8356C)
                                            : const Color(0xFF4E48B4)),
                                  ),
                                ),
                                ClipOval(
                                  child: Material(
                                      color: provider.checkStatus ==
                                          "break_in"
                                          ? AppColors.colorDeepRed
                                          : AppColors
                                          .colorPrimary, // Button color
                                      child: Container(
                                        height: 170,
                                        width: 170,
                                        decoration: provider
                                            .checkStatus ==
                                            "break_in"
                                            ? const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFE8356C),
                                                AppColors
                                                    .colorPrimary,
                                              ],
                                              begin:
                                              FractionalOffset(
                                                  1.0, 0.0),
                                              end: FractionalOffset(
                                                  0.0, 3.0),
                                              stops: [0.0, 1.0],
                                              tileMode:
                                              TileMode.clamp),
                                        )
                                            : const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                AppColors
                                                    .colorPrimary,
                                                Color(0xFF00CCFF)
                                              ],
                                              begin:
                                              FractionalOffset(
                                                  1.0, 0.0),
                                              end: FractionalOffset(
                                                  0.0, 3.0),
                                              stops: [0.0, 1.0],
                                              tileMode:
                                              TileMode.clamp),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Image.asset(
                                                  "assets/images/tap_figer.png",
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                tr(provider.checkStatus ==
                                                    "break_in"
                                                    ? "Back"
                                                    : "Start"),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            )
                                : Shimmer.fromColors(
                              baseColor: const Color(0xFFE8E8E8),
                              highlightColor: Colors.white,
                              child: Container(
                                  height: 184,
                                  width: 184,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8E8E8),
                                    borderRadius: BorderRadius.circular(
                                        100), // radius of 10// green as background color
                                  )),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBreak(
                                  title: "Warning!!",
                                  subTitle:
                                  "once you break start you can't go back till you back",
                                );
                              });
                        },
                        child: provider.isLoading == true
                            ? provider.responseBreakHistory!.data!.breakHistory!
                            .todayHistory!.isNotEmpty
                            ? const Text(
                          "Last Breaks",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                            : const SizedBox()
                            : Shimmer.fromColors(
                          baseColor: const Color(0xFFE8E8E8),
                          highlightColor: Colors.white,
                          child: Container(
                              height: 20,
                              width: 130,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8E8E8),
                                borderRadius: BorderRadius.circular(
                                    10), // radius of 10// green as background color
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      provider.isLoading == true
                          ? provider.responseBreakHistory!.data!.breakHistory!
                          .todayHistory!.isNotEmpty
                          ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                provider.isLoading == true
                                    ? provider
                                    .responseBreakHistory!
                                    .data!
                                    .breakHistory!
                                    .todayHistory!
                                    .isNotEmpty
                                    ? SizedBox(
                                  width: 100,
                                  child: Text(
                                    provider
                                        .responseBreakHistory
                                        ?.data
                                        ?.breakHistory
                                        ?.todayHistory?[
                                    index]
                                        .breakTimeDuration ??
                                        "",
                                    textAlign:
                                    TextAlign.center,
                                  ),
                                )
                                    : Shimmer.fromColors(
                                  baseColor:
                                  const Color(0xFFE8E8E8),
                                  highlightColor:
                                  Colors.white,
                                  child: Container(
                                      height: 16,
                                      width: 70,
                                      decoration:
                                      BoxDecoration(
                                        color: const Color(
                                            0xFFE8E8E8),
                                        borderRadius:
                                        BorderRadius.circular(
                                            10), // radius of 10// green as background color
                                      )),
                                )
                                    : Shimmer.fromColors(
                                  baseColor:
                                  const Color(0xFFE8E8E8),
                                  highlightColor: Colors.white,
                                  child: Container(
                                      height: 16,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFE8E8E8),
                                        borderRadius:
                                        BorderRadius.circular(
                                            10), // radius of 10// green as background color
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                provider.isLoading == true
                                    ? provider
                                    .responseBreakHistory!
                                    .data!
                                    .breakHistory!
                                    .todayHistory!
                                    .isNotEmpty
                                    ? Container(
                                  height: 40,
                                  width: 3,
                                  color:
                                  provider.checkStatus ==
                                      "break_in"
                                      ? const Color(
                                      0xFFE8356C)
                                      : AppColors
                                      .colorPrimary,
                                )
                                    : Shimmer.fromColors(
                                  baseColor:
                                  const Color(0xFFE8E8E8),
                                  highlightColor:
                                  Colors.white,
                                  child: Container(
                                      height: 40,
                                      width: 3,
                                      decoration:
                                      BoxDecoration(
                                        color: const Color(
                                            0xFFE8E8E8),
                                        borderRadius:
                                        BorderRadius.circular(
                                            10), // radius of 10// green as background color
                                      )),
                                )
                                    : Shimmer.fromColors(
                                  baseColor:
                                  const Color(0xFFE8E8E8),
                                  highlightColor: Colors.white,
                                  child: Container(
                                      height: 40,
                                      width: 3,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFE8E8E8),
                                        borderRadius:
                                        BorderRadius.circular(
                                            10), // radius of 10// green as background color
                                      )),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    provider.isLoading == true
                                        ? provider
                                        .responseBreakHistory!
                                        .data!
                                        .breakHistory!
                                        .todayHistory!
                                        .isNotEmpty
                                        ? Text(
                                      provider
                                          .responseBreakHistory
                                          ?.data
                                          ?.breakHistory
                                          ?.todayHistory?[
                                      index]
                                          .reason ??
                                          "",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight
                                              .bold),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: const Color(
                                          0xFFE8E8E8),
                                      highlightColor:
                                      Colors.white,
                                      child: Container(
                                          height: 14,
                                          width: 100,
                                          decoration:
                                          BoxDecoration(
                                            color: const Color(
                                                0xFFE8E8E8),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10), // radius of 10// green as background color
                                          )),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor:
                                      const Color(0xFFE8E8E8),
                                      highlightColor:
                                      Colors.white,
                                      child: Container(
                                          height: 14,
                                          width: 100,
                                          decoration:
                                          BoxDecoration(
                                            color: const Color(
                                                0xFFE8E8E8),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10), // radius of 10// green as background color
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    provider.isLoading == true
                                        ? provider
                                        .responseBreakHistory!
                                        .data!
                                        .breakHistory!
                                        .todayHistory!
                                        .isNotEmpty
                                        ? Text(provider
                                        .responseBreakHistory
                                        ?.data
                                        ?.breakHistory
                                        ?.todayHistory?[
                                    index]
                                        .breakBackTime ??
                                        "")
                                        : Shimmer.fromColors(
                                      baseColor: const Color(
                                          0xFFE8E8E8),
                                      highlightColor:
                                      Colors.white,
                                      child: Container(
                                          height: 14,
                                          width: 140,
                                          decoration:
                                          BoxDecoration(
                                            color: const Color(
                                                0xFFE8E8E8),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10), // radius of 10// green as background color
                                          )),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor:
                                      const Color(0xFFE8E8E8),
                                      highlightColor:
                                      Colors.white,
                                      child: Container(
                                          height: 14,
                                          width: 140,
                                          decoration:
                                          BoxDecoration(
                                            color: const Color(
                                                0xFFE8E8E8),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10), // radius of 10// green as background color
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: provider
                              .responseBreakHistory
                              ?.data
                              ?.breakHistory
                              ?.todayHistory
                              ?.length ??
                              0)
                          : const SizedBox()
                          : Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Shimmer.fromColors(
                                baseColor: const Color(0xFFE8E8E8),
                                highlightColor: Colors.white,
                                child: Container(
                                    height: 16,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8E8E8),
                                      borderRadius: BorderRadius.circular(
                                          10), // radius of 10// green as background color
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Shimmer.fromColors(
                                baseColor: const Color(0xFFE8E8E8),
                                highlightColor: Colors.white,
                                child: Container(
                                    height: 40,
                                    width: 3,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8E8E8),
                                      borderRadius: BorderRadius.circular(
                                          10), // radius of 10// green as background color
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: const Color(0xFFE8E8E8),
                                    highlightColor: Colors.white,
                                    child: Container(
                                        height: 14,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8E8E8),
                                          borderRadius: BorderRadius.circular(
                                              10), // radius of 10// green as background color
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: const Color(0xFFE8E8E8),
                                    highlightColor: Colors.white,
                                    child: Container(
                                        height: 14,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8E8E8),
                                          borderRadius: BorderRadius.circular(
                                              10), // radius of 10// green as background color
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Shimmer.fromColors(
                                baseColor: const Color(0xFFE8E8E8),
                                highlightColor: Colors.white,
                                child: Container(
                                    height: 16,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8E8E8),
                                      borderRadius: BorderRadius.circular(
                                          10), // radius of 10// green as background color
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Shimmer.fromColors(
                                baseColor: const Color(0xFFE8E8E8),
                                highlightColor: Colors.white,
                                child: Container(
                                    height: 40,
                                    width: 3,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8E8E8),
                                      borderRadius: BorderRadius.circular(
                                          10), // radius of 10// green as background color
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: const Color(0xFFE8E8E8),
                                    highlightColor: Colors.white,
                                    child: Container(
                                        height: 14,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8E8E8),
                                          borderRadius: BorderRadius.circular(
                                              10), // radius of 10// green as background color
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: const Color(0xFFE8E8E8),
                                    highlightColor: Colors.white,
                                    child: Container(
                                        height: 14,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8E8E8),
                                          borderRadius: BorderRadius.circular(
                                              10), // radius of 10// green as background color
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Shimmer.fromColors(
                                baseColor: const Color(0xFFE8E8E8),
                                highlightColor: Colors.white,
                                child: Container(
                                    height: 16,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8E8E8),
                                      borderRadius: BorderRadius.circular(
                                          10), // radius of 10// green as background color
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Shimmer.fromColors(
                                baseColor: const Color(0xFFE8E8E8),
                                highlightColor: Colors.white,
                                child: Container(
                                    height: 40,
                                    width: 3,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8E8E8),
                                      borderRadius: BorderRadius.circular(
                                          10), // radius of 10// green as background color
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: const Color(0xFFE8E8E8),
                                    highlightColor: Colors.white,
                                    child: Container(
                                        height: 14,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8E8E8),
                                          borderRadius: BorderRadius.circular(
                                              10), // radius of 10// green as background color
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: const Color(0xFFE8E8E8),
                                    highlightColor: Colors.white,
                                    child: Container(
                                        height: 14,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8E8E8),
                                          borderRadius: BorderRadius.circular(
                                              10), // radius of 10// green as background color
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
