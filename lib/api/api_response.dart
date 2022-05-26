class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse.inilial(this.message) : status = Status.INITIAL;
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.complated(this.data) : status = Status.COMPLATED;
  ApiResponse.error(this.message) : status = Status.ERROR;
}

enum Status { INITIAL, LOADING, COMPLATED, ERROR }
