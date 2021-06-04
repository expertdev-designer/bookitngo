import 'package:book_it/UI/IntroApps/login_bloc/LoginBloc.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/WebAppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:book_it/Web/WebHome/WebDashboardPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WebSignInSignUpPage extends StatefulWidget {
  @override
  _WebSignInSignUpPageState createState() => _WebSignInSignUpPageState();
}

class _WebSignInSignUpPageState extends State<WebSignInSignUpPage> {
  bool isSignUpSelected = true;
  bool isForgotSelected = false;
  bool isSignInSelected = false;

  // bool isSignInSelected = false;

  final List<SliderList> imagesList = [
    SliderList(
        imageUrl: "assets/image/onBoardingImage/B1.png",
        title: "Easy Find Hotel",
        des:
            "Haselfree  booking  of  flight  tickets  \nwith  full  refund  on  cancelation"),
    SliderList(
        imageUrl: "assets/image/onBoardingImage/N1.png",
        title: "Booking Hotel",
        des:
            "Haselfree  booking  of  flight  tickets  \nwith  full  refund  on  cancelation"),
    SliderList(
        imageUrl: "assets/image/onBoardingImage/G1.png",
        title: "Discover Place",
        des:
            "Haselfree  booking  of  flight  tickets  \nwith  full  refund  on  cancelation"),
  ];

  int _currentIndex = 0;

  /*   Sign Up  Controllers.......*/
  final GlobalKey<FormState> _formSignUpKey = new GlobalKey<FormState>();

  final TextEditingController _textFullNameController = TextEditingController();
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();

  /*  Sign In  Controllers.......*/
  final GlobalKey<FormState> _formSignInKey = new GlobalKey<FormState>();
  final TextEditingController _signInPasswordController =
      TextEditingController();
  final TextEditingController _signInEmailController = TextEditingController();

  /*  Forgot Password Controllers.......*/
  final GlobalKey<FormState> _formForgotPasswordKey =
      new GlobalKey<FormState>();
  final TextEditingController _forgotEmailController = TextEditingController();

  LoginBloc _loginBloc;
  AppConstantHelper _appConstantHelper;

  @override
  void initState() {
    _loginBloc = LoginBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    super.initState();
  }

  void callLoginApi(String email, String password) {
    _loginBloc.doLogin(
        username: email, password: password.trim(), context: context);
  }

  void callSignUpApi({String email, String password, String fullName}) {
    _loginBloc.register(
        username: fullName,
        email: email,
        password: password.trim(),
        context: context);
  }

  void callForgotPasswordApi(String email) {
    _loginBloc.forgotPassword(email: email, context: context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _headerWidget(height, width),
                _mainContainerWidget(height, width),
                _footerWidget(height, width),
              ],
            ),
            // child: StreamBuilder<int>(
            //     initialData: null,
            //     stream: _loginBloc.onSuccessStream,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData && snapshot.data == 1) {
            //         _textPasswordController.clear();
            //         _textFullNameController.clear();
            //         _textEmailController.clear();
            //         isSignUpSelected = false;
            //         isSignInSelected=true;
            //         isForgotSelected=false;
            //
            //       } else if (snapshot.hasData && snapshot.data == 2) {
            //         _forgotEmailController.clear();
            //         isSignUpSelected = false;
            //         isSignInSelected=true;
            //         isForgotSelected=false;
            //
            //       }
            //
            //       return Column(
            //         children: [
            //           _headerWidget(height, width),
            //           _mainContainerWidget(height, width),
            //           _footerWidget(height, width),
            //         ],
            //       );
            //     }),
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

  _headerWidget(height, width) {
    return Container(
      width: width,
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(
                    10,
                  ),
                  height: 60,
                  child: Image.asset("assets/image/logo/fullLogo.png"),
                )
              ],
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.only(right: 24, left: 24, top: 12, bottom: 12),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: isSignUpSelected ? Colors.white : Colors.black),
                borderRadius: BorderRadius.circular(4)),
            splashColor: Colors.black12,
            onPressed: () {
              // if (isSignUpSelected) {
              //
              //   isSignUpSelected = false;
              // } else {
              //   isSignUpSelected = true;
              // }
              if (!isSignInSelected) {
                isSignInSelected = true;
                isSignUpSelected = false;
              }
              setState(() {});
            },
            child: Text(
              WebAppStrings.sign_in,
              style: TextStyle(
                  fontSize: isSignInSelected && !isSignUpSelected ? 16.0 : 14,
                  fontWeight: isSignInSelected && !isSignUpSelected
                      ? FontWeight.w600
                      : FontWeight.w600,
                  color: isSignInSelected && !isSignUpSelected
                      ? Colors.black87
                      : Colors.black87.withOpacity(0.7),
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: 1,
          ),
          MaterialButton(
            padding: EdgeInsets.only(right: 24, left: 24, top: 12, bottom: 12),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: isSignUpSelected ? Colors.black : Colors.white),
                borderRadius: BorderRadius.circular(4)),
            splashColor: Colors.black12,
            onPressed: () {
              if (!isSignUpSelected) {
                isSignUpSelected = true;
                isSignInSelected = false;
              }
              /*else {
                isSignUpSelected = true;
              }*/
              setState(() {});
            },
            child: Text(
              WebAppStrings.sign_up,
              style: TextStyle(
                  fontSize: isSignUpSelected && !isSignInSelected ? 16.0 : 14,
                  fontWeight: isSignUpSelected && !isSignInSelected
                      ? FontWeight.w600
                      : FontWeight.w600,
                  color: isSignUpSelected && !isSignInSelected
                      ? Colors.black87
                      : Colors.black87.withOpacity(0.7),
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  _mainContainerWidget(height, width) {
    return Container(
      width: width,
      color: Colors.white,
      child: width < 650
          ? Column(
              children: [_mobileSliderViewWidget(500), _mobileFormWidget()],
            )
          : Row(
              children: [_webSliderViewWidget(height), _webFormWidget()],
            ),
    );
  }

  _footerWidget(height, width) {
    return Container(
      width: width,
      height: 80,
      margin: EdgeInsets.only(top: 50),
      color: Color(0xFFF6F6F6),
      child: Center(
        child: Text(
          WebAppStrings.copy_right,
          style: TextStyle(
              fontFamily: "Gotik",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF474747),
              letterSpacing: 1.5),
        ),
      ),
    );
  }

  _signInWidget() {
    return Form(
      key: _formSignInKey,
      child: Column(
        children: [
          Text(
            WebAppStrings.sign_in.toUpperCase(),
            style: TextStyle(
                fontSize: 24,
                height: 2.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.5),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _signInEmailController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              Pattern pattern =
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                  r"{0,253}[a-zA-Z0-9])?)*$";
              RegExp regex = new RegExp(pattern);

              if (val.isEmpty) {
                return WebAppStrings.emailEmptyError;
              } else if (!regex.hasMatch(val))
                return WebAppStrings.emailValidError;
              else
                return null;
            },
            decoration: InputDecoration(
              labelText: 'Email *',
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.5,
                  )),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _signInPasswordController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (val.isEmpty) {
                return WebAppStrings.passwordEmptyError;
              } else if (val.length < 6) {
                return WebAppStrings.passwordLengthError;
              } else
                return null;
            },
            obscuringCharacter: "*",
            decoration: InputDecoration(
              labelText: 'Password *',
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.5,
                  )),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 30),
          MaterialButton(
              color: AppColor.colorGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              onPressed: () {
                //sign in click
                if (_formSignInKey.currentState.validate()) {
                  print("Working");
                  // call  sign in api here ...........

                  callLoginApi(_signInEmailController.text,
                      _signInPasswordController.text);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  WebAppStrings.sign_in.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.5),
                ),
              )),
          SizedBox(height: 20),
          MaterialButton(
            onPressed: () {
              print("isForgotSelected");
              isForgotSelected = true;
              isSignUpSelected = false;
              isSignInSelected = false;
              setState(() {});
            },
            child: Text(
              WebAppStrings.forgot_password,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            color: AppColor.webGreenColor,
            height: 0.3,
          ),
          Text(
            'New ?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up ',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.8,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  splashColor: AppColor.colorGreen,
                  onTap: () {
                    isForgotSelected = false;
                    isSignUpSelected = true;
                    isSignInSelected = false;
                    setState(() {});
                  },
                  child: Text(
                    'Here',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.8,
                      fontWeight: FontWeight.w500,
                      color: AppColor.colorGreen,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _signUpWidget() {
    return Form(
      key: _formSignUpKey,
      child: Column(
        children: [
          Text(
            WebAppStrings.sign_up.toUpperCase(),
            style: TextStyle(
                fontSize: 24,
                height: 2.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.5),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _textFullNameController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (val.isEmpty) {
                return WebAppStrings.fullNameEmptyError;
              } else
                return null;
            },
            decoration: InputDecoration(
              labelText: 'Full Name *',
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.5,
                  )),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _textEmailController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              Pattern pattern =
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                  r"{0,253}[a-zA-Z0-9])?)*$";
              RegExp regex = new RegExp(pattern);

              if (val.isEmpty) {
                return WebAppStrings.emailEmptyError;
              } else if (!regex.hasMatch(val))
                return WebAppStrings.emailValidError;
              else
                return null;
            },
            decoration: InputDecoration(
              labelText: 'Email *',
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.5,
                  )),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _textPasswordController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            obscureText: true,
            obscuringCharacter: "*",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (val.isEmpty) {
                return WebAppStrings.passwordEmptyError;
              } else if (val.length < 6) {
                return WebAppStrings.passwordLengthError;
              } else
                return null;
            },
            decoration: InputDecoration(
              labelText: 'Password *',
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.5,
                  )),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 30),
          MaterialButton(
              color: AppColor.colorGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              onPressed: () {
                if (_formSignUpKey.currentState.validate()) {
                  // call sign up api here ..........
                  callSignUpApi(
                      fullName: _textFullNameController.text,
                      email: _textEmailController.text,
                      password: _textPasswordController.text);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  WebAppStrings.sign_up.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.5),
                ),
              )),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            color: AppColor.webGreenColor,
            height: 0.3,
          ),
          Text(
            'Existing Account?',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: AppColor.colorGreen,
              onTap: () {
                isForgotSelected = false;
                isSignUpSelected = false;
                isSignInSelected = true;
                setState(() {});
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                  color: AppColor.webWhiteColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _forgotPasswordWidget() {
    return Form(
      key: _formForgotPasswordKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            WebAppStrings.forgot_password.toUpperCase(),
            style: TextStyle(
                fontSize: 24,
                height: 2.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.5),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _forgotEmailController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              Pattern pattern =
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                  r"{0,253}[a-zA-Z0-9])?)*$";
              RegExp regex = new RegExp(pattern);

              if (val.isEmpty) {
                return WebAppStrings.emailEmptyError;
              } else if (!regex.hasMatch(val))
                return WebAppStrings.emailValidError;
              else
                return null;
            },
            decoration: InputDecoration(
              labelText: 'Email *',
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.5,
                  )),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 30),
          MaterialButton(
              color: AppColor.colorGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              onPressed: () {
                if (_formForgotPasswordKey.currentState.validate()) {
                  callForgotPasswordApi(_forgotEmailController.text);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  WebAppStrings.send.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.5),
                ),
              )),
          SizedBox(height: 180),
          MaterialButton(
            onPressed: () {
              isForgotSelected = false;
              isSignInSelected = true;
              isSignUpSelected = false;
              setState(() {});
            },
            child: Text(
              WebAppStrings.back,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _mobileSliderViewWidget(height) {
    return _crousel(height);
  }

  _webSliderViewWidget(height) {
    return Expanded(child: _crousel(height));
  }

  Widget _crousel(height) {
    return Container(
      // margin: EdgeInsets.all(20),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.0,
              height: height,
              // enlargeCenterPage: true,
              //scrollDirection: Axis.vertical,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _currentIndex = index;
                  },
                );
              },
            ),
            items: imagesList
                .map(
                  (item) => Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            // height: MediaQuery.of(context).size.height*0.7,
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Image.asset(
                                "${item.imageUrl}",
                                // fit: BoxFit.fitHeight,
                              ),
                            )),
                        Expanded(
                          // height: MediaQuery.of(context).size.height*0.1,
                          flex: 1,
                          child: Text(
                            "${item.title}",
                            style: TextStyle(
                                fontSize: 34,
                                height: _currentIndex == 2 ? 2 : 1,
                                fontWeight: FontWeight.w700,
                                color: AppColor.webBlackColor,
                                letterSpacing: 1.5),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          // height: MediaQuery.of(context).size.height*0.2,
                          child: Text(
                            "${item.des}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                height: 1.2,
                                fontWeight: FontWeight.w400,
                                color: AppColor.webBlackColor,
                                letterSpacing: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imagesList.map((urlOfItem) {
              int index = imagesList.indexOf(urlOfItem);
              return Container(
                width: 60.0,
                height: 4.0,
                margin: EdgeInsets.only(top: 20, bottom: 30.0, right: 10),
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  gradient: _currentIndex == index
                      ? LinearGradient(colors: [
                          Color(0xFF7D55B6),
                          Color(0xFF6774E7),
                        ])
                      : LinearGradient(colors: [
                          Color(0xFFD8D8D8),
                          Color(0xFFD8D8D8),
                        ]),
                  // color: _currentIndex == index
                  //     ? Color.fromRGBO(0, 0, 0, 0.8)
                  //     : Color.fromRGBO(0, 0, 0, 0.3),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  _webFormWidget() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
            color: AppColor.webPrimaryColor,
            borderRadius: BorderRadius.circular(14)),
        child: isSignInSelected && !isSignUpSelected && !isForgotSelected
            ? _signInWidget()
            : !isSignInSelected && isSignUpSelected && !isForgotSelected
                ? _signUpWidget()
                : !isSignInSelected && !isSignUpSelected && isForgotSelected
                    ? _forgotPasswordWidget()
                    : _signUpWidget(),
        // child: isForgotSelected && !isSignUpSelected
        //     ? _forgotPasswordWidget()
        //     : !isSignUpSelected && !isForgotSelected
        //         ? _signInWidget()
        //         : isSignUpSelected && !isForgotSelected
        //             ? _signUpWidget()
        //             : _signUpWidget(),
      ),
    );
  }

  _mobileFormWidget() {
    return Container(
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
          color: AppColor.webPrimaryColor,
          borderRadius: BorderRadius.circular(14)),
      child: isSignInSelected && !isSignUpSelected && !isForgotSelected
          ? _signInWidget()
          : !isSignInSelected && isSignUpSelected && !isForgotSelected
              ? _signUpWidget()
              : !isSignInSelected && !isSignUpSelected && isForgotSelected
                  ? _forgotPasswordWidget()
                  : _signUpWidget(),
      // child: isForgotSelected && !isSignUpSelected
      //     ? _forgotPasswordWidget()
      //     : !isSignUpSelected && !isForgotSelected
      //         ? _signInWidget()
      //         : isSignUpSelected && !isForgotSelected
      //             ? _signUpWidget()
      //             : _signUpWidget(),
    );
  }
}

class SliderList {
  var imageUrl;
  var title;
  var des;

  SliderList({this.imageUrl, this.title, this.des});
}
