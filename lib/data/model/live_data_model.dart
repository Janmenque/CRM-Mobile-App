import 'package:flutter/cupertino.dart';
import 'daily_tracking_model.dart';

class LiveDataModel {
  final bool? success;
  final String? message;
  final double? distance;
  final List<DailyTrackingList>? locationData;

  LiveDataModel(
      {@required this.success,
        @required this.message,
        @required this.distance,
        @required this.locationData});

  factory LiveDataModel.fromJson(Map<String, dynamic> json) {
    return LiveDataModel(
        success: json['success'],
        message: json['message'],
        locationData: json['lastEight'] != null ? List<DailyTrackingList>.from(json['lastEight'].map((e) => DailyTrackingList.fromJson(e))) : null,
        distance: json['distance'] ?? 0.0);
  }
}
