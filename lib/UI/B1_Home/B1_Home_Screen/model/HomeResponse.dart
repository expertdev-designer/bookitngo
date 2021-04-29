class HomeResponse {
  bool _status;
  String _message;
  HomeData _data;

  HomeResponse({bool status, String message, HomeData data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  HomeData get data => _data;
  set data(HomeData data) => _data = data;

  HomeResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
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

class HomeData {
  List<HotelData> _featured;
  List<HotelData> _recommended;
  List<Destinations> _destinations;
  List<Categories> _categories;
  List<HotelData> _rooms;

  HomeData(
      {List<HotelData> featured,
      List<HotelData> recommended,
      List<Destinations> destinations,
      List<Categories> categories,
      List<HotelData> rooms}) {
    this._featured = featured;
    this._recommended = recommended;
    this._destinations = destinations;
    this._categories = categories;
    this._rooms = rooms;
  }

  List<HotelData> get featured => _featured;
  set featured(List<HotelData> featured) => _featured = featured;
  List<HotelData> get recommended => _recommended;
  set recommended(List<HotelData> recommended) => _recommended = recommended;
  List<Destinations> get destinations => _destinations;
  set destinations(List<Destinations> destinations) => _destinations = destinations;
  List<Categories> get categories => _categories;
  set categories(List<Categories> categories) => _categories = categories;
  List<HotelData> get rooms => _rooms;
  set rooms(List<HotelData> rooms) => _rooms = rooms;

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['featured'] != null) {
      _featured = new List<HotelData>();
      json['featured'].forEach((v) {
        _featured.add(new HotelData.fromJson(v));
      });
    }
    if (json['recommended'] != null) {
      _recommended = new List<HotelData>();
      json['recommended'].forEach((v) {
        _recommended.add(new HotelData.fromJson(v));
      });
    }
    if (json['destinations'] != null) {
      _destinations = new List<Destinations>();
      json['destinations'].forEach((v) {
        _destinations.add(new Destinations.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      _categories = new List<Categories>();
      json['categories'].forEach((v) {
        _categories.add(new Categories.fromJson(v));
      });
    }
    if (json['rooms'] != null) {
      _rooms = new List<HotelData>();
      json['rooms'].forEach((v) {
        _rooms.add(new HotelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._featured != null) {
      data['featured'] = this._featured.map((v) => v.toJson()).toList();
    }
    if (this._recommended != null) {
      data['recommended'] = this._recommended.map((v) => v.toJson()).toList();
    }
    if (this._destinations != null) {
      data['destinations'] = this._destinations.map((v) => v.toJson()).toList();
    }
    if (this._categories != null) {
      data['categories'] = this._categories.map((v) => v.toJson()).toList();
    }
    if (this._rooms != null) {
      data['rooms'] = this._rooms.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotelData {
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
  int _rating;
  String _category;
  String _updatedAt;
  String _createdAt;
  int _iV;

  HotelData(
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
      int rating,
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
  int get rating => _rating;
  set rating(int rating) => _rating = rating;
  String get category => _category;
  set category(String category) => _category = category;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  int get iV => _iV;
  set iV(int iV) => _iV = iV;

  HotelData.fromJson(Map<String, dynamic> json) {
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

class Categories {
  String _sId;
  String _name;
  String _image;
  bool _isDeleted;
  String _updatedAt;
  String _createdAt;
  int _iV;

  Categories(
      {String sId,
      String name,
      String image,
      bool isDeleted,
      String updatedAt,
      String createdAt,
      int iV}) {
    this._sId = sId;
    this._name = name;
    this._image = image;
    this._isDeleted = isDeleted;
    this._updatedAt = updatedAt;
    this._createdAt = createdAt;
    this._iV = iV;
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

  Categories.fromJson(Map<String, dynamic> json) {
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


class Destinations {
  List<String> _images;
  String _sId;
  String _name;
  String _description;
  String _updatedAt;
  String _createdAt;
  int _iV;

  Destinations(
      {List<String> images,
        String sId,
        String name,
        String description,
        String updatedAt,
        String createdAt,
        int iV}) {
    this._images = images;
    this._sId = sId;
    this._name = name;
    this._description = description;
    this._updatedAt = updatedAt;
    this._createdAt = createdAt;
    this._iV = iV;
  }

  List<String> get images => _images;
  set images(List<String> images) => _images = images;
  String get sId => _sId;
  set sId(String sId) => _sId = sId;
  String get name => _name;
  set name(String name) => _name = name;
  String get description => _description;
  set description(String description) => _description = description;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  int get iV => _iV;
  set iV(int iV) => _iV = iV;

  Destinations.fromJson(Map<String, dynamic> json) {
    _images = json['images'].cast<String>();
    _sId = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this._images;
    data['_id'] = this._sId;
    data['name'] = this._name;
    data['description'] = this._description;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['__v'] = this._iV;
    return data;
  }
}