import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/title_and_add_button.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../sales/product/content/product_create_and_search_content.dart';

class ContractTypeList extends StatelessWidget {

  const ContractTypeList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<ContractListProvider>(
      builder: (context, provider, _) {
        final contractTypeList = provider.crmCreateContractComponentResponse?.data?.contractType;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TitleAndAddContent(
                    title: "Create Contract",
                    onTap:(){
                      addContractTypeDialog(context, provider);
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
                          const Text("Contract Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text("Total : ${contractTypeList?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                      const SizedBox(height: 14,),
                      contractTypeList?.isNotEmpty == true ?
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: contractTypeList?.length,
                          itemBuilder: (BuildContext context, int index){
                            final data = contractTypeList?[index];
                            return InkWell(
                              onTap: (){},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex : 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Id", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                            Text("Name", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex : 4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(": ${data?.id}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                            Text(": ${data?.name}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                          ],
                                        ),
                                      ),
                                      ],),
                                const SizedBox(height: 14,)],),
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

  void addContractTypeDialog(BuildContext parentContext, ContractListProvider? provider ) {
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
                    'Add Contract Type',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                content: Consumer<ContractListProvider>(
                  builder: (_, provider, __) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          NewTextField(labelText: "Enter Name", controller: provider.contractTypeNameController, ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: ElevatedButton(
                                onPressed: ()=> provider.addContractType(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff5B58FF),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
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
            },
          ),
        );
      },
    );
  }

}
