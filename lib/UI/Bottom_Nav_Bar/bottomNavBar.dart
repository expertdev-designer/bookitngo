import 'dart:async';
import 'package:book_it/UI/B4_Booking/Booking.dart';
import 'package:book_it/UI/ic_reservation_icons.dart';
import 'package:flutter/material.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:book_it/UI/B2_Message/B2_MessageScreen.dart';
import 'package:book_it/UI/B3_Trips/B3_TripScreen.dart';
import 'package:book_it/UI/B5_Profile/B5_ProfileScreen.dart';
import 'custom_nav_bar.dart';

class bottomNavBar extends StatefulWidget {
  String userID;

  bottomNavBar({this.userID});

  _bottomNavBarState createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  int currentIndex = 0;
  bool _color = true;

  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new Home(
          userID: widget.userID,
        );
        break;
      case 1:
        return new noMessage(
          userID: widget.userID,
        );
        break;
      case 2:
        return new trip(
          userID: widget.userID,
        );
        break;
      case 3:
        return new BookingScreen(
          idUser: widget.userID,
        );
        break;
      case 4:
        return new profile(
          userID: widget.userID,
        );
        break;
      default:
        return new Home(
          userID: widget.userID,
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: callPage(currentIndex),
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavigationDotBar(
            color: Colors.black26,
            items: <BottomNavigationDotBarItem>[
              BottomNavigationDotBarItem(
                  icon: IconData(0xe900, fontFamily: 'home'),
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: IconData(0xe900, fontFamily: 'message'),
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: IconData(
                    0xe900,
                    fontFamily: 'trip',
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: Ic_reservation.qwsa,
                  // icon: IconData(0xe900, fontFamily: 'hearth'),
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: IconData(0xe900, fontFamily: 'profile'),
                  onTap: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  }),
            ]),
      ),
    );
  }
}
