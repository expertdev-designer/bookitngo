import 'dart:async';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../travelSelection.dart';

class LoginBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void doLogin({String username, String password, BuildContext context}) {
    progressSink.add(true);
    apiRepository
        .loginApi(usernameEmail: username, password: password)
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        setLocalStorage(onResponse.data);
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new mainSelection(
                  userID: onResponse.data.token,
                )));
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
      {String email, String username, String password, BuildContext context}) {
    progressSink.add(true);
    apiRepository
        .registerApi(
      userEmail: email,
      username: username,
      password: password,
    )
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        print("Register" + onResponse.message);
        showErrorDialog(context, "Congratulations!!!",
            "Thanks for creating the account with us. We have sent you a mail on your registered email account. Please follow the steps in the mail to complete the sign up process.");
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
