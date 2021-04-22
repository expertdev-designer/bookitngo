import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/src/calendar.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/src/constant.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/src/customization/header_style.dart';
import 'package:book_it/UI/B5_Profile/B5_ProfileScreen.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'MyExpansionCard.dart';
import 'RoomDetail.dart';
import 'calender.dart';
import 'hotelDetail_concept_2.dart';
import 'src/customization/day_style.dart';
import 'src/customization/dayofweek_style.dart';

// ignore: must_be_immutable
class SelectCheckInOutDate extends StatefulWidget {
  String imageD,
      titleD,
      locationD,
      idD,
      typeD,
      userId,
      nameD,
      photoProfileD,
      emailD;
  List<String> photoD, serviceD, descriptionD;
  num ratingD, priceD, latLang1D, latLang2D;

  SelectCheckInOutDate({
    this.imageD,
    this.titleD,
    this.priceD,
    this.locationD,
    this.idD,
    this.photoD,
    this.serviceD,
    this.descriptionD,
    this.userId,
    this.typeD,
    this.emailD,
    this.nameD,
    this.photoProfileD,
    this.latLang1D,
    this.latLang2D,
    this.ratingD,
  });

  @override
  _SelectCheckInOutDateState createState() => _SelectCheckInOutDateState();
}

class _SelectCheckInOutDateState extends State<SelectCheckInOutDate> {
  int isSelected = 0;
  var _txtStyleTitle = TextStyle(
    color: Colors.white,
    fontFamily: "Gotik",
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );
  bool isDateSelected = false;
  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );
  bool isCheckInTabSelected = true;
  bool isCheckOutTabSelected = false;
  bool isRoomTabSelected = false;
  var checkInDate = DateTime.now();
  var checkOutDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String _nama, _photoProfile, _email;

    var _appBar = PreferredSize(
      preferredSize: Size.fromHeight(45.0),
      child: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: Colors.black38,
            )),
        title: Text("Select Rooms & Guests",
            style: TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w400,
                fontSize: 16)),
      ),
    );
    return Scaffold(
      appBar: _appBar,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                tabBarWidget(),
                tabBarIndicator(),
                _weekDaysWidget(),
                isCheckInTabSelected
                    ? _CheckInCalender()
                    : isCheckOutTabSelected
                        ? _CheckOutCalender()
                        : isRoomTabSelected
                            ? _RoomAndGuestWidget()
                            : _CheckInCalender()
              ],
            ),
          ),
          _applyButton()
        ],
      ),
    );
  }

  labelTextWidget(label) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 2.0),
      child: Text(
        label,
        style: TextStyle(
            fontFamily: "Sofia", fontWeight: FontWeight.w600, fontSize: 16.0),
      ),
    );
  }

  Widget tabBarWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  isCheckInTabSelected = true;
                  isCheckOutTabSelected = false;
                  isRoomTabSelected = false;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Check IN'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${DateFormat('EEE, dd MMM').format(checkInDate)}',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isCheckInTabSelected = false;
                isCheckOutTabSelected = true;
                isRoomTabSelected = false;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Check Out'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  // 'Mon, 25 Apr',
                  '${DateFormat('EEE, dd MMM').format(checkOutDate)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isCheckInTabSelected = false;
                isCheckOutTabSelected = false;
                isRoomTabSelected = true;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '2 rooms'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.supervised_user_circle_rounded,
                      size: 16,
                    ),
                    Text(
                      '2 adults',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget weekText(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 10),
      ),
    );
  }

  tabBarIndicator() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 3,
            color: isCheckInTabSelected ? AppColor.primaryColor : Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            height: 3,
            color: isCheckOutTabSelected ? AppColor.primaryColor : Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            height: 3,
            color: isRoomTabSelected ? AppColor.primaryColor : Colors.white,
          ),
        ),
      ],
    );
  }

  _weekDaysWidget() {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "S",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "M",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "T",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "W",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "T",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "F",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "S",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  _CheckInCalender() {
    return Container(
      margin: EdgeInsets.only(bottom: 100),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: SimpleVerticalCalendar(
            startDate: checkInDate,
            numOfMonth: 6,
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontFamily: "Sofia",
                fontWeight: FontWeight.w400,
              ),
              textAlgin: TextAlign.center,
              monthFormat: MonthFormats.SHORT,
            ),
            calendarOption: CalendarOptions.SINGLE,
            dayOfWeekHeaderStyle: DayOfWeekHeaderStyle(
              backgroundStyle: BoxDecoration(
                color: Colors.transparent,
              ),
              textStyle: TextStyle(color: Colors.black87, fontSize: 13),
            ),
            dayStyle: DayHeaderStyle(
              textColor: Colors.black87,
            ),
            onDateTap: (start, end) {
              print("StartDate$start");
              print(end);
              checkInDate = start;
              setState(() {});
            },
          )),
    );
  }

  _CheckOutCalender() {
    return Container(
      margin: EdgeInsets.only(bottom: 100),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: SimpleVerticalCalendar(
            startDate: checkOutDate,
            numOfMonth: 6,
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontFamily: "Sofia",
                fontWeight: FontWeight.w400,
              ),
              textAlgin: TextAlign.center,
              monthFormat: MonthFormats.SHORT,
            ),
            calendarOption: CalendarOptions.SINGLE,
            dayOfWeekHeaderStyle: DayOfWeekHeaderStyle(
              backgroundStyle: BoxDecoration(
                color: Colors.transparent,
              ),
              textStyle: TextStyle(color: Colors.black87, fontSize: 13),
            ),
            dayStyle: DayHeaderStyle(
              textColor: Colors.black87,
            ),
            onDateTap: (start, end) {
              print("checkOutDate $start");
              print(end);
              checkOutDate = start;
              setState(() {});
            },
          )),
    );
  }

  _RoomAndGuestWidget() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(117, 117, 170, 0.17),
                blurRadius: 10,
                offset: Offset(0, 5))
          ],
          borderRadius: BorderRadius.circular(6)),
      // elevation: 1,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(Dimens.ten),
      // ),
      child: MyExpansionCard(
        initiallyExpanded: true,
        // backgroundColor: Colors.black87,
        margin: EdgeInsets.zero,
        borderRadius: 6,
        expandIcon: 'assets/image/images/location.svg',
        collapseIcon: 'assets/image/images/profile.svg',
        onExpansionChanged: (bool val) {
          print(val);
        },
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Room 1",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1,
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "1 Guest",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1,
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Adult",
                  style: TextStyle(
                      height: 1.1,
                      fontFamily: "Sofia",
                      color: Colors.black,
                      fontSize: 14.0),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: new FloatingActionButton(
                        onPressed: minus,
                        backgroundColor: AppColor.primaryColor,
                        child: new Text(
                          "﹣",
                          style: TextStyle(
                              height: 1.1,
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontSize: 30.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    new Text('$_n', style: new TextStyle(fontSize: 20.0)),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: new FloatingActionButton(
                        onPressed: add,
                        child: new Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        backgroundColor: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Travelling with children ? (0-13 years)",
                    style: TextStyle(
                        height: 1.1,
                        fontFamily: "Sofia",
                        color: Colors.black,
                        fontSize: 14.0),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: new FloatingActionButton(
                        onPressed: minus,
                        backgroundColor: AppColor.primaryColor,
                        child: new Text(
                          "﹣",
                          style: TextStyle(
                              height: 1.1,
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontSize: 30.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    new Text('$_n', style: new TextStyle(fontSize: 20.0)),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: new FloatingActionButton(
                        onPressed: add,
                        child: new Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        backgroundColor: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _n = 1;

  void minus() {
    setState(() {
      if (_n != 1) _n--;
    });
  }

  void add() {
    setState(() {
      _n++;
    });
  }

  _applyButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(bottom: 30, left: 14, right: 14),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          onPressed: () {},
          color: AppColor.primaryColor,
          splashColor: Colors.white12,
          child: Text(
            "Apply",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.0,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
