import 'dart:async';

import 'package:book_it/Library/loader_animation/dot.dart';
import 'package:book_it/Library/loader_animation/loader.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetailPage.dart';
import 'package:book_it/UI/Search/model/SearchResponse.dart';
import 'package:book_it/UI/Search/searchBoxEmpty.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'SearchTagResult.dart';
import 'bloc/SearchBloc.dart';
import 'model/SearchTagResponse.dart';

class Search extends StatefulWidget {
  String userId;

  Search({this.userId});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _addNameController;
  String searchString;

  bool load = true;
  SearchBloc searchBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        load = false;
      });
    });
    searchBloc = SearchBloc();
    _addNameController = TextEditingController();
    getSearchTag();
  }

  void getSearchResultsFromServer(String text) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        searchBloc.doSearchHotelsApiCall(context: context, searchText: text);
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

  void getSearchTag() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        searchBloc.getSearchTag(context: context);
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
        iconTheme: IconThemeData(color: Color(0xFF09314F)),
        title: Text(
          "Search",
          style: TextStyle(fontFamily: "Sofia"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 25.0, left: 20.0, right: 50.0),
              child: Text(
                "What would you like to search ?",
                style: TextStyle(
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w600,
                    fontSize: 27.0,
                    color: Colors.black54,
                    fontFamily: "Sofia"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 25.0, right: 20.0, left: 20.0, bottom: 20.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15.0,
                          spreadRadius: 0.0)
                    ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 10.0,
                    ),
                    child: Theme(
                      data: ThemeData(hintColor: Colors.transparent),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            searchString = value.toLowerCase();
                            getSearchResultsFromServer(searchString);
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.search,
                              color: Color(0xFF09314F),
                              size: 28.0,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                StreamBuilder<SearchResponse>(
                  stream: searchBloc.searchTagDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    if (searchString == null) {
                      return StreamBuilder<SearchTagResponse>(
                          initialData: null,
                          stream: searchBloc.tagDataStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // tagList = snapshot.data.data;
                              // print("tagList ${tagList}");
                              return searchBoxEmpty(
                                idUser: widget.userId,
                                tagList: snapshot.data.data,
                              );
                            } else
                              return Container();
                          });
                    }
                    if (searchString.trim() == "") {
                      return StreamBuilder<SearchTagResponse>(
                          initialData: null,
                          stream: searchBloc.tagDataStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // tagList = snapshot.data.data;
                              // print("tagList ${tagList}");
                              return searchBoxEmpty(
                                idUser: widget.userId,
                                tagList: snapshot.data.data,
                              );
                            } else
                              return Container();
                          });
                    }

                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data.data != null &&
                        snapshot.data.data.length > 0) {
                      return cardList(
                        dataUser: widget.userId,
                        list: snapshot.data.data,
                      );
                    } else
                      return noItem();
                  },
                ),
                StreamBuilder<bool>(
                  stream: searchBloc.progressStream,
                  builder: (context, snapshot) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: CommmonProgressIndicator(
                          snapshot.hasData ? snapshot.data : false),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

///
///
/// If no item cart this class showing
///
class noItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 30.0)),
            Image.asset(
              "assets/image/images/search.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              "No matching result found ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.5,
                  color: Colors.black26.withOpacity(0.3),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}
