import 'dart:async';
import 'dart:io';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HotelByLocationResponse.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HotelHotelByCategoryResponse.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get homeDataStream => homeDataController.stream;

  final BehaviorSubject homeDataController = BehaviorSubject<HomeResponse>();

  StreamSink get homeDataSink => homeDataController.sink;

  Stream get hotelByCategoryDataStream => hotelByCategoryDataController.stream;

  // ignore: close_sinks
  final BehaviorSubject hotelByCategoryDataController =
      // ignore: close_sinks
      BehaviorSubject<HotelByCategoryResponse>();

  StreamSink get hotelByCategoryDataSink => hotelByCategoryDataController.sink;

  Stream get hotelByLocationCategoryDataStream =>
      hotelByLocationCategoryDataController.stream;

  // ignore: close_sinks
  final BehaviorSubject hotelByLocationCategoryDataController =
      // ignore: close_sinks
      BehaviorSubject<HotelByLocationResponse>();

  StreamSink get hotelByLocationCategoryDataSink =>
      hotelByLocationCategoryDataController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void getHomePageData({BuildContext context}) {
    progressSink.add(true);
    apiRepository.homePageApi().then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        homeDataSink.add(onResponse);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void getHotelByCategory({BuildContext context, String categoryId}) {
    progressSink.add(true);
    apiRepository
        .getHotelByCategoryApi(categoryId: categoryId)
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        // showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        hotelByCategoryDataSink.add(onResponse);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }


void getHotelListingApi({BuildContext context, String type}) {
    progressSink.add(true);
    apiRepository
        .getHotelListingApi(type: type)
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        // showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        hotelByCategoryDataSink.add(onResponse);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void getRecommendedHotelByCategory({BuildContext context}) {
    progressSink.add(true);
    apiRepository.getRecommendedHotelsApi().then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        hotelByCategoryDataSink.add(onResponse);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void getHotelByLocationCategory({BuildContext context, String location}) {
    progressSink.add(true);
    apiRepository.getHotelByLocation(location: location).then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        hotelByLocationCategoryDataSink.add(onResponse);
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
