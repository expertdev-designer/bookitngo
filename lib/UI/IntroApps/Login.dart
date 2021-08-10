import 'package:book_it/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'ForgotPassword.dart';
import 'SignUp.dart';
import 'login_bloc/LoginBloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  var tap = 0;
  bool isLoading = false;
  bool autoValidation = false;
  bool _isHidden = false;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _pass, _email2, _pass2, _name, _id;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  LoginBloc _loginBloc;
  AppConstantHelper _appConstantHelper;
  final String redirectUrl = 'https://smarttersstudio.com';
  final String clientId = '78el5r2y1dwp4j ';
  final String clientSecret = 'RnyXiCNz3cahNx1g ';
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  @override

  /// set state animation controller

  void initState() {
    // LinkedInLogin.initialize(context,
    //     clientId: AppStrings.linkedinClientID,
    //     clientSecret: AppStrings.linkedinClientSecret,
    //     redirectUri: redirectUrl);
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    _loginBloc = LoginBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  void callLoginApi(String email, String password) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _loginBloc.doLogin(
            username: email, password: password.trim(), context: context);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AppConstantHelper.showDialog(
                  context: context,
                  title: "Network Error",
                  msg: "Please check internet connection!");
            });
      }
    });
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          /*
      isLoading
          ? Center(
          child: ColorLoader5(
            dotOneColor: Colors.red,
            dotTwoColor: Colors.blueAccent,
            dotThreeColor: Colors.green,
            dotType: DotType.circle,
            dotIcon: Icon(Icons.adjust),
            duration: Duration(seconds: 1),
          ))
      ////
      /// Layout loading
      ///
          :*/

          Stack(
        children: [
          Form(
            key: _registerFormKey,
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 270,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                height: 300,
                                width: width + 20,
                                child: FadeAnimation(
                                    1.3,
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/image/destinationPopuler/tripBackground.png'),
                                              fit: BoxFit.fill)),
                                    )),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// Fade Animation for transtition animaniton
                              FadeAnimation(
                                  1.2,
                                  Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 37.5,
                                        wordSpacing: 0.1),
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              FadeAnimation(
                                  1.7,
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                196, 135, 198, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10),
                                          )
                                        ]),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            validator: (input) {
                                              Pattern pattern =
                                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                  r"{0,253}[a-zA-Z0-9])?)*$";
                                              RegExp regex =
                                                  new RegExp(pattern);
                                              if (input.isEmpty) {
                                                return 'Please enter an Email';
                                              } else if (!regex
                                                      .hasMatch(input) ||
                                                  input == null)
                                                return 'Please enter a valid Email';
                                              else
                                                return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            onSaved: (input) => _email = input,
                                            controller: loginEmailController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "Email",
                                                icon: Icon(
                                                  Icons.email,
                                                  color: Colors.black12,
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "sofia")),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return 'Please enter a Password';
                                              }
                                              if (input.length < 5) {
                                                return 'Minimum of 5 characters allowed';
                                              } else
                                                return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            onSaved: (input) => _pass = input,
                                            controller: loginPasswordController,
                                            obscureText: _isHidden,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: "Password",
                                              icon: Icon(
                                                Icons.vpn_key,
                                                color: Colors.black12,
                                              ),
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: "sofia"),
                                              suffix: InkWell(
                                                onTap: _togglePasswordView,
                                                child: Icon(
                                                  !_isHidden
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  1.7,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    PageRouteBuilder(
                                                        pageBuilder:
                                                            (_, __, ___) =>
                                                                Signup(),
                                                        transitionDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    2000),
                                                        transitionsBuilder: (_,
                                                            Animation<double>
                                                                animation,
                                                            __,
                                                            Widget child) {
                                                          return Opacity(
                                                            opacity:
                                                                animation.value,
                                                            child: child,
                                                          );
                                                        }));
                                          },
                                          child: Text(
                                            "Create Account",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 1.3),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    pageBuilder: (_, __, ___) =>
                                                        ForgotPassword(),
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 2000),
                                                    transitionsBuilder: (_,
                                                        Animation<double>
                                                            animation,
                                                        __,
                                                        Widget child) {
                                                      return Opacity(
                                                        opacity:
                                                            animation.value,
                                                        child: child,
                                                      );
                                                    }));
                                          },
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 1.3),
                                          )),
                                    ],
                                  )),
                              SizedBox(height: 110)
                            ],
                          ),
                        ),
                      ],
                    ),
                    FadeAnimation(
                        1.9,
                        InkWell(
                          onTap: () async {
                            if (_registerFormKey.currentState.validate()) {
                              await callLoginApi(loginEmailController.text,
                                  loginPasswordController.text);
                            } else {
                              autoValidation = true;
                            }
                            return false;
                            // SharedPreferences prefs;
                            // prefs =
                            //     await SharedPreferences.getInstance();
                            // final formState =
                            //     _registerFormKey.currentState;
                            // FirebaseUser user;
                            // if (formState.validate()) {
                            //   formState.save();
                            //   try {
                            //     prefs.setString("username", _email);
                            //     prefs.setString("id", _id);
                            //     user = await FirebaseAuth.instance
                            //         .signInWithEmailAndPassword(
                            //       email: _email,
                            //       password: _pass,
                            //     );
                            //
                            //     setState(() {
                            //       isLoading = true;
                            //     });
                            //     // user.sendEmailVerification();
                            //
                            //   } catch (e) {
                            //     print('Error: $e');
                            //     CircularProgressIndicator();
                            //     print(e.message);
                            //     print(_email);
                            //
                            //     print(_pass);
                            //   } finally {
                            //     if (user != null) {
                            //       user = await FirebaseAuth.instance
                            //           .signInWithEmailAndPassword(
                            //             email: _email,
                            //             password: _pass,
                            //           )
                            //           .then((currentUser) => Firestore
                            //               .instance
                            //               .collection("users")
                            //               .document(currentUser.uid)
                            //               .get()
                            //               .then((DocumentSnapshot
                            //                       result) =>
                            //                   Navigator.of(context)
                            //                       .pushReplacement(
                            //                           PageRouteBuilder(
                            //                               pageBuilder: (_,
                            //                                       __,
                            //                                       ___) =>
                            //                                   new mainSelection(
                            //                                     userID:
                            //                                         currentUser.uid,
                            //                                   ))))
                            //               .catchError(
                            //                   (err) => print(err)))
                            //           .catchError((err) => print(err));
                            //     } else {
                            //       showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return AppConstantHelper.showDialog(
                            //                 context: context,
                            //                 title: "Login Failed",
                            //                 msg:
                            //                     "Please check your password and try again!");
                            //           });
                            //     }
                            //   }
                            // } else {
                            //   showDialog(
                            //       context: context,
                            //       builder: (BuildContext context) {
                            //         return AppConstantHelper.showDialog(
                            //             context: context,
                            //             title: "Error",
                            //             msg:
                            //                 "Please check your email and password");
                            //       });
                            // }
                            // ;
                          },
                          child: Container(
                            height: 55.0,
                            margin: EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xFF8DA2BF),
                            ),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.5,
                                    letterSpacing: 1.2),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 14),
                FadeAnimation(
                  2.1,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2),
                        Expanded(
                          child: new Container(
                              // margin: const EdgeInsets.only(left: 40.0),
                              child: Divider(
                            color: Colors.black38,
                            // height: 50,
                          )),
                        ),
                        Icon(
                          Icons.brightness_1_outlined,
                          color: Colors.black38,
                          size: 10,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Login With",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Sofia",
                              fontSize: 14,
                              letterSpacing: 1.2),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.brightness_1_outlined,
                          color: Colors.black38,
                          size: 10,
                        ),
                        Expanded(
                          child: new Container(
                              // margin: const EdgeInsets.only(right: 40.0),
                              child: Divider(
                            color: Colors.black38,
                            height: 50,
                          )),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          socialMediaIconWidget(
                              context,
                              "assets/image/images/fb_wb.svg",
                              () => _facebookButtonOnClick()),
                          SizedBox(
                            width: 20,
                          ),
                          socialMediaIconWidget(
                              context, "assets/image/images/g_wb.svg", ()=>_googleButtonOnClick()),
                          SizedBox(
                            width: 20,
                          ),
                          socialMediaIconWidget(
                              context,
                              "assets/image/images/linkedin_wb.svg",
                              () => _linkedinButtonOnClick()),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 30)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<bool>(
            stream: _loginBloc.progressStream,
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

  Widget socialMediaIconWidget(
      BuildContext context, var iconType, VoidCallback onPressed) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(196, 135, 198, .3),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]),
      child: IconButton(
        iconSize: 45,
        icon: SvgPicture.asset(
          iconType,
          width: 24,
          height: 24,
        ),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<void> _facebookButtonOnClick() async {
    final fb = FacebookLogin();
// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! Your ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        // await callLoginApi(
        //     email: email,
        //     social_id: profile.userId,
        //     fullname: profile.name,
        //     social_type: 'facebook');
        fb.logOut();
        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        // Utils.showErrorSnackBar(message: '${res.error}', context: context);
        break;
    }
  }

  void _linkedinButtonOnClick() {
    // LinkedInLogin.getProfile(
    //         destroySession: true,
    //         forceLogin: true,
    //         appBar: AppBar(
    //           title: Text('Demo Login Page'),
    //         ))
    //     .then((profile) => print(profile.toJson().toString()))
    //     .catchError((error) {
    //   print(error.errorDescription);
    // });
  }


  Future<void> _googleButtonOnClick() async {
    try {
      await _googleSignIn.signIn();
      print('${_googleSignIn.currentUser.email.toString()}');
      print('${_googleSignIn.currentUser.displayName.toString()}');
      // await callLoginApi(
      //     email: _googleSignIn.currentUser.email.toString(),
      //     social_type: 'google',
      //     fullname: _googleSignIn.currentUser.displayName.toString(),
      //     social_id: _googleSignIn.currentUser.id.toString());
      _handleSignOut();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
}
