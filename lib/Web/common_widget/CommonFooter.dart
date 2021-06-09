import 'package:book_it/UI/Utills/WebAppStrings.dart';
import 'package:flutter/cupertino.dart';

class CommonFooterWidget extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return _footerWidget(height,width);

  }

}

_footerWidget(height, width) {
  return Container(
    width: width,
    // height: 80,
    margin: EdgeInsets.only(top: 20),
    padding: EdgeInsets.symmetric(vertical: 20),
    color: Color(0xFF000000),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  WebAppStrings.about_us,
                  style: TextStyle(
                      fontFamily: "Gotik",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 1.5),
                ),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Flexible(
                child: Text(
                  WebAppStrings.contact_us,
                  style: TextStyle(
                      fontFamily: "Gotik",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 1.5),
                ),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Flexible(
                child: Text(
                  WebAppStrings.privacy_Policy,
                  style: TextStyle(
                      fontFamily: "Gotik",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 1.5),
                ),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Flexible(
                child: Text(
                  WebAppStrings.term_Conditions,
                  style: TextStyle(
                      fontFamily: "Gotik",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 1.5),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            WebAppStrings.copy_right,
            style: TextStyle(
                fontFamily: "Gotik",
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: Color(0xFFFFFFFF),
                letterSpacing: 1.5),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}
