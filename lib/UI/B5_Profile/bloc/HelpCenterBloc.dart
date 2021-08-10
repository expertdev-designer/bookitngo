import 'dart:async';
import 'dart:io';
import 'package:book_it/UI/B5_Profile/ListProfile/CallCenter.dart';
import 'package:book_it/UI/B5_Profile/ListProfile/HelpCenter.dart';
import 'package:book_it/UI/B5_Profile/model/HelpCenterResponse.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HelpCenterBloc {
  // show progress dialog stream.......
  Stream get progressStream => progressController.stream;
  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  // help data  stream.......
  Stream get helpDataStream => helpDataController.stream;
  final BehaviorSubject helpDataController = BehaviorSubject<List<HelpData>>();
  StreamSink get helpDataSink => helpDataController.sink;


  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void callHelpCenterApi({BuildContext context}) {
    progressSink.add(true);
    apiRepository.callHelpCenterApi().then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        progressSink.add(true);
        helpDataSink.add(onResponse.data);
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
