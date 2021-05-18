import 'package:book_it/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:book_it/UI/Search/model/SearchResponse.dart';
import 'package:book_it/UI/Search/search.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bloc/SearchBloc.dart';

class SearchTagResult extends StatefulWidget {
  String userID, type, data;

  SearchTagResult({this.userID, this.data, this.type});

  @override
  _SearchTagResultState createState() => _SearchTagResultState();
}

class _SearchTagResultState extends State<SearchTagResult> {
  SearchBloc searchBloc;

  @override
  void initState() {
    searchBloc = SearchBloc();
    getSearchResultsFromServer();
    super.initState();
  }

  void getSearchResultsFromServer() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        searchBloc.doSearchHotelsApiCall(
            context: context, searchText: widget.data);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Search Tag Result",
          style: TextStyle(fontFamily: "Sofia"),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: StreamBuilder<SearchResponse>(
                    stream: searchBloc.searchTagDataStream,
                    builder: (BuildContext ctx, snapshot) {
                      if (!snapshot.hasData) {
                        return new Container(
                          height: 190.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "  https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc"))),
                        );
                      }
                      return snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data.data != null &&
                              snapshot.data.data.length > 0
                          ? new cardList(
                              dataUser: widget.userID,
                              list: snapshot.data.data,
                            )
                          : noItem();
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          StreamBuilder<bool>(
            stream: searchBloc.progressStream,
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

class cardList extends StatelessWidget {
  String dataUser;
  final List<SearchData> list;

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
          List<String> photo = List.from(list[i].images);
          List<String> service = List.from(list[i].amenities);
          String description = list[i].description;
          String title = list[i].name.toString();
          String type = list[i].name.toString();
          num rating = list[i].rating;
          String location = list[i].address.toString();
          String image = list[i].images.first.toString();
          String id = list[i].sId.toString();
          num price = list[i].price;
          num latLang1 = num.parse(list[i].latitude.toString());
          num latLang2 = num.parse(list[i].longitude.toString());

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
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 1.0,
                        spreadRadius: 1.0)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Row(
                    children: <Widget>[
                      Hero(
                        tag: 'hero-tag-${id}',
                        child: Material(
                          child: Container(
                            height: 180.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      AppStrings.imagePAth + image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 174.0,
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 150.0,
                                  child: Text(
                                    "\$ " + price.toString() + "/Night",
                                    style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontSize: 16.0,
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.pin_drop,
                                  size: 16.0,
                                  color: Colors.black38,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 150.0,
                                  child: Text(
                                    location,
                                    style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 17.0,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Text(
                                    rating.toString(),
                                    style: TextStyle(
                                      fontFamily: "Sans",
                                      fontSize: 15.0,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
