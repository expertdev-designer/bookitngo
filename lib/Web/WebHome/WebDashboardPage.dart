import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/WebAppStrings.dart';
import 'package:book_it/Web/WebHome/WebHomePage.dart';
import 'package:book_it/Web/WebHome/WebHotelBookingFormPage.dart';
import 'package:book_it/Web/WebHome/WebHotelDetailPage.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WebHotelCategoryWiseListingPage.dart';

class WebDashBoardPage extends StatefulWidget {
  var tabIndex;
  var pageRoute;
  var title;
  var categoryId;
  HotelData hotelData;

  WebDashBoardPage(
      {this.tabIndex,
      this.pageRoute,
      this.title,
      this.categoryId,
      this.hotelData});

  @override
  _WebDashBoardPageState createState() => _WebDashBoardPageState();
}

class _WebDashBoardPageState extends State<WebDashBoardPage> {
  bool isHomeSelected = true;
  bool isMsgSelected = false;
  bool isReservationSelected = false;
  bool isSettingSelected = false;

  @override
  void initState() {
    super.initState();

    if (widget.tabIndex == 0) {
      isHomeSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width > 650 ? 70 : 200,
        title: menuBar(width),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: pages(),
    );
  }

  Widget pages() {
    if (isHomeSelected) {
      if (widget.pageRoute == "ListingPage") {
        return WebHotelCategoryWiseListingPage(
            title: widget.title, categoryId: widget.categoryId);
      }
      if (widget.pageRoute == "HotelDetailPage") {
        return WebHotelDetailPage(
            title: widget.title, hotelData: widget.hotelData);
      }
      if (widget.pageRoute == "BookingFormPage") {
        return WebHotelBookingFormPage(
          //category id is a hotel id here used for getting hotels rooms
            title: widget.title, categoryId: widget.categoryId);
      }

      else {
        return WebHomePage();
      }
    }
  }

  Widget menuBar(width) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: width > 650 ? webViewForMenu(width) : mobileViewForMenu(width),
    );
  }

  mobileViewForMenu(width) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          // margin: EdgeInsets.only(left: , ),
          height: 60,
          child: Image.asset("assets/image/logo/fullLogo.png"),
        ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: () {
            homeClick();
          },
          child: Column(
            children: [
              Text(
                WebAppStrings.home,
                style: TextStyle(
                    fontSize: isHomeSelected ? 14 : 12,
                    fontWeight:
                        isHomeSelected ? FontWeight.w600 : FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 1.5),
              ),
              Visibility(visible: isHomeSelected, child: selectedTab()),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        MaterialButton(
          onPressed: () {
            messageClick();
          },
          child: Column(
            children: [
              Text(
                WebAppStrings.message,
                style: TextStyle(
                    fontSize: isMsgSelected ? 14 : 12,
                    fontWeight:
                        isMsgSelected ? FontWeight.w600 : FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 1.5),
              ),
              Visibility(visible: isMsgSelected, child: selectedTab()),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        MaterialButton(
          onPressed: () {
            reservationClick();
          },
          child: Column(
            children: [
              Text(
                WebAppStrings.reservations,
                style: TextStyle(
                    fontSize: isReservationSelected ? 14 : 13,
                    fontWeight: isReservationSelected
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 1.5),
              ),
              Visibility(visible: isReservationSelected, child: selectedTab()),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        MaterialButton(
          onPressed: () {
            settingsClick();
          },
          child: Column(
            children: [
              Text(
                WebAppStrings.settings,
                style: TextStyle(
                    fontSize: isSettingSelected ? 14 : 12,
                    fontWeight:
                        isSettingSelected ? FontWeight.w600 : FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 1.5),
              ),
              Visibility(visible: isSettingSelected, child: selectedTab()),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  webViewForMenu(width) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.03,
        ),
        Container(
          // margin: EdgeInsets.only(left: width*0.5),
          height: 60,
          child: Image.asset("assets/image/logo/fullLogo.png"),
        ),
        Expanded(child: Container()),
        MaterialButton(
          onPressed: () {
            homeClick();
          },
          child: Column(
            children: [
              Text(
                WebAppStrings.home,
                style: TextStyle(
                    fontSize: isHomeSelected ? 14 : 12,
                    fontWeight:
                        isHomeSelected ? FontWeight.w600 : FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 1.5),
              ),
              Visibility(visible: isHomeSelected, child: selectedTab()),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        MaterialButton(
          onPressed: () {
            messageClick();
          },
          child: Column(
            children: [
              Text(
                WebAppStrings.message,
                style: TextStyle(
                    fontSize: isMsgSelected ? 14 : 12,
                    fontWeight:
                        isMsgSelected ? FontWeight.w600 : FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 1.5),
              ),
              Visibility(visible: isMsgSelected, child: selectedTab()),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        MaterialButton(
          onPressed: () {
            reservationClick();
          },
          child: Column(
            children: [
              Text(
                WebAppStrings.reservations,
                style: TextStyle(
                    fontSize: isReservationSelected ? 14 : 12,
                    fontWeight: isReservationSelected
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 1.5),
              ),
              Visibility(visible: isReservationSelected, child: selectedTab()),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        MaterialButton(
          onPressed: () {
            settingsClick();
          },
          child: Column(
            children: [
              Text(
                WebAppStrings.settings,
                style: TextStyle(
                    fontSize: isSettingSelected ? 14 : 12,
                    fontWeight:
                        isSettingSelected ? FontWeight.w600 : FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 1.5),
              ),
              Visibility(visible: isSettingSelected, child: selectedTab()),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  Widget selectedTab() {
    return Container(
      height: 2,
      margin: EdgeInsets.only(top: 6),
      width: isHomeSelected
          ? 50
          : isMsgSelected
              ? 70
              : isReservationSelected
                  ? 110
                  : isSettingSelected
                      ? 70
                      : 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          gradient: LinearGradient(colors: [
            Color(0xFF7D55B6),
            Color(0xFF6774E7),
          ])),
    );
  }

  void homeClick() {
    isHomeSelected = true;
    isMsgSelected = false;
    isReservationSelected = false;
    isSettingSelected = false;
    notify();
  }

  void reservationClick() {
    isHomeSelected = false;
    isMsgSelected = false;
    isReservationSelected = true;
    isSettingSelected = false;
    notify();
  }

  void settingsClick() {
    isHomeSelected = false;
    isMsgSelected = false;
    isReservationSelected = false;
    isSettingSelected = true;
    notify();
  }

  void messageClick() {
    isHomeSelected = false;
    isMsgSelected = true;
    isReservationSelected = false;
    isSettingSelected = false;
    notify();
  }

  void notify() {
    setState(() {});
  }
}
