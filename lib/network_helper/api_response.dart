class ApiResponse<T> {
  Status status;

  T data;

  String message;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

 // ApiResponse.emptyList(this.message):status =Status.EMPTYLIST;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n HomeData : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
