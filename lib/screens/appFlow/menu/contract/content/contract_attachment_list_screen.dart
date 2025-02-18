import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_attachment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';

class ContractAttachmentListScreen extends StatelessWidget {
  int contractId;
  ContractAttachmentListScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractAttachmentProvider>(
      builder: (context, provider, _) {
        final attachments = provider.contractAttachmentListResponse?.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProductCreateAndSearchContent(
                  onTap: ()=> createContractAttachmentDialog(context, provider, contractId),
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
                          const Text("Contract Attachments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text("Total : ${attachments?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                      attachments?.isNotEmpty == true ?
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: attachments?.length ?? 0,
                          itemBuilder: (BuildContext context, int index){
                            final data = attachments?[index];
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
                                          Text("Title: ${data?.title ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                          const SizedBox(height: 5),
                                          CachedNetworkImage(
                                            height: 50, width: 50, fit: BoxFit.cover, imageUrl: data?.attachmentFile ?? "",
                                            placeholder: (context, url) => Center(child: Image.asset("assets/images/app_logo.png"),),
                                            errorWidget: (context, url, error) => Image.asset("assets/images/app_logo.png",fit: BoxFit.cover,),
                                          ),
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

  void createContractAttachmentDialog(BuildContext parentContext, ContractAttachmentProvider provider, int contractId) {
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
                      'Add Attachment',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Consumer<ContractAttachmentProvider>(
                      builder: (_, provider, __) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              NewTextField(labelText: "Title", controller: provider.titleController,),
                              InkWell(
                                onTap: () => provider.pickContractAttachmentImage(parentContext),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 12),
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                              ),
                                              border: Border.all(color: Colors.grey, width: 1)),
                                          child: const Text(
                                            "Image",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 12),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF5F5F5),
                                            borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
                                            border: Border.all(
                                                color: Colors.grey, width: 1)),
                                        child: const Text(
                                          "Browse",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              provider.contractAttachmentImagePath != null
                                  ? Padding(padding: const EdgeInsets.only(left: 18.0, top: 10),
                                child: Image.file(
                                  provider.contractAttachmentImagePath!,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ) : const SizedBox(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      provider.addContractAttachment(context, contractId);
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
