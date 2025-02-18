import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/mailbox/compose_contract_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_estimate_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_invoice_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_lead_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_note_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_project_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_project_payment_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_proposal_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_sale_payment_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_task_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_ticket_list.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/compose_type_horizontal_list.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/mailbox_multiselect_cc.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/mailbox_multiselect_recipients.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/compose_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Compose Mail", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ComposeProvider(),
        child: Consumer<ComposeProvider>(
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ComposeTypeHorizontalList(provider: provider),
                      provider.selectComposeType == "project" ?
                      CustomDropdown<ComposeProject>(
                        value: provider.composeProject,
                        labelText: 'Select project',
                        items: provider.composeMailProjectListResponse?.data ?? [],
                        onChanged: (ComposeProject? newValue) {
                          provider.selectedComposeProject(newValue!);
                        },
                        itemLabelBuilder: (ComposeProject value) => value.name ?? '',
                      ) : const SizedBox(),

                      provider.selectComposeType == "task" ?
                      CustomDropdown<ComposeTask>(
                        value: provider.composeTask,
                        labelText: 'Select Task',
                        items: provider.composeMailTaskListResponse?.data ?? [],
                        onChanged: (ComposeTask? newValue) {
                          provider.selectedComposeTask(newValue!);
                        },
                        itemLabelBuilder: (ComposeTask value) => value.name ?? '',
                      ) : const SizedBox(),

                      provider.selectComposeType == "lead" ?
                      CustomDropdown<ComposeLead>(
                        value: provider.composeLead,
                        labelText: 'Select Lead',
                        items: provider.composeMailLeadListResponse?.data ?? [],
                        onChanged: (ComposeLead? newValue) {
                          provider.selectedComposeLead(newValue!);
                        },
                        itemLabelBuilder: (ComposeLead value) => value.name ?? '',
                      ) : const SizedBox(),


                      provider.selectComposeType == "invoice" ?
                      CustomDropdown<ComposeInvoice>(
                        value: provider.composeInvoice,
                        labelText: 'Select Invoice',
                        items: provider.composeMailInvoiceListResponse?.data ?? [],
                        onChanged: (ComposeInvoice? newValue) {
                          provider.selectedComposeInvoice(newValue!);
                        },
                        itemLabelBuilder: (ComposeInvoice value) => value.invoiceNo ?? '',
                      ) : const SizedBox(),

                      provider.selectComposeType == "estimate" ?
                      CustomDropdown<ComposeEstimate>(
                        value: provider.composeEstimate,
                        labelText: 'Select Estimate',
                        items: provider.composeMailEstimateListResponse?.data ?? [],
                        onChanged: (ComposeEstimate? newValue) {
                          provider.selectedComposeEstimate(newValue!);
                        },
                        itemLabelBuilder: (ComposeEstimate value) => value.invoiceNo ?? '',
                      ) : const SizedBox(),

                      provider.selectComposeType == "proposal" ?
                      CustomDropdown<ComposeProposal>(
                        value: provider.composeProposal,
                        labelText: 'Select Proposal',
                        items: provider.composeMailProposalListResponse?.data ?? [],
                        onChanged: (ComposeProposal? newValue) {
                          provider.selectedComposeProposal(newValue!);
                        },
                        itemLabelBuilder: (ComposeProposal value) => value.invoiceNo ?? '',
                      ) : const SizedBox(),

                      provider.selectComposeType == "note" ?
                      CustomDropdown<ComposeNote>(
                        value: provider.composeNote,
                        labelText: 'Select Note',
                        items: provider.composeMailNoteListResponse?.data ?? [],
                        onChanged: (ComposeNote? newValue) {
                          provider.selectedComposeNote(newValue!);
                        },
                        itemLabelBuilder: (ComposeNote value) => value.description ?? '',
                      ) : const SizedBox(),

                      provider.selectComposeType == "contract" ?
                      CustomDropdown<ComposeContract>(
                        value: provider.composeContract,
                        labelText: 'Select Contract',
                        items: provider.composeMailContractListResponse?.data ?? [],
                        onChanged: (ComposeContract? newValue) {
                          provider.selectedComposeContract(newValue!);
                        },
                        itemLabelBuilder: (ComposeContract value) => value.client?.name ?? '',
                      ) : const SizedBox(),

                      provider.selectComposeType == "ticket" ?
                      CustomDropdown<ComposeTicket>(
                        value: provider.composeTicket,
                        labelText: 'Select Ticket',
                        items: provider.composeMailTicketListResponse?.data ?? [],
                        onChanged: (ComposeTicket? newValue) {
                          provider.selectedComposeTicket(newValue!);
                        },
                        itemLabelBuilder: (ComposeTicket value) => value.subject ?? '',
                      ) : const SizedBox(),

                      provider.selectComposeType == "project_Payment" ?
                      CustomDropdown<ComposeProjectPayment>(
                        value: provider.composeProjectPayment,
                        labelText: 'Select Project Payment',
                        items: provider.composeMailProjectPaymentListResponse?.data ?? [],
                        onChanged: (ComposeProjectPayment? newValue) {
                          provider.selectedComposeProjectPayment(newValue!);
                        },
                        itemLabelBuilder: (ComposeProjectPayment value) => value.project?.name ?? '',
                      ) : const SizedBox(),


                      provider.selectComposeType == "sale_payment" ?
                      CustomDropdown<ComposeSalePayment>(
                        value: provider.composeSalePayment,
                        labelText: 'Select Project Payment',
                        items: provider.composeMailSalePaymentListResponse?.data ?? [],
                        onChanged: (ComposeSalePayment? newValue) {
                          provider.selectedComposeSalePayment(newValue!);
                        },
                        itemLabelBuilder: (ComposeSalePayment value) => value.paymentReference ?? '',
                      ) : const SizedBox(),


                      const SizedBox(height: 14),
                      MailboxMultiselectRecipients(provider: provider,),
                      const SizedBox(height: 8),
                      MailboxMultiselectCC(provider: provider),
                      const SizedBox(height: 8),
                      NewTextField(labelText: "Enter Subject", controller: provider.subjectController,),
                      const SizedBox(height: 8),
                      ///upload images
                      InkWell(
                        onTap: () => provider.pickComposeAttachment(context),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    border: Border.all(color: Colors.grey, width: 1)
                                ),
                                child: const Text("Upload Image", style: TextStyle(color: Colors.grey),),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                              decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  border: Border.all(color: Colors.grey, width: 1)
                              ),
                              child: const Text("Browse", style: TextStyle(color: Colors.grey),),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12,),
                      provider.mailAttachmentImages.isNotEmpty ?
                      Wrap(
                        children: List.generate(provider.mailAttachmentImages.length, (index){
                          return
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 14, bottom: 14),
                                  child: Image.file(
                                    provider.mailAttachmentImages[index],
                                    height: 60, width: 60, fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: -10,
                                  child: InkWell(
                                    onTap: ()=> provider.removeImage(index),
                                    child: Card(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration:  BoxDecoration(
                                          color:  Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: const Offset(1, 1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Icon(Icons.close, color: Colors.red, size: 10,),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                        }),
                      ) :
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index){
                              return  SizedBox(
                                height: 60,
                                width: 60,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(14.sp),
                                      margin: const EdgeInsets.only(top: 6),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffF5F5F5),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: const Icon(Icons.photo_camera_back, color: Colors.grey,),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: -3,
                                      child: Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration:  BoxDecoration(
                                            color:  Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: const Offset(1, 1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: const Icon(Icons.close, color: Colors.black,size: 10,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      const SizedBox(height: 8),
                      NewTextField(labelText: "Message", maxLine: 4, controller: provider.messageController,),
                      Padding(
                        padding: const EdgeInsets.symmetric( vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                               provider.postCompose(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
