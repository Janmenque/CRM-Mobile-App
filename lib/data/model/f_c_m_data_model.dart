class FCMDataModel {
  final String? image;
  final String? body;
  final String? title;
  final String? type;
  final int? orderId;
  final String? url;

  FCMDataModel(
      {this.image, this.body, this.title, this.type, this.orderId, this.url});

  factory FCMDataModel.fromJson(Map<String, dynamic> json) {
    return FCMDataModel(
        image: json['image'],
        body: json['body'],
        title: json['title'],
        type: json['type'],
        orderId: json['order_id'],
        url: json['url']);
  }
}
