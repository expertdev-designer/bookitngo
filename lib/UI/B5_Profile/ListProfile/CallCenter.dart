import 'package:book_it/UI/B5_Profile/bloc/CallCenterBloc.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class callCenter extends StatefulWidget {
  @override
  _callCenterState createState() => _callCenterState();
}

class _callCenterState extends State<callCenter> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _name, _email, _problem;
  TextEditingController nama = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController problem = new TextEditingController();
  CallCenterBloc _callCenterBloc;
  AppConstantHelper _appConstantHelper;
  bool autoValidate = false;

  void callCenterUpdateProblemApi() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _callCenterBloc.callCenter(
            context: context,
            username: nama.text,
            email: email.text,
            detail: problem.text);
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
  void initState() {
    // TODO: implement initState
    super.initState();

    _callCenterBloc = CallCenterBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    email.text = AppStrings.userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Call Center",
          style: TextStyle(
              fontFamily: "Sofia", fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 12.0, left: 12.0, top: 15.0),
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                // Text(
                //   "Call Center",
                //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF8E1),
                      border: Border.all(width: 1.2, color: Color(0xFFFFAB40))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "If something goes wrong with our system, or there are bugs that interfere with the use of the application, please let us know through this form, the admin will respond as soon as possible.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          fontFamily: "Sans"),
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                    initialData: null,
                    stream: _callCenterBloc.successStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data) {
                        nama.clear();
                        // email.clear();
                        problem.clear();
                      }
                      return Form(
                        key: _form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 24.0,
                            ),
                            // Text(
                            //   "Name",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w500, fontSize: 15.0),
                            // ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 6.0, right: 6.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10.0,
                                          color:
                                              Colors.black12.withOpacity(0.1)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                        top: 4,
                                        bottom: 4),
                                    child: Theme(
                                      data: ThemeData(
                                        highlightColor: Colors.white,
                                        hintColor: Colors.white,
                                      ),
                                      child: TextFormField(
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: "Sofia"),
                                          controller: nama,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return "Please enter your full name";
                                            } else
                                              return null;
                                          },
                                          autovalidate: autoValidate,
                                          onChanged: (val) {
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Full name',
                                            labelStyle: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: "Sofia",
                                                height: 1.0),
                                            enabledBorder:
                                                new UnderlineInputBorder(
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
                            // TextFormField(
                            //   validator: (input) {
                            //     if (input.isEmpty) {
                            //       return 'Please input your name';
                            //     }
                            //   },
                            //   autovalidate: autoValidate,
                            //   onChanged: (val)
                            //   {
                            //     setState(() {
                            //
                            //     });
                            //   },
                            //   onSaved: (input) => _name = input,
                            //   controller: nama,
                            //   keyboardType: TextInputType.text,
                            //   textCapitalization: TextCapitalization.words,
                            //   style: TextStyle(
                            //       fontFamily: "WorkSansSemiBold",
                            //       fontSize: 16.0,
                            //       color: Colors.black),
                            //   decoration: InputDecoration(
                            //    // filled: true,
                            //     enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.grey),
                            //     ),
                            //     border: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.grey),
                            //     ),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.grey),
                            //     ),
                            //
                            //     contentPadding: EdgeInsets.all(13.0),
                            //     hintText: "Input your name",
                            //     hintStyle: TextStyle(
                            //         fontFamily: "Sans", fontSize: 15.0),
                            //   ),
                            // ),
                            SizedBox(
                              height: 24.0,
                            ),
                            // Text("Email",
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.w500,
                            //         fontSize: 15.0)),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 6.0, right: 6.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10.0,
                                          color:
                                              Colors.black12.withOpacity(0.1)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0,
                                          right: 0.0,
                                          top: 0,
                                          bottom: 0),
                                      child: Theme(
                                        data: ThemeData(
                                          highlightColor: Colors.white,
                                          hintColor: Colors.white,
                                        ),
                                        child: TextFormField(
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: "Sofia"),
                                            controller: email,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return "Input your email";
                                              } else
                                                return null;
                                            },
                                            autovalidate: autoValidate,
                                            onChanged: (val) {
                                              setState(() {});
                                            },
                                            enabled: false,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20.0,
                                                      top: 16,
                                                      bottom: 16),
                                              labelText: 'Email',
                                              filled: true,
                                              labelStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily: "Sofia",
                                                  height: 1.0),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
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
                            // TextFormField(
                            //   validator: (input) {
                            //     if (input.isEmpty) {
                            //       return 'Please input your email';
                            //     }
                            //   },
                            //   onSaved: (input) => _email = input,
                            //   controller: email,
                            //   keyboardType: TextInputType.text,
                            //   // textCapitalization: TextCapitalization.words,
                            //   style: TextStyle(
                            //       fontFamily: "WorkSansSemiBold",
                            //       fontSize: 16.0,
                            //       color: Colors.black),
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     enabled: false,
                            //     border: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //             width: 0.5,
                            //             color:
                            //                 Colors.black12.withOpacity(0.01))),
                            //     contentPadding: EdgeInsets.all(13.0),
                            //     hintText: "Input your email",
                            //     hintStyle: TextStyle(
                            //         fontFamily: "Sans", fontSize: 15.0),
                            //   ),
                            // ),
                            SizedBox(
                              height: 24.0,
                            ),
                            // Text("Description",
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.w500,
                            //         fontSize: 15.0)),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 6.0, right: 6.0),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10.0,
                                          color:
                                              Colors.black12.withOpacity(0.1)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 4,
                                      bottom: 4),
                                  child: Center(
                                    child: Theme(
                                      data: ThemeData(
                                        highlightColor: Colors.white,
                                        hintColor: Colors.white,
                                      ),
                                      child: TextFormField(
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: "Sofia"),
                                          controller: problem,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return "Please explain the problem that you are facing on this app.";
                                            } else
                                              return null;
                                          },
                                          autovalidate: autoValidate,
                                          onChanged: (val) {
                                            setState(() {});
                                          },
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                          minLines: 5,
                                          maxLines: 8,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            labelText: 'Description',
                                            hintText:
                                                "Please explain the problem that you are facing on this app.",
                                            labelStyle: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: "Sofia",
                                                height: 1.0),
                                            hintStyle: TextStyle(
                                                color: Colors.black38,
                                                fontFamily: "Sofia",
                                                height: 1.0,
                                                fontSize: 14),
                                            enabledBorder:
                                                new UnderlineInputBorder(
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
                            // Container(
                            //   color: Colors.white,
                            //   width: double.infinity,
                            //   child: TextFormField(
                            //     validator: (input) {
                            //       if (input.isEmpty) {
                            //         return 'Please enter the problem that you are facing on this app.';
                            //       }
                            //     },
                            //     autovalidate: autoValidate,
                            //     onChanged: (val)
                            //     {
                            //       setState(() {
                            //
                            //       });
                            //     },
                            //     maxLines: 10,
                            //     onSaved: (input) => _problem = input,
                            //     controller: problem,
                            //     keyboardType: TextInputType.text,
                            //     textCapitalization: TextCapitalization.words,
                            //     style: TextStyle(
                            //         fontFamily: "WorkSansSemiBold",
                            //         fontSize: 16.0,
                            //         color: Colors.black),
                            //     decoration: InputDecoration(
                            //
                            //       contentPadding: EdgeInsets.all(13.0),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.grey),
                            //       ),
                            //       border: OutlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.grey),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.grey),
                            //       ),
                            //       hintText: "Please explain the problem that you are facing on this app.",
                            //       hintStyle: TextStyle(
                            //           fontFamily: "Sans", fontSize: 15.0),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 40.0,
                            ),
                            InkWell(
                              onTap: () {
                                final formState = _form.currentState;

                                if (formState.validate()) {
                                  formState.save();
                                  setState(() {});
                                  // addData();
                                  callCenterUpdateProblemApi();
                                } else {
                                  autoValidate = true;
                                }
                              },
                              child: Container(
                                height: 60.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xFF09314F),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        fontFamily: "Popins",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
            StreamBuilder<bool>(
              stream: _callCenterBloc.progressStream,
              builder: (context, snapshot) {
                return Center(
                    child: CommmonProgressIndicator(
                        snapshot.hasData ? snapshot.data : false));
              },
            )
          ],
        ),
      ),
    );
  }
}
