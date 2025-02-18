import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_contract/all_contract_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/view/add_contract.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/view/contract_view_screen.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/title_and_add_button.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import '../../sales/product/content/product_create_and_search_content.dart';

class ContractList extends StatelessWidget {
  List<Contract>? contracts;
  ContractList({super.key, required this.contracts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [

            TitleAndAddContent(
              title: "Create Contract",
                onTap:(){
                  NavUtil.navigateScreen(context, const AddContract());
                }
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
                      const Text("Contracts", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      Text("Total : ${contracts?.length ?? 0}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                  contracts?.isNotEmpty == true ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: contracts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index){
                        final data = contracts?[index];
                        return InkWell(
                          onTap: (){
                              NavUtil.navigateScreen(context, ContractViewScreen(contractId: data?.id ?? 0,));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 14,),
                              Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                              const SizedBox(height: 14,),
                              Row(
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Client Name", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                        Text("Subject", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                        Text("Type", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                        Text("Amount", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                        Text("Start Date", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                        Text("End Date", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(": ${data?.clientName ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:AppColors.colorPrimary),),
                                        Text(": ${data?.subject ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                        Text(": ${data?.contractType ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                        Text(": ${data?.amount ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                        Text(": ${data?.startDate ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                        Text(": ${data?.endDate ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                      ],
                                    ),
                                  ),
                                ],),],),
                        );}) : const NoDataFoundWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



}
