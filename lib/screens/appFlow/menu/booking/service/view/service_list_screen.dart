import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/service/provider/service_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/service/view/add_service_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  void addVariantDialog(BuildContext context, int serviceId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final variantNameController = Provider.of<ServiceListProvider>(context, listen: false).variantNameController;
        final variantPriceController = Provider.of<ServiceListProvider>(context, listen: false).variantPriceController;

        return AlertDialog(
          title: const Center(
            child: Text(
              'Add Service Variant',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NewTextField(controller: variantNameController, labelText: "Variant Name"),
              NewTextField(controller: variantPriceController, labelText: "Variant Price"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () async {
                await Provider.of<ServiceListProvider>(context, listen: false).createVariant(context, serviceId);
              },
            ),
          ],
        );
      },
    );
  }


  PopupMenuItem buildPopupMenuItem(context, int serviceId) {
    return  PopupMenuItem(
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ()=> addVariantDialog(context, serviceId ),
            child: const Row(
              children: [
                Text(
                  "Add Variant",
                  style: TextStyle(color: AppColors.colorPrimary, fontSize: 12),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceListProvider>(builder: (context, provider, _) {
      final services = provider.serviceListResponse?.data?.data;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Service List", style: TextStyle(fontWeight: FontWeight.bold),),
          actions: [
            InkWell(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AddServiceScreen())),
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
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Service", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text("Total : ${services?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                      services?.isNotEmpty == true ?
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: services?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final data = services?[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 14),
                                Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                                const SizedBox(height: 14),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Service Name: ${data?.name ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Category: ${data?.category ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Zone: ${data?.zone ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Bidding Price: ${data?.minBiddingPrice ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.grey),
                                        ),
                                        Row(
                                          children: [
                                            const Text("Sale Status : ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            Text(
                                              data?.status ?? "",
                                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      child: PopupMenuButton(
                                        iconSize: 18,
                                        icon: const Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.grey,
                                        ),
                                        onSelected: (value) {},
                                        itemBuilder: (BuildContext context) => [
                                          buildPopupMenuItem(context, data?.id ?? 0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }) : const NoDataFoundWidget(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
