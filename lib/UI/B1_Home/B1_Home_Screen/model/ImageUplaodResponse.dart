class ImageUplaodResponse {
  bool _status;
  String _message;
  String _data;

  ImageUplaodResponse({bool status, String message, String data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  String get data => _data;
  set data(String data) => _data = data;

  ImageUplaodResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    data['data'] = this._data;
    return data;
  }
}