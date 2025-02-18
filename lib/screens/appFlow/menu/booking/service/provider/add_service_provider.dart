
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/service/service_create_compoment_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/service/provider/service_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddServiceProvider extends ChangeNotifier{

  ServiceCreateComponentModel? serviceCreateComponentResponse;

  final TextEditingController tagController = TextEditingController();

  final serviceNameController = TextEditingController();
  final serviceTaxPercentageController = TextEditingController();
  final minimumBiddingPriceController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final longDescriptionController = TextEditingController();




  ServiceCategory? category;
  List<ServiceSubCategory>? subCategories;
  ServiceSubCategory? subCategory;
  Zone? zone;
  List<String> statusList = ['Active', 'Inactive'];
  String? status;

  File? thumbnailImagePath;
  File? coverImagePath;

  List<String> tags = [];


  AddServiceProvider(){
    getCreateServiceComponentList();
  }



  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
      notifyListeners();
    }
  }


  void removeTag(String tag) {
    tags.remove(tag);
    notifyListeners();
  }




  getCreateServiceComponentList() async {
    final response = await CRMSalesRepository.getCreateServiceComponentListData();
    if(response.result == true){
      serviceCreateComponentResponse = response.data;
      notifyListeners();
    }
  }


  selectCategory(ServiceCategory categoryValue){
    category = categoryValue;
    subCategories = categoryValue.subCategories;
    subCategory = null;
    notifyListeners();
  }


  selectSubCategory(ServiceSubCategory subCategoryValue){
    subCategory = subCategoryValue;
    notifyListeners();
  }


  selectZone(Zone zoneValue){
    zone = zoneValue;
    notifyListeners();
  }


  selectStatus(String statusValue){
    status = statusValue;
    notifyListeners();
  }


  ///thumbnailImage picker
  Future<dynamic> pickThumbnailImage(BuildContext context) async {
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
            thumbnailImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            thumbnailImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }


  ///coverImage picker
  Future<dynamic> pickCoverImage(BuildContext context) async {
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
            coverImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            coverImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }



  ///create service method
  Future createService(context) async {
    var thumbnailFile = thumbnailImagePath!.path.split('/').last;
    var coverImageFile = coverImagePath!.path.split('/').last;
    final data = FormData.fromMap({
      "name": serviceNameController.text,
      "category_id": category?.id,
      "sub_category_id": subCategory?.id,
      "tax_percentage": serviceTaxPercentageController.text,
      "minimum_bidding_price": minimumBiddingPriceController.text,
      "tags": tags.join(","),
      "short_description": shortDescriptionController.text,
      "long_description": longDescriptionController.text,
      "thumbnail_image":  await MultipartFile.fromFile(thumbnailImagePath!.path, filename: thumbnailFile),
      "cover_image": await MultipartFile.fromFile(coverImagePath!.path, filename: coverImageFile),
      "status": status == "Active" ? 1 : 0
    });
    final response = await CRMSalesRepository.postCreateService(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<ServiceListProvider>(context, listen: false).getServiceList();
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