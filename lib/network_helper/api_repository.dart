import 'dart:convert';
import 'dart:io';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HotelByLocationResponse.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HotelHotelByCategoryResponse.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/ImageUplaodResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/SelectCheckInOutDate.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/BookingRoomList.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/CreateBookingResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/HotelRoomListingResponse.dart';
import 'package:book_it/UI/B3_Trips/model/DiscoverNewPlacesResponse.dart';
import 'package:book_it/UI/B4_Booking/model/BookingHistoryResponse.dart';
import 'package:book_it/UI/B5_Profile/model/PaymentCardResponse.dart';
import 'package:book_it/UI/IntroApps/model/CategoriesResponse.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/model/CommonResponse.dart';
import 'package:dio/dio.dart';
import 'api_helper.dart';
import 'common_api_utils.dart';
import 'local_storage.dart';

class ApiRepository {
  ApiHelper apiHelper = ApiHelper();
  Dio _dio = Dio();

  var base_url = "http://18.217.126.228:3002/api/";

  var image_base_url = "http://18.217.126.228:3002/api/";

  /*................... login api ..........*/

  Future<LoginResponse> loginApi(
      {String usernameEmail, String password}) async {
    print('usernameEmail${usernameEmail}password${password}');
    var response =
        await _dio.post(base_url + ApiEndPoints.post_api_Login, data: {
      'email': usernameEmail,
      'device_token': 'ADFSDFDSdfbsbkfshfb',
      'password': password
    });
    print("LoginResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return LoginResponse.fromJson(data);
  }

  /*................... Forgot Password api ..........*/

  Future<CommonResponse> forgotPasswordApi({String email}) async {
    print('usernameEmail${email}}');
    var response =
        await _dio.post(base_url + ApiEndPoints.post_api_forgotPassword, data: {
      'email': email,
    });
    print("ForgotPasswordResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CommonResponse.fromJson(data);
  }

  /*................... Register api ..........*/

  Future<CommonResponse> registerApi(
      {String username, String userEmail, String password}) async {
    print('usernameEmail${userEmail}password${password}');
    var response =
        await _dio.post(base_url + ApiEndPoints.post_api_Register, data: {
      'username': username,
      'email': userEmail,
      'device_token': 'ADFSDFDSdfbsbkfshfb',
      'password': password
    });
    print("RegisterResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CommonResponse.fromJson(data);
  }

  //  uploadDocument api ..........
  Future<ImageUplaodResponse> uploadImage({File file}) async {
    print('file  ${file}');
    getDioOptions(_dio);
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: 'images.jpg', //important
      ),
    });
    var response = await _dio.post(
        image_base_url + ApiEndPoints.post_api_uploadImage_document,
        data: formData);
    print("FileUploadResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return ImageUplaodResponse.fromJson(data);
  }

  /*................... update_username api ..........*/

  Future<CommonResponse> updateUsername({String username}) async {
    print('update_username${username}}');
    getDioOptions(_dio);
    var response =
        await _dio.post(base_url + ApiEndPoints.update_username, data: {
      'username': username,
    });
    print("UpdateUserName" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CommonResponse.fromJson(data);
  }

  /*................... call Center api ..........*/

  Future<CommonResponse> callCenterApi(
      {String username, String email, String detail}) async {
    var response = await _dio.post(base_url + ApiEndPoints.callCenter, data: {
      'name': username,
      'email': email,
      'detail': detail,
    });
    print("callCenterApi" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CommonResponse.fromJson(data);
  }

  /*................... get Category api ..........*/

  Future<CategoriesResponse> getCategories() async {
    getDioOptions(_dio);
    var response = await _dio.post(base_url + ApiEndPoints.getCategory);
    print("getCategoryResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CategoriesResponse.fromJson(data);
  }

  /*................... get Category api ..........*/

  Future<CommonResponse> saveCategories(List<String> categories) async {
    getDioOptions(_dio);
    var response =
        await _dio.post(base_url + ApiEndPoints.saveUserCategory, data: {
      'categories': categories,
    });
    print("getCategoryResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CommonResponse.fromJson(data);
  }

  /*................... Add Card api ..........*/

  Future<CommonResponse> addPaymentCard(String stripeToken) async {
    getDioOptions(_dio);
    var response = await _dio.post(base_url + 'addCard', data: {
      'stripe_token': stripeToken,
    });
    print("AddCardResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CommonResponse.fromJson(data);
  }

  /*................... Get Card api ..........*/

  Future<PaymentCardResponse> getCard() async {
    getDioOptions(_dio);
    var response = await _dio.post(
      base_url + "getCards",
    );
    print("getCardResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return PaymentCardResponse.fromJson(data);
  }

  /*................... Delete  Card api ..........*/

  Future<CommonResponse> deleteCard({String cardId}) async {
    getDioOptions(_dio);
    var response = await _dio.post(base_url + ApiEndPoints.deleteCard, data: {
      'card_id': cardId,
    });
    print("ForgotPasswordResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CommonResponse.fromJson(data);
  }

/*................... Home Page  api ..........*/

  Future<HomeResponse> homePageApi() async {
    getDioOptions(_dio);
    var response = await _dio.post(base_url + ApiEndPoints.post_api_home);
    print("homeResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return HomeResponse.fromJson(data);
  }

// /*.....................Get Rooms api ...............*/

  Future<HotelRoomListingResponse> getRooms({String hotelId}) async {
    getDioOptions(_dio);
    var response =
        await _dio.post(base_url + ApiEndPoints.post_api_getRoom, data: {
      'hotel_id': hotelId,
    });
    print("HotelListingResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return HotelRoomListingResponse.fromJson(data);
  }

//*.....................Get Hotel by category api ...............*/

  Future<HotelByCategoryResponse> getHotelByCategoryApi(
      {String categoryId}) async {
    getDioOptions(_dio);
    var response = await _dio
        .post(base_url + ApiEndPoints.post_api_GetHotelByCategory, data: {
      'category_id': categoryId,
    });
    print("GetHotelByCategoryResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return HotelByCategoryResponse.fromJson(data);
  }

//*.....................Get Hotel by category api ...............*/

  Future<HotelByLocationResponse> getHotelByLocation(
      {String categoryId, String location}) async {
    getDioOptions(_dio);
    var response = await _dio
        .post(base_url + ApiEndPoints.post_api_GotHotelByLocation, data: {
      'location': location,
    });
    print("GetHotelByLocationResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return HotelByLocationResponse.fromJson(data);
  }

  //*.....................get Recommended Hotels api ...............*/

  Future<HotelByCategoryResponse> getRecommendedHotelsApi() async {
    getDioOptions(_dio);
    var response =
        await _dio.post(base_url + ApiEndPoints.post_api_GetRecommendedHotels);
    print("RecommendedHotelsApiResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return HotelByCategoryResponse.fromJson(data);
  }

//*....................create Booking api ...............*/

  Future<CreateBookingResponse> bookHotelApi({BookingRoomList roomList}) async {
    getDioOptions(_dio);
    var response = await _dio.post(base_url + "createBooking", data: roomList);
    print("CreateBookingResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return CreateBookingResponse.fromJson(data);
  }

  //*.....................get Bookings api ...............*/

  Future<BookingHistoryResponse> getBookings() async {
    getDioOptions(_dio);
    var response =
        await _dio.post(base_url + ApiEndPoints.post_api_get_booking);
    print("GetBookingsResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return BookingHistoryResponse.fromJson(data);
  }

  //*.....................discover New Places api ...............*/

  Future<DiscoverNewPlacesResponse> discoverNewPlacesApi() async {
    getDioOptions(_dio);
    var response =
        await _dio.post(base_url + ApiEndPoints.post_api_discoverNewPlaces);
    print("discoverNewPlacesResponse" + response.toString());
    Map<String, dynamic> data = jsonDecode(response.toString());
    return DiscoverNewPlacesResponse.fromJson(data);
  }

  getDioOptions(Dio _dio) {
    String authTOKEN;
    LocalStorage.getUserAuthToken().then((value) {
      authTOKEN = "" + value;
      print("x-access-token $authTOKEN");
    });
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      if (authTOKEN != null) {
        options.headers["x-access-token"] = authTOKEN;
      }
    }));
  }
}
