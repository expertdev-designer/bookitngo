import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:book_it/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:book_it/UI/IntroApps/Login.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BookitDropdownDatePicker.dart';
import 'login_bloc/LoginBloc.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  @override
  //Animation Declaration
  AnimationController sanimationController;
  bool isLoading = false;
  bool autoValidation = false;
  bool _isHidden = false;
  bool isIAgreeSelected = false;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _pass, _pass2, _name;
  var profilePicUrl;
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupLastNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  String dob = "";
  var tap = 0;
  LoginBloc _loginBloc;
  AppConstantHelper _appConstantHelper;
  static final now = DateTime.now();

  final dropdownDatePicker = BookitDropdownDatePicker(
    dateFormat: DateFormat.dmy,
    firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
    lastDate: ValidDate(year: now.year - 18, month: now.month, day: now.day),
    textStyle: TextStyle(
        fontFamily: "Sofia",
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 13.5,
        wordSpacing: 0.1),
    dropdownColor: Colors.white,
    dateHint: DateHint(year: 'Year    ', month: 'Month    ', day: 'Day    '),
    ascending: false,
  );

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

  void callRegisterApi(
    String firstName,
    String lastName,
    String email,
    String password,
    String dob,
  ) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _loginBloc.register(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            dob: dob,
            context: context);
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

    print("dfsdfsfds${dropdownDatePicker.getDate()}");
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Image Top
                        Container(
                          height: 220,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                height: 270,
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
                              FadeAnimation(
                                  1.2,
                                  Text(
                                    "Sign Up",
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp("[a-zA-Z]")),
                                            ],
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return 'Please enter your First Name';
                                              }
                                            },
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            onSaved: (input) => _name = input,
                                            controller: signupNameController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "First Name",
                                                icon: Icon(
                                                  Icons.person,
                                                  color: Colors.black12,
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "sofia")),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return 'Please enter your Last Name';
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp("[a-zA-Z]")),
                                            ],
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            controller:
                                                signupLastNameController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "Last Name",
                                                icon: Icon(
                                                  Icons.person,
                                                  color: Colors.black12,
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "sofia")),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (input) {
                                              Pattern pattern =
                                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                  r"{0,253}[a-zA-Z0-9])?)*$";
                                              RegExp regex =
                                                  new RegExp(pattern);
                                              if (input.isEmpty) {
                                                return 'Please enter your Email';
                                              } else if (!regex
                                                      .hasMatch(input) ||
                                                  input == null)
                                                return 'Please enter a valid Email';
                                              else
                                                return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            onSaved: (input) => _email = input,
                                            controller: signupEmailController,
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            controller:
                                                signupPasswordController,
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return 'Please enter your Password';
                                              }
                                              if (input.length < 5) {
                                                return 'Minimum of 5 characters allowed';
                                              }
                                            },
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            onSaved: (input) => _pass = input,
                                            obscureText: _isHidden,
                                            textInputAction:
                                                TextInputAction.done,
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
                                                )),
                                          ),
                                        ),
                                        birthDateSelectWidget(),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  1.7,
                                  InkWell(
                                      onTap: () async {
                                        Navigator.of(context).pushReplacement(
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    Login(),
                                                transitionDuration: Duration(
                                                    milliseconds: 2000),
                                                transitionsBuilder: (_,
                                                    Animation<double> animation,
                                                    __,
                                                    Widget child) {
                                                  return Opacity(
                                                    opacity: animation.value,
                                                    child: child,
                                                  );
                                                }));
                                      },
                                      child: Text(
                                        "Existing Account? Sign In",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontFamily: "Sofia",
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.3),
                                      ))),
                              SizedBox(
                                height: 40,
                              ),
                              FadeAnimation(
                                  1.9,
                                  InkWell(
                                    onTap: () async {
                                      SharedPreferences prefs;
                                      prefs =
                                          await SharedPreferences.getInstance();
                                      final formState =
                                          _registerFormKey.currentState;
                                      if (formState.validate()) {
                                        if (dropdownDatePicker
                                                .getDate()
                                                .toString() !=
                                            "null-null-null") {
                                          callRegisterApi(
                                              signupNameController.text,
                                              signupNameController.text,
                                              signupEmailController.text,
                                              signupPasswordController.text,
                                              dropdownDatePicker.getDate());
                                          // signupNameController.clear();
                                          // signupEmailController.clear();
                                          // signupPasswordController.clear();
                                        }
                                      } else {
                                        autoValidation = true;
                                      }
                                      return false;
                                    },
                                    child: Container(
                                      height: 55.0,
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xFF8DA2BF),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Sign Up",
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
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    /// Set Animaion after user click buttonSignup
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  birthDateSelectWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Birthday",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Sofia",
                fontWeight: FontWeight.w500,
                fontSize: 17.5,
                letterSpacing: 1.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "To sign up, you must be 18 or older. Other people won't see your birthday.",
            style: TextStyle(
                color: Colors.grey,
                fontFamily: "Sofia",
                fontWeight: FontWeight.w400,
                fontSize: 12.5,
                letterSpacing: 1.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: dropdownDatePicker,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                checkColor: Colors.white,
                activeColor: Colors.green,
                value: isIAgreeSelected,
                onChanged: (val) {
                  isIAgreeSelected = val;
                  setState(() {});
                }),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                  text: TextSpan(
                      text: "By singing up, I agree to Bookit n Go's ",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.5,
                          letterSpacing: 1.2),
                      children: [
                        TextSpan(
                            text: 'Term of Services,',
                            style: TextStyle(
                                color: Colors.green.withOpacity(0.8),
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.5,
                                letterSpacing: 1.2)),
                        TextSpan(
                            text: ' Privacy Policy,',
                            style: TextStyle(
                                color: Colors.green.withOpacity(0.8),
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.5,
                                letterSpacing: 1.2)),
                        TextSpan(
                            text: ' Guest Refund,',
                            style: TextStyle(
                                color: Colors.green.withOpacity(0.8),
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.5,
                                letterSpacing: 1.2)),
                        TextSpan(
                            text: ' Copyright policy,',
                            style: TextStyle(
                                color: Colors.green.withOpacity(0.8),
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.5,
                                letterSpacing: 1.2)),
                        TextSpan(
                            text: ' About Us,',
                            style: TextStyle(
                                color: Colors.green.withOpacity(0.8),
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.5,
                                letterSpacing: 1.2)),
                        TextSpan(
                            text: ' FAQs. ',
                            style: TextStyle(
                                color: Colors.green.withOpacity(0.8),
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.5,
                                letterSpacing: 1.2)),
                      ]),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}
