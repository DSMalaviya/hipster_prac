class ResponseStatus {
  ResponseType? resType;
  String? msg;
  Object? error;

  ResponseStatus.success() : resType = ResponseType.success;
  ResponseStatus.loading() : resType = ResponseType.loading;
  ResponseStatus.error({String errormsg = "Something went wrong", this.error})
    : resType = ResponseType.error,
      msg = errormsg;
}

enum ResponseType { success, loading, error }
