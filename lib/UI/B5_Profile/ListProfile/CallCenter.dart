import 'package:book_it/UI/B5_Profile/bloc/CallCenterBloc.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
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

  void addData() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      Firestore.instance.collection("Laporan").add({
        "Name": _name,
        "Email": _email,
        "Detail Problem": _problem,
      });
    });
    Navigator.pop(context);
  }

  void callCenterUpdateProblemApi() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _callCenterBloc.callCenter(
            context: context, username: _name, email: _email, detail: _problem);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text("Call Center"),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 12.0, left: 12.0, top: 15.0),
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                Text(
                  "Call Center",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
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
                        email.clear();
                        problem.clear();
                      }
                      return Form(
                        key: _form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please input your name';
                                }
                              },
                              onSaved: (input) => _name = input,
                              controller: nama,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Colors.black12.withOpacity(0.01))),
                                contentPadding: EdgeInsets.all(13.0),
                                hintText: "Input your name",
                                hintStyle: TextStyle(
                                    fontFamily: "Sans", fontSize: 15.0),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0)),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please input your email';
                                }
                              },
                              onSaved: (input) => _email = input,
                              controller: email,
                              keyboardType: TextInputType.text,
                              // textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Colors.black12.withOpacity(0.01))),
                                contentPadding: EdgeInsets.all(13.0),
                                hintText: "Input your email",
                                hintStyle: TextStyle(
                                    fontFamily: "Sans", fontSize: 15.0),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Detail Problem",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0)),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) {
                                    return 'Please input your problem';
                                  }
                                },
                                maxLines: 10,
                                onSaved: (input) => _problem = input,
                                controller: problem,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.5,
                                          color: Colors.black12
                                              .withOpacity(0.01))),
                                  contentPadding: EdgeInsets.all(13.0),
                                  hintText: "Input your problem",
                                  hintStyle: TextStyle(
                                      fontFamily: "Sans", fontSize: 15.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
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
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Error"),
                                          content: Text(
                                              "Please input your information"),
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
                              },
                              child: Container(
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xFF09314F),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                child: Center(
                                  child: Text(
                                    "Input Data",
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
