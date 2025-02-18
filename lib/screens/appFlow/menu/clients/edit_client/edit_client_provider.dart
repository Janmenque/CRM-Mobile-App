import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../custom_widgets/custom_dialog.dart';
import '../../../../../utils/nav_utail.dart';

class EditClientProvider extends ChangeNotifier {
  final clientNameController = TextEditingController();
  final clientPhoneNumberController = TextEditingController();
  final clientEmailController = TextEditingController();
  final clientAddressController = TextEditingController();
  final clientDescriptionController = TextEditingController();

  String? clientImage;
  File? imagePath;

  ClientDetailsModel? clientDetailsdata;

  EditClientProvider(ClientDetailsModel? clientDetails) {
    clientDetailsdata = clientDetails;
    setControllerData(clientDetails);
  }

  setControllerData(ClientDetailsModel? clientDetailsdata) {
    clientImage = clientDetailsdata?.data?.client?.avater;
    clientNameController.text = clientDetailsdata?.data?.client?.name ?? "";
    clientPhoneNumberController.text =
        clientDetailsdata?.data?.client?.phone ?? "";
    clientEmailController.text = clientDetailsdata?.data?.client?.email ?? "";
    clientAddressController.text =
        clientDetailsdata?.data?.client?.address ?? "";
    clientDescriptionController.text =
        clientDetailsdata?.data?.client?.description ?? "";

    notifyListeners();
  }

  Future editClient(context) async {
    final data = FormData.fromMap({
      "avatar": imagePath != null
          ? await MultipartFile.fromFile(imagePath!.path)
          : null,
      "id": clientDetailsdata!.data!.client?.id,
      "name": clientNameController.text,
      "phone": clientPhoneNumberController.text,
      "email": clientEmailController.text,
      'address': clientAddressController.text,
      'description': clientDescriptionController.text,
    });
    final response = await CrmClientRepository.updateClient(data);
    if (response['result'] == true) {
      NavUtil.pushAndRemoveUntil(context, const ButtomNavigationBar());
      Fluttertoast.showToast(msg: "Client Successfully updated");
      notifyListeners();
    }
  }

  ///Pick image from Camera and Gallery
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
            if (kDebugMode) {
              print(File(image.path));
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            imagePath = File(imageGallery!.path);
            if (kDebugMode) {
              print(File(imageGallery.path));
            }
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }
}
