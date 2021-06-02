import 'dart:async';
import 'dart:io';
import 'package:book_it/network_helper/local_storage.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:book_it/UI/IntroApps/OnBoarding.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'UI/B1_Home/Hotel/Hotel_Detail_Concept_2/BookItNow.dart';
import 'UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'UI/IntroApps/Login.dart';
import 'UI/IntroApps/CategorySelection.dart';
import 'Web/LoginSign/WebSignInSignUpPage.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  // runApp(Home());
  runApp(splash());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return kIsWeb ?
    MaterialApp(
      home: WebSignInSignUpPage(),
      //home: splashScreen(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          fontFamily: "Poppins",
          primaryColorBrightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.white),
    ) :
    MaterialApp(
      home: splashScreen(),
      //home: splashScreen(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorBrightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.white),
    );
  }
}

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void _Navigator() {
    LocalStorage.getUserAuthToken().then((value) {
      if (value.isEmpty) {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => onBoarding(),
        ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    bottomNavBar(
                      userID: value,
                    )));
      }
    });

    /*FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => onBoarding(),
                  ))
                }
              else
                {
                  Firestore.instance
                      .collection("users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bottomNavBar(
                                        userID: currentUser.uid,
                                      ))))
                      .catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));*/
  }

  /// Set timer splash
  _timer() async {
    return Timer(Duration(milliseconds: 2300), _Navigator);
  }

  @override
  void initState() {
    super.initState();
    _timer();

    ///
    /// Setting Message Notification from firebase to user
    ///
    // _messaging.getToken().then((token) {
    //   print(token);
    // });
  }

  /// Check user
  bool _checkUser = true;

  bool loggedIn = false;
  @override
  SharedPreferences prefs;

  ///
  /// Checking user is logged in or not logged in
  ///
  Future<Null> _function() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getString("username") != null) {
        print('false');
        _checkUser = false;
      } else {
        print('true');
        _checkUser = true;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("assets/image/splashScreen/splashScreen.png"),
        //         fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Image.asset(
              "assets/image/logo/fullLogo.png",
              width: 250.0,
            ),
          ),
        ),
      ),
    );
  }
}
