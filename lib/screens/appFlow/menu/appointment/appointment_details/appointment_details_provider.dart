import 'package:flutter/foundation.dart';
import 'package:hrm_app/data/model/appointment_model/appointment_details_model.dart';
import 'package:hrm_app/data/server/respository/appointment/appointment_repository.dart';

class AppointmentDetailsProvider extends ChangeNotifier{

  int id;
  AppointmentDetailsModel? appointmentDetails;


  AppointmentDetailsProvider(this.id){
    getAppointmentDetails(id);
  }

  Future getAppointmentDetails(appointmentId) async{
    if (kDebugMode) {
      print('appointment ID $appointmentId' );
    }
    final response = await AppointmentRepository.getAppointmentDetails(appointmentId);
    appointmentDetails = response.data;
    notifyListeners();
  }
}