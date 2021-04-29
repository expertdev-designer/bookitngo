import 'dart:async';
import 'package:book_it/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:book_it/UI/IntroApps/model/CategoriesResponse.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../travelSelection.dart';

class CategoryBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get categoryDataStream => categoryDataController.stream;

  // ignore: close_sinks
  final BehaviorSubject categoryDataController =
      BehaviorSubject<CategoriesResponse>();

  StreamSink get categoryDataSink => categoryDataController.sink;

  Stream get successDataStream => successDataController.stream;

  // ignore: close_sinks
  final BehaviorSubject successDataController =
      // ignore: close_sinks, close_sinks
      BehaviorSubject<bool>();

  StreamSink get successDataSink => successDataController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void getCategory({BuildContext context}) {
    progressSink.add(true);
    apiRepository.getCategories().then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Login Error", onResponse.message);
      } else if (onResponse.status) {
        categoryDataSink.add(onResponse);
        // Navigator.of(context).pushReplacement(PageRouteBuilder(
        //     pageBuilder: (_, __, ___) => new mainSelection(
        //           userID: onResponse.data.token,
        //         )));
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Login Error", onError.toString());
    });
  }

  void saveCategory({BuildContext context, List<String> categories}) {
    progressSink.add(true);
    apiRepository.saveCategories(categories).then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, " Error", onResponse.message);
      } else if (onResponse.status) {
        successDataSink.add(true);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => bottomNavBar(
                userID: AppStrings.authToken,
              ),
            ));
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
//
}
