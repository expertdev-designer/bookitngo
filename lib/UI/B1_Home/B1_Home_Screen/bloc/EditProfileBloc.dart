import 'dart:async';
import 'dart:io';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void uploadProfileImage({File file, BuildContext context}) {
    progressSink.add(true);
    apiRepository.uploadImage(file: file).then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Upload Image Error", onResponse.message);
      } else if (onResponse.status) {
        LocalStorage.setUserImage(onResponse.data.toString());
        LocalStorage.getUserImage().then((image) {
          AppStrings.userImage = image;
          print('UserImage...........$image');
        });
        _showUpdateProfileDialog(context);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Upload Image Error", onError.toString());
    });
  }

  void updateUsername({String username, BuildContext context}) {
    progressSink.add(true);
    apiRepository.updateUsername(username: username).then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Update Profile Error", onResponse.message);
      } else if (onResponse.status) {
        LocalStorage.setUserName(username);
        LocalStorage.getUserName().then((name) {
          AppStrings.userName = name;
          print('UserName...........$name');
        });

        _showUpdateProfileDialog(context);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Update Profile Error", onError.toString());
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

  _showUpdateProfileDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      barrierDismissible: true,
      child: SimpleDialog(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Icon(
                        Icons.close,
                        size: 30.0,
                      ))),
              SizedBox(
                width: 10.0,
              )
            ],
          ),
          Container(
              padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
              color: Colors.white,
              child: Icon(
                Icons.check_circle,
                size: 150.0,
                color: Colors.green,
              )),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              "Success",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
            ),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
            child: Text(
              "Your profile is updated successfully.",
              style: TextStyle(fontSize: 17.0),
            ),
          )),
        ],
      ),
    );
  }
}
