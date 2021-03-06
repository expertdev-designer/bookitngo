import 'dart:async';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/IntroApps/model/RegisterResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/Web/CategorySelection/CategorySelectionPage.dart';
import 'package:book_it/Web/WebHome/WebDashboardPage.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../CategorySelection.dart';

class LoginBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get onSuccessStream => onSuccessController.stream;

  final BehaviorSubject onSuccessController = BehaviorSubject<int>();

  StreamSink get onSuccessSink => onSuccessController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void doLogin({
    String username,
    String password,
    BuildContext context,
  }) {
    progressSink.add(true);
    apiRepository
        .loginApi(usernameEmail: username, password: password)
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        setLocalStorage(onResponse.data);
        if (kIsWeb) {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new WebCategorySelectionPage(
                    token: onResponse.data.accessToken,
                    isFrom: "Login",
                  )));
        } else {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new CategorySelectionPage(
                    userID: onResponse.data.accessToken,
                  )));
        }
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Login Error", onError.toString());
    });
  }

  void forgotPassword({String email, BuildContext context}) {
    progressSink.add(true);

    apiRepository
        .forgotPasswordApi(
      email: email,
    )
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        print("Register" + onResponse.message);
        onSuccessSink.add(2);
        showErrorDialog(context, "Forgot Password", onResponse.message);
      }

      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void register(
      {String email,
      String firstName,
      String lastName,
      String dob,
      String password,
      BuildContext context}) {
    progressSink.add(true);
    apiRepository
        .registerApi(
      userEmail: email,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      password: password,
    )
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        print("Register" + onResponse.message);
        onSuccessSink.add(1);
        setLocalStorageAfterRegister(onResponse.data);
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new CategorySelectionPage(
                  userID: onResponse.data.accessToken,
                )));
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Register Error", onError.toString());
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

  setLocalStorageAfterRegister(RegisterData onResponse) {
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

//
}
