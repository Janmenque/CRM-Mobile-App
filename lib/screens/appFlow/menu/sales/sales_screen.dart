import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sales_provider.dart';
import 'package:hrm_app/screens/custom_widgets/sales_pie_chart.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/custom_title_appbar.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SalesProvider(),
      child: Consumer<SalesProvider>(
        builder: (context, provider, _) {
          final grossData = provider.salesModel?.data?.staticstics;
          final latestSales = provider.salesModel?.data?.latestSales;
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar:
            PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child: const CustomTitleAppBar(
                title: "Sales",
              ),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              children: [
                IntrinsicHeight(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(grossData?.orders?.number.toString() ?? '',
                                    style: Theme
                                        .of(context)
                                        .textTheme.titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                  "Orders",
                                  style: Theme
                                      .of(context)
                                      .textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            width: 20,
                            thickness: 1,
                            indent: 12,
                            endIndent: 12,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(grossData?.gross?.number.toString() ?? '',
                                    style: Theme
                                        .of(context)
                                        .textTheme.titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                  "Gross",
                                  style: Theme
                                      .of(context)
                                      .textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            width: 20,
                            thickness: 1,
                            indent: 12,
                            endIndent: 12,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                    grossData?.pending?.number.toString() ?? '',
                                    style: Theme
                                        .of(context)
                                        .textTheme.titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                  "Pending",
                                  style: Theme
                                      .of(context)
                                      .textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const SalesPieChart(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Latest Sales', style: TextStyle(
                      color: AppColors.black, fontWeight: FontWeight.bold),),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text("Products",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                            fontSize: 14.sp, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(
                      'Price',
                      style: Theme
                          .of(context)
                          .textTheme.bodySmall!
                          .copyWith(fontSize: 14),
                    )
                  ],
                ),
                const Divider(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: latestSales?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final data = latestSales?[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(data?.image ?? '',
                          height: 80,
                          width: 80,),
                      ),
                      title: Text(data?.titile ?? ''),
                      subtitle: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Text(data?.user ?? ''),
                          Container(
                            height: 6,
                            width: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                          Text(data?.payment ?? ''),
                          Container(
                            height: 6,
                            width: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                          Text(data?.price.toString() ?? ''),
                        ],
                      ),
                      trailing: const Text("\$345"),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
