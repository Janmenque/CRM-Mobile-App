
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/sales_product_list.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/provider/product_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/view/create_product.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/title_and_add_button.dart';
import 'package:provider/provider.dart';

import '../../../../../custom_widgets/title_with_length.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(
      builder: (context, provider, _) {
        final products = provider.productListResponse?.data?.products;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Product List", style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              InkWell(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CreateProduct())),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
                  margin: EdgeInsets.symmetric( horizontal: 15.w),
                  decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8.r)),
                  child: Icon(Icons.add, size: 16.sp, color: Colors.white,),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleAndLength(title: "Products", length: products?.length ?? 0,),
                  const SizedBox(height: 16,),
                  provider.isLoading ? const CustomListShimer() :
                  provider.productListResponse?.data?.products?.isNotEmpty == true ?
                  productList(provider) : const NoDataFoundWidget()
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}