import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/break_report/break_report_search/break_report_search_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class BreakReportSearch extends StatelessWidget {
  const BreakReportSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BreakReportSearchProvider(),
        child: Consumer<BreakReportSearchProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              appBar: AppBar(
                title: Text(tr('break_time_report')),
              ),
              body: Column(
                children: [
                  InkWell(
                    onTap: () {
                      provider.getEmployeeData(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // radius of 10
                            color: Colors.grey[100] // green as background color
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(tr("search")),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      child: ListTile(
                        title: Text(provider.officialInfo?.data?.name ?? ""),
                        subtitle:
                        Text(provider.officialInfo?.data?.designation ?? ""),
                        leading: ClipOval(
                          child: CachedNetworkImage(
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            imageUrl: "${provider.officialInfo?.data?.avatar}",
                            placeholder: (context, url) => Center(
                              child: Image.asset(
                                  "assets/images/placeholder_image.png"),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
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
                          provider.breakDate != null
                              ? "${provider.breakDate!.toLocal()}".split(" ")[0]
                              : "Select Break Date",
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
                              size: 30,
                              color: AppColors.colorPrimary,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xff6AB026),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${tr('total_break_time')}:",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 16, color: Colors.white),
                        ),
                        // ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          provider.responseBreakReport?.data?.totalBreakTime ??
                              "00:00:00",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "digitalNumber"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  provider.isLoading == true
                      ? provider.responseBreakReport!.data!.breakHistory!
                              .todayHistory!.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            provider
                                                    .responseBreakReport
                                                    ?.data
                                                    ?.breakHistory
                                                    ?.todayHistory?[index]
                                                    .breakTimeDuration ??
                                                "",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          width: 3,
                                          color: AppColors.colorPrimary,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider
                                                      .responseBreakReport
                                                      ?.data
                                                      ?.breakHistory
                                                      ?.todayHistory?[index]
                                                      .reason ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(provider
                                                    .responseBreakReport
                                                    ?.data
                                                    ?.breakHistory
                                                    ?.todayHistory?[index]
                                                    .breakBackTime ??
                                                ""),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: provider
                                          .responseBreakReport
                                          ?.data
                                          ?.breakHistory
                                          ?.todayHistory
                                          ?.length ??
                                      0),
                            )
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tr("nothing_found"),
                                    style: const TextStyle(
                                        color: Color(0x65555555),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                      : const SizedBox(),
                ],
              ),
            );
          },
        ));
  }
}
