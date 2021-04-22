
class PaymentCardResponse {
  bool status;
  String message;
  List<PaymentCardData> data;

  PaymentCardResponse({this.status, this.message, this.data});

  PaymentCardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<PaymentCardData>();
      json['data'].forEach((v) {
        data.add(new PaymentCardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentCardData {
  String sId;
  String userId;
  String cardId;
  String cardType;
  String cardHolderName;
  String cardNumber;
  String expDate;
  bool isDeleted;
  String updatedBy;
  String createdBy;
  String createdAt;
  String updatedAt;
  int iV;

  PaymentCardData(
      {this.sId,
      this.userId,
      this.cardId,
      this.cardType,
      this.cardHolderName,
      this.cardNumber,
      this.expDate,
      this.isDeleted,
      this.updatedBy,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PaymentCardData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    cardType = json['card_type'];
    cardHolderName = json['card_holder_name'];
    cardNumber = json['card_number'];
    expDate = json['exp_date'];
    isDeleted = json['is_deleted'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['card_id'] = this.cardId;
    data['card_type'] = this.cardType;
    data['card_holder_name'] = this.cardHolderName;
    data['card_number'] = this.cardNumber;
    data['exp_date'] = this.expDate;
    data['is_deleted'] = this.isDeleted;
    data['updated_by'] = this.updatedBy;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}