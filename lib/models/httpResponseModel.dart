class HttpResponseModel<T> {
  bool isSuccess;
  T data;
  String? message;
  int? responseCode;

  HttpResponseModel(this.isSuccess, this.data,
      {this.message, this.responseCode});
}
