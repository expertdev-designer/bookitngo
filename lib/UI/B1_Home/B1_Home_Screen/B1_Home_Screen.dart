import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/Destination/Anaheim.dart';
import 'package:book_it/UI/B1_Home/Recommendation/RecommendationDetailScreen.dart';
import 'package:book_it/UI/B1_Home/Vocation/vacationsPage.dart';
import 'package:book_it/UI/B4_Booking/Booking.dart';
import 'package:book_it/UI/Search/search.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:shimmer/shimmer.dart';
import 'bloc/HomeBloc.dart';
import 'editProfile.dart';
import 'model/HomeResponse.dart';

class Home extends StatefulWidget {
  String userID;

  Home({this.userID});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final _txtStyle = TextStyle(
      fontSize: 15.5,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Gotik');

  HomeBloc _homeBloc;
  AppConstantHelper _appConstantHelper;
  bool _enabled = false;
  List<HotelData> _featured = [];
  List<HotelData> _recommended = [];
  List<Destinations> _destinations = [];
  List<Categories> _categories = [];
  List<HotelData> _rooms = [];

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    getLocalStorage();
    getHomeDataFrommServer();

    super.initState();
  }

  void getHomeDataFrommServer() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _homeBloc.getHomePageData(context: context);
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
    var _appBar = AppBar(
      backgroundColor: Colors.white,
      title: Text("Home",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: "Gotik",
              fontSize: 28.0,
              color: Colors.black)),
      centerTitle: false,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Padding(
              padding: const EdgeInsets.only(right: 0.0, top: 9.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new updateProfile(
                                name: "${AppStrings.userName}",
                                uid: "widget.userID",
                                photoProfile: "${AppStrings.userImage}",
                              ),
                          transitionDuration: Duration(milliseconds: 600),
                          transitionsBuilder: (_, Animation<double> animation,
                              __, Widget child) {
                            return Opacity(
                              opacity: animation.value,
                              child: child,
                            );
                          }))
                      .then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(AppStrings.userImage.isNotEmpty
                            ? AppStrings.imagePAth + AppStrings.userImage
                            : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                        fit: BoxFit.cover,
                      )),
                ),
              )),
        )
      ],
      brightness: Brightness.light,
      elevation: 0.0,
    );

    var _searchBox = Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new Search(
            userId: widget.userID,
          ),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        )),
        child: Container(
          height: 43.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 1.0,
                blurRadius: 3.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Color(0xFF09314F),
                  size: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Find what you want",
                      style: TextStyle(
                          color: Colors.black26,
                          fontFamily: "Gotik",
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: StreamBuilder<HomeResponse>(
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
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _searchBox,
                            _featuredHotel(),
                            Recomendedbookitngo(),
                            _destinationPopuler(),
                            _vacations(),
                            _recommendedRooms()
                          ],
                        );
                      } else if (!snapshot.hasData)
                        return shimmerView(context);
                      else
                        return shimmerView(context);
                    }),
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
        ),
      ),
    );
  }

  Widget _featuredHotel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text(
            "Featured",
            style: _txtStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Container(
              height: 195.0,
              child: _featured != null && _featured.length > 0
                  ? new FeaturedCard(
                      dataUser: widget.userID,
                      featured: _featured,
                    )
                  : Container(
                      height: 190.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                    )),
        )
      ],
    );
  }

  Widget Recomendedbookitngo() {
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      height: 350.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 20.0),
            child: Text(
              "Recommended",
              style: _txtStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: _recommended != null && _recommended.length > 0
                ? Container(
                    height: 250.0,
                    child: new CardRecommended(
                      dataUser: widget.userID,
                      list: _recommended,
                    ),
                  )
                : Container(
                    height: 260.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _destinationPopuler() {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      height: 280.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Popular Destinations",
                    style: _txtStyle,
                  ),
                  Text(
                    "See More",
                    style: _txtStyle.copyWith(
                        color: Colors.black26, fontSize: 13.5),
                  )
                ],
              )),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                ),
                Container(
                  height: 400.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _destinations != null && _destinations.length > 0
                              ? _destinations.length
                              : 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    new PopularDestination(
                                      title: "${_destinations[index].name}",
                                      userId: widget.userID,
                                      destinations: _destinations[index],
                                    ),
                                transitionDuration: Duration(milliseconds: 600),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: child,
                                  );
                                }));
                          },
                          child: CardDestinationPopuler(
                            txt: _destinations[index].name,
                            img: AppStrings.imagePAth +
                                _destinations[index].images[index],
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vacations() {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      height: 280.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Vacations",
                    style: _txtStyle,
                  ),
                  Text(
                    "",
                    style: _txtStyle.copyWith(
                        color: Colors.black26, fontSize: 13.5),
                  )
                ],
              )),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                ),
                Container(
                  height: 400.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories != null && _categories.length > 0
                          ? _categories.length
                          : 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new VacationPage(
                                      title: '${_categories[index].name}',
                                      categoryId: "${_categories[index].sId}",
                                    ),
                                transitionDuration: Duration(milliseconds: 600),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: child,
                                  );
                                }));
                          },
                          child: CardDestinationPopuler(
                            txt: _categories[index].name,
                            img:
                                AppStrings.imagePAth + _categories[index].image,
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendedRooms() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0),
              child: Text("Recommended Rooms", style: _txtStyle),
            ),

            /// To set GridView item
            ///
            _rooms != null && _rooms.length > 0
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.795, crossAxisCount: 2),
                    itemCount: _rooms.length,
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    primary: false,
                    itemBuilder: (BuildContext context, int i) {
                      List<String> photo = List.from(_rooms[i].images);
                      List<String> service = List.from(_rooms[i].amenities);
                      String description = _rooms[i].description;
                      String title = _rooms[i].name.toString();
                      String type = _rooms[i].name.toString();
                      num rating = num.parse(_rooms[i].rating.toString());
                      String location = _rooms[i].address.toString();
                      String image = _rooms[i].images.first.toString();
                      String id = _rooms[i].sId.toString();
                      num price =_rooms[i].price;
                      num latLang1 = num.parse(_rooms[i].latitude.toString());
                      num latLang2 = num.parse(_rooms[i].longitude.toString());

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new hotelDetail2(
                                      userId: widget.userID,
                                      titleD: title,
                                      idD: id,
                                      imageD: image,
                                      latLang1D: latLang1,
                                      latLang2D: latLang2,
                                      locationD: location,
                                      priceD: price,
                                      descriptionD: description,
                                      photoD: photo,
                                      ratingD: rating,
                                      serviceD: service,
                                      typeD: type,
                                    ),
                                transitionDuration: Duration(milliseconds: 600),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: child,
                                  );
                                }));
                          },
                          child: Container(
                            height: 1000.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF656565).withOpacity(0.15),
                                    blurRadius: 4.0,
                                    spreadRadius: 1.0,
                                    //           offset: Offset(4.0, 10.0)
                                  )
                                ]),
                            child: Wrap(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Hero(
                                      tag: 'hero-tag_room-${id}',
                                      child: Material(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.8,
                                          width: 200.0,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(7.0),
                                                  topRight:
                                                      Radius.circular(7.0)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      AppStrings.imagePAth +
                                                          image),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 5.0)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                        width: 130.0,
                                        child: Text(
                                          title,
                                          style: TextStyle(
                                              letterSpacing: 0.5,
                                              color: Colors.black54,
                                              fontFamily: "Sans",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 2.0)),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 0.0),
                                          child: Text(
                                            "\$${price.toString()}",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: "Gotik",
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Text(
                                          "/night",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: "Gotik",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.0),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 15.0, top: 5.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              ratingbar(
                                                starRating: double.parse(
                                                    rating.toString()),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Text(
                                                  rating.toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Sans",
                                                      color: Colors.black26,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Container(
                    height: 190.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                  )
          ],
        ),
      ),
    );
  }

  Widget shimmerView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 43.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  spreadRadius: 1.0,
                  blurRadius: 3.0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Color(0xFF09314F),
                    size: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Find what you want",
                        style: TextStyle(
                            color: Colors.black26,
                            fontFamily: "Gotik",
                            fontWeight: FontWeight.w300,
                            fontSize: 15.0)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Featured",
            style: TextStyle(
                fontSize: 15.5,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: 'Gotik'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200.0,
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //     boxShadow: [
            //       BoxShadow(
            //           color: Colors.black12.withOpacity(0.1),
            //           blurRadius: 3.0,
            //           spreadRadius: 1.0)
            //     ]),
            child: Shimmer.fromColors(
              baseColor: Colors.black38,
              highlightColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 125.0,
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
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 10.0),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 100.0,
                                    height: 25.0,
                                    color: Colors.black12,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 5.0)),
                                  Container(
                                    height: 15.0,
                                    width: 80.0,
                                    color: Colors.black12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.9),
                                    child: Container(
                                      height: 12.0,
                                      width: 50.0,
                                      color: Colors.black12,
                                    ),
                                  )
                                ],
                              ))
                        ]),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 125.0,
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
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 10.0),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 100.0,
                                    height: 25.0,
                                    color: Colors.black12,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 5.0)),
                                  Container(
                                    height: 15.0,
                                    width: 80.0,
                                    color: Colors.black12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.9),
                                    child: Container(
                                      height: 12.0,
                                      width: 50.0,
                                      color: Colors.black12,
                                    ),
                                  )
                                ],
                              ))
                        ]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Recommended",
            style: TextStyle(
                fontSize: 15.5,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: 'Gotik'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
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
                    ],
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class FeaturedCard extends StatelessWidget {
  String dataUser;
  final List<HotelData> featured;

  FeaturedCard({
    this.dataUser,
    this.featured,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount:
            featured != null && featured.length > 0 ? featured.length : 0,
        itemBuilder: (context, i) {
          List<String> photo = featured[i].images;
          List<String> service = featured[i].amenities;
          String description = featured[i].description;
          String title = featured[i].name.toString();
          String type = featured[i].name.toString();
          num rating = featured[i].rating;
          String location = featured[i].address;
          String image = featured[i].images[0];
          String id = featured[i].sId.toString();
          num price = featured[i].price;
          var latLang1 = featured[i].latitude;
          var latLang2 = featured[i].longitude;

          return Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new hotelDetail2(
                          userId: dataUser,
                          titleD: title,
                          idD: id,
                          imageD: image,
                          latLang1D: num.parse(latLang1),
                          latLang2D: num.parse(latLang2),
                          locationD: location,
                          priceD: price,
                          descriptionD: description,
                          photoD: photo,
                          ratingD: rating.toDouble(),
                          serviceD: service,
                          typeD: type,
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                      )
                    ]),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Hero(
                          tag: 'hero-tag-${id}',
                          child: Material(
                            child: Container(
                              height: 120.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(7.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          AppStrings.imagePAth + image),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            width: 110.0,
                            child: Text(
                              title,
                              style: TextStyle(
                                  letterSpacing: 0.5,
                                  color: Colors.black54,
                                  fontFamily: "Sans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 2.0)),
                        /*   Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 0.0),
                              child: Text(
                                "\$ " + price.toString(),
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.0),
                              ),
                            ),
                            Text(
                              "/night",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Gotik",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0),
                            ),
                          ],
                        ),*/
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 15.0, top: 3.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: double.parse(rating.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      rating.toString(),
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          color: Colors.black26,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class CardRecommended extends StatelessWidget {
  @override
  String dataUser;
  final List<HotelData> list;
  GestureTapCallback navigatorOntap;

  CardRecommended({
    this.dataUser,
    this.list,
  });

  Widget build(BuildContext context) {
    // if (list[i].data['title']) {}
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          String title = list[i].name.toString();
          String image = list[i].images.first;
          String textImage = list[i].images.first.toString();
          String desc = list[i].description.toString();
          String key = list[i].sId.toString();
          return Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 12.0, top: 8.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new RecommendedDetail(
                              keyID: key,
                              title: title,
                              categoryId: dataUser,
                            )));
                  },
                  child: Container(
                    width: 285.0,
                    height: 135.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(AppStrings.imagePAth + image),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF656565).withOpacity(0.15),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                          )
                        ]),
                    /*child: Center(
                     child: Text(
                       textImage,
                       style: TextStyle(
                           fontFamily: 'Amira',
                           color: Colors.white,
                           fontSize: 40.0,
                           letterSpacing: 2.0,
                           shadows: [
                             Shadow(
                               color: Colors.black12.withOpacity(0.1),
                               blurRadius: 2.0,
                             )
                           ]),
                     ),
                   )*/
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: "Sans",
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                  child: Container(
                      width: 270.0,
                      child: Text(
                        desc,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: "Sans",
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black26,
                        ),
                      )),
                ),
              ],
            ),
          );
        });
  }
}

class CardDestinationPopuler extends StatelessWidget {
  String img, txt;

  CardDestinationPopuler({this.img, this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400.0,
        width: 140.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 4.0,
                  spreadRadius: 1.0)
            ]),
        child: Center(
          child: Text(
            txt,
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
  }
}


