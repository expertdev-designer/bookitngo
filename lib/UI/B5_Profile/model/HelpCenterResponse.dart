class HelpCenterResponse {
  String _message;
  bool _status;
  List<HelpData> _data;

  HelpCenterResponse({String message, bool status, List<HelpData> data}) {
    this._message = message;
    this._status = status;
    this._data = data;
  }

  String get message => _message;

  set message(String message) => _message = message;

  bool get status => _status;

  set status(bool status) => _status = status;

  List<HelpData> get data => _data;

  set data(List<HelpData> data) => _data = data;

  HelpCenterResponse.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = new List<HelpData>();
      json['data'].forEach((v) {
        _data.add(new HelpData.fromJson(v));
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

class HelpData {
  int _id;
  String _name;
  String _description;
  String _status;
  List<Questions> _questions;
  List<SubCategory> _subCategory;

  HelpData(
      {int id,
      String name,
      String description,
      String status,
      List<Questions> questions,
      List<SubCategory> subCategory}) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._status = status;
    this._questions = questions;
    this._subCategory = subCategory;
  }

  int get id => _id;

  set id(int id) => _id = id;

  String get name => _name;

  set name(String name) => _name = name;

  String get description => _description;

  set description(String description) => _description = description;

  String get status => _status;

  set status(String status) => _status = status;

  List<Questions> get questions => _questions;

  set questions(List<Questions> questions) => _questions = questions;

  List<SubCategory> get subCategory => _subCategory;

  set subCategory(List<SubCategory> subCategory) => _subCategory = subCategory;

  HelpData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _status = json['status'];
    if (json['questions'] != null) {
      _questions = new List<Questions>();
      json['questions'].forEach((v) {
        _questions.add(new Questions.fromJson(v));
      });
    }
    if (json['sub_category'] != null) {
      _subCategory = new List<SubCategory>();
      json['sub_category'].forEach((v) {
        _subCategory.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['description'] = this._description;
    data['status'] = this._status;
    if (this._questions != null) {
      data['questions'] = this._questions.map((v) => v.toJson()).toList();
    }
    if (this._subCategory != null) {
      data['sub_category'] = this._subCategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int _id;
  int _categoryId;
  int _subcategoryId;
  String _question;
  String _answer;
  String _suggested;
  String _status;
  String _createdAt;
  String _updatedAt;
  String _categoryName;

  // Null _subcategoryName;
  // List<Null> _translations;

  Questions({
    int id,
    int categoryId,
    int subcategoryId,
    String question,
    String answer,
    String suggested,
    String status,
    String createdAt,
    String updatedAt,
    String categoryName,
    // Null subcategoryName,
    // List<Null> translations
  }) {
    this._id = id;
    this._categoryId = categoryId;
    this._subcategoryId = subcategoryId;
    this._question = question;
    this._answer = answer;
    this._suggested = suggested;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._categoryName = categoryName;
    // this._subcategoryName = subcategoryName;
    // this._translations = translations;
  }

  int get id => _id;

  set id(int id) => _id = id;

  int get categoryId => _categoryId;

  set categoryId(int categoryId) => _categoryId = categoryId;

  int get subcategoryId => _subcategoryId;

  set subcategoryId(int subcategoryId) => _subcategoryId = subcategoryId;

  String get question => _question;

  set question(String question) => _question = question;

  String get answer => _answer;

  set answer(String answer) => _answer = answer;

  String get suggested => _suggested;

  set suggested(String suggested) => _suggested = suggested;

  String get status => _status;

  set status(String status) => _status = status;

  String get createdAt => _createdAt;

  set createdAt(String createdAt) => _createdAt = createdAt;

  String get updatedAt => _updatedAt;

  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  String get categoryName => _categoryName;

  set categoryName(String categoryName) => _categoryName = categoryName;

  // Null get subcategoryName => _subcategoryName;
  // set subcategoryName(Null subcategoryName) =>
  //     _subcategoryName = subcategoryName;
  // List<Null> get translations => _translations;
  // set translations(List<Null> translations) => _translations = translations;

  Questions.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _question = json['question'];
    _answer = json['answer'];
    _suggested = json['suggested'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _categoryName = json['category_name'];
    // _subcategoryName = json['subcategory_name'];
    // if (json['translations'] != null) {
    //   _translations = new List<Null>();
    //   json['translations'].forEach((v) {
    //     _translations.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['category_id'] = this._categoryId;
    data['subcategory_id'] = this._subcategoryId;
    data['question'] = this._question;
    data['answer'] = this._answer;
    data['suggested'] = this._suggested;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['category_name'] = this._categoryName;
    // data['subcategory_name'] = this._subcategoryName;
    // if (this._translations != null) {
    //   data['translations'] = this._translations.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class SubCategory {
  int _id;
  int _categoryId;
  String _name;
  String _description;
  String _status;
  List<Questions> _questions;
  String _categoryName;

  SubCategory(
      {int id,
      int categoryId,
      String name,
      String description,
      String status,
      List<Questions> questions,
      String categoryName}) {
    this._id = id;
    this._categoryId = categoryId;
    this._name = name;
    this._description = description;
    this._status = status;
    this._questions = questions;
    this._categoryName = categoryName;
  }

  int get id => _id;

  set id(int id) => _id = id;

  int get categoryId => _categoryId;

  set categoryId(int categoryId) => _categoryId = categoryId;

  String get name => _name;

  set name(String name) => _name = name;

  String get description => _description;

  set description(String description) => _description = description;

  String get status => _status;

  set status(String status) => _status = status;

  List<Questions> get questions => _questions;

  set questions(List<Questions> questions) => _questions = questions;

  String get categoryName => _categoryName;

  set categoryName(String categoryName) => _categoryName = categoryName;

  SubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _name = json['name'];
    _description = json['description'];
    _status = json['status'];
    if (json['questions'] != null) {
      _questions = new List<Questions>();
      json['questions'].forEach((v) {
        _questions.add(new Questions.fromJson(v));
      });
    }
    _categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['category_id'] = this._categoryId;
    data['name'] = this._name;
    data['description'] = this._description;
    data['status'] = this._status;
    if (this._questions != null) {
      data['questions'] = this._questions.map((v) => v.toJson()).toList();
    }
    data['category_name'] = this._categoryName;
    return data;
  }
}
