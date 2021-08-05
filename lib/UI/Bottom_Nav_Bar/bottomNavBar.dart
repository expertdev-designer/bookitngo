import 'dart:async';
import 'package:book_it/UI/B4_Booking/Booking.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/ic_reservation_icons.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:book_it/UI/B2_Message/B2_MessageScreen.dart';
import 'package:book_it/UI/B3_Trips/B3_TripScreen.dart';
import 'package:book_it/UI/B5_Profile/B5_ProfileScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'custom_nav_bar.dart';

class bottomNavBar extends StatefulWidget {
  String userID;

  bottomNavBar({this.userID});

  _bottomNavBarState createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  int currentIndex = 0;
  bool _color = true;
  List<Widget> pageList = [
    Home(
      userID: "userID",
    ),
    noMessage(
      userID: "userID",
    ),
    trip(
      userID: "afs",
    ),
    BookingScreen(
      idUser: "asf",
    ),
    profile(
      userID: "ferwt24",
    ),
    profile(
      userID: "ferwt24",
    ),
  ];

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
      // case 2:
      //   return new trip(
      //     userID: widget.userID,
      //   );
      //   break;
      case 2:
        return new BookingScreen(
          idUser: widget.userID,
        );
        break;
      case 3:
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
    void _handleIndexChanged(int i) {
      setState(() {
        currentIndex = i;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: callPage(currentIndex)
      /*IndexedStack(
        index: currentIndex,
        children: pageList,
          //
      )*/
      ,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: DotNavigationBar(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          itemPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 12.0),
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColor.primaryColor,
          currentIndex: currentIndex,
          dotIndicatorColor: AppColor.primaryColor,
          duration: Duration(milliseconds: 1000),
          onTap: _handleIndexChanged,
          // dotIndicatorColor: Colors.black,

          items: [
            /// Home
            DotNavigationBarItem(
              unselectedColor: Colors.grey,
              selectedColor: AppColor.primaryColor,
              icon: SvgPicture.asset(
                'assets/image/icon/home.svg',
                width: 20,
                height: 20,
                color: currentIndex == 0 ? AppColor.primaryColor : Colors.grey,
              ),
            ),

            /// Likes
            DotNavigationBarItem(
              unselectedColor: Colors.grey,
              selectedColor: AppColor.primaryColor,
              icon: SvgPicture.asset('assets/image/icon/chat.svg',
                  width: 20,
                  height: 20,
                  color:
                      currentIndex == 1 ? AppColor.primaryColor : Colors.grey),
            ),

            /// Search
            // DotNavigationBarItem(
            //   unselectedColor: Colors.grey,
            //   selectedColor: AppColor.primaryColor,
            //   icon: SvgPicture.asset('assets/image/icon/travel.svg',width: 22,height: 22,color: currentIndex==2?AppColor.primaryColor:Colors.grey),
            //
            // ),
            /// Search
            DotNavigationBarItem(
              unselectedColor: Colors.grey,
              selectedColor: AppColor.primaryColor,
              icon: SvgPicture.asset(
                'assets/image/icon/heart.svg',
                width: 20,
                height: 20,
                color: currentIndex == 3 ? AppColor.primaryColor : Colors.grey,
              ),
            ),

            /// Profile
            DotNavigationBarItem(
              unselectedColor: Colors.grey,
              selectedColor: AppColor.primaryColor,
              icon: SvgPicture.asset(
                'assets/image/icon/profile.svg',
                width: 20,
                height: 20,
                color: currentIndex == 4 ? AppColor.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 60,
      //   child: BottomNavigationDotBar(
      //       color: Colors.black26,
      //       items: <BottomNavigationDotBarItem>[
      //         BottomNavigationDotBarItem(
      //             icon: IconData(0xe900, fontFamily: 'home'),
      //             onTap: () {
      //               setState(() {
      //                 currentIndex = 0;
      //               });
      //             }),
      //         BottomNavigationDotBarItem(
      //             icon:  IconData(0xe900, fontFamily: 'message'),
      //             onTap: () {
      //               setState(() {
      //                 currentIndex = 1;
      //               });
      //             }),
      //         BottomNavigationDotBarItem(
      //             icon: IconData(
      //               0xe900,
      //               fontFamily: 'trip',
      //             ),
      //             onTap: () {
      //               setState(() {
      //                 currentIndex = 2;
      //               });
      //             }),
      //         BottomNavigationDotBarItem(
      //             // icon: Ic_reservation.qwsa,
      //             icon: IconData(0xe900, fontFamily: 'hearth'),
      //             onTap: () {
      //               setState(() {
      //                 currentIndex = 3;
      //               });
      //             }),
      //         BottomNavigationDotBarItem(
      //             icon:  IconData(0xe900, fontFamily: 'profile'),
      //             onTap: () {
      //               setState(() {
      //                 currentIndex = 4;
      //               });
      //             }),
      //       ]),
      // ),
    );
  }
}
