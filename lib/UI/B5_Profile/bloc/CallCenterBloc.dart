import 'dart:async';
import 'dart:io';
import 'package:book_it/UI/B5_Profile/ListProfile/CallCenter.dart';
import 'package:book_it/UI/IntroApps/model/LoginResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/api_repository.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CallCenterBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get successStream => progressController.stream;

  final BehaviorSubject successController = BehaviorSubject<bool>();

  StreamSink get successSink => progressController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

//  Stream get progressStream => progressController.stream;

  void callCenter(
      {BuildContext context, String username, String email, String detail}) {
    progressSink.add(true);
    apiRepository
        .callCenterApi(username: username, email: email, detail: detail)
        .then((onResponse) {
      if (!onResponse.status) {
        print("Error From Server  " + onResponse.message);
        showErrorDialog(context, "Error", onResponse.message);
      } else if (onResponse.status) {
        successSink.add(true);
        showErrorDialog(context, "Success", onResponse.message);
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
//             "Success",
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
//           ),
//         )),
//         Center(
//             child: Padding(
//           padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
//           child: Text(
//             "Update Profile Success",
//             style: TextStyle(fontSize: 17.0),
//           ),
//         )),
//       ],
//     ),
//   );
// }
}
