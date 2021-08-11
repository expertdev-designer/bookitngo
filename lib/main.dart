import 'dart:async';
import 'dart:io';
import 'package:book_it/Web/WebHome/WebDashboardPage.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:book_it/UI/IntroApps/OnBoarding.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'Web/LoginSign/WebSignInSignUpPage.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  HttpOverrides.global = new MyHttpOverrides();
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

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
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

    return

        /*kIsWeb
        ? MaterialApp(
            home: WebSignInSignUpPage(),
            // home: WebDashBoardPage(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                primaryColorLight: Colors.white,
                fontFamily: "Poppins",
                primaryColorBrightness: Brightness.light,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primaryColor: Colors.white),
          )
        : */
        MaterialApp(
          builder: (BuildContext context, Widget child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor: data.textScaleFactor > 1.0 ? 1.0 : data.textScaleFactor),
              child: child,
            );
          },
      title: "Book It n Go",
      home: SplashScreen(),
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

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void _Navigator() {
    LocalStorage.getUserAuthToken().then((value) {
      if (kIsWeb) {
        if (value.isEmpty) {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => WebSignInSignUpPage(),
          ));
        } else {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => WebDashBoardPage(
              tabIndex: 0,
              pageRoute: 'main',
            ),
          ));
        }
      } else {
        if (value.isEmpty) {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => onBoarding(),
          ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => bottomNavBar(
                        userID: value,
                      )));
        }
      }
    });
  }

  /// Set timer splash
  _timer() async {
    return Timer(Duration(milliseconds: kIsWeb ? 0 : 2300), _Navigator);
  }

  @override
  void initState() {
    super.initState();
    _timer();
  }

  /// Check user
  bool _checkUser = true;

  bool loggedIn = false;
  @override
  SharedPreferences prefs;

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
