class CategoriesResponse {
  bool _status;
  String _message;
  List<CategoriesData> _data;

  CategoriesResponse({bool status, String message, List<CategoriesData> data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;

  set status(bool status) => _status = status;

  String get message => _message;

  set message(String message) => _message = message;

  List<CategoriesData> get data => _data;

  set data(List<CategoriesData> data) => _data = data;

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = new List<CategoriesData>();
      json['data'].forEach((v) {
        _data.add(new CategoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesData {
  String _sId;
  String _name;
  String _image;
  bool _isDeleted;
  String _updatedAt;
  String _createdAt;
  int _iV;
  bool isSelect = false;

  CategoriesData(
      {String sId,
      String name,
      String image,
      bool isDeleted,
      String updatedAt,
      String createdAt,
      int iV,
      bool isSelect}) {
    this._sId = sId;
    this._name = name;
    this._image = image;
    this._isDeleted = isDeleted;
    this._updatedAt = updatedAt;
    this._createdAt = createdAt;
    this._iV = iV;
    this.isSelect = isSelect;
  }

  String get sId => _sId;

  set sId(String sId) => _sId = sId;

  String get name => _name;

  set name(String name) => _name = name;

  String get image => _image;

  set image(String image) => _image = image;

  bool get isDeleted => _isDeleted;

  set isDeleted(bool isDeleted) => _isDeleted = isDeleted;

  String get updatedAt => _updatedAt;

  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  String get createdAt => _createdAt;

  set createdAt(String createdAt) => _createdAt = createdAt;

  int get iV => _iV;

  set iV(int iV) => _iV = iV;

  bool get iSSelect => isSelect;

  set iSSelect(bool isSelect) => isSelect = isSelect;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _image = json['image'];
    _isDeleted = json['is_deleted'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['name'] = this._name;
    data['image'] = this._image;
    data['is_deleted'] = this._isDeleted;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['__v'] = this._iV;
    return data;
  }
}
