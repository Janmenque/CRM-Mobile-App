import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/adjustment/provider/adjustment_list_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';

class AdjustmentList extends StatelessWidget {
  const AdjustmentList({
    super.key,
    required this.provider,
  });

  final AdjustmentListProvider provider;

  @override
  Widget build(BuildContext context) {
    final adjustments = provider.adjustmentResponse?.data?.adjustments;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        provider.isLoading ? const CustomListShimer() :
        adjustments?.isNotEmpty == true ?
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: adjustments?.length ?? 0,
            itemBuilder: (BuildContext context, int index){
              final data = adjustments?[index];
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data?.products != null ? Text(overflow: TextOverflow.ellipsis, data?.products?[0].name ?? "",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),) : const SizedBox(),
                    const SizedBox(height: 14,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex : 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Reference", style: TextStyle(color: Colors.grey, fontSize: 12),),
                              Text(data?.referenceNo ?? "", style: const TextStyle(color: Colors.black, fontSize: 12),)
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex : 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Warehouse", style: TextStyle(color: Colors.grey, fontSize: 12),),
                              Text(data?.warehouse ?? "", style: const TextStyle(color: Colors.black, fontSize: 12),)
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Date", style: TextStyle(color: Colors.grey, fontSize: 12),),
                            Text(provider.formatDate(provider.parseCustomDate(data?.date ?? "")), style: const TextStyle(color: Colors.green, fontSize: 12),),
                            Text(provider.formatTime(provider.parseCustomDate(data?.date ?? "")), style: const TextStyle(color: Colors.green, fontSize: 12),)
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(height: 10,),
                    Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Colors.grey,),
                    const SizedBox(height: 10,),
                    Text(textAlign: TextAlign.start,data?.note ?? ""),

                  ],
                ),
              );
            }) : const NoDataFoundWidget(),
      ],
    );
  }
}