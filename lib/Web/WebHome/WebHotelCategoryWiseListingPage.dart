import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/bloc/HomeBloc.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HotelHotelByCategoryResponse.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:book_it/Web/common_widget/CommonFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WebDashboardPage.dart';

// ignore: must_be_immutable
class WebHotelCategoryWiseListingPage extends StatefulWidget {
  var title, categoryId;

  WebHotelCategoryWiseListingPage({this.title, this.categoryId});

  @override
  _WebHotelCategoryWiseListingPageState createState() =>
      _WebHotelCategoryWiseListingPageState();
}

class _WebHotelCategoryWiseListingPageState
    extends State<WebHotelCategoryWiseListingPage> {
  HomeBloc _homeBloc;
  AppConstantHelper _appConstantHelper;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);

    if (widget.title == "Featured" ||
        widget.title == "Recommended" ||
        widget.title == "Recommended Rooms") {
      _homeBloc.getHotelListingApi(context: context, type: widget.categoryId);
    } else
      _homeBloc.getHotelByCategory(
          context: context, categoryId: widget.categoryId);
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
              _hotelCardListView(width),
              SizedBox(
                height: 80,
              ),
              CommonFooterWidget()
            ],
          ),
        ),
        StreamBuilder<bool>(
          stream: _homeBloc.progressStream,
          builder: (context, snapshot) {
            return Center(
                child: CommmonProgressIndicator(
                    snapshot.hasData ? snapshot.data : false));
          },
        )
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
        "${widget.title}",
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.5),
      ),
    );
  }

  Widget _hotelCardListView(width) {
    var _txtStyleTitle = TextStyle(
      color: Colors.black,
      fontFamily: "Poppins",
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    );

    return StreamBuilder<HotelByCategoryResponse>(
        stream: _homeBloc.hotelByCategoryDataStream,
        builder: (BuildContext ctx, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data.data.length > 0) {
            if (snapshot.data.data.length > 0)
              return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.12, right: width * 0.12, top: 20),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 230.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 3.0,
                                    spreadRadius: 1.0)
                              ]),
                          child: Row(children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1)),
                                  image: DecorationImage(
                                      image: NetworkImage(AppStrings.imagePAth +
                                          snapshot.data.data[i].images.first),
                                      fit: BoxFit.cover),
                                ),
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 16.0,
                                    right: 16,
                                    bottom: 16.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text(
                                                  "${snapshot.data.data[i].name}",
                                                  style: _txtStyleTitle,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.9),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 16.0,
                                                      color: Colors.grey,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 3.0,
                                                                right: 6)),
                                                    Text(
                                                      snapshot
                                                          .data.data[i].address,
                                                      style: TextStyle(
                                                          height: 1.0,
                                                          color: Colors.black54,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.0),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                "Starting at ",
                                                style: TextStyle(
                                                    height: 1.0,
                                                    color: Colors.black54,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.0),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.9),
                                                child: Text(
                                                  "\$" +
                                                      snapshot
                                                          .data.data[i].price
                                                          .toString() +
                                                      "/per night",
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Description : ",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins"),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "${snapshot.data.data[i].description}",
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ratingbar(
                                            starRating: double.parse(snapshot
                                                .data.data[i].rating
                                                .toString()),
                                            size: 50,
                                          ),
                                          MouseRegion(
                                            // onEnter: _incrementEnter,
                                            // onHover:_updateLocation,
                                            // onExit: _incrementExit,
                                            child: MaterialButton(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16, horizontal: 20),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  side: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Color(0xFF6774E7))),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WebDashBoardPage(
                                                              tabIndex: 0,
                                                              pageRoute:
                                                                  "HotelDetailPage",
                                                              title: "Detail",
                                                              categoryId:
                                                                  "recommended",
                                                              hotelData:
                                                                  snapshot.data
                                                                      .data[i],
                                                            )));
                                              },
                                              child: Text(
                                                "View Details".toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF6774E7),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  });
            else
              return Center(
                child: Text(
                  "No data found",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      height: 4.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              );
          } else {
            return Container();
          }
        });
  }
}
