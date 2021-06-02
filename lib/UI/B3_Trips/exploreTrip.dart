import 'dart:math';

import 'package:book_it/UI/B1_Home/Destination/populardestination.dart';
import 'package:book_it/UI/B3_Trips/bloc/DiscoverNewPlacesBloc.dart';
import 'package:book_it/UI/B3_Trips/model/DiscoverNewPlacesResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_it/DataSample/HotelListData.dart';
import 'package:book_it/DataSample/travelModelData.dart';
import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/Destination/destinationDetail.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetailPage.dart';

class exploreTrip extends StatefulWidget {
  String userId;

  exploreTrip({this.userId});

  @override
  _exploreTripState createState() => _exploreTripState();
}

class _exploreTripState extends State<exploreTrip> {
  DiscoverNewPlacesBloc discoverNewPlacesBloc;

  AppConstantHelper appConstantHelper;

  @override
  void initState() {
    discoverNewPlacesBloc = DiscoverNewPlacesBloc();
    appConstantHelper = AppConstantHelper();
    appConstantHelper.setContext(context);
    getNewPlaces();
    super.initState();
  }

  void getNewPlaces() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        discoverNewPlacesBloc.getDiscoverNewPlace(context: context);
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
    Future getCarouselWidget() async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore.collection("banner").getDocuments();
      return qn.documents;
    }

    var _sliderImage = Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 190,
          aspectRatio: 24 / 24,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [0, 1, 2, 3].map((i) {
          return FutureBuilder(
              future: getCarouselWidget(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return new Container(
                    height: 190.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                " dehttps://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"),
                            fit: BoxFit.cover)),
                  );
                }

                // List<String> ingredients =
                //     List.from(snapshot.data[i].data['ingredients']);
                // List<String> directions =
                //     List.from(snapshot.data[i].data['directions']);
                // String title = snapshot.data[i].data['title'].toString();
                // num rating = snapshot.data[i].data['rating'];
                // String category = snapshot.data[i].data['category'].toString();
                // String image = snapshot.data[i].data['image'].toString();
                // String id = snapshot.data[i].data['id'].toString();
                // String time = snapshot.data[i].data['time'].toString();
                // String calorie = snapshot.data[i].data['calorie'].toString();
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 9.0,
                              spreadRadius: 7.0,
                              color: Colors.black12.withOpacity(0.03))
                        ],
                        image: DecorationImage(
                            image: NetworkImage(
                                snapshot.data[i].data["imageBanner"]),
                            fit: BoxFit.cover),
                        color: Color(0xFF23252E)),
                  ),
                );
              });
        }).toList(),
      ),
    );

    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: _height,
              child: ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      //      _sliderImage,
                      Container(
                        height: 292.0,
                        child: new Carousel(
                          boxFit: BoxFit.cover,
                          dotColor: Colors.white.withOpacity(0.8),
                          dotSize: 5.5,
                          dotSpacing: 16.0,
                          dotBgColor: Colors.transparent,
                          showIndicator: true,
                          overlayShadow: true,
                          overlayShadowColors: Colors.white.withOpacity(0.9),
                          overlayShadowSize: 0.9,
                          images: [0, 1, 2, 3].map((i) {
                            return FutureBuilder(
                                future: getCarouselWidget(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return new Container(
                                      height: 190.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "jkghttps://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"),
                                              fit: BoxFit.cover)),
                                    );
                                  }
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
                                              color: Colors.black12
                                                  .withOpacity(0.03))
                                        ],
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data[i].data["imageBanner"]),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  );
                                });
                          }).toList(),
                        ),
                      ),
                      Container(
                        height: 292.0,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, left: 15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 45.0,
                            width: 45.0,
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Discover New Places",
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    height: 320.0,
                    child: StreamBuilder<DiscoverNewPlacesResponse>(
                      initialData: null,
                      stream: discoverNewPlacesBloc.discoverNewPlacesDataStream,
                      builder: (BuildContext ctx, snapshot) {
                        if (!snapshot.hasData) {
                          return new Container(
                            height: 190.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "hjgkjhhttps://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                          );
                        }
                        return snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data.data != null &&
                                snapshot.data.data.newPlaces != null &&
                                snapshot.data.data.newPlaces.length > 0
                            ? new card(
                                dataUser: widget.userId,
                                list: snapshot.data.data.newPlaces,
                              )
                            : Container(
                                height: 10.0,
                              );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Top Destination",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          // Text(
                          //   "See all",
                          //   style: TextStyle(
                          //       fontFamily: "Sofia",
                          //       fontSize: 16.0,
                          //       fontWeight: FontWeight.w300),
                          // ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: StreamBuilder<DiscoverNewPlacesResponse>(
                        initialData: null,
                        stream:
                            discoverNewPlacesBloc.discoverNewPlacesDataStream,
                        builder: (BuildContext ctx, snapshot) {
                          if (!snapshot.hasData) {
                            return new Container(
                              height: 190.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "hjdghttps://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                            );
                          }
                          return snapshot.hasData &&
                                  snapshot.data != null &&
                                  snapshot.data.data != null &&
                                  snapshot.data.data.topDestinations != null &&
                                  snapshot.data.data.topDestinations.length > 0
                              ? Container(
                                  height: 140.0,
                                  padding: EdgeInsets.only(left: 0),
                                  child: ListView.builder(
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.data
                                                .topDestinations.length >
                                            0
                                        ? snapshot
                                            .data.data.topDestinations.length
                                        : 0,
                                    itemBuilder: (BuildContext context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      new PopularDestination(
                                                        title:
                                                            '${snapshot.data.data.topDestinations[index].name}',
                                                        userId: snapshot
                                                            .data
                                                            .data
                                                            .topDestinations[
                                                                index]
                                                            .sId,
                                                        destinations: snapshot
                                                                .data
                                                                .data
                                                                .topDestinations[
                                                            index],
                                                      ),
                                                  transitionDuration: Duration(
                                                      milliseconds: 600),
                                                  transitionsBuilder: (_,
                                                      Animation<double>
                                                          animation,
                                                      __,
                                                      Widget child) {
                                                    return Opacity(
                                                      opacity: animation.value,
                                                      child: child,
                                                    );
                                                  }));
                                        },
                                        child: cardCountry(
                                          colorBottom: Color(
                                              Random().nextInt(0xffffffff)),
                                          colorTop: Colors.primaries[Random()
                                              .nextInt(
                                                  Colors.primaries.length)],
                                          image:
                                              "assets/image/icon/amerika.png",
                                          title:
                                              "${snapshot.data.data.topDestinations[index].name}",
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  height: 190.0,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                                );
                        }),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Text(
                      "Recommended",
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: StreamBuilder<DiscoverNewPlacesResponse>(
                      initialData: null,
                      stream: discoverNewPlacesBloc.discoverNewPlacesDataStream,
                      builder: (BuildContext ctx, snapshot) {
                        if (!snapshot.hasData) {
                          return new Container(
                            height: 190.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "hjfghhttps://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                          );
                        }
                        return snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data.data != null &&
                                snapshot.data.data.recommended != null &&
                                snapshot.data.data.recommended.length > 0
                            ? new recommendedCardList(
                                dataUser: widget.userId,
                                list: snapshot.data.data.recommended,
                              )
                            : Container(
                                height: 190.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "ytuyghttps://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                              );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
          StreamBuilder<bool>(
            stream: discoverNewPlacesBloc.progressStream,
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
}

class recommendedCardList extends StatelessWidget {
  String dataUser;
  final List<NewPlacesAndRecommended> list;

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

  recommendedCardList({
    this.dataUser,
    this.list,
  });

  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
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
          String image = list[i].images.first;
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
                    tag: 'hero-tag-recommended${id}',
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
                                  Text(
                                    "(" + rating.toString() + ")",
                                    style: _txtStyleSub,
                                  )
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

class card extends StatelessWidget {
  String dataUser;
  final List<NewPlacesAndRecommended> list;

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
          String image = list[i].images.first;
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
                    tag: 'hero-tag-${id}',
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
                Container(
                  width: 160.0,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        color: Colors.black87),
                  ),
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
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: Colors.black26),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 18.0,
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        rating.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sofia",
                            fontSize: 13.0),
                      ),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    Container(
                      height: 27.0,
                      width: 82.0,
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
                  // begin: Alignment.topLeft,
                  // end: Alignment.bottomRight),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
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
