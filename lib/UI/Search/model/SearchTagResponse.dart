class SearchTagResponse {
  bool _status;
  String _message;
  List<SearchTagData> _data;

  SearchTagResponse({bool status, String message, List<SearchTagData> data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  List<SearchTagData> get data => _data;
  set data(List<SearchTagData> data) => _data = data;

  SearchTagResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = new List<SearchTagData>();
      json['data'].forEach((v) {
        _data.add(new SearchTagData.fromJson(v));
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

class SearchTagData {
  String _sId;
  String _search;
  String _createdBy;
  String _updatedBy;
  String _updatedAt;
  String _createdAt;
  int _iV;

  SearchTagData(
      {String sId,
      String search,
      String createdBy,
      String updatedBy,
      String updatedAt,
      String createdAt,
      int iV}) {
    this._sId = sId;
    this._search = search;
    this._createdBy = createdBy;
    this._updatedBy = updatedBy;
    this._updatedAt = updatedAt;
    this._createdAt = createdAt;
    this._iV = iV;
  }

  String get sId => _sId;
  set sId(String sId) => _sId = sId;
  String get search => _search;
  set search(String search) => _search = search;
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

  SearchTagData.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _search = json['name'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['name'] = this._search;
    data['created_by'] = this._createdBy;
    data['updated_by'] = this._updatedBy;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['__v'] = this._iV;
    return data;
  }
}