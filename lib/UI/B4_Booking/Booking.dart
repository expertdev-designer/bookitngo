import 'dart:async';

import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B4_Booking/BookingDetail.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
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

  Future<Null> _function() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      mail = prefs.getString("username") ?? '';
    });
  }

  ///
  /// Get image data dummy from firebase server
  ///
  var imageNetwork = NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Artboard%203.png?alt=media&token=dc7f4bf5-8f80-4f38-bb63-87aed9d59b95");

  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        loadImage = false;
      });
    });
    _function();
    super.initState();
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
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 0.0),
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection("users")
                    .document(widget.idUser)
                    .collection('Booking')
                    .snapshots(),
                builder: (
                  BuildContext ctx,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (!snapshot.hasData) {
                    return noItem();
                  } else {
                    if (snapshot.data.documents.isEmpty) {
                      return noItem();
                    } else {
                      if (loadImage) {
                        return _loadingDataList(
                            ctx, snapshot.data.documents.length);
                      } else {
                        return new dataFirestore(
                          userId: widget.idUser,
                          list: snapshot.data.documents,
                          isCurrent: isCurrent,
                        );
                      }

                      //  return  new noItem();
                    }
                  }
                },
              )),
          SizedBox(
            height: 40.0,
          )
        ],
      ),
    );
  }

  _pastBookingTabView() {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 0.0),
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection("users")
                    .document(widget.idUser)
                    .collection('Booking')
                    .snapshots(),
                builder: (
                  BuildContext ctx,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (!snapshot.hasData) {
                    return noItem();
                  } else {
                    if (snapshot.data.documents.isEmpty) {
                      return noItem();
                    } else {
                      if (loadImage) {
                        return _loadingDataList(
                            ctx, snapshot.data.documents.length);
                      } else {
                        return new dataFirestore(
                            userId: widget.idUser,
                            list: snapshot.data.documents);
                      }

                      //  return  new noItem();
                    }
                  }
                },
              )),
          SizedBox(
            height: 40.0,
          )
        ],
      ),
    );
  }
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

///
///
/// Calling imageLoading animation for set a list layout
///
///
Widget _loadingDataList(BuildContext context, int panjang) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.only(top: 0.0),
      itemCount: panjang,
      itemBuilder: (ctx, i) {
        return loadingCard(ctx);
      },
    ),
  );
}

Widget loadingCard(BuildContext ctx) {
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
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10.0),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.black12,
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

class dataFirestore extends StatefulWidget {
  String userId;
  bool isCurrent;

  dataFirestore({this.list, this.userId, this.isCurrent});

  final List<DocumentSnapshot> list;

  @override
  _dataFirestoreState createState() => _dataFirestoreState();
}

class _dataFirestoreState extends State<dataFirestore> {
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

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
          ],
        ),
      ),
    );

    return SizedBox.fromSize(
//      size: const Size.fromHeight(410.0),
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: widget.list.length,
      itemBuilder: (context, i) {
        List<String> photo = List.from(widget.list[i].data['photo']);
        List<String> service = List.from(widget.list[i].data['service']);
        List<String> description =
            List.from(widget.list[i].data['description']);
        String title = widget.list[i].data['title'].toString();
        String type = widget.list[i].data['type'].toString();
        num rating = widget.list[i].data['rating'];
        String image = widget.list[i].data['image'].toString();
        String id = widget.list[i].data['id'].toString();
        String checkIn = widget.list[i].data['Check In'].toString();
        String checkOut = widget.list[i].data['Check Out'].toString();
        String count = widget.list[i].data['Count'].toString();
        String locationReservision = widget.list[i].data['Location'].toString();
        String rooms = widget.list[i].data['Rooms'].toString();
        String roomName = widget.list[i].data['Room Name'].toString();
        String information = widget.list[i].data['Information Room'].toString();
        num priceRoom = widget.list[i].data['Price Room'];
        num price = widget.list[i].data['price'];
        num latLang1 = widget.list[i].data['latLang1'];
        num latLang2 = widget.list[i].data['latLang2'];

        DocumentSnapshot _list = widget.list[i];

        return InkWell(
          onTap: () {
            if (widget.isCurrent) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new BookingDetail(
                        userId: widget.userId,
                        titleD: title,
                        idD: id,
                        imageD: image,
                        information: information,
                        priceRoom: priceRoom,
                        roomName: roomName,
                        latLang1D: latLang1,
                        latLang2D: latLang2,
                        priceD: price,
                        listItem: _list,
                        descriptionD: description,
                        photoD: photo,
                        ratingD: rating,
                        serviceD: service,
                        typeD: type,
                        checkIn: checkIn,
                        checkOut: checkOut,
                        count: count,
                        locationReservision: locationReservision,
                        rooms: rooms,
                      ),
                  transitionDuration: Duration(milliseconds: 1000),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }));
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
            child: Container(
              height: widget.isCurrent ? 280 : 310.0,
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
                            image: NetworkImage(image), fit: BoxFit.cover),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                        child: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.black12,
                            child: InkWell(
                              onTap: () {
                                showCancelBookingDialog(context, image, title);
                              },
                              //   child: Icon(Icons.directions_subway),
                            )),
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
                                    child: Text(
                                      title,
                                      style: _txtStyleTitle,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Row(
                                  children: <Widget>[
                                    ratingbar(
                                      starRating: rating,
                                      color: Color(0xFF09314F),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 5.0)),
                                    Text(
                                      "(" + rating.toString() + ")",
                                      style: _txtStyleSub,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.9),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        size: 16.0,
                                        color: Colors.black26,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 3.0)),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "\$" + price.toString(),
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: Color(0xFF09314F),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Gotik"),
                                ),
                                Text("per night",
                                    style:
                                        _txtStyleSub.copyWith(fontSize: 11.0))
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
                          padding: const EdgeInsets.only(top: 6.9, left: 14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Check In : \t",
                                  style: _txtStyleSub.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Padding(padding: EdgeInsets.only(top: 3.0)),
                              Text(checkIn, style: _txtStyleSub)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.9, right: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Check Out : \t",
                                  style: _txtStyleSub.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Padding(padding: EdgeInsets.only(top: 3.0)),
                              Text(checkOut, style: _txtStyleSub)
                            ],
                          ),
                        )
                      ],
                    ),
                    Visibility(
                        visible: widget.isCurrent ? false : true,
                        child: _reviewRatingButton(context, image, title))
                  ]),
                  Visibility(
                    visible: widget.isCurrent ? false : true,
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
    ));
  }

  Widget _reviewRatingButton(context, image, title) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          showGiveRatingReviewDialog(context, image, title);
        },
        child: Text(
          "Give Rating & Reviews",
          style: TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w600,
              fontFamily: "Gotik"),
        ),
      ),
    );
  }

  void showCancelBookingDialog(BuildContext context, image, title) {
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
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Cancel booking " + title),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ));
              },
            ));
  }

  void showGiveRatingReviewDialog(BuildContext context, image, title) {
    num rating = 0.0;
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
                              onPressed: () {},
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
      child: SingleChildScrollView(
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
              "Not Have Item",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19.5,
                  color: Colors.black26.withOpacity(0.2),
                  fontFamily: "Sofia"),
            ),
          ],
        ),
      ),
    );
  }
}
