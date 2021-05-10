class HotelRoomListingResponse {
  bool _status;
  String _message;
  List<GetRoomData> _data;

  HotelRoomListingResponse(
      {bool status, String message, List<GetRoomData> data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;

  set status(bool status) => _status = status;

  String get message => _message;

  set message(String message) => _message = message;

  List<GetRoomData> get data => _data;

  set data(List<GetRoomData> data) => _data = data;

  HotelRoomListingResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = new List<GetRoomData>();
      json['data'].forEach((v) {
        _data.add(new GetRoomData.fromJson(v));
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

class GetRoomData {
  List<String> _images;
  String _sId;
  String _hotelId;
  String _name;
  String _description;
  String _price;
  String _room_type;
  int _adultCapacity;
  int _childCapacity;
  String _updatedAt;
  String _createdAt;
  int _iV;

  GetRoomData(
      {List<String> images,
      String sId,
      String hotelId,
      String name,
      String description,
      String price,
      String room_type,
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
    this._room_type = room_type;
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

  String get room_type => _room_type;

  set room_type(String price) => _room_type = price;

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

  GetRoomData.fromJson(Map<String, dynamic> json) {
    _images = json['images'].cast<String>();
    _sId = json['_id'];
    _hotelId = json['hotel_id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _room_type = json['room_type'];
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
    data['room_type'] = this._room_type;
    data['adult_capacity'] = this._adultCapacity;
    data['child_capacity'] = this._childCapacity;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['__v'] = this._iV;
    return data;
  }
}
