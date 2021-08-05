import 'dart:async';
import 'dart:io';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/BookingRoomList.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/HotelRoomListingResponse.dart';
import 'package:book_it/UI/B4_Booking/model/BookingHistoryResponse.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BookingHistoryBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get bookingHistoryDataStream => bookingHistoryDataController.stream;

  final BehaviorSubject bookingHistoryDataController =
      BehaviorSubject<BookingHistoryResponse>();

  StreamSink get bookingHistoryDataSink => bookingHistoryDataController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void getBookingsHistory({BuildContext context}) {
    progressSink.add(false);
    apiRepository.getBookings().then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        bookingHistoryDataSink.add(onResponse);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void giveReviewToHotel(
      {BuildContext context,
      String hotel_id,
      String booking_id,
      String rating,
      String comment}) {
    progressSink.add(true);
    apiRepository
        .giveRating(
            hotel_id: hotel_id,
            booking_id: booking_id,
            rating: rating,
            comment: comment)
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        showErrorDialog(context, "Rating & Review", onResponse.message);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void cancelBooking({BuildContext context, String transaction_id}) {
    progressSink.add(true);
    apiRepository
        .cancelBooking(transaction_id: transaction_id)
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        // showErrorDialog(context, "Cancel Booking", onResponse.message);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Booking Cancelled"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
        getBookingsHistory();
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void showErrorDialog(context, title, msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppConstantHelper.showDialog(
              context: context, title: title, msg: msg);
        });
  }
}
