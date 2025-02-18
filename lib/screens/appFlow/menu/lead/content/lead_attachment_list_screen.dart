import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_attachment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/empty_message.dart';
import 'package:provider/provider.dart';

class LeadAttachmentListScreen extends StatelessWidget {
  int leadId;

  LeadAttachmentListScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadAttachmentProvider>(builder: (context, provider, _) {
      final attachments = provider.leadsAttachmentListResponse?.data;
      return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Attachments",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        addAttachmentDialog(context, provider);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xff5B58FF),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                            Text(
                              "Create",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      margin: const EdgeInsets.symmetric( horizontal: 14),
                      decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: attachments?.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: attachments?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                final data = attachments?[index];
                                return  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Title: ${data?.title ?? "N/A"}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                              ),
                                              const Text(
                                                "Type: Image",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "File Size : ${data?.title ?? "N/A"}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Author : ${data?.author ?? "N/A"}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Date : ${data?.date ?? "N/A"}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
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
                                              itemBuilder: (BuildContext context) => [],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 14),
                                        width: MediaQuery.of(context).size.width,
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                    ],
                                  );
                              })
                          : const EmptyMessageWidget()
                    ),
            ],
          ));
    });
  }

  void addAttachmentDialog(
      BuildContext parentContext, LeadAttachmentProvider provider) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<LeadAttachmentProvider>(
                    builder: (_,provider,__){
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 5),
                            const Text(
                              "Add Attachment",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            NewTextField(labelText: "Software solution", controller: provider.softwareSolutionController,),
                            InkWell(
                              onTap: () => provider.pickLeadAttachmentImage(parentContext),
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
                            provider.leadAttachmentImagePath != null
                                ? Padding(padding: const EdgeInsets.only(left: 18.0, top: 10),
                                  child: Image.file(
                                  provider.leadAttachmentImagePath!,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                              ),
                            )
                                : const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    // Form and Image Validation
                                    if (provider.softwareSolutionController.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Software solution is required."),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else if (provider.leadAttachmentImagePath == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Image is required."),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      provider.addAttachment(context, leadId);
                                    }
                                  },
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
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
