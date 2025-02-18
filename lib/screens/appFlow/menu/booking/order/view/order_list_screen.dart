import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/order/provider/order_list_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderListProvider(),
      child: Consumer<OrderListProvider>(
          builder: (context, provider, _) {
            final customers = provider.orderListResponse?.data?.customers;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Order List", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 13.5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          onChanged: ((value) {}),
                          maxLines: 1,
                          cursorColor: const Color(0xff5B58FF),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 8.0),
                              ),
                              hintStyle: TextStyle(
                                  color: Color(0xffCED1DA),
                                  fontWeight: FontWeight.bold,),
                              hintText:"Search"),
                        ),
                      ),
                      const SizedBox(height: 16,),
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
                                const Text("Order", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Order ID: ${data?.name ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Customer: ${data?.companyName ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Total Amount: ${data?.email ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              const Row(
                                                children: [
                                                  Text("Payment Status : ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                                  Text("Paid", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),

                                                ],
                                              ),
                                              Text("Scheduled AT : ${data?.plan ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Ordered AT : ${data?.points ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                             ],
                                          ),
                                          SizedBox(
                                            child: PopupMenuButton(
                                              iconSize: 18,
                                              icon: const Icon(Icons.more_vert_rounded, color: Colors.grey,),
                                              onSelected: (value) {},
                                              itemBuilder: (BuildContext context) => [],
                                            ),
                                          ),],),],);}),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
