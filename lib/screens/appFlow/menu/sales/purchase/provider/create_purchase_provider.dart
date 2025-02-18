import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_sales/purchase_product_info_model.dart';
import 'package:hrm_app/data/model/crm_sales/purchase_product_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/supplier_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/warehouse_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/purchase/provider/purchase_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreatePurchaseProvider extends ChangeNotifier{

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController shippingCostController = TextEditingController();
  final TextEditingController noteController = TextEditingController();


  PurchaseProductInfoModel? purchaseProductInfoResponse;

  PurchaseProductListModel? purchaseProductListResponse;
  SupplierListModel? supplierListResponse;

  WareHouseListModel? wareHouseListResponse;
  Warehouse? warehouse;

  Tax? tax;
  Tax? purchaseStatus;
  PurchaseProduct? purchaseProduct;
  Supplier? supplier;

  String? selectedDate;
  DateTime? date;

  File? imagePath;

  int quantity = 0;
  Timer? debounce;

  CreatePurchaseProvider(){
    getPurchaseProducts();
    getSuppliers();
    getWarehouseList();
  }


  void setQuantity(int? value, PurchaseProduct? purchaseProduct, ) {
    quantity = value ?? 0;
    notifyListeners();
    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 1000), () {
      getPurchaseProductInfo(value!, purchaseProduct!);
    });

  }


  ///date selection
  Future selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        date = date;
        selectedDate = DateFormat('yyyy-MM-dd').format(date);
        if (kDebugMode) {
          print(DateFormat('yyyy-MM-dd').format(date));
        }
        notifyListeners();
      }
    });
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


  ///get purchase product list
  getPurchaseProducts() async {
    final response = await CRMSalesRepository.getPurchaseProducts();
    if(response.result == true){
      if (kDebugMode) {
        print(response.data?.data);
      }
      purchaseProductListResponse = response.data;
    }
    notifyListeners();
  }


  ///get supplier list
  getSuppliers() async {
    final response = await CRMSalesRepository.getSuppliers();
    if(response.result == true){
      supplierListResponse = response.data;
    }
    notifyListeners();
  }

  ///warehouse list
  getWarehouseList() async {
    final response = await CRMSalesRepository.getWarehouseListData();
    if(response.result == true){
      wareHouseListResponse = response.data;
    }
    notifyListeners();
  }


  ///purchase product info
  getPurchaseProductInfo(int quantity, PurchaseProduct product) async {
    final response = await CRMSalesRepository.getPurchaseProductInfoData(quantity, product);
    if(response.result == true){
      purchaseProductInfoResponse = response.data;
    }
    notifyListeners();
  }


  selectWarehouse(Warehouse warehouseValue){
    warehouse = warehouseValue;
    notifyListeners();
  }


  selectTax(Tax taxValue){
    tax = taxValue;
    notifyListeners();
  }


  selectPurchaseProduct(PurchaseProduct purchaseProductValue){
    purchaseProduct = purchaseProductValue;
    notifyListeners();
  }


  selectPurchaseStatus(Tax taxValue){
    purchaseStatus = taxValue;
    notifyListeners();
  }


  selectSupplier(Supplier supplierValue){
    supplier = supplierValue;
    notifyListeners();
  }


  Future addPurchase(context) async {
    var fileName = imagePath?.path.split('/').last;
    final data = FormData.fromMap({
      "created_at" : selectedDate,
      "warehouse_id" : warehouse?.id,
      "supplier_id" : supplier?.id,
      "qty" : quantity,
      "status" : purchaseStatus?.id,
      "product_code" : purchaseProduct?.code,
      "product_id" : purchaseProduct?.id,
      "purchase_unit" : purchaseProductInfoResponse?.data?.purchaseUnit,
      "net_unit_cost" : purchaseProductInfoResponse?.data?.netUnitCost,
      "tax_rate" : purchaseProductInfoResponse?.data?.taxRate,
      "tax" : purchaseProductInfoResponse?.data?.tax,
      "subtotal" : purchaseProductInfoResponse?.data?.subTotal,
      "grand_total" : purchaseProductInfoResponse?.data?.subTotal,
      "shipping_cost" : shippingCostController.text,
      "note" : noteController.text,
      "document" : await MultipartFile.fromFile(imagePath!.path, filename: fileName)
    });
    final response = await CRMSalesRepository.postAddPurchase(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<PurchaseListProvider>(context, listen: false).getPurchaseList();
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


}