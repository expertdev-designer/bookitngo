class LoginResponse {
  bool status;
  String message;
  LoginData data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    data =
        json['data'] != null && status ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class LoginData {
  String sId;
  String username;
  String email;
  int emailVerify;
  String password;
  String image;
  String deviceToken;
  String updatedAt;
  String createdAt;
  int iV;
  String token;

  LoginData(
      {this.sId,
      this.username,
      this.email,
      this.emailVerify,
      this.password,
      this.image,
      this.deviceToken,
      this.updatedAt,
      this.createdAt,
      this.iV,
      this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    emailVerify = json['email_verify'];
    password = json['password'];
    image = json['image'];
    deviceToken = json['device_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verify'] = this.emailVerify;
    data['password'] = this.password;
    data['image'] = this.image;
    data['device_token'] = this.deviceToken;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    data['token'] = this.token;
    return data;
  }
}
