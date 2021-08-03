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

import 'WebDashboardPage.dart';

// ignore: must_be_immutable
class WebHotelDetailPage extends StatefulWidget {
  var title, categoryId;
  HotelData hotelData;

  WebHotelDetailPage({this.title, this.hotelData});

  @override
  _WebHotelDetailPageState createState() => _WebHotelDetailPageState();
}

class _WebHotelDetailPageState extends State<WebHotelDetailPage> {
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
    descText = widget.hotelData.description;

    allMarkers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        ),
        markerId: MarkerId(widget.hotelData.latitude.toString()),
        draggable: false,
        position: LatLng(double.parse(widget.hotelData.latitude),
            double.parse(widget.hotelData.longitude))));
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
              _descriptionView(width),
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
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF6774E7),
        Color(0xFF7D55B6),
      ], tileMode: TileMode.mirror)),
      child: Text(
        // "${widget.title}",
        "Detail",
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

    return InkWell(
      onTap: () {},
      child: Container(
        margin:
            EdgeInsets.only(left: width * 0.12, right: width * 0.12, top: 20),
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
                child: CarouselSlider(
                    items: widget.hotelData.images
                        .map((item) => Container(
                              width: double.infinity,
                              child: Image.network(AppStrings.imagePAth + item,
                                  fit: BoxFit.cover),
                            ))
                        .toList(),
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 400,

                      // aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      // autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
              Positioned(
                top: 170,
                left: 0,
                child: InkWell(
                  onTap: () {
                    // initialIndex = initialIndex--;
                    // currentindex = currentindex--;
                    // _animateToIndex(currentindex);
                    buttonCarouselController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                    setState(() {});
                  },
                  child: Container(
                    height: 60,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: Colors.grey,
                      size: 14,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 170,
                right: 0,
                child: InkWell(
                  onTap: () {
                    // initialIndex = initialIndex++;
                    // currentindex = currentindex++;
                    // _animateToIndex(currentindex);
                    buttonCarouselController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                    setState(() {});
                  },
                  child: Container(
                    height: 60,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    child: Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Colors.grey,
                      size: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              // mainAxisAlignment:
              // MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "${widget.hotelData.name}",
                          style: _txtStyleTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 16.0,
                              color: Colors.grey,
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 3.0, right: 6)),
                            Text(
                              "${widget.hotelData.address}",
                              style: TextStyle(
                                  height: 1.0,
                                  color: Colors.black54,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ratingbar(
                        starRating:
                            double.parse(widget.hotelData.rating.toString()),
                        size: 50,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(height: 8,),
                      Text(
                        "Starting at ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "\$" +
                              widget.hotelData.price.toString() +
                              "/per night",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MouseRegion(
                        // onEnter: _incrementEnter,
                        // onHover:_updateLocation,
                        // onExit: _incrementExit,
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          color: AppColor.primaryColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebDashBoardPage(
                                      tabIndex: 0,
                                      pageRoute: "BookingFormPage",
                                      title: "${widget.hotelData.name}",
                                      categoryId: "${widget.hotelData.sId}",
                                    )));
                          },
                          child: Text(
                            "Book now".toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  _descriptionView(width) {
    return Container(
      width: width,
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
            "Description".toUpperCase(),
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(descText,
                  style: TextStyle(
                      fontSize: 13.0,
                      height: 1.5,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins"),
                  maxLines: descTextShowFlag ? 8 : 3,
                  textAlign: TextAlign.start),
              InkWell(
                onTap: () {
                  setState(() {
                    descTextShowFlag = !descTextShowFlag;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    descTextShowFlag
                        ? Text(
                            "less",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          )
                        : Text("more", style: TextStyle(color: Colors.blue))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _amenitiesView(width) {
    return Container(
      width: width,
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
          Wrap(
            // We changed from Row to Wrap
            children: List.generate(widget.hotelData.amenities.length, (i) {
              return Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: width * 0.15,
                    child: RichText(
                      text: TextSpan(
                        text: "✓  ",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"),
                        children: <TextSpan>[
                          TextSpan(
                              text: "${widget.hotelData.amenities[i]}",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  height: 1.5,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  ));
            }),
          ),
        ],
      ),
    );
  }

  _mapView(width) {
    return Container(
      width: width,
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
          Container(
            height: 250,
            color: Colors.grey,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(double.parse(widget.hotelData.latitude),
                      double.parse(widget.hotelData.longitude)),
                  zoom: 13.0),

              // markers: markers,
              onTap: (pos) {
                print(pos);
                Marker m = Marker(markerId: MarkerId('1'), position: pos);
                setState(() {
                  allMarkers.add(m);
                });
              },
              markers: Set.from(allMarkers),
              onMapCreated: (GoogleMapController controller) {
                // _controller = controller;
                // _controller.setMapStyle(_mapStyle);
              },
            ),
            // child: GoogleMap(),
          )
        ],
      ),
    );
  }
}
