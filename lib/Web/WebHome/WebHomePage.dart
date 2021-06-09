import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/bloc/HomeBloc.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/WebAppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:book_it/Web/WebHome/WebDashboardPage.dart';
import 'package:book_it/Web/common_widget/CommonFooter.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'WebHotelCategoryWiseListingPage.dart';

class WebHomePage extends StatefulWidget {
  static final _txtStyle = TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Poppins');

  @override
  _WebHomePageState createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  var viewDetailButtonColor = Colors.grey;

  var textColor = Colors.grey;
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementEnter(PointerEvent details) {
    setState(() {
      _enterCounter++;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      textColor = AppColor.colorLightBlue;
      _exitCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      textColor = Colors.grey;
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  HomeBloc _homeBloc;
  AppConstantHelper _appConstantHelper;
  bool _enabled = false;
  List<HotelData> _featured = [];
  List<HotelData> _recommended = [];
  List<Destinations> _destinations = [];
  List<Categories> _categories = [];
  List<HotelData> _rooms = [];
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    getLocalStorage();
    _homeBloc.getHomePageData(context: context);

    super.initState();
  }

  getLocalStorage() {
    LocalStorage.getEmail().then((email) {
      AppStrings.userEmail = email;
      print('Email.......$email');
    });
    LocalStorage.getUserName().then((name) {
      AppStrings.userName = name;
      print('Name.......$name');
    });
    LocalStorage.getUserAuthToken().then((token) {
      AppStrings.authToken = token;
      print('AuthToken...........$token');
    });
    LocalStorage.getUserImage().then((image) {
      AppStrings.userImage = image;
      print('UserImage...........$image');
    });
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
              _searchView(height, width),
              StreamBuilder<HomeResponse>(
                  initialData: null,
                  stream: _homeBloc.homeDataStream,
                  builder: (context, snapshot) {
                    // ignore: missing_return
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data.data != null) {
                      _featured = [];
                      _recommended = [];
                      _destinations = [];
                      _categories = [];
                      _rooms = [];
                      _featured = snapshot.data.data.featured;
                      print("_featured${_featured.length}");
                      _recommended = snapshot.data.data.recommended;
                      print("_recommended${_recommended.length}");
                      _destinations = snapshot.data.data.destinations;
                      _categories = snapshot.data.data.categories;
                      _rooms = snapshot.data.data.rooms;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        titleAndShowMore(
                            context: context,
                            title: "Featured",
                            onClick: () {
                              // ignore: missing_return
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebDashBoardPage(
                                            tabIndex: 0,
                                            pageRoute: "ListingPage",
                                            title: "Featured",
                                            categoryId: "features",
                                          )));
                            }),
                        _featuredAndRecommendedHotelListview(
                            height, width, context, _featured),
                        titleAndShowMore(
                            context: context,
                            title: "Recommended",
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebDashBoardPage(
                                            tabIndex: 0,
                                            pageRoute: "ListingPage",
                                            title: "Recommended",
                                            categoryId: "recomended",
                                          )));
                            }),
                        _recommendedHotelListview(
                            height, width, context, _recommended),
                        titleAndShowMore(
                            context: context,
                            title: "Popular Destination",
                            onClick: () {}),
                        popularDestinationAndVacationListItem(
                            height, width, context, _destinations),
                        titleAndShowMore(
                            context: context,
                            title: "Vacations",
                            onClick: () {}),
                        vacationListItem(height, width, context, _categories),
                        titleAndShowMore(
                            context: context,
                            title: "Recommended Rooms",
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebDashBoardPage(
                                            tabIndex: 0,
                                            pageRoute: "ListingPage",
                                            title: "Recommended Rooms",
                                            categoryId: "rooms",
                                          )));
                            }),
                        _featuredAndRecommendedHotelListview(
                            height, width, context, _rooms),
                        CommonFooterWidget()
                      ],
                    );
                  }),
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

  _searchView(height, width) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/image/images/search_bg.png"),
            // image:
            //     AssetImage("assets/image/destinationPopuler/destination1.png"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Container(
              color: Colors.white.withOpacity(0.3),
              margin: EdgeInsets.symmetric(
                  horizontal: width > 650 ? width * 0.25 : width * 0.1),
              child: Container(
                margin: EdgeInsets.all(6),
                color: Colors.white,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Color(0xFF6774E7),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.webBlackColor,
                            letterSpacing: 1.5),
                        decoration: InputDecoration(
                          hintText: "Find what you want",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColor.webBlackColor,
                              letterSpacing: 1.5),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColor.webBlackColor,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      height: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: LinearGradient(colors: [
                            Color(0xFF7D55B6),
                            Color(0xFF6774E7),
                          ], tileMode: TileMode.mirror)),
                      child: MaterialButton(
                        splashColor: Color(0xFF6774E7),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Search",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.webWhiteColor,
                              letterSpacing: 1.5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              WebAppStrings.choose_destination,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColor.webWhiteColor,
                  letterSpacing: 1.5,
                  decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleAndShowMore(
      {BuildContext context, String title, VoidCallback onClick}) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          top: 40.0,
          right: MediaQuery.of(context).size.width * 0.05,
          bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title",
            style: WebHomePage._txtStyle,
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () => onClick(),
            child: Text(
              title == "Vacations" ? "" : "See More",
              style: WebHomePage._txtStyle.copyWith(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _featuredAndRecommendedHotelListview(
      height, width, context, List<HotelData> dataList) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          height: 330,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              primary: false,
              itemCount: dataList.length > 0 ? dataList.length : 0,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 24),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        width: width > 650
                            ? MediaQuery.of(context).size.width * 0.21
                            : MediaQuery.of(context).size.width * 0.38,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF656565).withOpacity(0.1),
                                  blurRadius: 6.0,
                                  offset: Offset(-1, 1))
                            ]),
                        child: Column(
                          children: [
                            Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(2.0),
                                      topRight: Radius.circular(2.0)),
                                  image: DecorationImage(
                                      image:
                                          /*AssetImage(
                                          "assets/image/destinationPopuler/destination1.png")*/
                                          NetworkImage(AppStrings.imagePAth +
                                              dataList[i].images[0]),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${dataList[i].name}',
                                          style: TextStyle(
                                              letterSpacing: 0.5,
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        ratingbar(
                                          starRating: double.parse(
                                              dataList[i].rating.toString()),
                                          size: 30,
                                          // starRating: double.parse(rating.toString()),
                                        ),
                                      ],
                                    ),

                                    // width: MediaQuery.of(context).size.width*0.,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          " Starting at ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w300,
                                              fontSize: 10.0),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0.0, right: 0.0),
                                          child: Text(
                                            "\$${'${dataList[i].price}'}/night",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: width,
                              child: MouseRegion(
                                // onEnter: _incrementEnter,
                                // onHover:_updateLocation,
                                // onExit: _incrementExit,
                                child: MaterialButton(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      side:
                                          BorderSide(width: 0.8, color: textColor)),
                                  onPressed: () {},
                                  child: Text(
                                    "View Details".toUpperCase(),
                                    style: WebHomePage._txtStyle.copyWith(
                                        color: textColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                );
              }),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.043,top: 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Icon(Icons.keyboard_arrow_left_outlined),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.046,top: 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Icon(Icons.keyboard_arrow_right_outlined),
          ),
        )
      ],
    );
  }

  Widget _recommendedHotelListview(
      height, width, context, List<HotelData> _recommended) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          height: 320,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              primary: false,
              itemCount: _recommended.length > 0 ? _recommended.length : 0,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 24),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        width: width > 650
                            ? MediaQuery.of(context).size.width * 0.29
                            : MediaQuery.of(context).size.width * 0.48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF656565).withOpacity(0.1),
                                  blurRadius: 6.0,
                                  offset: Offset(-1, 1)),
                            ]),
                        child: Column(
                          children: [
                            Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(2.0),
                                      topRight: Radius.circular(2.0)),
                                  image: DecorationImage(
                                      image:
                                          /* AssetImage(
                                          "assets/image/destinationPopuler/destination1.png")*/
                                          NetworkImage(AppStrings.imagePAth +
                                              _recommended[i].images[0]),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_recommended[i].name}',
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${_recommended[i].description}',
                                    maxLines: 3,
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              }),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.043,top: 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Icon(Icons.keyboard_arrow_left_outlined),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.046,top: 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Icon(Icons.keyboard_arrow_right_outlined),
          ),
        )
      ],
    );
  }

  Widget popularDestinationAndVacationListItem(
      height, width, context, var _destinations) {
    return Stack(
      children: [
        Container(
            height: 320.0,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _destinations.length > 0 ? _destinations.length : 0,
                itemBuilder: (context, index) {
                  return Container(
                    height: 320.0,
                    width: width > 650
                        ? MediaQuery.of(context).size.width * 0.21
                        : MediaQuery.of(context).size.width * 0.38,
                    margin: EdgeInsets.only(right: 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        image: DecorationImage(
                          image: NetworkImage(
                            AppStrings.imagePAth +
                                '${_destinations[index].images[0]}',
                          ),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF656565).withOpacity(0.1),
                              blurRadius: 6.0,
                              offset: Offset(-1, 1))
                        ]),
                    child: Center(
                      child: Text(
                        "${_destinations[index].name}",
                        style: TextStyle(
                          fontFamily: 'Amira',
                          color: Color(0xFFFFFFFF),
                          fontSize: 32.0,
                          letterSpacing: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                })),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.043,top: 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Icon(Icons.keyboard_arrow_left_outlined),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.046,top: 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Icon(Icons.keyboard_arrow_right_outlined),
          ),
        )
      ],
    );
  }

  Widget vacationListItem(height, width, context, List<Categories> categories) {
    return Stack(
      children: [
        Container(
            height: 320.0,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length > 0 ? categories.length : 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebDashBoardPage(
                                tabIndex: 0,
                                pageRoute: "ListingPage",
                                title: "${categories[index].name}",
                                categoryId: "${_categories[index].sId}",
                              )));
                    },
                    child: Container(
                      height: 320.0,
                      width: width > 650
                          ? MediaQuery.of(context).size.width * 0.21
                          : MediaQuery.of(context).size.width * 0.38,
                      margin: EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          image: DecorationImage(
                            image: NetworkImage(
                              AppStrings.imagePAth + '${categories[index].image}',
                            ),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF656565).withOpacity(0.1),
                                blurRadius: 6.0,
                                offset: Offset(-1, 1))
                          ]),
                      child: Center(
                        child: Text(
                          "${categories[index].name}",
                          style: TextStyle(
                            fontFamily: 'Amira',
                            color: Color(0xFFFFFFFF),
                            fontSize: 32.0,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                })),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.043,top: 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Icon(Icons.keyboard_arrow_left_outlined),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.046,top: 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Icon(Icons.keyboard_arrow_right_outlined),
          ),
        )
      ],
    );
  }
}
