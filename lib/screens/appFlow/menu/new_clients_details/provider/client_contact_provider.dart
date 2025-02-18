import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_client_model/client_contact_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:image_picker/image_picker.dart';

class ClientContactProvider extends ChangeNotifier{

  ClientContactListModel? clientContactListResponse;

  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  File? profileImage;

  bool invoice = true;
  bool project = true;
  bool contract = true;
  bool ticket = true;
  bool file = true;
  bool contact = true;
  bool estimate = true;
  bool task = true;
  bool proposal = true;
  bool note = true;
  bool reminder = true;
  bool emailInvoice = true;
  bool emailEstimate = true;
  bool emailProject = true;
  bool emailTask = true;
  bool emailContract = true;
  bool emailProposal = true;
  bool emailTicket = true;





  ClientContactProvider(int clientId){
    getClientContactList(clientId);
  }



  void inVoiceSwitch(bool value) {
    invoice = value;
    notifyListeners();
  }
  void projectSwitch(bool value) {
    project = value;
    notifyListeners();
  }

  void contractSwitch(bool value) {
    contract = value;
    notifyListeners();
  }

  void ticketSwitch(bool value) {
    ticket = value;
    notifyListeners();
  }

  void fileSwitch(bool value) {
    file = value;
    notifyListeners();
  }

  void contactSwitch(bool value) {
    contact = value;
    notifyListeners();
  }

  void estimateSwitch(bool value) {
    estimate = value;
    notifyListeners();
  }

  void taskSwitch(bool value) {
    task = value;
    notifyListeners();
  }

  void proposalSwitch(bool value) {
    proposal = value;
    notifyListeners();
  }

  void noteSwitch(bool value) {
    note = value;
    notifyListeners();
  }

  void reminderSwitch(bool value) {
    reminder = value;
    notifyListeners();
  }

  void emailInvoiceSwitch(bool value) {
    emailInvoice = value;
    notifyListeners();
  }

  void emailProjectSwitch(bool value) {
    emailProject = value;
    notifyListeners();
  }

  void emailContractSwitch(bool value) {
    emailContract = value;
    notifyListeners();
  }

  void emailTicketSwitch(bool value) {
    emailTicket = value;
    notifyListeners();
  }

  void emailEstimateSwitch(bool value) {
    emailEstimate = value;
    notifyListeners();
  }

  void emailTaskSwitch(bool value) {
    emailTask = value;
    notifyListeners();
  }

  void emailProposalSwitch(bool value) {
    emailProposal = value;
    notifyListeners();
  }


  getClientContactList(int clientId) async {
    isLoading = true;
    final response = await CrmClientRepository.getClientContactListData(clientId);
    if(response.result == true){
      clientContactListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }


  ///profile Image picker
  Future<dynamic> pickProfileImageFile(BuildContext context) async {
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
            profileImage = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            profileImage = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }



  Future clientCreateContact (context, int clientId) async {
    var fileName = profileImage!.path.split('/').last;
    final formData = FormData.fromMap({
      "client_id" : clientId,
      "name" : nameController.text,
      "email" : emailController.text,
      "phone" : phoneController.text,
      "position" : positionController.text,
      "password" : passwordController.text,
      "is_invoice" : invoice == true ? 1 : 0,
      "is_estimate" : estimate == true ? 1 : 0,
      "is_project" : project == true ? 1 : 0,
      "is_task" : task == true ? 1 : 0,
      "is_ticket" : ticket == true ? 1 : 0,
      "is_contract" : contract == true ? 1 : 0,
      "is_contact" : contact == true ? 1 : 0,
      "is_proposal" : proposal == true ? 1 : 0,
      "is_note" : note == true ? 1 : 0,
      "is_file" : file == true ? 1 : 0,
      "is_reminder" : reminder == true ? 1 : 0,
      "is_email_invoice" : emailInvoice == true ? 1 : 0,
      "is_email_estimate" : emailEstimate == true ? 1 : 0,
      "is_email_project" : emailProject == true ? 1 : 0,
      "is_email_task" : emailTask == true ? 1 : 0,
      "is_email_ticket" : emailTicket == true ? 1 : 0,
      "is_email_contract" : emailContract == true ? 1 : 0,
      "is_email_proposal" : emailProposal == true ? 1 : 0,
      "image" : await MultipartFile.fromFile(profileImage!.path, filename: fileName)
    });

    final response = await CrmClientRepository.postContractClient(formData);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      getClientContactList(clientId);
      Navigator.pop(context);
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      positionController.clear();
      passwordController.clear();
      profileImage = null;
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
