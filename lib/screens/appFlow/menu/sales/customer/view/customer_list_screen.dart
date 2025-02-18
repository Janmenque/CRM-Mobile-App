import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/customer/view/create_customer_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import '../provider/customer_list_provider.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerListProvider>(
        builder: (context, provider, _) {
          final customers = provider.customerListResponse?.data?.customers;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Customer List", style: TextStyle(fontWeight: FontWeight.bold),),
              actions: [
                InkWell(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AddCustomerScreen())),
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
                    provider.isLoading  ? const CustomListShimer() :
                    customers?.isNotEmpty == true ?
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Customer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text("Total : ${customers?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: customers?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = customers?[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 14,),
                                    Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                                    const SizedBox(height: 14,),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex : 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              data?.customerGroup != null ? const Text("Group", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),) : const SizedBox(),
                                              const Text("Customer Name", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              const Text("Company", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              const Text("Email", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              const Text("Phone", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              const Text("Plan", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              const Text("Points", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              const Text("Balance", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              const Text("Due", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex : 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              data?.customerGroup != null ? Text(": ${data?.customerGroup ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),) : const SizedBox(),
                                              Text(": ${data?.name ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text(": ${data?.companyName ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text(": ${data?.email ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text(": ${data?.phoneNumber ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text(": ${data?.plan ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text(": ${data?.points ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text(": ${data?.balance ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                              Text(": ${data?.due ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                      ],),],);}),
                        ],
                      ),
                    ) : const NoDataFoundWidget()
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
