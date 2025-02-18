import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_sales/add_sale_all_dropdown_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/sale_product_info_model.dart';
import 'package:hrm_app/data/model/crm_sales/sale_product_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sale/provider/sale_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddSaleProvider extends ChangeNotifier{

  AddSalesAllDropdownListModel? addSalesAllDropdownListResponse;

  SaleProductListModel? saleProductListResponse;

  SaleProductInfoModel? saleProductInfoResponse;

  final referenceController = TextEditingController();
  final discountValueController = TextEditingController();
  final shippingCostController = TextEditingController();
  final saleNoteController = TextEditingController();
  final staffNoteController = TextEditingController();

  SaleProduct? saleProduct;

  String? monthYear;
  DateTime? selectedDate;

  File? imagePath;

  int quantity = 0;
  Timer? debounce;

  SaleData? biller;
  SaleData? warehouse;
  SaleData? customer;
  SaleData? tax;
  DiscountType? discountType;
  SaleData? saleStatus;
  SaleData? paymentStatus;


  AddSaleProvider(){
    getAddSaleAllDropDownData();
  }


  selectWarehouse(SaleData warehouseValue){
    warehouse = warehouseValue;
    getSaleProductListData(warehouse?.id ?? 0);
    saleProduct = null;
    notifyListeners();
  }

  selectCustomer(SaleData customerValue){
    customer = customerValue;
    saleProduct = null;
    notifyListeners();

  }

  selectTax(SaleData taxValue){
    tax = taxValue;
    notifyListeners();
  }

  selectDiscountType(DiscountType discountTypeValue){
    discountType = discountTypeValue;
    notifyListeners();
  }

  selectSaleStatus(SaleData saleStatusValue){
    saleStatus = saleStatusValue;
    notifyListeners();
  }

  selectPaymentStatus(SaleData paymentStatusValue){
    paymentStatus = paymentStatusValue;
    notifyListeners();
  }

  selectBiller(SaleData billerValue){
    biller = billerValue;
    notifyListeners();
  }

  selectSaleProduct(SaleProduct saleProductValue){
    saleProduct = saleProductValue;
    notifyListeners();
  }

  Future selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        monthYear = DateFormat('yyyy-MM-dd').format(selectedDate!);
        if (kDebugMode) {
          print(DateFormat('yyyy-MM-dd').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }


  ///set product quantity
  void setQuantity(int? value, SaleProduct? purchaseProduct, int? customerId ) {
    quantity = value ?? 0;
    notifyListeners();
    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 1000), () {
      getSaleProductInfo(value, purchaseProduct,customerId);
    });
  }


  ///purchase product info
  getSaleProductInfo(int? quantity, SaleProduct? product, int? customerId) async {
    final response = await CRMSalesRepository.getSaleProductInfoData(quantity, product, customerId);
    if(response.result == true){
      saleProductInfoResponse = response.data;
    }
    notifyListeners();
  }



  ///add sale all dropdown
  getAddSaleAllDropDownData() async {
    final response = await CRMSalesRepository.getAddSaleAllDropdownData();
    if(response.result == true){
      if (kDebugMode) {
        print(response.data?.data);
      }
      addSalesAllDropdownListResponse = response.data;
    }
    notifyListeners();
  }


  ///get sale product list
  getSaleProductListData(int warehouseId) async {
    final response = await CRMSalesRepository.getSaleProductListData(warehouseId);
    if(response.result == true){
      saleProductListResponse = response.data;
    }
    notifyListeners();
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



  Future addSale(context) async {
    var fileName = imagePath?.path.split('/').last;
    final data = FormData.fromMap({
      "created_at" : monthYear,
      "reference_no" : referenceController.text,
      "customer_id" : customer?.id,
      "warehouse_id" : warehouse?.id,
      "biller_id" : biller?.id,
      "qty" : quantity,
      "product_code" : saleProductInfoResponse?.data?.code,
      "product_id" : saleProduct?.productId,
      "sale_unit" : saleProductInfoResponse?.data?.saleUnit,
      "net_unit_price" : saleProductInfoResponse?.data?.netUnitPrice,
      "discount" : 0,
      "tax_rate" : saleProductInfoResponse?.data?.taxRate,
      "tax" : saleProductInfoResponse?.data?.tax,
      "subtotal" : saleProductInfoResponse?.data?.subTotal,
      'total_qty' : quantity,
      "total_discount" : 0,
      "total_tax" : saleProductInfoResponse?.data?.tax,
      "total_price" : saleProductInfoResponse?.data?.subTotal,
      "item" : 1,
      "order_tax" : saleProductInfoResponse?.data?.tax,
      "grand_total" : saleProductInfoResponse?.data?.subTotal,
      "pos" : 0,
      "order_tax_rate" : saleProductInfoResponse?.data?.taxRate,
      "order_discount_type" : discountType?.name,
      "order_discount_value" : discountValueController.text,
      "shipping_cost" : shippingCostController.text,
      "sale_status" : saleStatus?.id,
      "payment_status" : paymentStatus?.id,
      "sale_note" : saleNoteController.text,
      "staff_note" : staffNoteController.text,
      "coupon_active" : 0,
      "document" : await MultipartFile.fromFile(imagePath!.path, filename: fileName)
    });
    final response = await CRMSalesRepository.postAddSale(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<SaleListProvider>(context, listen: false).getSaleList();
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