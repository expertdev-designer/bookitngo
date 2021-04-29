class HotelRoomListingResponse {
  bool _status;
  String _message;
  List<Data> _data;

  HotelRoomListingResponse({bool status, String message, List<Data> data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  HotelRoomListingResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
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

class Data {
  List<String> _images;
  String _sId;
  String _hotelId;
  String _name;
  String _description;
  String _price;
  int _adultCapacity;
  int _childCapacity;
  String _updatedAt;
  String _createdAt;
  int _iV;

  Data(
      {List<String> images,
      String sId,
      String hotelId,
      String name,
      String description,
      String price,
      int adultCapacity,
      int childCapacity,
      String updatedAt,
      String createdAt,
      int iV}) {
    this._images = images;
    this._sId = sId;
    this._hotelId = hotelId;
    this._name = name;
    this._description = description;
    this._price = price;
    this._adultCapacity = adultCapacity;
    this._childCapacity = childCapacity;
    this._updatedAt = updatedAt;
    this._createdAt = createdAt;
    this._iV = iV;
  }

  List<String> get images => _images;
  set images(List<String> images) => _images = images;
  String get sId => _sId;
  set sId(String sId) => _sId = sId;
  String get hotelId => _hotelId;
  set hotelId(String hotelId) => _hotelId = hotelId;
  String get name => _name;
  set name(String name) => _name = name;
  String get description => _description;
  set description(String description) => _description = description;
  String get price => _price;
  set price(String price) => _price = price;
  int get adultCapacity => _adultCapacity;
  set adultCapacity(int adultCapacity) => _adultCapacity = adultCapacity;
  int get childCapacity => _childCapacity;
  set childCapacity(int childCapacity) => _childCapacity = childCapacity;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  int get iV => _iV;
  set iV(int iV) => _iV = iV;

  Data.fromJson(Map<String, dynamic> json) {
    _images = json['images'].cast<String>();
    _sId = json['_id'];
    _hotelId = json['hotel_id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _adultCapacity = json['adult_capacity'];
    _childCapacity = json['child_capacity'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this._images;
    data['_id'] = this._sId;
    data['hotel_id'] = this._hotelId;
    data['name'] = this._name;
    data['description'] = this._description;
    data['price'] = this._price;
    data['adult_capacity'] = this._adultCapacity;
    data['child_capacity'] = this._childCapacity;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['__v'] = this._iV;
    return data;
  }
}