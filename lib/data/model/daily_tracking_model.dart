class DailyTrackingList {
  double? latitude;
  double? longitude;

  DailyTrackingList({this.latitude, this.longitude});

  factory DailyTrackingList.fromJson(Map<String, dynamic> json) {
    return DailyTrackingList(
        latitude: json['latitude'], longitude: json['longitude']);
  }
}