import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/product_list/product_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/stock_dsahboard/stock_dashboard.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:provider/provider.dart';

class StockProductListScreen extends StatelessWidget {
  const StockProductListScreen({super.key, this.value});

  final String? value;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProductListProvider(),
      child: Consumer<ProductListProvider>(
        builder: (BuildContext context, provider, _) {
          final data = provider.categoryData?.data?.items;
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child: const CustomTitleAppBar(
                title: "Products ",
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
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
                          if (kDebugMode) {
                            print(value);
                          }
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final content = data?[index];
                        return ProductCard(
                            productImage: content?.avatar,
                            productname: content?.name ?? '',
                            brand: content?.brand,
                            quantity: content?.stock ?? '',
                            price: content?.price ?? '');
                      },
                    ),
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
