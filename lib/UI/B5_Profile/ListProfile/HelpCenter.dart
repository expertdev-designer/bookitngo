import 'package:book_it/UI/B5_Profile/bloc/CallCenterBloc.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class helpCenter extends StatefulWidget {
  @override
  _helpCenterState createState() => _helpCenterState();
}

class _helpCenterState extends State<helpCenter> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Help Center",
          style: TextStyle(fontFamily: "Sofia"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 12.0, left: 12.0, top: 15.0),
        child: Stack(
          children: [


            ListView(
              children: <Widget>[
              Text("Welcome! How Can We Help?",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Sofia"),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
