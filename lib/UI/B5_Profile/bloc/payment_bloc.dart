import 'dart:async';
import 'dart:io';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/BookingConfirmPage.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/SelectCheckInOutDate.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/BookingRoomList.dart';
import 'package:book_it/UI/B5_Profile/ListProfile/CallCenter.dart';
import 'package:book_it/UI/B5_Profile/model/PaymentCardResponse.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PaymentBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get cardDataStream => cardDataController.stream;

  final BehaviorSubject cardDataController =
      BehaviorSubject<PaymentCardResponse>();

  StreamSink get cardDataSink => cardDataController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void addCardApi({BuildContext context, String stripeToken}) {
    progressSink.add(true);
    apiRepository.addPaymentCard(stripeToken).then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        // successSink.add(true);
        // showErrorDialog(context, "Call Center", onResponse.message);
        getCardDetail(context: context);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void getCardDetail({BuildContext context}) {
    progressSink.add(true);
    apiRepository.getCard().then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        cardDataSink.add(onResponse);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void createBooking(
      {BuildContext context,
      BookingRoomList roomList,
      String amount,
      String phone,
      String specialInstruction}) {
    progressSink.add(true);
    apiRepository
        .bookHotelApi(
            roomList: roomList)
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        Navigator.of(context).pushReplacement(
            PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                new BookingConfirmPage(bookingData: onResponse.data,),
                transitionDuration:
                Duration(milliseconds: 600),
                transitionsBuilder: (_,
                    Animation<double> animation,
                    __,
                    Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                }));
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      showErrorDialog(context, "Error", onError.toString());
    });
  }

  void deleteCard({BuildContext context, String cardID}) {
    progressSink.add(true);
    apiRepository.deleteCard(cardId: cardID).then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        // successSink.add(true);
        // showErrorDialog(context, "Call Center", onResponse.message);
        getCardDetail(context: context);
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

  // _showUpdateProfileDialog(BuildContext ctx) {
  //   showDialog(
  //     context: ctx,
  //     barrierDismissible: true,
  //     child: SimpleDialog(
  //       children: <Widget>[
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Padding(
  //                 padding: EdgeInsets.only(left: 10.0),
  //                 child: InkWell(
  //                     onTap: () {
  //                       Navigator.of(ctx).pop();
  //                     },
  //                     child: Icon(
  //                       Icons.close,
  //                       size: 30.0,
  //                     ))),
  //             SizedBox(
  //               width: 10.0,
  //             )
  //           ],
  //         ),
  //         Container(
  //             padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
  //             color: Colors.white,
  //             child: Icon(
  //               Icons.check_circle,
  //               size: 150.0,
  //               color: Colors.green,
  //             )),
  //         Center(
  //             child: Padding(
  //           padding: const EdgeInsets.only(top: 16.0),
  //           child: Text(
  //             "Succes",
  //             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
  //           ),
  //         )),
  //         Center(
  //             child: Padding(
  //           padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
  //           child: Text(
  //             "Update Profile Succes",
  //             style: TextStyle(fontSize: 17.0),
  //           ),
  //         )),
  //       ],
  //     ),
  //   );
  // }
}
