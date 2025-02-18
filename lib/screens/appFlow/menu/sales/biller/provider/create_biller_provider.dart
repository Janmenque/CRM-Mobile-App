
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_sales/add_biller_country_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/biller/provider/biller_list_provider.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateBillerProvider extends ChangeNotifier{

  CountryListModel? countryListResponse;
  Country? country;

  final billerNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final vatNumberController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final stateController = TextEditingController();

  File? imagePath;

  CreateBillerProvider(){
   getCountryList();
  }

  getCountryList() async {
    final response = await CRMSalesRepository.getCountryListData();
    if(response.result == true){
      countryListResponse = response.data;
      notifyListeners();
    }
  }


  selectCountry(Country? countryValue){
    country = countryValue;
    notifyListeners();
  }


  Future addBiller(context) async {
    var fileName = imagePath!.path.split('/').last;
    final data = FormData.fromMap({
      "name": billerNameController.text,
      "company_name": companyNameController.text,
      "vat_number": vatNumberController.text,
      "email": emailController.text,
      "phone_number": phoneNumberController.text,
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "postal_code": postalCodeController.text,
      "country_id": country?.id,
      "image": await MultipartFile.fromFile(imagePath!.path, filename: fileName),
    });
    final response = await CRMSalesRepository.postAddABiller(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<BillerListProvider>(context, listen: false).getBillerList();
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