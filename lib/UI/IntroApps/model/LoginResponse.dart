class LoginResponse {
  String _message;
  bool _status;
  LoginData _data;

  LoginResponse({String message, bool status, LoginData data}) {
    this._message = message;
    this._status = status;
    this._data = data;
  }

  String get message => _message;

  set message(String message) => _message = message;

  bool get status => _status;

  set status(bool status) => _status = status;

  LoginData get data => _data;

  set data(LoginData data) => _data = data;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class LoginData {
  String _accessToken;
  int _userId;
  String _firstName;
  String _lastName;
  String _userImage;
  String _dob;
  String _emailId;
  String _currencyCode;
  String _currencySymbol;

  LoginData(
      {String accessToken,
      int userId,
      String firstName,
      String lastName,
      String userImage,
      String dob,
      String emailId,
      String currencyCode,
      String currencySymbol}) {
    this._accessToken = accessToken;
    this._userId = userId;
    this._firstName = firstName;
    this._lastName = lastName;
    this._userImage = userImage;
    this._dob = dob;
    this._emailId = emailId;
    this._currencyCode = currencyCode;
    this._currencySymbol = currencySymbol;
  }

  String get accessToken => _accessToken;

  set accessToken(String accessToken) => _accessToken = accessToken;

  int get userId => _userId;

  set userId(int userId) => _userId = userId;

  String get firstName => _firstName;

  set firstName(String firstName) => _firstName = firstName;

  String get lastName => _lastName;

  set lastName(String lastName) => _lastName = lastName;

  String get userImage => _userImage;

  set userImage(String userImage) => _userImage = userImage;

  String get dob => _dob;

  set dob(String dob) => _dob = dob;

  String get emailId => _emailId;

  set emailId(String emailId) => _emailId = emailId;

  String get currencyCode => _currencyCode;

  set currencyCode(String currencyCode) => _currencyCode = currencyCode;

  String get currencySymbol => _currencySymbol;

  set currencySymbol(String currencySymbol) => _currencySymbol = currencySymbol;

  LoginData.fromJson(Map<String, dynamic> json) {
    _accessToken = json['access_token'];
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _userImage = json['user_image'];
    _dob = json['dob'];
    _emailId = json['email_id'];
    _currencyCode = json['currency_code'];
    _currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this._accessToken;
    data['user_id'] = this._userId;
    data['first_name'] = this._firstName;
    data['last_name'] = this._lastName;
    data['user_image'] = this._userImage;
    data['dob'] = this._dob;
    data['email_id'] = this._emailId;
    data['currency_code'] = this._currencyCode;
    data['currency_symbol'] = this._currencySymbol;
    return data;
  }
}
