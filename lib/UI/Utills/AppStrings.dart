import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/BookingRoomList.dart';

class AppStrings {
  //Local Storage..........................
  static var userName = "";
  static var authToken = "";
  static var userEmail = "";
  static var userImage = "";
  static var imagePAth = "http://18.217.126.228/server/";

  // static var linkedinClientID = '86tgh53q1bmevs';
  // static var linkedinClientSecret = 'QRyKNEg1xQfxsogB';
  // static var linkedinRedirectURl = '';
  //
  static String linkedinRedirectURl = 'https://www.cozii.ca/';
  static String linkedinClientID = '86iywglhbco377';
  static String linkedinClientSecret = 'yFeilzis3gU8dBqa';

  static List<SelectedRoomList> selectedRoomList = List();
  static var checkInDate = DateTime.now();
  static var checkOutDate = DateTime.now().add(Duration(days: 1));
}
