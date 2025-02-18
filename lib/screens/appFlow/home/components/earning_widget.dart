import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/model/home/crm_home_model.dart';

class EarningWidget extends StatefulWidget {
  const EarningWidget({super.key, this.chartData});

  final StaticsticsData? chartData;

  @override
  State<EarningWidget> createState() => _EarningWidgetState();
}

class _EarningWidgetState extends State<EarningWidget> {

  String? setTotalSaleFilter;
  final List<Color> gradientColors = [
    const Color.fromARGB(255, 159, 158, 255),
    AppColors.white,
  ];
  final List<Color> gradientColorsNext = [
    const Color.fromARGB(255, 255, 219, 200),
    AppColors.white,
  ];
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    List<FlSpot>? completeTask = widget.chartData?.completeTasks
        ?.map((e) => FlSpot(e.date!.toDouble(), e.complete!.toDouble()))
        .toList();
    List<FlSpot>? inCompleteTask = widget.chartData?.incompleteTasks
        ?.map((e) => FlSpot(e.date!.toDouble(), e.incomplete!.toDouble()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.chartData?.completeTasks != null
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Statistics",
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SizedBox(
                          height: 220.h,
                          width: MediaQuery.of(context).size.width,
                          child: LineChart(
                              LineChartData(
                              backgroundColor: AppColors.white,
                              gridData: FlGridData(
                                show: false,
                                getDrawingHorizontalLine: (value) {
                                  return const FlLine(
                                    color: Color(0xffEFEFEF),
                                    strokeWidth: 1,
                                  );
                                },
                                drawVerticalLine: false,
                                getDrawingVerticalLine: (value) {
                                  return const FlLine(
                                    color: Color(0xffEFEFEF),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              borderData: FlBorderData(
                                show: false,
                                border: Border.all(
                                    color: const Color(0xffEFEFEF), width: 2),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                    spots: completeTask ?? [],
                                    isCurved: true,
                                    preventCurveOverShooting: true,
                                    color: AppColors.primaryColor,
                                    barWidth: 3,
                                    dotData: const FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: false,
                                      gradient: LinearGradient(
                                        colors: gradientColors,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    )
                                ),
                                LineChartBarData(
                                    spots: inCompleteTask ?? [],
                                    isCurved: true,
                                    color: const Color(0xffFFBC99),
                                    barWidth: 3,
                                    dotData: const FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: false,
                                      gradient: LinearGradient(
                                        colors: gradientColorsNext,
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ))
                              ])),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Shimmer.fromColors(
                baseColor: const Color(0xFFE8E8E8),
                highlightColor: Colors.white,
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  height: 200.h,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(
                        10), // radius of 10// green as background color
                  ),
                ),
              ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
