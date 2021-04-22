import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorLightBlue,
      body: Stack(
        children: [
          okButton(context),
          SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  SvgPicture.asset('assets/image/images/tick.svg',height: 80,width: 80,),
                  SizedBox(
                    height: 14.0,
                  ),
                  Center(
                    child: Text('Booking Confirmed !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0)),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Text(
                        'Your booking has been confirmed.\n Check your email for detail.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0)),
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset("assets/image/homeImage/hotel.png")),
                  SizedBox(
                    height: 14.0,
                  ),
                  Center(
                    child: Text(
                        'Hotel Park Avenue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,

                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0)),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/image/images/location.svg",height: 16,width: 16,),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                          'Anaheim',

                          textAlign: TextAlign.center,
                          style: TextStyle(

                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0)),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _checkInCheckOutWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _checkInCheckOutWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color.fromRGBO(1, 42, 69, 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'Check In',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                        Text(
                          '23',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),Text(
                          'Apr | 12:00 PM',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 1,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 35),
              ),
              Expanded(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'Check Out',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                        Text(
                          '24',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),Text(
                          'Apr | 11:00 AM',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '1 Day & 1 Night (1 room, 2 Guest)',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Sofia",
                fontWeight: FontWeight.w400,
                fontSize: 12.0),
          ),
        ],
      ),
    );
  }
     Widget okButton(BuildContext context)
     {
       return Align(
         alignment: Alignment.bottomCenter,
         child: Container(
           height: 80,
           width: MediaQuery.of(context).size.width,
           color: Color.fromRGBO(1, 42, 69, 1),
           child:FlatButton(
             onPressed: ()
             {
               Navigator.pop(context);
             },
             splashColor: Colors.white30,
             color: Color.fromRGBO(1, 42, 69, 1),
             child: Text(
               'Ok'.toUpperCase(),
               style: TextStyle(
                   color: Colors.white,
                   fontFamily: "Sofia",
                   fontWeight: FontWeight.w600,
                   fontSize: 16),
             ),
           ) ,
         ),
       );
     }
}
