class DiscoverNewPlacesResponse {
  bool _status;
  String _message;
  DiscoverNewPlacesData _data;

  DiscoverNewPlacesResponse({bool status, String message, DiscoverNewPlacesData data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  DiscoverNewPlacesData get data => _data;
  set data(DiscoverNewPlacesData data) => _data = data;

  DiscoverNewPlacesResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? new DiscoverNewPlacesData.fromJson(json['data']) : null;
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

class DiscoverNewPlacesData {
  List<NewPlacesAndRecommended> _newPlaces;
  List<TopDestinations> _topDestinations;
  List<NewPlacesAndRecommended> _recommended;

  DiscoverNewPlacesData(
      {List<NewPlacesAndRecommended> newPlaces,
      List<TopDestinations> topDestinations,
      List<NewPlacesAndRecommended> recommended}) {
    this._newPlaces = newPlaces;
    this._topDestinations = topDestinations;
    this._recommended = recommended;
  }

  List<NewPlacesAndRecommended> get newPlaces => _newPlaces;
  set newPlaces(List<NewPlacesAndRecommended> newPlaces) => _newPlaces = newPlaces;
  List<TopDestinations> get topDestinations => _topDestinations;
  set topDestinations(List<TopDestinations> topDestinations) =>
      _topDestinations = topDestinations;
  List<NewPlacesAndRecommended> get recommended => _recommended;
  set recommended(List<NewPlacesAndRecommended> recommended) => _recommended = recommended;

  DiscoverNewPlacesData.fromJson(Map<String, dynamic> json) {
    if (json['new_places'] != null) {
      _newPlaces = new List<NewPlacesAndRecommended>();
      json['new_places'].forEach((v) {
        _newPlaces.add(new NewPlacesAndRecommended.fromJson(v));
      });
    }
    if (json['top_destinations'] != null) {
      _topDestinations = new List<TopDestinations>();
      json['top_destinations'].forEach((v) {
        _topDestinations.add(new TopDestinations.fromJson(v));
      });
    }
    if (json['recommended'] != null) {
      _recommended = new List<NewPlacesAndRecommended>();
      json['recommended'].forEach((v) {
        _recommended.add(new NewPlacesAndRecommended.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._newPlaces != null) {
      data['new_places'] = this._newPlaces.map((v) => v.toJson()).toList();
    }
    if (this._topDestinations != null) {
      data['top_destinations'] =
          this._topDestinations.map((v) => v.toJson()).toList();
    }
    if (this._recommended != null) {
      data['recommended'] = this._recommended.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewPlacesAndRecommended {
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
  num _price;
  bool _isDeleted;
  bool _isFeatured;
  num _rating;
  String _category;
  String _updatedAt;
  String _createdAt;
  int _iV;

  NewPlacesAndRecommended(
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
      num price,
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
    this._price = price;
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
  num get price => _price;
  set price(int price) => _price = price;
  String get category => _category;
  set category(String category) => _category = category;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  int get iV => _iV;
  set iV(int iV) => _iV = iV;

  NewPlacesAndRecommended.fromJson(Map<String, dynamic> json) {
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
    _price = json['price'];
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
    data['price'] = this._price;
    data['category'] = this._category;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['__v'] = this._iV;
    return data;
  }
}

class TopDestinations {
  List<String> _images;
  String _sId;
  String _name;
  String _description;
  String _updatedAt;
  String _createdAt;
  int _iV;

  TopDestinations(
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

  TopDestinations.fromJson(Map<String, dynamic> json) {
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