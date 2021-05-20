import 'package:book_it/Library/loader_animation/dot.dart';
import 'package:book_it/Library/loader_animation/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CommmonProgressIndicator extends StatelessWidget {
  var isLoading = false;

  CommmonProgressIndicator(this.isLoading);

  @override
  Widget build(BuildContext context) {
    // final spinkit = SpinKitCircle(
    //   itemBuilder: (BuildContext context, int index) {
    //     return DecoratedBox(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //         color:  AppColor.dollerOrangeColor,
    //
    //       ),
    //     );
    //   },
    // );
    return isLoading
        ? Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: isLoading
                ? Container(child: Center(
                child: ColorLoader5(
                  dotOneColor: Colors.red,
                  dotTwoColor: Colors.blueAccent,
                  dotThreeColor: Colors.green,
                  dotType: DotType.circle,
                  dotIcon: Icon(Icons.adjust),
                  duration: Duration(seconds: 1),
                )),
              decoration: BoxDecoration(color: Colors.transparent.withOpacity(0.1)),)
                : Container())
        : Container(
            height: 0.0,
            width: 0.0,
          );
  }
}


