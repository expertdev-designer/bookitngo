class CreateBookingResponse {
  bool _status;
  String _message;
  BookingData _data;

  CreateBookingResponse({bool status, String message, BookingData data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;

  set status(bool status) => _status = status;

  // ignore: unnecessary_getters_setters
  String get message => _message;

  set message(String message) => _message = message;

  BookingData get data => _data;

  set data(BookingData data) => _data = data;

  CreateBookingResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? new BookingData.fromJson(json['data']) : null;
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

class BookingData {
  String _hotelName;
  String _location;
  String _image;
  String _checkIn;
  String _checkOut;
  List<Rooms> _rooms;

  BookingData(
      {String hotelName,
      String location,
      String image,
      String checkIn,
      String checkOut,
      List<Rooms> rooms}) {
    this._hotelName = hotelName;
    this._location = location;
    this._image = image;
    this._checkIn = checkIn;
    this._checkOut = checkOut;
    this._rooms = rooms;
  }

  String get hotelName => _hotelName;

  set hotelName(String hotelName) => _hotelName = hotelName;

  String get location => _location;

  set location(String location) => _location = location;

  String get image => _image;

  set image(String image) => _image = image;

  String get checkIn => _checkIn;

  set checkIn(String checkIn) => _checkIn = checkIn;

  String get checkOut => _checkOut;

  set checkOut(String checkOut) => _checkOut = checkOut;

  List<Rooms> get rooms => _rooms;

  set rooms(List<Rooms> rooms) => _rooms = rooms;

  BookingData.fromJson(Map<String, dynamic> json) {
    _hotelName = json['hotel_name'];
    _location = json['location'];
    _image = json['image'];
    _checkIn = json['check_in'];
    _checkOut = json['check_out'];
    if (json['rooms'] != null) {
      _rooms = new List<Rooms>();
      json['rooms'].forEach((v) {
        _rooms.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotel_name'] = this._hotelName;
    data['location'] = this._location;
    data['image'] = this._image;
    data['check_in'] = this._checkIn;
    data['check_out'] = this._checkOut;
    if (this._rooms != null) {
      data['rooms'] = this._rooms.map((v) => v.toJson()).toList();
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
