import 'dart:async';
import 'dart:io';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/BookingRoomList.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/HotelMapListingResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/HotelRoomListingResponse.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../SelectCheckInOutDate.dart';

class MapBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get hotelMapDataStream => hotelMapDataController.stream;

  final BehaviorSubject hotelMapDataController =
      // ignore: close_sinks, close_sinks
      BehaviorSubject<HotelMapListingResponse>();

  StreamSink get hotelMapDataSink => hotelMapDataController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void getHotelForMapView({BuildContext context}) {
    progressSink.add(true);
    apiRepository.getHotelMap().then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        hotelMapDataSink.add(onResponse);
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

  setLocalStorage(LoginData onResponse) {
    LocalStorage.setUserName(onResponse.username).then((sucess) {
      LocalStorage.setUserAuthToken(onResponse.token);
      LocalStorage.setEmail(onResponse.email.toString());
      LocalStorage.setUserImage(onResponse.image.toString());
    });
    LocalStorage.getEmail().then((email) {
      AppStrings.userEmail = email;
      print('Email.......$email');
    });
    LocalStorage.getUserName().then((name) {
      AppStrings.userName = name;
      print('Name.......$name');
    });
    LocalStorage.getUserAuthToken().then((token) {
      AppStrings.authToken = token;
      print('AuthToken...........$token');
    });
    LocalStorage.getUserImage().then((image) {
      AppStrings.userImage = image;
      print('UserImage...........$image');
    });
  }
}
