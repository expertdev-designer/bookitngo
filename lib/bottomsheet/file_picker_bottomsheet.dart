import 'dart:io';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void filePickerBottomSheet(context, AppConstantHelper helper,Function(File) onFilePicked) async {
  Future<void> requestPermission(Permission permission,bool isCamera) async {


    Map<Permission, PermissionStatus> statuses = await [permission].request();
    PermissionStatus permissionStatus = statuses[permission];
    print("pickImage>>>>>${permissionStatus}");
    if (permissionStatus == PermissionStatus.granted) {

      await helper.pickImage(isCamera: isCamera, imagePicked: (file) {

        print("pickImage>>>>>${file.path}");
        onFilePicked(file);
      });

    } else {
      helper.showAlert(true, "need permission");
    }
  }

  return await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext bc) {
        return Container(

          padding: EdgeInsets.all(25),
          child: new Wrap(
            children: [
              new ListTile(
                  leading: new Icon(Icons.camera_alt,color: AppColor.primaryColor,),
                  title: new Text('Use Camera ',
                    style: TextStyle(

                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1.0,
                      height: 1.0,
                    ),

                  ),
                  onTap: () {
                    requestPermission(Permission.camera,true);
                    Navigator.pop(context);
                  }),
              Divider(),
              new ListTile(
                leading: new Icon(Icons.image,color: AppColor.primaryColor),
                title: new Text("Open Gallery",
                  style: TextStyle(

                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 1.0,
                    height: 1.0,
                  ),

                ),
                onTap: () {
                  if (Platform.isAndroid)
                    requestPermission(Permission.storage,false);
                  else
                    requestPermission(Permission.photos,false);

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}
