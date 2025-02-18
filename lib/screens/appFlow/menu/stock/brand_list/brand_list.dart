import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/brand_list/brand_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/stock_dsahboard/stock_dashboard.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:provider/provider.dart';

class BrandListScreen extends StatelessWidget {
  const BrandListScreen({super.key, this.value});

  final String? value;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => StockBrandListProvider(),
      child: Consumer<StockBrandListProvider>(
        builder: (BuildContext context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child: const CustomTitleAppBar(
                title: "Brands",
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 16.w),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffEBEBEB)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: TextFormField(
                        onChanged: ((value) {
                          //print(value);
                          provider.getSearchValue(value);
                        }),
                        maxLines: 1,
                        cursorColor: const Color(0xff5B58FF),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                padding: EdgeInsets.all(8.sp),
                                height: 29.h,
                                width: 29.w,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff5B58FF)),
                                child: Image.asset(
                                  "assets/task/search_bar.png",
                                  height: 11.h,
                                  width: 11.w,
                                ),
                              ),
                            ),
                            hintStyle: TextStyle(
                                color: const Color(0xffCED1DA),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                            hintText: "Search...."),
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 135.h,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h),
                        children: [
                          ...List.generate(
                            provider.categoryData?.data?.items?.length ?? 0,
                            (index) {
                              final data = provider.categoryData?.data?.items;
                              return StoreCardWidget(
                                image: data?[index].avatar,
                                name: data?[index].name,
                                quantity: "${data?[index].count} items",
                              );
                            },
                          )
                         
                       ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

