import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AppConstantHelper {
  BuildContext context;
  String cropType;

  AppConstantHelper._internal();

  static final AppConstantHelper _singleton = AppConstantHelper._internal();

  factory AppConstantHelper() {
    return _singleton;
  }

  setContext(BuildContext context) {
    this.context = context;
  }

  setCropType(String cropType) {
    this.cropType = cropType;
  }

  static Widget showDialog({BuildContext context, title, msg}) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: kIsWeb ? MediaQuery.of(context).size.width * 0.2 : 20),
      // title: Text("$title"),
      content: Text("$msg"),
      actions: <Widget>[
        MaterialButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  static String allWordsCapitilize(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter a email address';
    } else if (!regex.hasMatch(value) || value == null)
      return 'Please enter a valid email address';
    else
      return null;
  }

  static Future<bool> checkConnectivity() async {
    bool isConnectd = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isConnectd = true;
      } else {
        isConnectd = false;
      }
    } on SocketException catch (_) {
      print('not connected');
      isConnectd = false;
    }
    return isConnectd;
  }

  Future<bool> requestPermissionForStorageandCamera(bool isCamera) async {
    if (!isCamera) {
      print("Pickerrd1");
      Map<Permission, PermissionStatus> storageStatuses = await [
        Permission.storage,
      ].request().then((value) {
        if (value == PermissionStatus.granted) {
          print("Pickerrd");
        }
      });

      if (storageStatuses == PermissionStatus.denied ||
          storageStatuses == PermissionStatus.denied ||
          storageStatuses == PermissionStatus.restricted) {
        showAlert(true, "Need permissions");
      }
    } else {
      Map<Permission, PermissionStatus> cameraStatus = await [
        Permission.camera,
      ].request();

      if (cameraStatus == PermissionStatus.granted) {
        return true;
      }
      if (cameraStatus == PermissionStatus.denied ||
          cameraStatus == PermissionStatus.denied ||
          cameraStatus == PermissionStatus.restricted) {
        showAlert(true, "Nedd permissions");
      }
    }
  }

  File imageFile;

  Future<Null> pickImage({bool isCamera, Function(File) imagePicked}) async {
    imageFile = isCamera
        ? await ImagePicker.pickImage(
            source: ImageSource.camera,
          )
        : await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      print("imageFile>>${imageFile.path}");
      cropRectangleImage(false, imageFile).then((imgFile) async {
        if (imgFile != null) {
          if (imageFile == imgFile) {
          } else {
            //set & upload the image to server
            imagePicked(imgFile);
          }
        }
      });
    } else {
      showAlert(true, "Need Camera & Gellery Permission");
    }
  }

  Future<File> cropRectangleImage(
    bool isCircular,
    File imageFile,
  ) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      cropStyle: cropType == 'Circle' ? CropStyle.circle : CropStyle.rectangle,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
      ],
      iosUiSettings: IOSUiSettings(
        aspectRatioLockEnabled: true,
        rotateButtonsHidden: true,
        minimumAspectRatio: 1.0,
      ),
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          showCropGrid: false,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
    );

    if (croppedFile != null) {
      imageFile = croppedFile;
    }
    return imageFile;
  }

  void showAlert(bool val, String text) {
    print(context);
    var alert = AlertDialog(
      title: Text("Error"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      )),
      content: Stack(
        children: <Widget>[
          Container(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
//          Positioned(
//              top: 0,
//              child: Image.asset(
//                Images.ICON_APP_NIGERIA,
//                height: 50,
//                width: 50,
//              ))
        ],
      ),
      actions: [
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
  }

  placeHolderImage({String imagePath, double height, double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(98)),
        child: Image.asset(
          'assets/images/profile.png',
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
