import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_sales/product_list_accourding_warehouse_model.dart';
import 'package:hrm_app/data/model/crm_sales/warehouse_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/adjustment/provider/adjustment_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddAdjustmentProvider extends ChangeNotifier{

  final quantityController = TextEditingController();
  final noteController = TextEditingController();

  WareHouseListModel? wareHouseListResponse;
  Warehouse? warehouse;

  ProductListAccordingWarehouseModel? productListAccordingWarehouseResponse;
  WareHouseProduct? wareHouseProduct;

  List<String> actionList = ["Addition", "Subtraction"];
  String? action;

  File? imagePath;

  AddAdjustmentProvider(){
    getWarehouseList();
  }



  ///warehouse list
  getWarehouseList() async {
    final response = await CRMSalesRepository.getWarehouseListData();
    if(response.result == true){
      wareHouseListResponse = response.data;
    }
    notifyListeners();
  }


  /// productList according warehouse
  getWarehouseProductList(int? warehouseId) async {
    final response = await CRMSalesRepository.getWarehouseProductListData(warehouseId ?? 0);
    if(response.result == true){
      productListAccordingWarehouseResponse = response.data;
    }
    notifyListeners();
  }


  selectWarehouse(Warehouse warehouseValue){
    warehouse = warehouseValue;
    getWarehouseProductList(warehouse?.id);
    wareHouseProduct = null;
    notifyListeners();
  }


  selectWarehouseProduct(WareHouseProduct wareHouseProductValue){
    wareHouseProduct = wareHouseProductValue;
    notifyListeners();

  }

  selectAction(String selectionValue){
    action = selectionValue;
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


  ///add adjustment
  Future addAdjustment(context) async {
    var fileName = imagePath!.path.split('/').last;
    final data = FormData.fromMap({
      "warehouse_id": warehouse?.id,
      "product_code": wareHouseProduct?.code,
      "document": await MultipartFile.fromFile(imagePath!.path, filename: fileName),
      "action" : action == "Addition" ? "+" : "-",
      "qty": quantityController.text,
      "note": noteController.text
    });
    final response = await CRMSalesRepository.postAddAdjustment(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<AdjustmentListProvider>(context, listen: false).getAdjustmentList();
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