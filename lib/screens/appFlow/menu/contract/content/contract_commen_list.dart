
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_comment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';

class ContractCommentList extends StatelessWidget {
  int contractId;
  ContractCommentList({super.key, required this.contractId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractCommentProvider>(
        builder: (context, provider, _) {
          final comments = provider.contractCommentListResponse?.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductCreateAndSearchContent(
                    onTap: ()=> createContractCommentDialog(context, provider, contractId),
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
                            const Text("Comments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("Total : ${comments?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 14,),
                        Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                        comments?.isNotEmpty == true ?
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: comments?.length ?? 0,
                            itemBuilder: (BuildContext context, int index){
                              final data = comments?[index];
                              return InkWell(
                                onTap: (){
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Message: ${data?.message ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Created: ${data?.created ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            ],
                                          ),
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


  void createContractCommentDialog(BuildContext parentContext, ContractCommentProvider provider, int contractId) {
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
                      'Add Comment',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Consumer<ContractCommentProvider>(
                      builder: (_, provider, __) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              NewTextField(labelText: "Message", controller: provider.messageController, maxLine: 3,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      provider.addContractComment(context, contractId);
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
