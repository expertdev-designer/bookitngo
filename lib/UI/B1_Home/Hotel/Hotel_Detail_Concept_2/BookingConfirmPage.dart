import 'package:book_it/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'model/CreateBookingResponse.dart';

class BookingConfirmPage extends StatelessWidget {
  BookingData bookingData;

  BookingConfirmPage({this.bookingData});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => bottomNavBar(
                userID: AppStrings.authToken,
              ),
            ));
      },
      child: Scaffold(
        backgroundColor: AppColor.colorLightBlue,
        body: Stack(
          children: [
            okButton(context),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    SvgPicture.asset(
                      'assets/image/images/tick.svg',
                      height: 80,
                      width: 80,
                    ),
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
                        child: Image.network(
                          AppStrings.imagePAth + bookingData.image,
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      height: 14.0,
                    ),
                    Center(
                      child: Text('${bookingData.hotelName}',
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
                        SvgPicture.asset(
                          "assets/image/images/location.svg",
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('${bookingData.location}',
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
                          "${bookingData.checkIn.split('-')[0]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                        Text(
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
                          "${bookingData.checkOut.split('-')[0]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                        Text(
                          '${_parseDateStr(bookingData.checkOut).split(' ').first} | 11:00 AM',
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
            "${calculateRoomAndGuest(bookingData.rooms)}",
            // '1 Day & 1 Night (1 room, 2 Guest)',
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

  String _parseDateStr(String inputString) {
    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime newDate = format.parse(inputString);

    print("Date *********${DateFormat.yMMMMd().format(newDate)}"); // print
    return "${DateFormat.yMMMMd().format(newDate)}";
  }

  String calculateRoomAndGuest(List<Rooms> list) {
    num totaladult=0, totalChild=0, totalGuest=0;
    list.forEach((element) {
      totaladult += element.adult;
      totalChild += element.child;
    });
    totalGuest = totaladult + totalChild;
    return "${list.length}\t room\t ${totalGuest}\t guest";
  }

  Widget okButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(1, 42, 69, 1),
        child: FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => bottomNavBar(
                    userID: AppStrings.authToken,
                  ),
                ));
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
        ),
      ),
    );
  }
}
