class ApiResponse<T> {
  int? httpCode;
  bool? result;
  String? message;
  T? data;
  T? error;

  ApiResponse({this.httpCode, this.result, this.message, this.data,this.error});

  @override
  String toString() {
    return '${error ?? ''}';
  }

}
