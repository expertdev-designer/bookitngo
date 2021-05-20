import 'package:book_it/Library/loader_animation/dot.dart';
import 'package:book_it/Library/loader_animation/loader.dart';
import 'package:book_it/UI/IntroApps/CategorySelection.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_it/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:book_it/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUp.dart';
import 'login_bloc/LoginBloc.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with TickerProviderStateMixin {
  @override
  //Animation Declaration
  AnimationController sanimationController;
  bool autoValidation=false;
  var tap = 0;

  bool isLoading = false;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _email2, _pass2, _name, _id;

  TextEditingController loginEmailController = new TextEditingController();
  LoginBloc _loginBloc;
  AppConstantHelper _appConstantHelper;

  @override

  /// set state animation controller
  void initState() {
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

  void callForgotPasswordApi(String email) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _loginBloc.forgotPassword(email: email, context: context);
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
          /*isLoading
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
          //
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
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, left: 20.0),
                                        child: Container(
                                            height: 35.0,
                                            width: 35.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(40.0),
                                              ),
                                              color: Colors.white70,
                                            ),
                                            child: Icon(
                                              Icons.arrow_back,
                                              color: Colors.black,
                                            )),
                                      ))),
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
                                    "Forgot Password",
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
                                                return 'Please enter an email';
                                              } else if (!regex
                                                      .hasMatch(input) ||
                                                  input == null)
                                                return 'Please enter a valid email';
                                              else
                                                return null;
                                            },
                                            onSaved: (input) => _email = input,
                                            autovalidate: autoValidation,
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
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),

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
                            SharedPreferences prefs;
                            prefs = await SharedPreferences.getInstance();
                            final formState = _registerFormKey.currentState;
                            FirebaseUser user;
                            if (formState.validate()) {
                              callForgotPasswordApi(loginEmailController.text);
                              loginEmailController.clear();
                              /*try {
                                      user = await FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                        email: loginEmailController.text,
                                      )
                                          .then((currentUser) {
                                        // isLoading = false;
                                        loginEmailController.clear();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Forgot Password "),
                                                content: Text(
                                                    "Please check your email for reset password instruction link sent on your email Address "),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text("Close"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      }).catchError((err) {
                                        print(err);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    Text("Forgot Password Failed"),
                                                content: Text(
                                                    "Please check your email and try again! "),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text("Close"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      });

                                      // setState(() {
                                      //   isLoading = true;
                                      // });
                                      // user.sendEmailVerification();

                                    } catch (e) {
                                      print('Error: $e');
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Forgot Password Failed"),
                                              content: Text(
                                                  "Please check your email and try again! "),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Close"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  }*/
                            }
                            else{
                              autoValidation = true;
                            }
                            return false;
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
                                "Send",
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
}
