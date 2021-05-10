import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/HotelRoomListingResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/src/calendar.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/src/constant.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/src/customization/header_style.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';

import 'MyExpansionCard.dart';
import 'bloc/GetRoomsAndBookNowBloc.dart';
import 'model/BookingRoomList.dart';
import 'src/customization/day_style.dart';
import 'src/customization/dayofweek_style.dart';

// ignore: must_be_immutable

// ignore: must_be_immutable
class SelectCheckInOutDate extends StatefulWidget {
  num adultCapacity, childCapacity;
  String hotelID; String selectedRoomType;

  SelectCheckInOutDate({this.adultCapacity, this.childCapacity, this.hotelID,this.selectedRoomType});

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
  num totalAdultCount = 0;
  num totalChildCount = 0;
  num availableChildCount = 0;
  num availableAdultCount = 0;
  num availableRoomCount = 0;
  DateTime start = DateTime.now();
  DateTime end;

  DateTime checkoutDate = DateTime.now();
  DateTime checkoutend;

  // var checkInDate = DateTime.now();
  // var checkOutDate = DateTime.now();
  GetRoomsAndBookNowBloc _getRoomsAndBookNowBloc;
  AppConstantHelper _appConstantHelper;

  @override
  void initState() {
    _appConstantHelper = AppConstantHelper();
    _getRoomsAndBookNowBloc = GetRoomsAndBookNowBloc();
    totalAdultCount = 0;
    totalChildCount = 0;
    AppStrings.selectedRoomList.forEach((element) {
      totalAdultCount += element.adult;
      totalChildCount += element.child;
    });
    getAvailableHotelRoomsListing();
    super.initState();
  }

  void getAvailableHotelRoomsListing() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        var difference =
            AppStrings.checkOutDate.difference(AppStrings.checkInDate).inDays;
        print("Datedifference$difference");
        if (difference <= -1) {
          showErrorDialog(context, "Select Date",
              "Please select check Out date after check In Date");
        } else {
          _getRoomsAndBookNowBloc.checkRoomAvailability(
              context: context,
              hotelId: widget.hotelID,
              checkIn: DateFormat("yyyy-MM-dd")
                  .format(AppStrings.checkInDate)
                  .split(" ")
                  .first,
              checkOut: DateFormat("yyyy-MM-dd")
                  .format(AppStrings.checkOutDate)
                  .split(' ')
                  .first,roomType: widget.selectedRoomType);
        }
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
  Widget build(BuildContext context) {

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
            child: StreamBuilder<HotelRoomListingResponse>(
                initialData: null,
                stream: _getRoomsAndBookNowBloc.getAvailableHotelRoomDataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data.data != null &&
                      snapshot.data.data.length > 0) {
                    availableAdultCount = num.parse(
                        snapshot.data.data[0].adultCapacity.toString());
                    availableChildCount = num.parse(
                        snapshot.data.data[0].childCapacity.toString());
                    availableRoomCount = snapshot.data.data.length;

                    print("availableAdultCount${availableAdultCount}");
                    print("availableChildCount${availableChildCount}");
                    print("availableRoomCount${availableRoomCount}");
                  }
                  return Column(
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
                  );
                }),
          ),
          _applyButton(),
          StreamBuilder<bool>(
            stream: _getRoomsAndBookNowBloc.progressStream,
            builder: (context, snapshot) {
              return Center(
                  child: CommmonProgressIndicator(
                      snapshot.hasData ? snapshot.data : false));
            },
          )
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
      child: Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
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
                    '${DateFormat('EEE, dd MMM').format(AppStrings.checkInDate)}',
                    style: TextStyle(
                        color: AppColor.primaryColor,
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
                    '${DateFormat('EEE, dd MMM').format(AppStrings.checkOutDate)}',
                    style: TextStyle(
                        color: AppColor.primaryColor,
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
                    AppStrings.selectedRoomList != null &&
                            AppStrings.selectedRoomList.length > 0
                        ? "${AppStrings.selectedRoomList.length}\trooms"
                        : ' room'.toUpperCase(),
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
                      SvgPicture.asset(
                        'assets/image/images/profile.svg',
                        color: AppColor.primaryColor,
                        width: 14,
                        height: 14,
                      ),
                      Text(
                        totalAdultCount > 0 && totalChildCount == 0
                            ? '\t${totalAdultCount} adult'
                            : "\t${totalAdultCount} adult\t ${totalChildCount}\tchildren",
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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
          ),
          Text(
            "S",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  _CheckInCalender() {
    /// method to check wether a day is in the selected range
    /// used for highlighting those day
    bool isInRange(DateTime date) {
      // if start is null, no date has been selected yet
      if (start == null) return false;
      // if only end is null only the start should be highlighted
      if (end == null) return date == start;
      // if both start and end aren't null check if date false in the range
      return ((date == start));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 100),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.7,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: PagedVerticalCalendar(
            addAutomaticKeepAlives: true,
            startDate: DateTime.now(),
            dayBuilder: (context, date) {
              // update the days color based on if it's selected or not
              final color = isInRange(date) ? Colors.black : Colors.transparent;
              return Container(
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Center(
                  child: Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      color: isInRange(date) ? Colors.white : Colors.black87,
                      fontSize: isInRange(date) ?16:13,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w400,),
                  ),
                ),
              );
            },
            onDayPressed: (date) {
              setState(() {
                // if start is null, assign this date to start

                print("StartDate$date");
                var difference =
                    AppStrings.checkOutDate.difference(date).inDays;
                print("Datedifference$difference");
                if(difference<=0)
                {
                  showErrorDialog(context, "Select Check In Date",
                      "Please select check In date before check Out Date");
                }else{
                  start = date;
                  AppStrings.checkInDate = start;
                }
              });
            },
          )
          /*SimpleVerticalCalendar(
            // startDate: AppStrings.checkInDate,
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
            // dayOfWeek: ["S","M", "T", "W", "T", "F", "S",],
            onDateTap: (start, end) {
              print("StartDate$start");
              print(end);

              setState(() {
                var difference =
                    AppStrings.checkOutDate.difference(start).inDays;
                print("Datedifference$difference");
                if(difference<=0)
                {
                  showErrorDialog(context, "Select Check In Date",
                      "Please select check In date before check Out Date");
                }else{
                  AppStrings.checkInDate = start;
                }
              });
            },
          )*/
          ),
    );
  }

  _CheckOutCalender() {

    bool isInRange(DateTime date) {
      // if start is null, no date has been selected yet
      if (checkoutDate == null) return false;
      // if only end is null only the start should be highlighted
      if (checkoutend == null) return date == checkoutDate;
      // if both start and end aren't null check if date false in the range
      return ((date == checkoutDate));
    }
    return Container(
      margin: EdgeInsets.only(bottom: 100),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.7,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: PagedVerticalCalendar(
            addAutomaticKeepAlives: true,
            startDate: DateTime.now(),
            dayBuilder: (context, date) {
              // update the days color based on if it's selected or not
              final color = isInRange(date) ? Colors.black : Colors.transparent;
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Center(
                  child: Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                        color: isInRange(date) ? Colors.white : Colors.black87,
                      fontSize: isInRange(date) ?16:13,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w400,),
                  ),
                ),
              );
            },
            onDayPressed: (date) {
              setState(() {

                final difference =
                    date.difference(AppStrings.checkInDate).inHours;
                print("Datedifference$difference");
                if (difference <= 0) {
                  showErrorDialog(context, "Select Check In Date",
                      "Please select check out date after check in Date");
                } else {
                  print("checkOutDate $date");
                  checkoutDate = date;
                  AppStrings.checkOutDate = checkoutDate;
                  getAvailableHotelRoomsListing();
                }
              });
            },
          )
        /*SimpleVerticalCalendar(
            startDate: AppStrings.checkOutDate,
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
            // dayOfWeek: ["S","M", "T", "W", "T", "F", "S",],
            onDateTap: (start, end) {
              print("checkOutDate $start");
              print(end);

              final difference =
                  start.difference(AppStrings.checkInDate).inHours;
              print("Datedifference$difference");

              setState(() {
                if (difference <= 0) {
                  showErrorDialog(context, "Select Check In Date",
                      "Please select check out date after check in Date");
                } else {
                  AppStrings.checkOutDate = start;
                  getHotelRoomsListing();
                }
              });
            },
          )*/),
    );
  }

  _RoomAndGuestWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Visibility(
                  visible: AppStrings.selectedRoomList != null &&
                          AppStrings.selectedRoomList.length > 0
                      ? true
                      : false,
                  child: selectedRoomListWidget()),
              // Container(
              //   margin: EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //             color: Color.fromRGBO(117, 117, 170, 0.17),
              //             blurRadius: 10,
              //             offset: Offset(0, 5))
              //       ],
              //       borderRadius: BorderRadius.circular(6)),
              //   child: MyExpansionCard(
              //     initiallyExpanded: true,
              //     // backgroundColor: Colors.black87,
              //     margin: EdgeInsets.zero,
              //     borderRadius: 6,
              //     expandIcon: 'assets/image/images/location.svg',
              //     collapseIcon: 'assets/image/images/profile.svg',
              //     onExpansionChanged: (bool val) {
              //       print(val);
              //     },
              //     title: Container(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             "Room",
              //             style: TextStyle(
              //               color: Colors.black87,
              //               fontSize: 14,
              //               height: 1,
              //               fontFamily: "Sofia",
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //           Text(
              //             " Guest",
              //             style: TextStyle(
              //               color: Colors.black87,
              //               fontSize: 14,
              //               height: 1,
              //               fontFamily: "Sofia",
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     children: <Widget>[
              //       Divider(),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 14, vertical: 8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               "Adult",
              //               style: TextStyle(
              //                   height: 1.1,
              //                   fontFamily: "Sofia",
              //                   color: Colors.black,
              //                   fontSize: 14.0),
              //             ),
              //             new Row(
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: <Widget>[
              //                 SizedBox(
              //                   height: 30,
              //                   width: 30,
              //                   child: new FloatingActionButton(
              //                     onPressed: minus,
              //                     backgroundColor: AppColor.primaryColor,
              //                     child: new Text(
              //                       "﹣",
              //                       style: TextStyle(
              //                           height: 1.1,
              //                           fontFamily: "Sofia",
              //                           color: Colors.white,
              //                           fontSize: 30.0),
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 20,
              //                 ),
              //                 new Text('$adult',
              //                     style: new TextStyle(fontSize: 20.0)),
              //                 SizedBox(
              //                   width: 20,
              //                 ),
              //                 SizedBox(
              //                   height: 30,
              //                   width: 30,
              //                   child: new FloatingActionButton(
              //                     onPressed: add,
              //                     child: new Icon(
              //                       Icons.add,
              //                       color: Colors.white,
              //                     ),
              //                     backgroundColor: AppColor.primaryColor,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 14, vertical: 8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Flexible(
              //               child: Text(
              //                 "Travelling with children ? (0-13 years)",
              //                 style: TextStyle(
              //                     height: 1.1,
              //                     fontFamily: "Sofia",
              //                     color: Colors.black,
              //                     fontSize: 14.0),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             new Row(
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: <Widget>[
              //                 SizedBox(
              //                   height: 30,
              //                   width: 30,
              //                   child: new FloatingActionButton(
              //                     onPressed: minusChild,
              //                     backgroundColor: AppColor.primaryColor,
              //                     child: new Text(
              //                       "﹣",
              //                       style: TextStyle(
              //                           height: 1.1,
              //                           fontFamily: "Sofia",
              //                           color: Colors.white,
              //                           fontSize: 30.0),
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 20,
              //                 ),
              //                 new Text('$_child',
              //                     style: new TextStyle(fontSize: 20.0)),
              //                 SizedBox(
              //                   width: 20,
              //                 ),
              //                 SizedBox(
              //                   height: 30,
              //                   width: 30,
              //                   child: new FloatingActionButton(
              //                     onPressed: addChild,
              //                     child: new Icon(
              //                       Icons.add,
              //                       color: Colors.white,
              //                     ),
              //                     backgroundColor: AppColor.primaryColor,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         margin: EdgeInsets.only(top: 8.0),
              //         height: 1,
              //         color: Colors.grey.withOpacity(0.2),
              //       ),
              //       Row(
              //         children: [
              //           // Expanded(
              //           //   child: FlatButton(
              //           //       onPressed: () {},
              //           //       child: Flexible(
              //           //         child: Text(
              //           //           "Delete Room",
              //           //           style: TextStyle(
              //           //               height: 1.1,
              //           //               fontFamily: "Sofia",
              //           //               color: AppColor.colorGreen,
              //           //               fontSize: 15.0),
              //           //         ),
              //           //       )),
              //           // ),
              //           // Container(
              //           //   color: Colors.grey.withOpacity(0.2),
              //           //   width: 0.8,
              //           //   height: 50,
              //           // ),
              //           Expanded(
              //             child: FlatButton(
              //                 onPressed: () {
              //                   setState(() {
              //                     AppStrings.selectedRoomList.add(
              //                         SelectedRoomList(
              //                             adult: adult, child: _child));
              //                     totalAdultCount = 0;
              //                     totalChildCount = 0;
              //                     AppStrings.selectedRoomList
              //                         .forEach((element) {
              //                       totalAdultCount += element.adult;
              //                       totalChildCount += element.child;
              //                     });
              //                     adult = 1;
              //                     _child = 0;
              //                   });
              //                 },
              //                 child: Flexible(
              //                   child: Text(
              //                     "Add Room",
              //                     style: TextStyle(
              //                         height: 1.1,
              //                         fontFamily: "Sofia",
              //                         color: AppColor.colorGreen,
              //                         fontSize: 14.0),
              //                   ),
              //                 )),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }

  Widget selectedRoomListWidget() {
    return ListView.builder(
        itemCount: AppStrings.selectedRoomList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          num totalGuest = num.parse(
                  AppStrings.selectedRoomList[index].child.toString()) +
              num.parse(AppStrings.selectedRoomList[index].adult.toString());
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
                      "Room ${index + 1}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        height: 1,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${totalGuest.toString()}\tGuest",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8.0),
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
                              onPressed: () {
                                removeRoomAdult(index);
                              },
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
                          new Text(
                              '${AppStrings.selectedRoomList[index].adult}',
                              style: new TextStyle(fontSize: 20.0)),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: new FloatingActionButton(
                              onPressed: () {
                                updateRoomAdult(index);
                              },
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8.0),
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
                              onPressed: () {
                                removeRoomChild(index);
                              },
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
                          new Text(
                              '${AppStrings.selectedRoomList[index].child}',
                              style: new TextStyle(fontSize: 20.0)),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: new FloatingActionButton(
                              onPressed: () {
                                updateRoomChild(index);
                              },
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
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                Row(
                  children: [
                    Visibility(
                      visible:
                          index == AppStrings.selectedRoomList.length - 1 &&
                                  AppStrings.selectedRoomList.length > 1
                              ? true
                              : false,
                      child: Expanded(
                        child: FlatButton(
                            onPressed: () {
                              setState(() {
                                AppStrings.selectedRoomList.removeAt(index);
                                totalAdultCount = 0;
                                totalChildCount = 0;
                                AppStrings.selectedRoomList.forEach((element) {
                                  totalAdultCount += element.adult;
                                  totalChildCount += element.child;
                                });
                              });
                            },
                            child: Text(
                              "Delete Room",
                              style: TextStyle(
                                  height: 1.1,
                                  fontFamily: "Sofia",
                                  color: AppColor.colorGreen,
                                  fontSize: 15.0),
                            )),
                      ),
                    ),
                    Visibility(
                      visible:
                          index == AppStrings.selectedRoomList.length - 1 &&
                                  AppStrings.selectedRoomList.length > 1
                              ? true
                              : false,
                      child: Container(
                        color: Colors.grey.withOpacity(0.2),
                        width: 0.8,
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              if (index ==
                                  AppStrings.selectedRoomList.length - 1) {
                                if (AppStrings.selectedRoomList.length ==
                                        availableRoomCount ||
                                    AppStrings.selectedRoomList.length >
                                        availableRoomCount) {
                                  showErrorDialog(context, "Add Room",
                                      "Sorry, Only ${availableRoomCount} rooms are available for booking");
                                } else {
                                  AppStrings.selectedRoomList
                                      .add(SelectedRoomList(
                                    adult: adult,
                                    child: _child,
                                  ));
                                  totalAdultCount = 0;
                                  totalChildCount = 0;
                                  AppStrings.selectedRoomList
                                      .forEach((element) {
                                    totalAdultCount += element.adult;
                                    totalChildCount += element.child;
                                  });
                                }

                                adult = 1;
                                _child = 0;
                              } else {
                                AppStrings.selectedRoomList.removeAt(index);
                                totalAdultCount = 0;
                                totalChildCount = 0;
                                AppStrings.selectedRoomList.forEach((element) {
                                  totalAdultCount += element.adult;
                                  totalChildCount += element.child;
                                });
                              }
                            });
                          },
                          child: Text(
                            index == AppStrings.selectedRoomList.length - 1
                                ? "Add Room"
                                : "Delete Room",
                            style: TextStyle(
                                height: 1.1,
                                fontFamily: "Sofia",
                                color: AppColor.colorGreen,
                                fontSize: 15.0),
                          )),
                    ),
                    // Container(
                    //   color: Colors.grey.withOpacity(0.2),
                    //   width: 0.8,
                    //   height: 50,
                    // ),
                    // Expanded(
                    //   child: FlatButton(
                    //       onPressed: () {},
                    //       child: Flexible(
                    //         child: Text(
                    //           "Add Room",
                    //           style: TextStyle(
                    //               height: 1.1,
                    //               fontFamily: "Sofia",
                    //               color: AppColor.colorGreen,
                    //               fontSize: 14.0),
                    //         ),
                    //       )),
                    // )
                  ],
                )
              ],
            ),
          );
        });
  }

  int adult = 1;

  void minus() {
    setState(() {
      if (adult != 0) adult--;
    });
  }

  void add() {
    setState(() {
      if (adult < availableAdultCount)
        adult++;
      else
        showErrorDialog(context, "Select Adult",
            "Only ${availableAdultCount}  adult are allowed in room");
    });
  }

  int _child = 0;

  void minusChild() {
    setState(() {
      if (_child != 0) _child--;
    });
  }

  void addChild() {
    setState(() {
      if (_child < availableChildCount)
        _child++;
      else {
        showErrorDialog(context, "Select Children",
            "Only ${availableChildCount}  children are allowed in room");
      }
    });
  }

  void updateRoomAdult(index) {
    setState(() {
      if (AppStrings.selectedRoomList[index].adult < widget.adultCapacity) {
        AppStrings.selectedRoomList[index].adult++;
        totalAdultCount = 0;
        totalChildCount = 0;
        AppStrings.selectedRoomList.forEach((element) {
          totalAdultCount += element.adult;
          totalChildCount += element.child;
        });
      } else {
        showErrorDialog(context, "Select Children",
            "Only ${widget.adultCapacity}  adult are allowed in room");
      }
    });
  }

  void removeRoomAdult(index) {
    setState(() {
      if (AppStrings.selectedRoomList[index].adult != 1) {
        AppStrings.selectedRoomList[index].adult--;
        totalAdultCount = 0;
        totalChildCount = 0;
        AppStrings.selectedRoomList.forEach((element) {
          totalAdultCount += element.adult;
          totalChildCount += element.child;
        });
      }
    });
  }

  void updateRoomChild(index) {
    setState(() {
      if (AppStrings.selectedRoomList[index].child < widget.childCapacity) {
        AppStrings.selectedRoomList[index].child++;
        totalAdultCount = 0;
        totalChildCount = 0;
        AppStrings.selectedRoomList.forEach((element) {
          totalAdultCount += element.adult;
          totalChildCount += element.child;
        });
      } else {
        showErrorDialog(context, "Select Children",
            "Only ${widget.childCapacity}  children are allowed in room");
      }
    });
  }

  void removeRoomChild(index) {
    setState(() {
      if (AppStrings.selectedRoomList[index].child != 0) {
        AppStrings.selectedRoomList[index].child--;
        totalAdultCount = 0;
        totalChildCount = 0;
        AppStrings.selectedRoomList.forEach((element) {
          totalAdultCount += element.adult;
          totalChildCount += element.child;
        });
      }
    });
  }

  void showErrorDialog(context, title, msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppConstantHelper.showDialog(
              context: context, title: title, msg: msg);
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
          onPressed: () {
            Navigator.pop(context);
          },
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
