import 'dart:async';

import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B4_Booking/BookingDetail.dart';
import 'package:book_it/UI/B4_Booking/bloc/BookingHistoryBloc.dart';
import 'package:book_it/UI/B4_Booking/model/BookingHistoryResponse.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'RatingBar.dart';

class BookingScreen extends StatefulWidget {
  String idUser;

  BookingScreen({this.idUser});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool checkMail = true;
  String mail;

  SharedPreferences prefs;

  /// Get image data dummy from firebase server
  ///
  var imageNetwork = NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Artboard%203.png?alt=media&token=dc7f4bf5-8f80-4f38-bb63-87aed9d59b95");

  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;
  BookingHistoryBloc _bookingHistoryBloc;
  String _error;
  AppConstantHelper _appConstantHelper;
  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        loadImage = false;
      });
    });

    _bookingHistoryBloc = BookingHistoryBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);

    getBookingHistory();
    super.initState();
  }

  void getBookingHistory() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _bookingHistoryBloc.getBookingsHistory(context: context);
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

  void callCancelBookingApi(String transactionId) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _bookingHistoryBloc.cancelBooking(
            context: context, transaction_id: transactionId);
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

  void giveReviewAndRating(
      {String hotel_id, String booking_id, String rating, String comment}) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _bookingHistoryBloc.giveReviewToHotel(
            context: context,
            hotel_id: hotel_id,
            booking_id: booking_id,
            rating: rating,
            comment: comment);
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            elevation: 0.0,
            title: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 5.0),
              child: Text(
                "Reservations",
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontSize: 36.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            ),
            bottom: TabBar(
              indicatorColor: AppColor.primaryColor,
              labelStyle: TextStyle(
                  color: AppColor.primaryColor,
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0),
              unselectedLabelStyle: TextStyle(
                  color: AppColor.primaryColor,
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0),
              unselectedLabelColor: AppColor.primaryColor,
              labelColor: AppColor.primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: '     Current     ',
                ),
                Tab(
                  text: '     Past     ',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _currentBookingTabView(true),
              _currentBookingTabView(false)
            ],
          )),
    );
  }

  _currentBookingTabView(bool isCurrent) {
    return Stack(
      children: [
        StreamBuilder<BookingHistoryResponse>(
            stream: _bookingHistoryBloc.bookingHistoryDataStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return cardHeaderLoading(context);
              } else if (snapshot.hasData &&
                  snapshot.data.data != null)
                return Container(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 0.0),
                          child: PastCurrentListView(
                            list: isCurrent
                                ? snapshot.data.data.current
                                : snapshot.data.data.past,
                            isCurrent: isCurrent,
                          )),
                      SizedBox(
                        height: 40.0,
                      )
                    ],
                  ),
                );
              else
                return noItem();
            }),
        StreamBuilder<bool>(
          stream: _bookingHistoryBloc.progressStream,
          builder: (context, snapshot) {
            return Center(
                child: CommmonProgressIndicator(
                    snapshot.hasData ? snapshot.data : false));
          },
        )
      ],
    );
  }

  Widget PastCurrentListView({bool isCurrent, final List<Current> list}) {
    var _txtStyleTitle = TextStyle(
      color: Colors.black87,
      fontFamily: "Gotik",
      fontSize: 17.0,
      fontWeight: FontWeight.w800,
    );

    var _txtStyleSub = TextStyle(
      color: Colors.black26,
      fontFamily: "Gotik",
      fontSize: 12.5,
      fontWeight: FontWeight.w600,
    );
    return list != null && list.length > 0
        ? SizedBox.fromSize(
            child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: list.length,
            itemBuilder: (context, i) {
              List<String> photo = List.from(list[i].hotelDetail.images);
              List<String> service = List.from(list[i].hotelDetail.amenities);
              String description = list[i].hotelDetail.description;
              String title = list[i].hotelDetail.name;
              String type = list[i].hotelDetail.name;
              num rating = num.parse(list[i].hotelDetail.rating.toString());
              String image = list[i].hotelDetail.images.first;
              String id = list[i].hotelDetail.sId;
              String checkIn = list[i].checkIn;
              String checkOut = list[i].checkOut;
              String count = "";
              String locationReservision = list[i].hotelDetail.address;
              String rooms = "";
              String roomName = "";
              String information = "";
              num priceRoom = num.parse(list[i].amount);
              num price = num.parse(list[i].amount);
              num latLang1 = num.parse(list[i].hotelDetail.latitude);
              num latLang2 = num.parse(list[i].hotelDetail.longitude);

              return InkWell(
                onTap: () {
                  if (isCurrent) {
                    // Navigator.of(context).push(PageRouteBuilder(
                    //     pageBuilder: (_, __, ___) => new BookingDetail(
                    //           userId: widget.userId,
                    //           titleD: title,
                    //           idD: id,
                    //           imageD: image,
                    //           information: information,
                    //           priceRoom: priceRoom,
                    //           roomName: roomName,
                    //           latLang1D: latLang1,
                    //           latLang2D: latLang2,
                    //           priceD: price,
                    //           listItem: _list,
                    //           descriptionD: description,
                    //           photoD: photo,
                    //           ratingD: rating,
                    //           serviceD: service,
                    //           typeD: type,
                    //           checkIn: checkIn,
                    //           checkOut: checkOut,
                    //           count: count,
                    //           locationReservision: locationReservision,
                    //           rooms: rooms,
                    //         ),
                    //       transitionDuration: Duration(milliseconds: 1000),
                    //       transitionsBuilder:
                    //           (_, Animation<double> animation, __, Widget child) {
                    //         return Opacity(
                    //           opacity: animation.value,
                    //           child: child,
                    //         );
                    //       }));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 0.0, bottom: 15.0),
                  child: Container(
                    height: isCurrent ? 280 : 310.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 3.0,
                              spreadRadius: 1.0)
                        ]),
                    child: Stack(
                      children: [
                        Column(children: [
                          Container(
                            height: 165.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      AppStrings.imagePAth + image),
                                  fit: BoxFit.cover),
                            ),
                            child: Visibility(
                              visible: isCurrent ? true : false,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 10.0),
                                child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: AppColor.primaryColor,
                                    child: InkWell(
                                      onTap: () {
                                        showCancelBookingDialog(
                                            context,
                                            AppStrings.imagePAth + image,
                                            title,
                                            list[i].sId.toString());
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ),
                            alignment: Alignment.topRight,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          width: 220.0,
                                          child: Text(
                                            title,
                                            style: _txtStyleTitle,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(top: 5.0)),
                                      Row(
                                        children: <Widget>[
                                          ratingbar(
                                            starRating:
                                                double.parse(rating.toString()),
                                            color: Color(0xFF09314F),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.0)),
                                          // Text(
                                          //   "(" + rating.toString() + ")",
                                          //   style: _txtStyleSub,
                                          // )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.9),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              size: 16.0,
                                              color: Colors.black26,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 3.0)),
                                            Text(locationReservision,
                                                style: _txtStyleSub)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "\$\t" + price.toString(),
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Color(0xFF09314F),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Gotik"),
                                      ),
                                      Text(
                                          // "per night",
                                          "",
                                          style: _txtStyleSub.copyWith(
                                              fontSize: 11.0))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 6.9, left: 14.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Check In : \t",
                                        style: _txtStyleSub.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    Padding(padding: EdgeInsets.only(top: 3.0)),
                                    Text(_parseDateStr(checkIn),
                                        style: _txtStyleSub)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.9, right: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Check Out : \t",
                                        style: _txtStyleSub.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    Padding(padding: EdgeInsets.only(top: 3.0)),
                                    Text(_parseDateStr(checkOut),
                                        style: _txtStyleSub)
                                  ],
                                ),
                              )
                            ],
                          ),
                          Visibility(
                              visible: isCurrent ? false : true,
                              child: _reviewRatingButton(
                                  context,
                                  AppStrings.imagePAth + image,
                                  title,
                                  list[i].hotelId.toString(),
                                  list[i].sId,
                                  list[i].status))
                        ]),
                        Visibility(
                          visible: isCurrent ? false : true,
                          child: Container(
                            height: 265,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                                color: Colors.grey.withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ))
        : noItem();
  }

  Widget cardHeaderLoading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Container(
        height: 250.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 3.0,
                  spreadRadius: 1.0)
            ]),
        child: Shimmer.fromColors(
          baseColor: Colors.black38,
          highlightColor: Colors.white,
          child: Column(children: [
            Container(
              height: 165.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
              ),
              child: Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                  child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.black12,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                ),
              ),
              alignment: Alignment.topRight,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 220.0,
                          height: 25.0,
                          color: Colors.black12,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Container(
                          height: 15.0,
                          width: 100.0,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.9),
                          child: Container(
                            height: 12.0,
                            width: 140.0,
                            color: Colors.black12,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 35.0,
                          width: 55.0,
                          color: Colors.black12,
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Container(
                          height: 10.0,
                          width: 55.0,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  String _parseDateStr(String inputString) {
    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime newDate = format.parse(inputString);

    print("Date *********${DateFormat.yMMMMd().format(newDate)}"); // print
    return "${DateFormat('dd MMM, yyyy').format(newDate)}";
  }

  Widget _reviewRatingButton(
      context, image, title, hotelID, bookingId, String bookingStatus) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          if (bookingStatus != "Cancelled") {
            showGiveRatingReviewDialog(
                context, image, title, hotelID, bookingId);
          }
        },
        child: Text(
          bookingStatus == "Cancelled" ? "Cancelled" : "Give Rating & Reviews",
          style: TextStyle(
              fontSize: bookingStatus == "Cancelled" ? 16.0 : 14.0,
              color: bookingStatus == "Cancelled"
                  ? AppColor.primaryColor.withOpacity(0.6)
                  : AppColor.primaryColor,
              fontWeight: FontWeight.w600,
              fontFamily: "Gotik"),
        ),
      ),
    );
  }

  void showCancelBookingDialog(
      BuildContext context, image, title, transactionID) {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: Image.network(
                image,
                fit: BoxFit.cover,
              ),
              title: Text('Cancel Booking?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Gotik",
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600)),
              description: Text(
                "Are you sure you want to cancel " + title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w300,
                    color: Colors.black26),
              ),
              onOkButtonPressed: () {
                Navigator.pop(context);
                callCancelBookingApi(transactionID);
                // Firestore.instance
                //     .collection('room')
                //     .document(list[i].documentID)
                //     .updateData({
                //   "quantity": FieldValue.increment(1)
                // });
                // Firestore.instance.runTransaction(
                //         (transaction) async {
                //       DocumentSnapshot snapshot =
                //       await transaction
                //           .get(list[i].reference);
                //       await transaction
                //           .delete(snapshot.reference);
                //       SharedPreferences prefs =
                //       await SharedPreferences
                //           .getInstance();
                //       prefs.remove(title);
                //     });
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text("Cancel booking " + title),
                //   backgroundColor: Colors.red,
                //   duration: Duration(seconds: 3),
                // ));
              },
            ));
  }

  void showGiveRatingReviewDialog(
      BuildContext context, image, title, hotelID, bookingId) {
    num rating = 5.0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter state) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              child: Wrap(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 14, left: 14, right: 14),
                          child: Text('Give Rating',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "Gotik",
                                  fontSize: 10.0,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 14, right: 14),
                            child: RatingBar(
                              starCount: 5,
                              rating: rating,
                              borderColor: Colors.grey,
                              color: Colors.yellow[800],
                              size: 24,
                              onRatingChanged: (index) {
                                rating = index;
                                state(() {
                                  print("rating${rating}");
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 14, left: 14, right: 14),
                          child: Text('Give Review',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "Gotik",
                                  fontSize: 10.0,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 14, left: 14, right: 14),
                          child: TextField(
                            minLines: 2,
                            maxLines: 4,
                            controller: reviewController,
                            style: TextStyle(
                                fontFamily: "Gotik",
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 250, 250, 1),
                                filled: true,
                                hintText: "Write Here...",
                                hintStyle: TextStyle(
                                    fontFamily: "Gotik",
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                                focusColor: Colors.grey[300],
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[300], width: 0.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300], width: 0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300], width: 0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            RaisedButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () {
                                Navigator.pop(context);
                                giveReviewAndRating(
                                    hotel_id: hotelID,
                                    booking_id: bookingId,
                                    rating: rating.toString(),
                                    comment: reviewController.text);
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }
}

///
///
/// If no item cart this class showing
///
class noItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(top: mediaQueryData.padding.top + 100.0)),
          Image.asset(
            "assets/image/illustration/empty.png",
            height: 270.0,
          ),
          Text(
            "No data found",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 19.5,
                color: Colors.black26.withOpacity(0.2),
                fontFamily: "Sofia"),
          ),
        ],
      ),
    );
  }
}
