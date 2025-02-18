import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/provider/product_list_provider.dart';
import 'package:hrm_app/utils/res.dart';

ListView productList(ProductListProvider provider) {
  return

    ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.productListResponse?.data?.products?.length ?? 0,
      itemBuilder: (BuildContext context, int index){
        final data = provider.productListResponse?.data?.products?[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    height: 70, width: 70, fit: BoxFit.cover, imageUrl: data?.image,
                    placeholder: (context, url) => Center(child: Image.asset("assets/images/app_logo.png"),),
                    errorWidget: (context, url, error) => Image.asset("assets/images/placeholder_image.png",fit: BoxFit.cover,),
                  ),
                ),
                title: Text(data?.name ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                subtitle:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data?.code ?? "", style: const TextStyle(fontSize: 12),),
                    Text(data?.brand ?? "", style: const TextStyle(fontSize: 12),),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Unit", style: TextStyle(fontSize: 12),),
                      Text(data?.unit ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("QTY", style: TextStyle(fontSize: 12),),
                      Text(data?.qty.toString() ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Cost", style: TextStyle(fontSize: 12),),
                      Text("\$${data?.cost ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Price", style: TextStyle(fontSize: 12),),
                      Text("\$${data?.price ?? ""}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Stock : ", style: TextStyle(fontSize: 14 ),),
                      Text(data?.stock ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: data?.status == "Active" ?  const Color(0xff04A69E) : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(data?.status ?? "", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),),
                  )
                ],
              ),
            ],
          ),
        );
      });
}