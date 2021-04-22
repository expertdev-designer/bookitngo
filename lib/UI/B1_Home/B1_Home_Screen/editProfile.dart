import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:book_it/bottomsheet/file_picker_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import 'bloc/EditProfileBloc.dart';

class updateProfile extends StatefulWidget {
  String name, password, photoProfile, uid;

  updateProfile({
    this.name,
    this.photoProfile,
    this.uid,
  });

  _updateProfileState createState() => _updateProfileState();
}

class _updateProfileState extends State<updateProfile> {
  TextEditingController nameController, countryController, cityController;
  final _formKey = GlobalKey<FormState>();
  String name = "";
  var profilePicUrl;
  File _image;
  String filename;
  String data;
  bool imageUpload = true;
  EditProfileBloc editProfileBloc;
  AppConstantHelper _appConstantHelper;



  @override
  void initState() {
    editProfileBloc = EditProfileBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setCropType("Circle");
    nameController = TextEditingController(
        text: AppConstantHelper.allWordsCapitilize(widget.name));
    super.initState();
  }

  void pickFileAndUploadToServer(BuildContext context) async {
    await Permission.camera.request();
    filePickerBottomSheet(context, _appConstantHelper, (filePicked) {
      print("filePath${filePicked.path}");
      _image = filePicked;
      setState(() {});
      editProfileBloc.uploadProfileImage(context: context, file: filePicked);
    });
  }

  void updateUsernameApiCall(String username) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        editProfileBloc.updateUsername(username: username, context: context);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AppConstantHelper.showDialog(
                  context: context,
                  title: "Network Error",
                  msg: "Please check your internet connection!");
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text("Edit Profile",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 17.0,
            )),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<bool>(
                          initialData: false,
                          stream: editProfileBloc.progressStream,
                          builder: (context, snapshot) {
                            return Container(
                              height: 140.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80.0)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12.withOpacity(0.1),
                                        blurRadius: 10.0,
                                        spreadRadius: 4.0)
                                  ]),
                              child: snapshot.hasData && !snapshot.data
                                  ? Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 170.0,
                                          width: 170.0,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(AppStrings
                                                                .userImage.isNotEmpty
                                                    ? AppStrings.imagePAth +
                                                        AppStrings.userImage
                                                    : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              ),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(170.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.1),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 2.0)
                                              ]),
                                        ),
                                        // CircleAvatar(
                                        //   backgroundColor: Colors.blueAccent,
                                        //   radius: 170.0,
                                        //   backgroundImage:
                                        //       NetworkImage(AppStrings.imagePAth+ widget.photoProfile,),
                                        // ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            onTap: () {
                                              // selectPhoto();
                                              pickFileAndUploadToServer(context);
                                            },
                                            child: Container(
                                              height: 45.0,
                                              width: 45.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                color: AppColor.primaryColor,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                  size: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                            );
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.black12.withOpacity(0.1)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Theme(
                          data: ThemeData(
                            highlightColor: Colors.white,
                            hintColor: Colors.white,
                          ),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                                style: TextStyle(
                                    color: Colors.black87, fontFamily: "Sofia"),
                                controller: nameController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please input your name";
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontFamily: "Sofia"),
                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                        style: BorderStyle.none),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0, top: 150.0),
                    child: InkWell(
                      onTap: () {
                        //  uploadImage();
                        // _showDialog(context);
                        if (_formKey.currentState.validate()) {
                          updateUsernameApiCall(nameController.text);
                        }
                      },
                      child: Container(
                        height: 55.0,
                        width: double.infinity,
                        child: Center(
                          child: Text("Update Profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0,
                                  fontFamily: "Sofia")),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF09314F),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<bool>(
            stream: editProfileBloc.progressStream,
            builder: (context, snapshot) {
              return Center(
                  child: CommmonProgressIndicator(
                      snapshot.hasData ? snapshot.data : false));
            },
          )
        ],
      ),
    );
  }
}

/// Card Popup if success payment
