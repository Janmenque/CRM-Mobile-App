import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoicePdfGenerator {
  static Future<File?> generateInvoicePdf(Map<String, dynamic> invoiceData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Invoice", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text("Invoice No: ${invoiceData['invoiceNo']}"),
              pw.Text("Amount: ${invoiceData['paidAmount']}"),
              pw.Text("Discount: ${invoiceData['orderDiscount']}"),
              pw.Text("Date: ${invoiceData['createdAt']}"),
              pw.Text("Payment Status: ${invoiceData['status']}"),
              pw.SizedBox(height: 20),
              pw.Text("Thank you for your business!", style: const pw.TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );

    try {
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/invoice_${invoiceData['invoiceNo']}.pdf");
      await file.writeAsBytes(await pdf.save());
      return file;
    } catch (e) {
      print("Error generating PDF: $e");
      return null;
    }
  }
}
