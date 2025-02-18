import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_sales/add_product_all_dropdown_model.dart';
import 'package:hrm_app/data/model/other_unit_body.dart';
import 'package:hrm_app/data/model/other_unit_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/provider/product_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';



class AddProductProvider extends ChangeNotifier {

  AddProductAllDropdownModel? addProductAllDropdownResponse;

  final productNameController = TextEditingController();
  final productCostController = TextEditingController();
  final productPriceController = TextEditingController();
  final dailySaleController = TextEditingController();
  final alertQuantityController = TextEditingController();
  final productDetailsController = TextEditingController();

  ProductType? productType;
  BarcodeSymbology? barcodeSymbology;
  Brand? brand;
  ProductCategory? category;
  ProductUnit? productUnit;
  TaxLists? taxLists;
  TaxMethod? taxMethod;
  OtherUnitModel? otherUnitResponse;
  OtherUnit? saleUnit;
  OtherUnit? purchaseUnit;
  String productCode = "Product Code";
  bool isFeatured = false;
  bool isBarCode = false;
  bool isVariant = false;
  bool isDifferentPrice = false;
  bool isBatch = false;
  bool isImei = false;
  bool isPromotionPrice = false;
  List<File> productImages = [];
  List<XFile> listOfFile = [];
  List<MultipartFile> imageFiles = [];


  AddProductProvider(){
    getAddProductAllDropDownData();
  }

  void toggleFeatured(bool value){
    isFeatured = value;
    notifyListeners();
  }

  void toggleBarcode(bool value){
    isBarCode = value;
    notifyListeners();
  }

  void toggleVariant(bool value){
    isVariant = value;
    notifyListeners();
  }

  void toggleDifferentPrice(bool value){
    isDifferentPrice = value;
    notifyListeners();
  }

  void toggleBatch(bool value){
    isBatch = value;
    notifyListeners();
  }

  void toggleImei(bool value){
    isImei = value;
    notifyListeners();
  }

  void togglePromotionPrice(bool value){
    isPromotionPrice = value;
    notifyListeners();
  }

  String _generateRandomCode() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(8,
          (_) => characters.codeUnitAt(Random().nextInt(characters.length)),
    ));
  }

  void generateCode() {
      productCode = _generateRandomCode();
      notifyListeners();
  }


  ///add product all dropdown
  getAddProductAllDropDownData() async {
    final response = await CRMSalesRepository.getAddProductAllDropdownData();
    if(response.result == true){
      if (kDebugMode) {
        print(response.data?.data);
      }
      addProductAllDropdownResponse = response.data;
    }
    notifyListeners();
  }


  selectProductType(ProductType productTypeValue){
    productType = productTypeValue;
    notifyListeners();
  }

  selectBarcodeSymbology(BarcodeSymbology barcodeSymbologyValue){
    barcodeSymbology = barcodeSymbologyValue;
    notifyListeners();
  }

  selectBrand(Brand brandValue){
    brand = brandValue;
    notifyListeners();
  }

  selectProductCategory(ProductCategory productCategoryValue){
    category = productCategoryValue;
    notifyListeners();
  }

  selectProductUnit(ProductUnit productUnitValue ){
    productUnit = productUnitValue;
    postProductUnit(context);
    saleUnit = null;
    purchaseUnit = null;
    notifyListeners();

  }

  selectTaxLists(TaxLists taxListValue){
    taxLists = taxListValue;
    notifyListeners();
  }

  selectTaxMethod(TaxMethod taxMethodValue){
    taxMethod = taxMethodValue;
    notifyListeners();
  }

  void postProductUnit(context) async {
    var data =  OtherUnitBody( unitId:  productUnit?.id);
    var apiResponse = await CRMSalesRepository.getOtherUnit(data);
    if(apiResponse.data?.result == true){
      otherUnitResponse = apiResponse.data;
      notifyListeners();
    }

  }


  selectSaleUnit(OtherUnit saleUnitValue){
    saleUnit = saleUnitValue;
    notifyListeners();
  }

  selectPurchaseUnit(OtherUnit purchaseUnitValue){
    purchaseUnit = purchaseUnitValue;
    notifyListeners();
  }


  Future<void> pickProductImage(BuildContext context) async {
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
            if (image != null) {
              productImages.add(File(image.path));
              listOfFile.add(image);
              notifyListeners();
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            if (imageGallery != null) {
              productImages.add(File(imageGallery.path));
              listOfFile.add(imageGallery);
              notifyListeners();
            }
          },
        );
      },
    );
  }

  void removeImage(int index) {
    productImages.removeAt(index);
    notifyListeners();
  }




  Future addProduct(context) async {

    Map<String, MultipartFile> fileMap = {};
    for (int i = 0; i < listOfFile.length; i++) {
      var fileName = listOfFile[i].path.split('/').last;
      if (kDebugMode) {
        print(listOfFile[i]);
      }
      var mFile = await MultipartFile.fromFile(listOfFile[i].path, filename: fileName);
      fileMap["image[$i]"] = mFile;
    }

    final formData = FormData.fromMap({
      "name" : productNameController.text,
      "code" : productCode,
      "type" : "standard",
      "barcode_symbology" : barcodeSymbology?.value,
      "brand_id" : brand?.id,
      "category_id" : category?.id,
      "unit_id" : productUnit?.id,
      "sale_unit_id" : saleUnit?.id,
      "purchase_unit_id" : purchaseUnit?.id,
      "cost" : productCostController.text,
      "price" : productPriceController.text,
      "daily_sale_objective" : dailySaleController.text,
      "alert_quantity" : alertQuantityController.text,
      "tax_id" : taxLists?.id,
      "tax_method" : taxMethod?.value,
      "featured" : isFeatured == true ? 1 : 0,
      "is_embeded" : isBarCode == true ? 1 : 0,
      "product_details" : productPriceController.text,
      "is_diffPrice" : isDifferentPrice == true ? 1 : 0,
      "is_batch" : isBatch == true ? 1 : 0,
      "is_imei" : isImei == true ? 1 : 0,
      "promotion" : isPromotionPrice ? 1 : 0,
    });

    formData.files.addAll(fileMap.entries.map((e) => MapEntry(e.key, e.value)));

    final response = await CRMSalesRepository.postAddProduct(formData);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<ProductListProvider>(context, listen: false).getProductList();
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

