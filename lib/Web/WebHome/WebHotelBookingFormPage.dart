import 'package:book_it/DataSample/HotelListData.dart';
import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/bloc/HomeBloc.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HotelHotelByCategoryResponse.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:book_it/Web/common_widget/CommonFooter.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class WebHotelBookingFormPage extends StatefulWidget {
  var title, categoryId;

  WebHotelBookingFormPage({this.title, this.categoryId});

  @override
  _WebHotelBookingFormPageState createState() =>
      _WebHotelBookingFormPageState();
}

class _WebHotelBookingFormPageState extends State<WebHotelBookingFormPage> {
  HomeBloc _homeBloc;
  AppConstantHelper _appConstantHelper;
  String descText;

  bool descTextShowFlag = false;
  var initialIndex = 0;
  final _controller = ScrollController();
  List<Marker> allMarkers = [];
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    // _homeBloc = HomeBloc();
    // _appConstantHelper = AppConstantHelper();
    // _appConstantHelper.setContext(context);
    //
    // if (widget.title == "Featured" ||
    //     widget.title == "Recommended" ||
    //     widget.title == "Recommended Rooms") {
    //   _homeBloc.getHotelListingApi(context: context, type: widget.categoryId);
    // } else
    //   _homeBloc.getHotelByCategory(
    //       context: context, categoryId: widget.categoryId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _titleWidget(width),
              crouselView(width),
              _bookingInfoView(width),
              _amenitiesView(width),
              _mapView(width),
              SizedBox(
                height: 80,
              ),
              CommonFooterWidget()
            ],
          ),
        ),
        // StreamBuilder<bool>(
        //   stream: _homeBloc.progressStream,
        //   builder: (context, snapshot) {
        //     return Center(
        //         child: CommmonProgressIndicator(
        //             snapshot.hasData ? snapshot.data : false));
        //   },
        // )
      ],
    );
  }

  Widget _titleWidget(width) {
    return Container(
      width: width,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF6774E7),
        Color(0xFF7D55B6),
      ], tileMode: TileMode.mirror)),
      child: Text(
        "${widget.title}",
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.5),
      ),
    );
  }

  Widget crouselView(width) {
    var _txtStyleTitle = TextStyle(
      color: Colors.black,
      fontFamily: "Poppins",
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    );
    var currentindex = 1;
    _animateToIndex(i) => _controller.animateTo(width * 0.7 * i,
        duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);

    return Container(
      margin: EdgeInsets.only(left: width * 0.12, right: width * 0.12, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: Offset(0, 2))
          ]),
      child: Column(children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, left: 8, right: 8),
              width: double.infinity,
              height: 400,
            ),
          ],
        ),
      ]),
    );
  }

  _bookingInfoView(width) {
    return Container(
      width: width,
      height: 400,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: width * 0.12, right: width * 0.12, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: Offset(0, 2))
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.redAccent,
              child: Column(
                children: [
                  Text(
                    "Add Card".toUpperCase(),
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }

  _amenitiesView(width) {
    return Container(
      width: width,
      height: 200,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: width * 0.12, right: width * 0.12, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Amenities".toUpperCase(),
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }

  _mapView(width) {
    return Container(
      width: width,
      height: 200,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: width * 0.12, right: width * 0.12, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Location".toUpperCase(),
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }
}
