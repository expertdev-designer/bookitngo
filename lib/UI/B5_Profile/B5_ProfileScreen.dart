import 'package:book_it/UI/B1_Home/B1_Home_Screen/editProfile.dart';
import 'package:book_it/UI/B5_Profile/ListProfile/AboutApps.dart';
import 'package:book_it/UI/IntroApps/onBoardingVideo.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Webview/web_view_screen.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ListProfile/CallCenter.dart';
import 'ListProfile/CreditCard.dart';
import 'ListProfile/HelpCenter.dart';

class profile extends StatefulWidget {
  String userID;

  profile({this.userID});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  ///
  /// Function for if user logout all preferences can be deleted
  ///
  _delete() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();
    LocalStorage.clearAllPreferncesData();
  }

  _launchURL() async {
    const url = 'http://bookitngo.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            height: 352.0,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/image/images/bannerProfile.png",
                    ),
                    fit: BoxFit.cover)),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 67.0, left: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 90.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(AppStrings
                                      .userImage.isNotEmpty
                                  ? AppStrings.imagePAth + AppStrings.userImage
                                  : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0)
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppStrings.userName != null
                                    ? AppConstantHelper.allWordsCapitilize(
                                        AppStrings.userName)
                                    : "Name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0),
                              ),
                              Text(
                                AppStrings.userEmail != null ||
                                        AppStrings.userEmail != ""
                                    ? AppStrings.userEmail
                                    : "Email",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ]),
                      ),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 230.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new updateProfile(
                                  name: "${AppStrings.userName}",
                                  uid: "widget.userID",
                                  photoProfile: "${AppStrings.userImage}",
                                )))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: category(
                    txt: "Edit Profile",
                    image: "assets/image/icon/profile.png",
                    padding: 20.0,
                    isSvg: false,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new AddCreditCard(
                            /* name: userDocument["name"],
                                       email: userDocument["email"],
                                       password: userDocument["password"],
                                       uid: widget.userID,
                                       photoProfile:
                                           userDocument["photoProfile"],*/
                            )));
                  },
                  child: category(
                    txt: "Credit Card",
                    image: "assets/image/icon/card.png",
                    padding: 20.0,
                    isSvg: false,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new callCenter()));
                  },
                  child: category(
                    txt: "Call Center",
                    image: "assets/image/icon/callCenter.png",
                    padding: 20.0,
                    isSvg: false,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new helpCenter()));
                  },
                  child: category(
                    txt: "Help Center",
                    image: "assets/image/icon/callCenter.png",
                    padding: 20.0,
                    isSvg: false,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // _launchURL();
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new WebView(
                              text: "About us",
                              url: "https://bookitngo.com/",
                            )));
                  },
                  child: category(
                    txt: "About Us",
                    image: "assets/image/icon/settings.png",
                    padding: 20.0,
                    isSvg: false,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new WebView(
                              text: "Privacy Policy",
                              url: "https://bookitngo.com/privacy-policy/",
                            )));
                  },
                  child: category(
                    txt: "Privacy Policy",
                    image: "assets/image/images/privacy_policy.svg",
                    padding: 20.0,
                    isSvg: true,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // _launchURL();

                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new WebView(
                            text: "Terms & Conditions",
                            url:
                                "https://bookitngo.com/terms-and-conditions/")));
                  },
                  child: category(
                    txt: "Terms & Conditions",
                    image: "assets/image/images/terms.svg",
                    padding: 20.0,
                    isSvg: true,
                  ),
                ),
                InkWell(
                  onTap: () {
                    //clear all preferences.................

                    _delete();
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (_, ___, ____) => new introVideo()));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(
                                    Icons.login,
                                    color: Colors.black38,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Sofia",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black26,
                                size: 15.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        color: Colors.black12,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  bool isSvg;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding, this.isSvg});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: padding),
                      child: !isSvg
                          ? Image.asset(
                              image,
                              height: 25.0,
                            )
                          : SvgPicture.asset(
                              image,
                              height: 25.0,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
