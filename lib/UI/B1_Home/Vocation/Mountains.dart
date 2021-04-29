import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_it/DataSample/travelModelData.dart';
import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';

class Mountains extends StatefulWidget {
  String title, userId;
  Mountains({this.title, this.userId});

  @override
  _MountainsState createState() => _MountainsState();
}

class _MountainsState extends State<Mountains> {
  @override
  Widget build(BuildContext context) {
    var onClickMenuIcon = () {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new Home(),
          transitionDuration: Duration(milliseconds: 750),

          /// Set animation with opacity
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    };

    var _appBar = PreferredSize(
      preferredSize: Size.fromHeight(45.0),
      child: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.title, style: TextStyle(fontFamily: "Sofia")),
      ),
    );

    var _category = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: Text(
            "Category",
            style: TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w700,
                fontSize: 20.0),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 30.0)),

        /// Get class CategoryIconValue
        CategoryIconValue(
          tap1: onClickMenuIcon,
          icon1: "assets/image/icon/confetti.png",
          title1: "Attraction",
          tap2: onClickMenuIcon,
          icon2: "assets/image/icon/tour.png",
          title2: "Tour",
          tap3: onClickMenuIcon,
          icon3: "assets/image/icon/bag.png",
          title3: "Travel",
          tap4: onClickMenuIcon,
          icon4: "assets/image/icon/plant.png",
          title4: "Spa",
        ),
        Padding(padding: EdgeInsets.only(top: 23.0)),
        CategoryIconValue(
          icon1: "assets/image/icon/lamp.png",
          tap1: onClickMenuIcon,
          title1: "Courses",
          icon2: "assets/image/icon/sneaker.png",
          tap2: onClickMenuIcon,
          title2: "Sports",
          icon3: "assets/image/icon/playground.png",
          tap3: onClickMenuIcon,
          title3: "Played",
          icon4: "assets/image/icon/ticket.png",
          tap4: onClickMenuIcon,
          title4: "Cinema",
        ),
        Padding(padding: EdgeInsets.only(top: 43.0)),

        Container(
          height: 30.0,
          width: double.infinity,
          color: Colors.black12.withOpacity(0.03),
        ),
      ],
    );

    var _recommended = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: Text(
            "Hotels around mountains :",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection("hotel")
                .where('vacations', isEqualTo: 'mountains')
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
                      dataUser: widget.userId,
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

    Future getCarouselWidget() async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection("banner")
          .where("location", isEqualTo: "New York")
          .getDocuments();
      return qn.documents;
    }

    return Scaffold(
      appBar: _appBar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Category
            // _category,

            /// Top Mountains
            /// _topMountains,
            SizedBox(
              height: 20.0,
            ),

            /// Recommended
            _recommended,
          ],
        ),
      ),
    );
  }
}

class card extends StatelessWidget {
  String dataUser;
  final List<DocumentSnapshot> list;
  card({this.dataUser, this.list});

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
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
                              descriptionD: null,
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
                                image: NetworkImage(image), fit: BoxFit.cover),
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

class cardList extends StatelessWidget {
  String dataUser;
  final List<DocumentSnapshot> list;

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

  cardList({
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
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                          descriptionD: null,
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
                    tag: 'hero-tag-${id}',
                    child: Material(
                      child: Container(
                        height: 165.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover),
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
                                    starRating: rating,
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

Widget _card(String image, title, location, ratting) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 220.0,
          width: 160.0,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 2.0)
              ]),
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
            Icon(
              Icons.star,
              size: 18.0,
              color: Colors.yellow,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                ratting,
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
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Center(
                child: Text("Discount 15%",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0)),
              ),
            )
          ],
        ),
      ],
    ),
  );
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
