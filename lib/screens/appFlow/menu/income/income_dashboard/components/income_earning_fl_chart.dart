import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/income/income_dashboard/components/get_income_title_data.dart';
import 'package:hrm_app/utils/res.dart';

class IncomeEarningWidget extends StatefulWidget {
  const IncomeEarningWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<IncomeEarningWidget> createState() => _IncomeEarningWidgetState();
}

class _IncomeEarningWidgetState extends State<IncomeEarningWidget> {
  String _selectedText = "Expense";
  String? setTotalSaleFilter;
  final List<Color> gradientColors = [
    const Color.fromARGB(255, 163, 161, 248),
    AppColors.white,
  ];

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                        "Staticstics",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.white,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold),
                            icon: Icon(
                              Icons.arrow_downward_sharp,
                              color: AppColors.primaryColor,
                              size: 14.sp,
                            ),
                            underline: Container(color: AppColors.white),
                            elevation: 0,
                            hint: const Text(
                              "Status",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                            value: _selectedText,
                            items: <String>[
                              'Expense',
                              'Expense 201',
                              'Expense 202'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              _selectedText = val!;
                              setState(() {
                                _selectedText = val;
                                if (kDebugMode) {
                                  print(val);
                                }

                                if (val == "Expense") {
                                  setTotalSaleFilter = "Expense";
                                } else if (val == "Expense 201") {
                                  setTotalSaleFilter = "Expense 201";
                                } else if (val == "Expense 202") {
                                  setTotalSaleFilter = "Expense 202";
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: SizedBox(
                    height: 220.h,
                    width: MediaQuery.of(context).size.width,
                    child: LineChart(LineChartData(
                        backgroundColor: AppColors.white,
                        minX: 0,
                        maxX: 11,
                        minY: 0,
                        maxY: 6,
                        titlesData: GetIncometitles.getTitleData(),
                        gridData: FlGridData(
                          show: false,
                          getDrawingHorizontalLine: (value) {
                            return const FlLine(
                              color: Color(0xffEFEFEF),
                              strokeWidth: 1,
                            );
                          },
                          drawVerticalLine: true,
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
                              spots: const [
                                FlSpot(0, 3),
                                FlSpot(2.6, 2),
                                FlSpot(4.9, 5),
                                FlSpot(6.8, 2.5),
                                FlSpot(8, 4),
                                FlSpot(9.5, 3),
                                FlSpot(11, 4),
                              ],
                              isCurved: true,
                              color: AppColors.primaryColor,
                              barWidth: 3,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: gradientColors,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              )),
                        ])),
                  ),
                )
              ],
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
