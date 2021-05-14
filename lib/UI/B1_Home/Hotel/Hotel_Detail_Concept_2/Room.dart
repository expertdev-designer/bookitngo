import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/HotelRoomListingResponse.dart';
import 'package:book_it/UI/B5_Profile/ListProfile/CreditCard.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'RoomDetail.dart';
import 'SelectCheckInOutDate.dart';
import 'bloc/GetRoomsAndBookNowBloc.dart';
import 'model/BookingRoomList.dart';

class Room extends StatefulWidget {
  String imageD,
      titleD,
      locationD,
      idD,
      typeD,
      userId,
      nameD,
      photoProfileD,
      emailD,
      descriptionD;
  List<String> photoD, serviceD;
  num ratingD, priceD, latLang1D, latLang2D;

  Room({
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
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  int isSelected = -1;
  num childCapacity;

  num adultCapacity;
  var _txtStyleTitle = TextStyle(
    color: Colors.white,
    fontFamily: "Gotik",
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );
  List<String> roomIds = [];
  GetRoomsAndBookNowBloc _getRoomsAndBookNowBloc;
  AppConstantHelper _appConstantHelper;
  num totalGuest = 0;
  num totalRoom = 0;
  num totalAmount = 0;
  String selectedRoomType="";
  num selectedRoomPrice = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController specialInstructionController =
      TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();

  @override
  void initState() {
    _appConstantHelper = AppConstantHelper();
    _getRoomsAndBookNowBloc = GetRoomsAndBookNowBloc();
    getHotelRoomsListing();
    AppStrings.selectedRoomList.clear();
    AppStrings.checkInDate = DateTime.now();
    AppStrings.checkOutDate = DateTime.now().add(new Duration(days: 1));
    AppStrings.selectedRoomList.add(SelectedRoomList(adult: 1, child: 0));
    totalGuest = 0;
    AppStrings.selectedRoomList.forEach((element) {
      totalGuest += element.child + element.adult;
      print("totalGuest $totalGuest");
    });
    // selectedRoomPrice = widget.priceD;
    // selectedRoomPrice = 20;
    super.initState();
  }

  num calculateRoomPrice() {
    var difference =
        AppStrings.checkOutDate.difference(AppStrings.checkInDate).inDays;
    print("Datedifference$difference");
    difference = difference;
    return (selectedRoomPrice * AppStrings.selectedRoomList.length) *
        difference;
  }

  void getHotelRoomsListing() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _getRoomsAndBookNowBloc.getHotelRoomsList(
            context: context, hotelId: widget.idD);
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

  void getAvailableRoomListing() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _getRoomsAndBookNowBloc.checkRoomAvailability(
            context: context,
            hotelId: widget.idD,
            checkIn: DateFormat("yyyy-MM-dd")
                .format(AppStrings.checkInDate)
                .split(" ")
                .first,
            checkOut: DateFormat("yyyy-MM-dd")
                .format(AppStrings.checkOutDate)
                .split(' ')
                .first,
            roomType: selectedRoomType);
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
    String _nama, _photoProfile, _email;

    var _appBar = PreferredSize(
      preferredSize: Size.fromHeight(45.0),
      child: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("${widget.titleD}",
            style: TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w600)),
      ),
    );

    return Scaffold(
      persistentFooterButtons: [_reserveBottomButton()],
      appBar: _appBar,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<HotelRoomListingResponse>(
                    initialData: null,
                    stream:
                        _getRoomsAndBookNowBloc.getAvailableHotelRoomDataStream,
                    builder: (context, snapshot) {
                      // if( snapshot.hasData &&
                      //     snapshot.data != null &&
                      //     snapshot.data.data.length > 0)
                      //   {
                      //
                      //     AppStrings.selectedRoomList.clear();
                      //     AppStrings.selectedRoomList.add(SelectedRoomList(adult: 1, child: 0));
                      //     totalGuest = 0;
                      //     AppStrings.selectedRoomList.forEach((element) {
                      //       totalGuest += element.child + element.adult;
                      //       print("totalGuest $totalGuest");
                      //     });
                      //
                      //   }else {
                      //   isSelected=-1;
                      // }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          hotelRoomSlider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                                bottom: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Date of Travel and guests',
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (selectedRoomType.isNotEmpty) {
                                      selectCheckInCheckoutDate();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AppConstantHelper.showDialog(
                                                context: context,
                                                title: "Select room",
                                                msg:
                                                    "Please select room first before selecting check in and checkout date and room guest");
                                          });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      /* Icon(
                                      Icons.edit,
                                      color: Color.fromRGBO(0, 186, 156, 1),
                                    ),*/
                                      SvgPicture.asset(
                                        'assets/image/images/edit.svg',
                                        width: 16,
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                            height: 1.2,
                                            color:
                                                Color.fromRGBO(0, 186, 156, 1),
                                            fontFamily: "Sofia",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          _checkInCheckOutWidget(),
                          labelTextWidget("Phone Number"),
                          _phoneNumberWidget(),
                          labelTextWidget('Special Instruction'),
                          _specialInstruction(),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
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

  _phoneNumberWidget() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10.0, color: Colors.black12.withOpacity(0.1)),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Theme(
                data: ThemeData(
                  highlightColor: Colors.white,
                  hintColor: Colors.white,
                ),
                child: TextFormField(
                    // onSaved: (input) => _location = input,
                    controller: phoneNoController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input your phione number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "",
                      hintStyle:
                          TextStyle(fontFamily: "Sofia", color: Colors.black),
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                            style: BorderStyle.none),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _specialInstruction() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0, color: Colors.black12.withOpacity(0.1)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                hintColor: Colors.white,
              ),
              child: TextFormField(
                  // onSaved: (input) => _location = input,
                  controller: specialInstructionController,
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "",
                    hintStyle:
                        TextStyle(fontFamily: "Sofia", color: Colors.black),
                    enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.none),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget hotelRoomSlider() {
    return StreamBuilder<HotelRoomListingResponse>(
        initialData: null,
        stream: _getRoomsAndBookNowBloc.getHotelRoomDataStream,
        builder: (context, snapshot) {
          return

              /*Container(
            height: 300.0,
            child: Material(
              child: new Carousel(
                dotColor: Colors.black26,
                dotIncreaseSize: 1.7,
                dotBgColor: Colors.transparent,
                autoplay: false,
                boxFit: BoxFit.cover,
                images: widget.photoD.map((image) {
                  return NetworkImage(AppStrings.imagePAth + image);
                }).toList(),
              ),
            ),
          );*/

              snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data.data.length > 0
                  ? Container(
                      margin: EdgeInsets.only(top: 20.0),
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.width * 0.64,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.hasData &&
                                  snapshot.data != null &&
                                  snapshot.data.data.length > 0
                              ? snapshot.data.data.length
                              : 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 0.0),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  color: Colors.transparent,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Hero(
                                          tag:
                                              'hero-tag-room${snapshot.data.data[index].sId}',
                                          child: Material(
                                            color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            AppStrings
                                                                    .imagePAth +
                                                                snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .images
                                                                    .first),
                                                        fit: BoxFit.cover),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black12
                                                              .withOpacity(0.1),
                                                          blurRadius: 3.0,
                                                          spreadRadius: 1.0)
                                                    ]),
                                                alignment: Alignment.topRight,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .yellow,
                                                              ),
                                                              SizedBox(
                                                                width: 4.0,
                                                              ),
                                                              Text(
                                                                "${widget.ratingD}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "Gotik",
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data.data[index].room_type}",
                                                            style:
                                                                _txtStyleTitle,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          RichText(
                                                            textAlign: TextAlign
                                                                .center,
                                                            text: TextSpan(
                                                              text:
                                                                  '\$${snapshot.data.data[index].price}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "Gotik"),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '\n/per night',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                            .white70,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontFamily:
                                                                            "Gotik")),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/image/images/location_blue.svg',
                                              width: 16,
                                              height: 16,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              widget.locationD,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Gotik",
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        FlatButton(
                                            color: index == isSelected
                                                ? Color.fromRGBO(0, 186, 156, 1)
                                                : Colors.white,
                                            padding: EdgeInsets.zero,
                                            shape: new RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: isSelected == index
                                                    ? Colors.white
                                                    : Color.fromRGBO(
                                                        0, 186, 156, 1),
                                              ),
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                3.0,
                                              ),
                                            ),
                                            height: 25,
                                            onPressed: () {
                                              setState(() {
                                                isSelected = index;
                                                childCapacity = snapshot.data
                                                    .data[index].childCapacity;
                                                adultCapacity = snapshot.data
                                                    .data[index].adultCapacity;
                                                print(
                                                    "isSelected${isSelected}");
                                                selectedRoomType = snapshot
                                                    .data.data[index].room_type;
                                                selectedRoomPrice = num.parse(
                                                    snapshot.data.data[index]
                                                        .price);

                                                AppStrings.selectedRoomList
                                                    .clear();
                                                AppStrings.selectedRoomList.add(
                                                    SelectedRoomList(
                                                        adult: 1, child: 0));
                                                totalGuest = 0;
                                                AppStrings.selectedRoomList
                                                    .forEach((element) {
                                                  totalGuest += element.child +
                                                      element.adult;
                                                  print(
                                                      "totalGuest $totalGuest");
                                                });
                                                // getAvailableRoomListing();
                                              });
                                            },
                                            child: Text(
                                              "Select".toUpperCase(),
                                              style: TextStyle(
                                                color: index == isSelected
                                                    ? Colors.white
                                                    : Color.fromRGBO(
                                                        0, 186, 156, 1),
                                                fontFamily: "Gotik",
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                      ]),
                                ),
                              ),
                            );
                          }),
                    )
                  : Container(
                      height: 260.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  " jbfbhttps://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                    );
        });
  }

  _checkInCheckOutWidget() {
    return InkWell(
      onTap: () {
        if (selectedRoomType.isNotEmpty) {
          selectCheckInCheckoutDate();
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AppConstantHelper.showDialog(
                    context: context,
                    title: "Select room",
                    msg:
                        "Please select room first before selecting check in and checkout date and room guest");
              });
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 14),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Color(0xFF09314F),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8.0,
                  ),
                  SvgPicture.asset(
                    'assets/image/images/calendar.svg',
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // '23 Apr -25 Apr',
                        '${DateFormat('dd MMM').format(AppStrings.checkInDate)}\t-\t${DateFormat('dd MMM').format(AppStrings.checkOutDate)}',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0),
                      ),
                      Text(
                        '12:00 PM - 11:00 AM',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 1,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/image/images/profile.svg',
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    children: [
                      Text(
                        AppStrings.selectedRoomList != null &&
                                AppStrings.selectedRoomList.length > 0
                            ? '${AppStrings.selectedRoomList.length} rooms'
                            : " 0 rooms",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0),
                      ),
                      Text(
                        '${totalGuest} guests',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _reserveBottomButton() {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${calculateRoomPrice()}',
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0)),
                  Text('Total Amount',
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0)),
                ],
              ),
              StreamBuilder<HotelRoomListingResponse>(
                  initialData: null,
                  stream: _getRoomsAndBookNowBloc.getHotelRoomDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.data != null &&
                        snapshot.data.data.length > 0) {
                      roomIds.clear();
                      for (int i = 0;
                          i < AppStrings.selectedRoomList.length;
                          i++) {
                        roomIds.add(snapshot.data.data[i].sId);
                      }
                      print("roomIds${roomIds.length}");
                    }
                    return FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(
                            4.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        splashColor: Colors.grey,
                        onPressed: () {
                          if (selectedRoomType.isNotEmpty) {
                            if (AppStrings.selectedRoomList != null &&
                                AppStrings.selectedRoomList.length > 0) {
                              if (_formKey.currentState.validate()) {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        new AddCreditCard(
                                          isFor: "Booking",
                                          hotelID: widget.idD,
                                          roomID: roomIds,
                                          checkInDate: AppStrings.checkInDate,
                                          checkOutDate: AppStrings.checkOutDate,
                                          roomList: AppStrings.selectedRoomList,
                                          amount: selectedRoomPrice.toString(),
                                          phone:
                                              phoneNoController.text.toString(),
                                          specialInstruction:
                                              specialInstructionController.text
                                                  .toString(),
                                        ),
                                    // pageBuilder: (_, __, ___) => new BookingConfirmPage(),
                                    transitionDuration:
                                        Duration(milliseconds: 600),
                                    transitionsBuilder: (_,
                                        Animation<double> animation,
                                        __,
                                        Widget child) {
                                      return Opacity(
                                        opacity: animation.value,
                                        child: child,
                                      );
                                    }));
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AppConstantHelper.showDialog(
                                        context: context,
                                        title:
                                            "Please select check in check out date and guest  ",
                                        msg: "Select Check In Check Out Date ");
                                  });
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AppConstantHelper.showDialog(
                                      context: context,
                                      title: "Choose room",
                                      msg: "Please choose room for booking");
                                });
                          }
                        },
                        color: AppColor.primaryColor,
                        child: Text('Reserve',
                            style: TextStyle(
                                height: 1.0,
                                color: Colors.white,
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0)));
                  })
            ],
          ),
        )
      ],
    );
  }

  void selectCheckInCheckoutDate() {
    Navigator.of(context)
        .push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new SelectCheckInOutDate(
                  adultCapacity: 2,
                  childCapacity: 2,
                  hotelID: widget.idD,
                  selectedRoomType: selectedRoomType,
                ),
            transitionDuration: Duration(milliseconds: 600),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }))
        .then((value) {
      setState(() {
        if (AppStrings.selectedRoomList != null &&
            AppStrings.selectedRoomList.length > 0) {
          totalRoom = AppStrings.selectedRoomList.length;
          // selectedRoomPrice =
          //     selectedRoomPrice * AppStrings.selectedRoomList.length;
          print("TotalPrice $totalGuest");
          print("totalRoom ${AppStrings.selectedRoomList.length}");
          totalGuest = 0;
          AppStrings.selectedRoomList.forEach((element) {
            totalGuest += element.child + element.adult;
            print("totalGuest $totalGuest");
          });
          getHotelRoomsListing();

          // totalGuest
        }
      });
    });
  }
}

/*
import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'RoomDetail.dart';
import 'hotelDetail_concept_2.dart';

class Room extends StatefulWidget {
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

  Room({
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
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    String _nama, _photoProfile, _email;

    void _getData() {
      StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            var userDocument = snapshot.data;
            _nama = userDocument["name"];
            _email = userDocument["email"];
            _photoProfile = userDocument["photoProfile"];

            setState(() {
              var userDocument = snapshot.data;
              _nama = userDocument["name"];
              _email = userDocument["email"];
              _photoProfile = userDocument["photoProfile"];
            });
          }

          var userDocument = snapshot.data;
          return Stack(
            children: <Widget>[Text(userDocument["name"])],
          );
        },
      );
    }

    var _appBar = PreferredSize(
      preferredSize: Size.fromHeight(45.0),
      child: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Choose Room",
            style: TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w600)),
      ),
    );

    var _recommended = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection("room")
                .where('title', isEqualTo: widget.titleD)
                .snapshots(),
            builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return new Container(
                  height: 190.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                );
              }
              return snapshot.hasData
                  ? new cardList(
                      descriptionD: widget.descriptionD,
                      userId: widget.userId,
                      titleD: widget.titleD,
                      idD: widget.idD,
                      imageD: widget.imageD,
                      latLang1D: widget.latLang1D,
                      latLang2D: widget.latLang2D,
                      locationD: widget.locationD,
                      priceD: widget.priceD,
                      photoD: widget.photoD,
                      ratingD: widget.ratingD,
                      serviceD: widget.serviceD,
                      typeD: widget.typeD,
                      emailD: _email,
                      nameD: _nama,
                      photoProfileD: _photoProfile,
                      list: snapshot.data.documents,
                    )
                  : Container(
                      height: 10.0,
                    );
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );

    return Scaffold(
      appBar: _appBar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Recommended
            _recommended,
          ],
        ),
      ),
    );
  }
}

class cardList extends StatelessWidget {
  String dataUser;
  final List<DocumentSnapshot> list;
  String imageD,
      titleD,
      locationD,
      idD,
      typeD,
      userId,
      nameD,
      photoProfileD,
      emailD,
      titleR,
      informationR,
      roomR,
      idR,
      _email,
      _photoProfile,
      _nama;
  List<String> photoD, serviceD, descriptionD, imageR;
  num ratingD, priceD, latLang1D, latLang2D, priceR;

  @override
  var _txtStyleTitle = TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 19.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  cardList({
    this.dataUser,
    this.list,
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

  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          List<String> image = List.from(list[i].data['image']);
          String title = list[i].data['title'].toString();
          String information = list[i].data['information'].toString();
          String room = list[i].data['room'].toString();
          String id = list[i].data['id'].toString();
          num price = list[i].data['priceRoom'];
          DocumentSnapshot _list = list[i];
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new RoomDetail(
                          userId: userId,
                          titleD: title,
                          idD: id,
                          imageR: image,
                          priceD: priceD,
                          roomR: room,
                          priceR: price,
                          informationR: information,
                          imageD: imageD,
                          latLang1D: latLang1D,
                          listItem: _list,
                          latLang2D: latLang2D,
                          locationD: locationD,
                          descriptionD: descriptionD,
                          photoD: photoD,
                          ratingD: ratingD,
                          serviceD: serviceD,
                          typeD: typeD,
                          emailD: _email,
                          nameD: _nama,
                          titleR: title,
                          photoProfileD: _photoProfile,
                        ),
                    transitionDuration: Duration(milliseconds: 600),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }));
              },
              child: Container(
                height: 190.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0)
                    ]),
                child: Column(children: [
                  Hero(
                    tag: 'hero-tag-${id}',
                    child: Material(
                      child: Container(
                        height: 125.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(image[0]), fit: BoxFit.cover),
                        ),
                        alignment: Alignment.topRight,
                      ),
                    ),
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
                                    room,
                                    style: _txtStyleTitle,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
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
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Gotik"),
                              ),
                              Text("per night",
                                  style: _txtStyleSub.copyWith(fontSize: 11.0))
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
        });
  }
}
*/
