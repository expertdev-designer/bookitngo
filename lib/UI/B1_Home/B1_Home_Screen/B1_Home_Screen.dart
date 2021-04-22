import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/Destination/Anaheim.dart';
import 'package:book_it/UI/B1_Home/Destination/Florida.dart';
import 'package:book_it/UI/B1_Home/Destination/LasVegas.dart';
import 'package:book_it/UI/B1_Home/Destination/LosAngels.dart';
import 'package:book_it/UI/B1_Home/Destination/NewYork.dart';
import 'package:book_it/UI/B1_Home/Destination/SanFrancisco.dart';
import 'package:book_it/UI/B1_Home/Recommendation/RecommendationDetailScreen.dart';
import 'package:book_it/UI/B1_Home/Vocation/Mountains.dart';
import 'package:book_it/UI/B1_Home/Vocation/Sun.dart';
import 'package:book_it/UI/B1_Home/Vocation/Tropical.dart';
import 'package:book_it/UI/B1_Home/Vocation/beaches.dart';
import 'package:book_it/UI/Search/search.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/HomeBloc.dart';
import 'editProfile.dart';

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
  @override
  void initState() {
    _homeBloc = HomeBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    getLocalStorage();
    super.initState();
  }


  void getHomeData(String username) {
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

    var _recomendedbookitngo = Container(
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
            child: Container(
              height: 250.0,
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection("recommendedCard")
                    .snapshots(),
                builder:
                    (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return new Container(
                      height: 260.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                    );
                  }
                  return snapshot.hasData
                      ? new cardSuggeted(
                          dataUser: widget.userID,
                          list: snapshot.data.documents,
                        )
                      : Container(
                          height: 10.0,
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );

    var _destinationPopuler = Container(
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
            child:  ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Anaheim(
                              title: 'Anaheim',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'Anaheim',
                    img:
                        'https://images.pexels.com/photos/374870/pexels-photo-374870.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new LosAngeles(
                              title: 'Los Angeles',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'Los Angeles',
                    img:
                        'https://images.pexels.com/photos/373912/pexels-photo-373912.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Florida(
                              title: 'Florida',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'Florida',
                    img:
                        'https://images.pexels.com/photos/3643461/pexels-photo-3643461.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new SanFrancisco(
                              title: 'San Francisco',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'San Francisco',
                    img:
                        'https://images.pexels.com/photos/208745/pexels-photo-208745.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new LasVegas(
                              title: 'Las Vegas',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'Las Vegas',
                    img:
                        'https://images.pexels.com/photos/2837909/pexels-photo-2837909.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new NewYork(
                              title: 'New York',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'New York',
                    img:
                        'https://images.pexels.com/photos/2190283/pexels-photo-2190283.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var _vacations = Container(
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
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Beaches(
                              title: 'Beaches',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'Beaches',
                    img:
                        'https://images.pexels.com/photos/1174732/pexels-photo-1174732.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Mountains(
                              title: 'Mountains',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'Mountains',
                    img:
                        'https://images.pexels.com/photos/2574643/pexels-photo-2574643.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Sun(
                              title: 'Sun',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'Sun',
                    img:
                        'https://images.pexels.com/photos/3768/sky-sunny-clouds-cloudy.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Tropical(
                              title: 'Tropical',
                              userId: widget.userID,
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
                  child: cardDestinationPopuler(
                    txt: 'Tropical',
                    img:
                        'https://images.pexels.com/photos/1033729/pexels-photo-1033729.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    ///  Grid item in bottom of Category
    var _recommendedRooms = SingleChildScrollView(
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
            StreamBuilder(
              stream: Firestore.instance
                  .collection("hotel")
                  .where('type', isEqualTo: 'recommended')
                  .snapshots(),
              builder:
                  (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                String dataUser;
                List<DocumentSnapshot> list = snapshot.data.documents;
                double mediaQueryData;
                return snapshot.hasData
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.2),
                  highlightColor: Colors.grey[100],
                  enabled: _enabled,
                      child: new GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.795, crossAxisCount: 2),
                          itemCount: snapshot.data.documents.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          primary: false,
                          itemBuilder: (BuildContext context, int i) {
                            List<String> photo = List.from(list[i].data['photo']);
                            List<String> service =
                                List.from(list[i].data['service']);
                            List<String> description =
                                List.from(list[i].data['description']);
                            String title = list[i].data['title'].toString();
                            String type = list[i].data['type'].toString();
                            num rating = list[i].data['rating'];
                            String location = list[i].data['location'].toString();
                            String image = list[i].data['image'].toString();
                            String id = list[i].data['id'].toString();
                            num price = list[i].data['price'];
                            num latLang1 = list[i].data['latLang1'];
                            num latLang2 = list[i].data['latLang2'];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          new hotelDetail2(
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
                                },
                                child: Container(
                                  height: 1000.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color(0xFF656565).withOpacity(0.15),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          //           offset: Offset(4.0, 10.0)
                                        )
                                      ]),
                                  child: Wrap(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Hero(
                                            tag: 'hero-tag-${id}',
                                            child: Material(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5.8,
                                                width: 200.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    7.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    7.0)),
                                                    image: DecorationImage(
                                                        image:
                                                            NetworkImage(image),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(top: 5.0)),
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
                                          Padding(
                                              padding: EdgeInsets.only(top: 2.0)),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 0.0),
                                                child: Text(
                                                  price.toString(),
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
                                                left: 10.0,
                                                right: 15.0,
                                                top: 5.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    ratingbar(
                                                      starRating: rating,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                          }),
                    )
                    : Container(
                        height: 10.0,
                      );
              },
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _searchBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, top: 10.0),
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
                              child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection("hotel")
                                    .where('type', isEqualTo: 'popular')
                                    .snapshots(),
                                builder: (BuildContext ctx,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                      ? new cardLastActivity(
                                    dataUser: widget.userID,
                                    list: snapshot.data.documents,
                                  )
                                      : Container(
                                    height: 10.0,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      _recomendedbookitngo,
                      _destinationPopuler,
                      _vacations,
                      _recommendedRooms
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cardLastActivity extends StatelessWidget {
  String dataUser;
  final List<DocumentSnapshot> list;

  cardLastActivity({
    this.dataUser,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          List<String> photo = List.from(list[i].data['photo']);
          List<String> service = List.from(list[i].data['service']);
          List<String> description = List.from(list[i].data['description']);
          String title = list[i].data['title'].toString();
          String type = list[i].data['type'].toString();
          num rating = list[i].data['rating'];
          String location = list[i].data['location'].toString();
          String image = list[i].data['image'].toString();
          String id = list[i].data['id'].toString();
          num price = list[i].data['price'];
          num latLang1 = list[i].data['latLang1'];
          num latLang2 = list[i].data['latLang2'];

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
                                      image: NetworkImage(image),
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
                                    starRating: rating,
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

class cardSuggeted extends StatelessWidget {
  @override
  String dataUser;
  final List<DocumentSnapshot> list;
  GestureTapCallback navigatorOntap;

  cardSuggeted({
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
          String title = list[i].data['title'].toString();
          String image = list[i].data['image'].toString();
          String textImage = list[i].data['textImage'].toString();
          String desc = list[i].data['desc'].toString();
          String key = list[i].data['key'].toString();
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
                              userId: dataUser,
                            )));
                  },
                  child: Container(
                    width: 285.0,
                    height: 135.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
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

class cardDestinationPopuler extends StatelessWidget {
  String img, txt;

  cardDestinationPopuler({this.img, this.txt});

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
                  blurRadius: 2.0,
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

/// ItemGrid in bottom item "Recomended" item
class ItemGrid extends StatelessWidget {
  String dataUser;
  List<DocumentSnapshot> list;

  ItemGrid({
    this.dataUser,
    this.list,
  });

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          List<String> photo = List.from(list[i].data['photo']);
          List<String> service = List.from(list[i].data['service']);
          List<String> description = List.from(list[i].data['description']);
          String title = list[i].data['title'].toString();
          String type = list[i].data['type'].toString();
          num rating = list[i].data['rating'];
          String location = list[i].data['location'].toString();
          String image = list[i].data['image'].toString();
          String id = list[i].data['id'].toString();
          num price = list[i].data['price'];
          num latLang1 = list[i].data['latLang1'];
          num latLang2 = list[i].data['latLang2'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new hotelDetail2(
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Hero(
                          tag: 'hero-tag-${id}',
                          child: Material(
                            child: Container(
                              height: mediaQueryData.size.height / 5.8,
                              width: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(7.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
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
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 0.0),
                              child: Text(
                                price.toString(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: rating,
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
