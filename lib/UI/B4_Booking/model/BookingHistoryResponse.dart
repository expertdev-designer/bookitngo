class BookingHistoryResponse {
  bool _status;
  String _message;
  BookingHistoryData _data;

  BookingHistoryResponse(
      {bool status, String message, BookingHistoryData data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;

  set status(bool status) => _status = status;

  String get message => _message;

  set message(String message) => _message = message;

  BookingHistoryData get data => _data;

  set data(BookingHistoryData data) => _data = data;

  BookingHistoryResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null
        ? new BookingHistoryData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class BookingHistoryData {
  List<Current> _current;
  List<Current> _past;

  BookingHistoryData({List<Current> current, List<Current> past}) {
    this._current = current;
    this._past = past;
  }

  List<Current> get current => _current;

  set current(List<Current> current) => _current = current;

  List<Current> get past => _past;

  set past(List<Current> past) => _past = past;

  BookingHistoryData.fromJson(Map<String, dynamic> json) {
    if (json['current'] != null) {
      _current = new List<Current>();
      json['current'].forEach((v) {
        _current.add(new Current.fromJson(v));
      });
    }
    if (json['past'] != null) {
      _past = new List<Current>();
      json['past'].forEach((v) {
        _past.add(new Current.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._current != null) {
      data['current'] = this._current.map((v) => v.toJson()).toList();
    }
    if (this._past != null) {
      data['past'] = this._past.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Current {
  List<String> _roomId;
  List<Rooms> _rooms;
  String _sId;
  String _transactionId;
  String _cardId;
  String _hotelId;
  String _checkIn;
  String _checkOut;
  int _adult;
  int _child;
  String _amount;
  int _phone;
  String _specialInstruction;
  String _status;
  String _createdBy;
  String _updatedBy;
  String _updatedAt;
  String _createdAt;
  int _iV;
  HotelDetail _hotelDetail;
  RoomDetail _roomDetail;

  Current(
      {List<String> roomId,
      List<Rooms> rooms,
      String sId,
      String transactionId,
      String cardId,
      String hotelId,
      String checkIn,
      String checkOut,
      int adult,
      int child,
      String amount,
      int phone,
      String specialInstruction,
      String status,
      String createdBy,
      String updatedBy,
      String updatedAt,
      String createdAt,
      int iV,
      HotelDetail hotelDetail,
      RoomDetail roomDetail}) {
    this._roomId = roomId;
    this._rooms = rooms;
    this._sId = sId;
    this._transactionId = transactionId;
    this._cardId = cardId;
    this._hotelId = hotelId;
    this._checkIn = checkIn;
    this._checkOut = checkOut;
    this._adult = adult;
    this._child = child;
    this._amount = amount;
    this._phone = phone;
    this._specialInstruction = specialInstruction;
    this._status = status;
    this._createdBy = createdBy;
    this._updatedBy = updatedBy;
    this._updatedAt = updatedAt;
    this._createdAt = createdAt;
    this._iV = iV;
    this._hotelDetail = hotelDetail;
    this._roomDetail = roomDetail;
  }

  List<String> get roomId => _roomId;

  set roomId(List<String> roomId) => _roomId = roomId;

  List<Rooms> get rooms => _rooms;

  set rooms(List<Rooms> rooms) => _rooms = rooms;

  String get sId => _sId;

  set sId(String sId) => _sId = sId;

  String get transactionId => _transactionId;

  set transactionId(String transactionId) => _transactionId = transactionId;

  String get cardId => _cardId;

  set cardId(String cardId) => _cardId = cardId;

  String get hotelId => _hotelId;

  set hotelId(String hotelId) => _hotelId = hotelId;

  String get checkIn => _checkIn;

  set checkIn(String checkIn) => _checkIn = checkIn;

  String get checkOut => _checkOut;

  set checkOut(String checkOut) => _checkOut = checkOut;

  int get adult => _adult;

  set adult(int adult) => _adult = adult;

  int get child => _child;

  set child(int child) => _child = child;

  String get amount => _amount;

  set amount(String amount) => _amount = amount;

  int get phone => _phone;

  set phone(int phone) => _phone = phone;

  String get specialInstruction => _specialInstruction;

  set specialInstruction(String specialInstruction) =>
      _specialInstruction = specialInstruction;

  String get status => _status;

  set status(String status) => _status = status;

  String get createdBy => _createdBy;

  set createdBy(String createdBy) => _createdBy = createdBy;

  String get updatedBy => _updatedBy;

  set updatedBy(String updatedBy) => _updatedBy = updatedBy;

  String get updatedAt => _updatedAt;

  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  String get createdAt => _createdAt;

  set createdAt(String createdAt) => _createdAt = createdAt;

  int get iV => _iV;

  set iV(int iV) => _iV = iV;

  HotelDetail get hotelDetail => _hotelDetail;

  set hotelDetail(HotelDetail hotelDetail) => _hotelDetail = hotelDetail;

  RoomDetail get roomDetail => _roomDetail;

  set roomDetail(RoomDetail roomDetail) => _roomDetail = roomDetail;

  Current.fromJson(Map<String, dynamic> json) {
    _roomId = json['room_id'].cast<String>();
    if (json['rooms'] != null) {
      _rooms = new List<Rooms>();
      json['rooms'].forEach((v) {
        _rooms.add(new Rooms.fromJson(v));
      });
    }
    _sId = json['_id'];
    _transactionId = json['transaction_id'];
    _cardId = json['card_id'];
    _hotelId = json['hotel_id'];
    _checkIn = json['check_in'];
    _checkOut = json['check_out'];
    _adult = json['adult'];
    _child = json['child'];
    _amount = json['amount'];
    _phone = json['phone'];
    _specialInstruction = json['special_instruction'];
    _status = json['status'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _iV = json['__v'];
    _hotelDetail = json['hotel_detail'] != null
        ? new HotelDetail.fromJson(json['hotel_detail'])
        : null;
    _roomDetail = json['room_detail'] != null
        ? new RoomDetail.fromJson(json['room_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this._roomId;
    if (this._rooms != null) {
      data['rooms'] = this._rooms.map((v) => v.toJson()).toList();
    }
    data['_id'] = this._sId;
    data['transaction_id'] = this._transactionId;
    data['card_id'] = this._cardId;
    data['hotel_id'] = this._hotelId;
    data['check_in'] = this._checkIn;
    data['check_out'] = this._checkOut;
    data['adult'] = this._adult;
    data['child'] = this._child;
    data['amount'] = this._amount;
    data['phone'] = this._phone;
    data['special_instruction'] = this._specialInstruction;
    data['status'] = this._status;
    data['created_by'] = this._createdBy;
    data['updated_by'] = this._updatedBy;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['__v'] = this._iV;
    if (this._hotelDetail != null) {
      data['hotel_detail'] = this._hotelDetail.toJson();
    }
    if (this._roomDetail != null) {
      data['room_detail'] = this._roomDetail.toJson();
    }
    return data;
  }
}

class Rooms {
  int _adult;
  int _child;

  Rooms({int adult, int child}) {
    this._adult = adult;
    this._child = child;
  }

  int get adult => _adult;

  set adult(int adult) => _adult = adult;

  int get child => _child;

  set child(int child) => _child = child;

  Rooms.fromJson(Map<String, dynamic> json) {
    _adult = json['adult'];
    _child = json['child'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this._adult;
    data['child'] = this._child;
    return data;
  }
}

class HotelDetail {
  List<String> _images;
  List<String> _amenities;
  String _sId;
  String _name;
  String _description;
  String _address;
  String _city;
  String _state;
  String _country;
  String _latitude;
  String _longitude;
  bool _isDeleted;
  bool _isFeatured;
  num _rating;
  String _category;
  String _updatedAt;
  String _createdAt;
  int _iV;

  HotelDetail(
      {List<String> images,
      List<String> amenities,
      String sId,
      String name,
      String description,
      String address,
      String city,
      String state,
      String country,
      String latitude,
      String longitude,
      bool isDeleted,
      bool isFeatured,
      num rating,
      String category,
      String updatedAt,
      String createdAt,
      int iV}) {
    this._images = images;
    this._amenities = amenities;
    this._sId = sId;
    this._name = name;
    this._description = description;
    this._address = address;
    this._city = city;
    this._state = state;
    this._country = country;
    this._latitude = latitude;
    this._longitude = longitude;
    this._isDeleted = isDeleted;
    this._isFeatured = isFeatured;
    this._rating = rating;
    this._category = category;
    this._updatedAt = updatedAt;
    this._createdAt = createdAt;
    this._iV = iV;
  }

  List<String> get images => _images;

  set images(List<String> images) => _images = images;

  List<String> get amenities => _amenities;

  set amenities(List<String> amenities) => _amenities = amenities;

  String get sId => _sId;

  set sId(String sId) => _sId = sId;

  String get name => _name;

  set name(String name) => _name = name;

  String get description => _description;

  set description(String description) => _description = description;

  String get address => _address;

  set address(String address) => _address = address;

  String get city => _city;

  set city(String city) => _city = city;

  String get state => _state;

  set state(String state) => _state = state;

  String get country => _country;

  set country(String country) => _country = country;

  String get latitude => _latitude;

  set latitude(String latitude) => _latitude = latitude;

  String get longitude => _longitude;

  set longitude(String longitude) => _longitude = longitude;

  bool get isDeleted => _isDeleted;

  set isDeleted(bool isDeleted) => _isDeleted = isDeleted;

  bool get isFeatured => _isFeatured;

  set isFeatured(bool isFeatured) => _isFeatured = isFeatured;

  num get rating => _rating;

  set rating(int rating) => _rating = rating;

  String get category => _category;

  set category(String category) => _category = category;

  String get updatedAt => _updatedAt;

  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  String get createdAt => _createdAt;

  set createdAt(String createdAt) => _createdAt = createdAt;

  int get iV => _iV;

  set iV(int iV) => _iV = iV;

  HotelDetail.fromJson(Map<String, dynamic> json) {
    _images = json['images'].cast<String>();
    _amenities = json['amenities'].cast<String>();
    _sId = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _isDeleted = json['is_deleted'];
    _isFeatured = json['is_featured'];
    _rating = json['rating'];
    _category = json['category'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this._images;
    data['amenities'] = this._amenities;
    data['_id'] = this._sId;
    data['name'] = this._name;
    data['description'] = this._description;
    data['address'] = this._address;
    data['city'] = this._city;
    data['state'] = this._state;
    data['country'] = this._country;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['is_deleted'] = this._isDeleted;
    data['is_featured'] = this._isFeatured;
    data['rating'] = this._rating;
    data['category'] = this._category;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['__v'] = this._iV;
    return data;
  }
}

class RoomDetail {
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

  RoomDetail(
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

  RoomDetail.fromJson(Map<String, dynamic> json) {
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
