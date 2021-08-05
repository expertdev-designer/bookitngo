import 'dart:async';
import 'dart:io';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/BookingRoomList.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/HotelRoomListingResponse.dart';
import 'package:book_it/UI/B4_Booking/model/BookingHistoryResponse.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Search/model/SearchResponse.dart';
import 'package:book_it/UI/Search/model/SearchTagResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get searchTagDataStream => searchTagDataController.stream;

  final BehaviorSubject searchTagDataController =
      BehaviorSubject<SearchResponse>();

  StreamSink get searchDataDataSink => searchTagDataController.sink;

  Stream get tagDataStream => tagDataController.stream;

  final BehaviorSubject tagDataController =
      BehaviorSubject<SearchTagResponse>();

  StreamSink get tagDataSink => tagDataController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void doSearchHotelsApiCall({BuildContext context, String searchText}) {
    progressSink.add(true);
    apiRepository.searchHotel(searchText: searchText).then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        searchDataDataSink.add(onResponse);
        // showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        searchDataDataSink.add(onResponse);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void getSearchTag({BuildContext context}) {
    progressSink.add(true);
    apiRepository.getSearchTag().then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        // showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        tagDataSink.add(onResponse);
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
    LocalStorage.setUserName(onResponse.firstName).then((sucess) {
      LocalStorage.setUserAuthToken(onResponse.accessToken);
      LocalStorage.setEmail(onResponse.emailId.toString());
      LocalStorage.setUserImage(onResponse.userImage.toString());
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
