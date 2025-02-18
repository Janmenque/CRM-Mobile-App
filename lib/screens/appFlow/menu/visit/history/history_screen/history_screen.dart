import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/history/history_screen/history_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryProvider(),
      child: Consumer<HistoryProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
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
                              size: 24,
                              color: AppColors.colorPrimary,
                            )),
                        const Spacer(),
                        Center(
                            child: Text(
                          provider.monthYear ?? "",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              provider.selectDate(context);
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.angleRight,
                              size: 24,
                              color: AppColors.colorPrimary,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              provider.isLoading
                  ? provider.responseVisitHistory!.data!.history!.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: provider.responseVisitHistory?.data
                                      ?.history?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        NavUtil.navigateScreen(
                                            context,
                                            VisitDetails(
                                              visitID: provider
                                                  .responseVisitHistory
                                                  ?.data
                                                  ?.history?[index]
                                                  .id,
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.primaryColor.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        provider
                                                                .responseVisitHistory
                                                                ?.data
                                                                ?.history?[
                                                                    index]
                                                                .month?.toUpperCase() ??
                                                            "",
                                                        style:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                color: AppColors.primaryColor,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        provider
                                                                .responseVisitHistory
                                                                ?.data
                                                                ?.history?[
                                                                    index]
                                                                .day ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors.primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        provider
                                                                .responseVisitHistory
                                                                ?.data
                                                                ?.history?[
                                                                    index]
                                                                .title ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [


                                                          Container(
                                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Color(int.parse(provider
                                                                  .responseVisitHistory
                                                                  ?.data
                                                                  ?.history?[
                                                              index]
                                                                  .statusColor ??
                                                                  "")).withOpacity(0.25),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                            ),
                                                            child: Text(
                                                              provider
                                                                  .responseVisitHistory
                                                                  ?.data
                                                                  ?.history?[
                                                              index]
                                                                  .status ??
                                                                  "",
                                                              style:  TextStyle(
                                                                  color: Color(int.parse(provider
                                                                      .responseVisitHistory
                                                                      ?.data
                                                                      ?.history?[
                                                                  index]
                                                                      .statusColor ??
                                                                      "")),
                                                                  fontSize:
                                                                  10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.primaryColor.withOpacity(0.2),
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Text(
                                                              "${provider.responseVisitHistory?.data?.history?[index].started ?? ""} - ${provider.responseVisitHistory?.data?.history?[index].reached ?? ""}",
                                                              style:
                                                              const TextStyle(
                                                                color: AppColors.primaryColor,
                                                                  fontSize:
                                                                  10,
                                                              fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward_ios,
                                                  color:
                                                  AppColors.primaryColor,
                                                  size: 20,
                                                )                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        )
                      :  Expanded(
                          child: Center(
                              child: Text(
                            tr("no_visit_history_found"),
                            style: const TextStyle(
                                color: Color(0x65555555),
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          )),
                        )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
