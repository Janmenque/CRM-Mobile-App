
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_renewal_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';

class ContractRenewalList extends StatelessWidget {
  int contractId;
  ContractRenewalList({super.key, required this.contractId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractRenewalProvider>(
        builder: (context, provider, _) {
          final renewals = provider.contractRenewalsListResponse?.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductCreateAndSearchContent(
                    onTap: ()=> createContractRenewalDialog(context, provider, contractId),
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
                            const Text("Contract Renewal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("Total : ${renewals?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 14,),
                        Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                        renewals?.isNotEmpty == true ?
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: renewals?.length ?? 0,
                            itemBuilder: (BuildContext context, int index){
                              final data = renewals?[index];
                              return InkWell(
                                onTap: (){},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 14,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Start Date: ${data?.startDate ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            Text("End Date: ${data?.endDate ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            Text("Contract Value: ${data?.contractValue ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            Text("Created at: ${data?.created ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),

                                          ],
                                        ),
                                        SizedBox(
                                          child: PopupMenuButton(
                                            iconSize: 18,
                                            icon: const Icon(Icons.more_vert_rounded, color: Colors.grey,),
                                            onSelected: (value) {},
                                            itemBuilder: (BuildContext context) => [],
                                          ),
                                        ),],),],),
                              );}) : const NoDataFoundWidget(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  void createContractRenewalDialog(BuildContext parentContext, ContractRenewalProvider provider, int contractId) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
              builder: (context) {
                return AlertDialog(
                  title: const Center(
                    child: Text(
                      'Add Renewal History',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Consumer<ContractRenewalProvider>(
                      builder: (_, provider, __) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              InkWell(
                                onTap: () => provider.selectStartDate(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                  margin: const EdgeInsets.symmetric( horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text( provider.startDate ??  "Start Date",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                      const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              InkWell(
                                onTap: () => provider.selectEndDate(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                  margin: const EdgeInsets.symmetric( horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text( provider.endDate ??  "End Date",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                      const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                                    ],
                                  ),
                                ),
                              ),
                              NewTextField(labelText: "Contract Value", controller: provider.valueController, maxLine: 3,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      provider.addContractRenewal(context, contractId);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff5B58FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      minimumSize: const Size(double.infinity, 50),
                                    ),
                                    child: const Text(
                                      "Create",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                        );
                      }
                  ),
                );
              }
          ),
        );
      },
    );
  }
}
