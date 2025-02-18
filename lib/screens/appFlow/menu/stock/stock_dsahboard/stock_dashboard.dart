import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/brand_list/brand_list.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/category_list/category_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/product_list/product_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/stock_dsahboard/stock_dashboard_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/widget/stock_dashboard_dialog.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class StockDashboardScreen extends StatelessWidget {
  const StockDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StockDashboardProvider(),
      child: Consumer<StockDashboardProvider>(
        builder: (context, provider, _) {
          final statistics = provider.stockModel?.data?.staticstics;
          final categories = provider.stockModel?.data?.categories;
          final products = provider.stockModel?.data?.products;
          final stores = provider.stockModel?.data?.stores;
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(56.h),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text(
                    "Stock",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const StockDashboardDialog());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Image.asset(
                          "assets/projects/projects_filter.png",
                          height: 22.h,
                          width: 22.w,
                        ),
                      ),
                    ),
                  ],
                )),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 17.w),
                child: Column(
                  children: [
                    GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children:
                            List.generate(statistics?.length ?? 0, (index) {
                          final data = statistics?[index];
                          return DashboardCard(
                            backgroundImage: data?.image ?? '',
                            title: data?.text ?? '',
                            amount: data?.count ?? '',
                            amountTop: 35.0.h,
                            amountRight: 15.0.w,
                            titleTop: 58.0.h,
                            titleRight: 20.0.w,
                          );
                        })),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryListScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff5B58FF)),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: const Color(0xff5B58FF),
                                    fontSize: 14.sp),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data = categories?[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: CategoryWidget(
                            image: data?.image ?? '',
                            titile: data?.title,
                            amount: "${data?.count ?? '0'} items",
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Product",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "(123)",
                                style: TextStyle(
                                    color: AppColors.lightGrey,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           const StockProductListScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff5B58FF)),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: const Color(0xff5B58FF),
                                    fontSize: 14.sp),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 02.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data = products?[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: ProductCard(
                              productImage: data?.avatar ?? '',
                              productname: data?.name ?? '',
                              brand: data?.brand,
                              quantity: "${data?.stock ?? ''} pcs",
                              price: data?.price.toString() ?? ''),
                        );
                      },
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Brands",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           const BrandListScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff5B58FF)),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: const Color(0xff5B58FF),
                                    fontSize: 14.sp),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 02.h,
                    ),
                    SizedBox(
                      height: 160.h,
                      child: ListView.builder(
                        itemCount: stores?.length ?? 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final data = stores?[index];
                          return StoreCardWidget(
                            image: data?.image ?? '',
                            name: data?.title ?? '',
                            quantity: "${data?.count ?? ''} items",
                          );
                        },
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

class StoreCardWidget extends StatelessWidget {
  const StoreCardWidget({Key? key, this.image, this.name, this.quantity})
      : super(key: key);

  final String? image, name, quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            image!,
            //"assets/stocks/puma.png",

            height: 60.h, width: 60.w,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            name ?? "",
            //"Puma Official",

            style: TextStyle(
                color: AppColors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                height: 1.5),
          ),
          Text(
            quantity ?? "",
            //"48 items",
            style: TextStyle(
                color: const Color(0xffFF8000),
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                height: 1.5),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      this.quantity,
      this.price,
      this.productImage,
      this.productname,
      this.rating,
      this.brand})
      : super(key: key);

  final String? productImage, productname, rating, brand, price, quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: Colors.white),
      child: Row(
        children: [
          Image.network(
            productImage!,
            height: 88.h,
            width: 88.w,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productname ?? '',
                      style: TextStyle(
                          height: 1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      children: [

                        Text(
                          brand ?? '',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightGrey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "stock : ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          quantity ?? "",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  price ?? "",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, this.image, this.titile, this.amount})
      : super(key: key);

  final String? image, titile, amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                image!,
                height: 56.h, width: 56.w,
              ),
              SizedBox(
                width: 14.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titile ?? "",
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        height: 1.5),
                  ),
                  Text(
                    amount ?? "",
                    style: TextStyle(
                        color: const Color(0xff8A8A8A),
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        height: 1.5),
                  ),
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 10.sp,
            color: AppColors.black,
          )
        ],
      ),
    );
  }
}
