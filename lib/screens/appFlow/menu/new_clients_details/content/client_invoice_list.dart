
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/invoice_pdf_generator.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_invoice_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/screen/client_create_invoice_screen.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';


class ClientInvoiceListScreen extends StatelessWidget {
  int clientId;
  ClientInvoiceListScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientInvoiceListProvider>(
        builder: (context, provider, _) {
          final invoiceList = provider.clientInvoiceListResponse?.data?.data;
          return SingleChildScrollView(
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Invoice", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          InkWell(
                            onTap: ()=> NavUtil.navigateScreen(context,  ClientCreateInvoiceScreen(clientId: clientId,)),

                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                              decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8)),
                              child: const Row(
                                children: [
                                  Icon(Icons.add, size: 14, color: Colors.white,),
                                  Text("Create", style: TextStyle(color: Colors.white, fontSize: 12),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    provider.isLoading ? const CustomListShimer() :
                    invoiceList?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: invoiceList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data = invoiceList?[index];
                          return InkWell(
                            onTap: () async {
                              final invoiceData = {
                                'invoiceNo': data?.invoiceNo ?? '',
                                'paidAmount': data?.paidAmount ?? '',
                                'orderDiscount': data?.orderDiscount ?? '',
                                'createdAt': provider.formatDate(provider.parseCustomDate(data?.createdAt.toString() ?? "")),
                                'status': data?.status?.name ?? '',
                              };

                              final pdfFile = await InvoicePdfGenerator.generateInvoicePdf(invoiceData);
                              if (pdfFile != null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Invoice PDF"),
                                    content: const Text("Invoice PDF has been generated successfully."),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          // Open the PDF file
                                          await OpenFile.open(pdfFile.path);
                                        },
                                        child: const Text("Open"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Failed to generate invoice PDF.")),
                                );
                              }
                            },
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Invoice No ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Amount", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Discount", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Date", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Payment Status", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(": ${data?.invoiceNo ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                               const Row(
                                                  children: [
                                                    Icon(Icons.picture_as_pdf_outlined, size: 18, color:AppColors.colorPrimary,),
                                                    SizedBox(width: 4,),
                                                    Text("PDF Generate", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),)
                                                  ],
                                                )
                                                ],
                                              ),
                                              Text(": ${data?.grandTotal ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.orderDiscount ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${provider.formatDate(provider.parseCustomDate(data?.createdAt.toString() ?? ""))}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              data?.status != null ?
                                              Text(": ${data?.status?.name ?? ""}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  provider.hexToColor(data?.status?.colorCode ?? "#000000")),)
                                                  : Text(": N/A", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:  provider.hexToColor(data?.status?.colorCode ?? "#000000")),),
                                            ],
                                          ),
                                        ),
                                      ],),
                                  ],),
                              ),
                            ),
                          );}) : const NoDataFoundWidget(),


                  ],
                ),
              )
          );
        }
    );
  }
}
