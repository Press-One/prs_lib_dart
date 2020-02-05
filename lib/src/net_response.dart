class NetResponse {
  var data;
  bool result;
  int code;
  var headers;

  NetResponse(this.data, this.result, this.code, {this.headers});
}
