import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_sales/create_quotation_all_dropdown_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/quotation_product_info_model.dart';
import 'package:hrm_app/data/model/crm_sales/quotation_product_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/quotation/provider/quotation_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddQuotationProvider extends ChangeNotifier{

  CreateQuotationAllDropdownListModel? createQuotationAllDropdownListResponse;
  QuotationProductListModel? quotationProductListResponse;
  QuotationProductInfoModel? quotationProductInfoResponse;

  final  quantityController = TextEditingController();
  final  orderDiscountController = TextEditingController();
  final  shippingCostController = TextEditingController();
  final  noteController = TextEditingController();

  Value? quotationBiller;
  Value? warehouse;
  Value? customer;
  Value? quotationSupplier;
  Value? tax;
  Value? status;
  QuotationProduct? quotationProduct;

  File? imagePath;

  int quantity = 0;
  Timer? debounce;

  AddQuotationProvider(){
    getQuotationAllDropdownList();
  }

  void setQuantity(int? value, QuotationProduct? quotationProduct, int? customerId) {
    quantity = value ?? 0;
    notifyListeners();
    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 1000), () {
      getQuotationProductInfo(value!, quotationProduct!, customer?.id ?? 0);
    });
  }


  ///quotation product info
  getQuotationProductInfo(int quantity, QuotationProduct product, int customerId) async {
    final response = await CRMSalesRepository.getQuotationProductInfoData(quantity, product, customer?.id ?? 0);
    if(response.result == true){
      quotationProductInfoResponse = response.data;
    }
    notifyListeners();
  }



  ///get Quotation dropdown list
  getQuotationAllDropdownList() async {
    final response = await CRMSalesRepository.getQuotationAllDropdownListData();
    if(response.result == true){
      createQuotationAllDropdownListResponse = response.data;
    }
    notifyListeners();
  }


  selectQuotationBiller(Value billerValue){
    quotationBiller = billerValue;
    notifyListeners();
  }


  selectWarehouse(Value warehouseValue){
    warehouse = warehouseValue;
    notifyListeners();
    getQuotationProducts(warehouse?.id ?? 0);
    quotationProduct =  null;
    notifyListeners();
  }


  selectCustomer(Value customerValue){
    customer = customerValue;
    notifyListeners();
  }


  selectQuotationSupplier(Value supplierValue){
    quotationSupplier = supplierValue;
    notifyListeners();
  }

  selectTax(Value taxValue){
    tax = taxValue;
    notifyListeners();
  }

  selectStatus(Value statusValue){
    status = statusValue;
    notifyListeners();
  }


  ///get Quotation product list
  getQuotationProducts(int warehouseId) async {
    final response = await CRMSalesRepository.getQuotationProductListData(warehouseId);
    if(response.result == true){
      quotationProductListResponse = response.data;
    }
    notifyListeners();
  }


  selectQuotationProduct(QuotationProduct quotationProductValue){
    quotationProduct = quotationProductValue;
    notifyListeners();
  }


  Future addQuotation(context) async {
    var fileName = imagePath?.path.split('/').last;
    final data = FormData.fromMap({
      "biller_id" : quotationBiller?.id,
      "supplier_id" : quotationSupplier?.id,
      "customer_id" : customer?.id,
      "warehouse_id" : warehouse?.id,
      "qty" : quantity,
      "product_code" : quotationProduct?.productCode,
      "product_id" : quotationProduct?.productId,
      "sale_unit" : quotationProductInfoResponse?.data?.purchaseUnit,
      "net_unit_price" : quotationProductInfoResponse?.data?.netUnitPrice,
      "discount" : orderDiscountController.text,
      "tax_rate" : quotationProductInfoResponse?.data?.taxRate,
      "tax" : quotationProductInfoResponse?.data?.tax,
      "subtotal" : quotationProductInfoResponse?.data?.subTotal,
      'total_qty' : quantity,
      "total_discount" : orderDiscountController.text,
      "total_tax" : quotationProductInfoResponse?.data?.tax,
      "total_price" : quotationProductInfoResponse?.data?.subTotal,
      "item" : 1,
      "grand_total" : quotationProductInfoResponse?.data?.subTotal,
      "shipping_cost" : shippingCostController.text,
      "quotation_status" : status?.id,
      "note" : noteController.text,
      "document" : await MultipartFile.fromFile(imagePath!.path, filename: fileName)
    });
    final response = await CRMSalesRepository.postAddQuotation(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<QuotationListProvider>(context, listen: false).getPurchaseList();
      Navigator.pop(context);
      notifyListeners();
    } else if(response.httpCode == 422){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    } else if(response.httpCode == 400){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    }
    else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
    }

  }


  ///image picker
  Future<dynamic> pickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            imagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            imagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }


}