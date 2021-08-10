import 'package:book_it/UI/B1_Home/B1_Home_Screen/bloc/HomeBloc.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HotelByLocationResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetailPage.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:carousel_pro/carousel_pro.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:book_it/DataSample/travelModelData.dart';
import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';

class PopularDestination extends StatefulWidget {
  String title, userId;
  var destinations;

  PopularDestination({this.title, this.userId, this.destinations});

  @override
  _PopularDestinationState createState() => _PopularDestinationState();
}

class _PopularDestinationState extends State<PopularDestination> {
  HomeBloc _homeBloc;
  AppConstantHelper _appConstantHelper;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    getHotelByLocationFromServer();
    super.initState();
  }

  void getHotelByLocationFromServer() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _homeBloc.getHotelByLocationCategory(
            context: context, location: widget.title);
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
        title: Text(widget.title, style: TextStyle(fontFamily: "Sofia")),
      ),
    );

    var _description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Text(
            widget.title,
            style: TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w700,
                fontSize: 20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 30.0),
          child: Container(
              width: MediaQuery.of(context).size.width - 10.0,
              child: Text(
                "${widget.destinations.description}",
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w300,
                    fontSize: 14.5,
                    color: Colors.black45),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.justify,
              )),
        ),
      ],
    );

    return Scaffold(
      appBar: _appBar,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 250.0,
                  child: widget.destinations.images != null &&
                          widget.destinations.images.length > 0
                    ? new Carousel(
                        boxFit: BoxFit.cover,
                        dotColor: Colors.white.withOpacity(0.8),
                        dotSize: 5.5,
                        dotSpacing: 16.0,
                        dotBgColor: Colors.transparent,
                        showIndicator: true,
                        overlayShadow: true,
                        overlayShadowColors: Colors.white.withOpacity(0.9),
                        overlayShadowSize: 0.9,
                        images: widget.destinations.images.map((i) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(0.0, 1.0),
                                  stops: [0.0, 1.0],
                                  colors: <Color>[
                                    Color(0x00FFFFFF),
                                    Color(0xFFFFFFFF),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 9.0,
                                      spreadRadius: 7.0,
                                      color: Colors.black12.withOpacity(0.03))
                                ],
                                image: DecorationImage(
                                    image: NetworkImage(
                                        AppStrings.imagePAth + i),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                      : Container(
                          height: 190.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      " hsd https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"),
                                  fit: BoxFit.cover)),
                        ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                /// Description
                _description,

                /// Category
                // _category,

                /// Top Anaheim
                ///
                _topAnaheim(),

                /// Recommended
                _recommended(),
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
      ),
    );
  }

  Widget _topAnaheim() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30.0),
          child: Text(
            "Top Choices",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          height: 320.0,
          padding: EdgeInsets.only(left: 10),
          child: StreamBuilder<HotelByLocationResponse>(
            initialData: null,
            stream: _homeBloc.hotelByLocationCategoryDataStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Container(
                  height: 190.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              " fadf https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                );
              }
              return snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data.data != null &&
                      snapshot.data.data.top != null &&
                      snapshot.data.data.top.length > 0
                  ? new card(
                      dataUser: widget.userId,
                      list: snapshot.data.data.top,
                    )
                  : Container(
                      child: Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 20.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
            },
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
      ],
    );
  }

  Widget _recommended() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: Text(
            "Hotels in ${widget.title}",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: StreamBuilder<HotelByLocationResponse>(
            initialData: null,
            stream: _homeBloc.hotelByLocationCategoryDataStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Container(
                  height: 190.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "  fe https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                );
              }
              return snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data.data != null &&
                      snapshot.data.data.all != null &&
                      snapshot.data.data.all.length > 0
                  ? new CardList(
                      dataUser: widget.userId,
                      list: snapshot.data.data.all,
                    )
                  : Container(
                      height: 300,
                      child: Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 20.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}

class card extends StatelessWidget {
  String dataUser;
  final List<HotelLocationTopChoicesData> list;

  card({this.dataUser, this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          List<String> photo = List.from(list[i].images);
          List<String> service = List.from(list[i].amenities);
          String description = list[i].description;
          String title = list[i].name.toString();
          String type = list[i].name.toString();
          num rating = num.parse(list[i].rating.toString());
          String location = list[i].address.toString();
          String image = list[i].images.first.toString();
          String id = list[i].sId.toString();
          num price = list[i].price;
          num latLang1 = num.parse(list[i].latitude);
          num latLang2 = num.parse(list[i].longitude);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new HotelDetailPage(
                              userId: dataUser,
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
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: Hero(
                    tag: 'hero-tag-AllChoices-${id}',
                    child: Material(
                      child: Container(
                        height: 220.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(AppStrings.imagePAth + image),
                                fit: BoxFit.cover),
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12.withOpacity(0.1),
                                  spreadRadius: 2.0)
                            ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 18.0,
                      color: Colors.black12,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Colors.black26),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Icon(
                    //   Icons.star,
                    //   size: 18.0,
                    //   color: Colors.yellow,
                    // ),
                    ratingbar(
                      starRating: double.parse(rating.toString()),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 3.0),
                    //   child: Text(
                    //     rating.toString(),
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w700,
                    //         fontFamily: "Sofia",
                    //         fontSize: 13.0),
                    //   ),
                    // ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      height: 27.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Center(
                        child: Text("\$ " + price.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class CardList extends StatelessWidget {
  String dataUser;
  final List<HotelLocationTopChoicesData> list;

  @override
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

  CardList({
    this.dataUser,
    this.list,
  });

  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length > 0 ? list.length : 0,
        itemBuilder: (context, i) {
          List<String> photo = List.from(list[i].images);
          List<String> service = List.from(list[i].amenities);
          String description = list[i].description;
          String title = list[i].name.toString();
          String type = list[i].name.toString();
          num rating = num.parse(list[i].rating.toString());
          String location = list[i].address.toString();
          String image = list[i].images.first.toString();
          String id = list[i].sId.toString();
          num price = list[i].price;
          num latLang1 = num.parse(list[i].latitude);
          num latLang2 = num.parse(list[i].longitude);

          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new HotelDetailPage(
                          userId: dataUser,
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
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }));
              },
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
                child: Column(children: [
                  Hero(
                    tag: 'hero-tag-topChoices-${id}',
                    child: Material(
                      child: Container(
                        height: 165.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(AppStrings.imagePAth + image),
                              fit: BoxFit.cover),
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
                                    title,
                                    style: _txtStyleTitle,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: double.parse(rating.toString()),
                                    color: Colors.blueAccent,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5.0)),
                                  // Text(
                                  //   "(" + rating.toString() + ")",
                                  //   style: _txtStyleSub,
                                  // )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.9),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 16.0,
                                      color: Colors.black26,
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 3.0)),
                                    Text(location, style: _txtStyleSub)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 13.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "\tStarting at ",
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                              ),
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

class cardCountry extends StatelessWidget {
  Color colorTop, colorBottom;
  String image, title;

  cardCountry({this.colorTop, this.colorBottom, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 105.0,
            width: 105.0,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              gradient: LinearGradient(
                  colors: [colorTop, colorBottom],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    image,
                    height: 60,
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Sofia",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

/// Component item Menu icon bellow a Description
class CategoryIconValue extends StatelessWidget {
  String icon1, icon2, icon3, icon4, title1, title2, title3, title4;
  GestureTapCallback tap1, tap2, tap3, tap4;

  CategoryIconValue(
      {this.icon1,
      this.tap1,
      this.icon2,
      this.tap2,
      this.icon3,
      this.tap3,
      this.icon4,
      this.tap4,
      this.title1,
      this.title2,
      this.title3,
      this.title4});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: tap1,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon1,
                height: 30.2,
                fit: BoxFit.cover,
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                title1,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap2,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon2,
                height: 32.2,
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                title2,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap3,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon3,
                height: 32.2,
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                title3,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap4,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon4,
                height: 32.2,
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                title4,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
