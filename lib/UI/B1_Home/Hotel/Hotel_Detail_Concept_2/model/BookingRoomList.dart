import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/SelectCheckInOutDate.dart';

class BookingRoomList {
  // "hotel_id": hotelID,
  // "room_id": roomID,
  // "check_in": checkInDate,
  // "check_out": checkOutDate,
  // /*"adult":2,
  //         "child":1,*/
  // "rooms": roomList,
  // "amount": amount,
  // "phone": phone,
  // "special_instruction": specialInstruction
  String hotelID;
  List<String> roomID;
  String checkInDate;
  String checkOutDate;
  List<SelectedRoomList> rooms;
  String amount;
  String phone;
  String special_instruction;

  BookingRoomList(
      {this.hotelID,
      this.roomID,
      this.checkInDate,
      this.checkOutDate,
      this.rooms,
      this.amount,
      this.phone,
      this.special_instruction});

  BookingRoomList.fromJson(Map<String, dynamic> json) {
    hotelID = json['hotel_id'];
    roomID = json['room_id'];
    checkInDate = json['check_in'];
    checkOutDate = json['check_out'];
    if (json['rooms'] != null) {
      rooms = new List<SelectedRoomList>();
      json['rooms'].forEach((v) {
        rooms.add(new SelectedRoomList.fromJson(v));
      });
    }
    amount = json['amount'];
    phone = json['phone'];
    special_instruction = json['special_instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotel_id'] = this.hotelID;
    data['room_id'] = this.roomID;
    data['check_in'] = this.checkInDate;
    data['check_out'] = this.checkOutDate;
    if (this.rooms != null) {
      data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['phone'] = this.phone;
    data['special_instruction'] = this.special_instruction;

    return data;
  }
}

class SelectedRoomList {
  num adult;
  num child;

  SelectedRoomList({this.adult, this.child});

  SelectedRoomList.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    child = json['child'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['child'] = this.child;
    return data;
  }
}
