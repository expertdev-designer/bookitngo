class CategoriesResponse {
  String _message;
  bool _status;
  List<CategoriesData> _data;

  CategoriesResponse({String message, bool status, List<CategoriesData> data}) {
    this._message = message;
    this._status = status;
    this._data = data;
  }

  String get message => _message;

  set message(String message) => _message = message;

  bool get status => _status;

  set status(bool status) => _status = status;

  List<CategoriesData> get data => _data;

  set data(List<CategoriesData> data) => _data = data;

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = <CategoriesData>[];
      json['data'].forEach((v) {
        _data.add(new CategoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesData {
  int _id;
  String _name;
  String _image;
  String _imageUrl;
  bool _isSelect=false;

  CategoriesData(
      {int id, String name, String image, String imageUrl, bool isSelect}) {
    this._id = id;
    this._name = name;
    this._image = image;
    this._imageUrl = imageUrl;
    this._isSelect = isSelect;
  }

  int get id => _id;

  set id(int id) => _id = id;

  String get name => _name;

  set name(String name) => _name = name;

  String get image => _image;

  set image(String image) => _image = image;

  String get imageUrl => _imageUrl;

  set imageUrl(String imageUrl) => _imageUrl = imageUrl;

  bool get isSelect => _isSelect;

  set isSelect(bool isSelect) => _isSelect = isSelect;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['image'] = this._image;
    data['image_url'] = this._imageUrl;
    return data;
  }
}
