import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/BookingRoomList.dart';

class AppStrings {
  //Local Storage..........................
  static var userName = "";
  static var authToken = "";
  static var userEmail = "";
  static var userImage = "";
  static var imagePAth = "http://18.217.126.228/server/";

  static List<SelectedRoomList> selectedRoomList = List();
  static var checkInDate = DateTime.now();
  static var checkOutDate = DateTime.now().add(Duration(days: 1));

}
