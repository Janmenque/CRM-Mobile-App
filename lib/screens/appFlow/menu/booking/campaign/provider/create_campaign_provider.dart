import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/discount/discount_create_component_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_booking_repository/crm_booking_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/campaign/provider/campaign_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateCampaignProvider with ChangeNotifier {

  DiscountCreateComponentListModel? campaignComponentListResponse;

  final campaignNameController = TextEditingController();
  final discountTitleController = TextEditingController();
  final amountController = TextEditingController();
  final minPurchaseController = TextEditingController();
  final maxPurchaseController = TextEditingController();

  String selectDiscountType = 'Category';

  String selectDiscountAmountType = "Percentage";

  File? thumbNailImageFile;
  File? coverImageFile;

  List<DiscountComponent> selectedCampaignCategories = [];
  List<DiscountComponent> selectedCampaignServices = [];
  List<DiscountComponent> selectedCampaignZones = [];

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  CreateCampaignProvider(){
    getCampaignComponentList();
  }


  getCampaignComponentList() async {
    final response = await CrmBookingRepository.getCreateDiscountComponentListData();
    if(response.result == true){
      campaignComponentListResponse = response.data;
    }
    notifyListeners();
  }



  void setSelectedDiscountType(String type) {
    selectDiscountType = type;
    notifyListeners();
  }


  void setSelectedDiscountAmountType(String type) {
    selectDiscountAmountType = type;
    notifyListeners();
  }


  void toggleCategory(DiscountComponent category) {
    if (selectedCampaignCategories.any((element) => element.id == category.id)) {
      selectedCampaignCategories.removeWhere((element) => element.id == category.id);
    } else {
      selectedCampaignCategories.add(category);
    }
    notifyListeners();
  }



  void toggleService(DiscountComponent service) {
    if (selectedCampaignServices.any((element) => element.id == service.id)) {
      selectedCampaignServices.removeWhere((element) => element.id == service.id);
    } else {
      selectedCampaignServices.add(service);
    }
    notifyListeners();
  }



  void toggleZone(DiscountComponent zone){
    if(selectedCampaignZones.any((element) => element.id == zone.id)){
      selectedCampaignZones.removeWhere((element) => element.id == zone.id);
    } else {
      selectedCampaignZones.add(zone);
    }
    notifyListeners();
  }


  ////Select Start date
  Future selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (pickedDate != null) {
      selectedStartDate = pickedDate;
      startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate!);
      notifyListeners();
    }
  }


  ///select end date
  Future selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: selectedStartDate!,
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedStartDate!,
      locale: const Locale("en"),
    );
    if (pickedDate != null) {
      selectedEndDate = pickedDate;
      endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate!);
      notifyListeners();
    }
  }



  ///Thumbnail Image picker
  Future<dynamic> pickThumbnailImageFile(BuildContext context) async {
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
            thumbNailImageFile = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            thumbNailImageFile = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }



  ///coverImage picker
  Future<dynamic> pickCoverImageFile(BuildContext context) async {
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
            coverImageFile = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            coverImageFile = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }



///add campaign
  Future createCampaign (context) async {
    var thumbnailFile = thumbNailImageFile!.path.split('/').last;
    var coverFile = coverImageFile!.path.split('/').last;
    final data = FormData.fromMap({
      "name" : campaignNameController.text,
      "thumbnail" : await MultipartFile.fromFile(thumbNailImageFile!.path, filename: thumbnailFile),
      "cover_image" : await MultipartFile.fromFile(coverImageFile!.path, filename: coverFile),
      "discount_type" : selectDiscountType,
      "discount_title" : discountTitleController.text,
      "category_id[]": selectedCampaignCategories.isNotEmpty ? selectedCampaignCategories.map((category) => category.id).toList() : null,
      "service_id[]": selectedCampaignServices.isNotEmpty ? selectedCampaignServices.map((service) => service.id).toList() : null,
      "zone_id[]": selectedCampaignZones.isNotEmpty ? selectedCampaignZones.map((zone) => zone.id).toList() : null,
      "discount_amount_type" : selectDiscountAmountType,
      "amount": amountController.text,
      "start_date" : startDate,
      "end_date" : endDate,
      "min_purchase_amount" : minPurchaseController.text,
      "max_purchase_amount" : maxPurchaseController.text,
    });
    final response = await CrmBookingRepository.postAddCampaign(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<CampaignListProvider>(context, listen: false).getCampaignList();
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

    notifyListeners();
  }

}