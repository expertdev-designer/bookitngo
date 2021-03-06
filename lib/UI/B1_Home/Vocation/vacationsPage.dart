import 'package:book_it/UI/B1_Home/B1_Home_Screen/bloc/HomeBloc.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HomeResponse.dart';
import 'package:book_it/UI/B1_Home/B1_Home_Screen/model/HotelHotelByCategoryResponse.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetailPage.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:flutter_svg/svg.dart';

class VacationPage extends StatefulWidget {
  String title, categoryId;

  VacationPage({this.title, this.categoryId});

  @override
  _VacationPageState createState() => _VacationPageState();
}

class _VacationPageState extends State<VacationPage> {
  HomeBloc _homeBloc;
  AppConstantHelper _appConstantHelper;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    getHotelByCategoryHotel();
    print("${widget.categoryId}");
    super.initState();
  }

  void getHotelByCategoryHotel() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        if (widget.title == "Featured" ||
            widget.title == "Recommended" ||
            widget.title == "Recommended Rooms")
          {
            _homeBloc.getHotelListingApi(
                context: context, type: widget.categoryId);
          }else
          _homeBloc.getHotelByCategory(
              context: context, categoryId: widget.categoryId);
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

    var _recommended = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.only(left: 22.0),
        //   child: Text(
        //     "Hotels around ${widget.title + "s"} :",
        //     style: TextStyle(
        //         fontFamily: "Sofia",
        //         fontSize: 20.0,
        //         fontWeight: FontWeight.w700),
        //   ),
        // ),
        Image.asset(
            "assets/image/destinationPopuler/vacations_placeholder.svg"),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: StreamBuilder<HotelByCategoryResponse>(
            stream: _homeBloc.hotelByCategoryDataStream,
            builder: (BuildContext ctx, snapshot) {
              // if (!snapshot.hasData) {
              //   return new Container(
              //     padding: EdgeInsets.symmetric(horizontal: 50.0),
              //     height: MediaQuery.of(context).size.height * 0.8,
              //     alignment: Alignment.center,
              //
              //   );
              // }

              return snapshot.hasData && snapshot.data != null
                  ? VacationList(
                      dataUser: widget.categoryId,
                      list: snapshot.data.data,
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 60.0),
                      height: MediaQuery.of(context).size.height * 0.7,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/image/destinationPopuler/vacation.png",
                          ),
                          Text(
                            "No data found",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontSize: 20.0,
                                height: 4.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
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

    return Scaffold(
      appBar: _appBar,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Category
                // _category,

                /// Top Beaches
                /// _topBeaches,
                SizedBox(
                  height: 20.0,
                ),

                /// Recommended
                _recommended,
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
}

class VacationList extends StatelessWidget {
  String dataUser;
  final List<HotelData> list;

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

  VacationList({
    this.dataUser,
    this.list,
  });

  Widget build(BuildContext context) {
    return list != null && list.length > 0
        ? ListView.builder(
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
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                                  image: NetworkImage(
                                      AppStrings.imagePAth + image),
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
                                        starRating:
                                            double.parse(rating.toString()),
                                        color: Colors.blueAccent,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 5.0)),
                                      // Text(
                                      //   "(" + rating.toString() + ")",
                                      //   style: _txtStyleSub,
                                      // )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.9),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 16.0,
                                          color: Colors.black26,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 3.0)),
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
                                  Text("/per night",
                                      style:
                                          _txtStyleSub.copyWith(fontSize: 11.0))
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
            })
        : Container(
            height: MediaQuery.of(context).size.height - 120,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    "assets/image/destinationPopuler/vacations_placeholder.svg"),
                Text(
                  "No data found",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
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
