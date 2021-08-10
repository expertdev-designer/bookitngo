import 'dart:async';
import 'package:book_it/UI/Search/model/SearchResponse.dart';
import 'package:book_it/UI/Search/searchBoxEmpty.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:book_it/network_helper/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
  TextEditingController searchController,
      checkOutDateController,
      checkINDateController,
      guestController;

  DateTime selectCheckOutDate = DateTime.now();
  DateTime selectCheckInDate = DateTime.now();
  String searchString;
  bool load = true;
  SearchBloc searchBloc;
  List<String> searchSuggestion = [];
  bool guestMaintainSize = false;
  bool guestMaintainAnimation = false;
  bool guestMaintainState = false;
  bool guestVisible = false;
  bool isSuggestionVisible = false;
  num totalAdultCount = 0;
  num totalChildCount = 0;

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
    getSearchTag();
    // LocalStorage.getListData(LocalStorage.getTag).then((value) {
    //   searchSuggestion = value;
    //   print("searchSuggestion${searchSuggestion.length}");
    // });
  }

  void incAdultCounter() {
    setState(() {
      totalAdultCount++;
    });
  }

  void incChildCounter() {
    setState(() {
      totalChildCount++;
    });
  }

  void decAdultCounter() {
    setState(() {
      if (totalAdultCount != 1) totalAdultCount--;
      // totalAdultCount--;
    });
  }

  void decChildCounter() {
    setState(() {
      if (totalChildCount != 0) totalChildCount--;
      // totalChildCount--;
    });
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

  Future<Null> selectCheckINDateFunc(BuildContext context) async {
    print("date**********");
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectCheckInDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        selectCheckInDate = picked;
        print("${selectCheckInDate.toLocal()}");
        checkINDateController = TextEditingController(
            text: DateFormat('dd-MM-yyyy').format(selectCheckOutDate));
      });
  }

  Future<Null> selectCheckOutDateFunc(BuildContext context) async {
    print("date**********");
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectCheckOutDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        selectCheckOutDate = picked;
        print("${selectCheckOutDate.toLocal()}");
        checkOutDateController = TextEditingController(
            text: DateFormat('dd-MM-yyyy').format(selectCheckOutDate));
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
        child: Padding(
          padding: const EdgeInsets.only(
              top: 25.0, left: 20.0, right: 20.0, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What would you like to search ?",
                style: TextStyle(
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w600,
                    fontSize: 27.0,
                    color: Colors.black54,
                    fontFamily: "Sofia"),
              ),
              Container(
                child: Form(
                  //key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //seach bar
                      SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.black12.withOpacity(0.1)),
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextFormField(
                            enabled: true,
                            style: TextStyle(
                                color: Colors.black87, fontFamily: "Sofia"),
                            controller: searchController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your place to search";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Anywhere',
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Sofia",
                                  height: 1.0),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            )),
                      ),
                      SizedBox(height: 20),
                      //check in
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.black12.withOpacity(0.1)),
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextFormField(
                            onTap: () => selectCheckINDateFunc(context),
                            enabled: true,
                            readOnly: true,
                            style: TextStyle(
                                color: Colors.black87, fontFamily: "Sofia"),
                            controller: checkINDateController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your date of birth";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Check-In',
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Sofia",
                                  height: 1.0),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            )),
                      ),
                      SizedBox(height: 20),
                      //check out
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.black12.withOpacity(0.1)),
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextFormField(
                            onTap: () => selectCheckOutDateFunc(context),
                            enabled: true,
                            readOnly: true,
                            style: TextStyle(
                                color: Colors.black87, fontFamily: "Sofia"),
                            controller: checkOutDateController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your date of birth";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Check-Out',
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Sofia",
                                  height: 1.0),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            )),
                      ),
                      SizedBox(height: 20),
                      //Guest Selection
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.black12.withOpacity(0.1)),
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextFormField(
                            onTap: () {
                              if (guestVisible) {
                                guestVisible = false;
                                guestMaintainSize = false;
                                guestMaintainAnimation = false;
                                guestMaintainState = false;
                                isSuggestionVisible = false;
                              } else {
                                guestVisible = true;
                                guestMaintainSize = true;
                                guestMaintainAnimation = true;
                                guestMaintainState = true;
                                isSuggestionVisible = true;
                              }
                              setState(() {});
                            },
                            enabled: true,
                            readOnly: true,
                            style: TextStyle(
                                color: Colors.black87, fontFamily: "Sofia"),
                            controller: guestController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your date of birth";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              labelText: '1 Guest',
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Sofia",
                                  height: 1.0),
                              suffixIcon: Icon(
                                !guestVisible
                                    ? Icons.keyboard_arrow_down_sharp
                                    : Icons.keyboard_arrow_up_sharp,
                                color: Colors.black,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            )),
                      ),
                      //drop down widget
                      Visibility(
                        maintainSize: guestMaintainSize,
                        maintainAnimation: guestMaintainAnimation,
                        maintainState: guestMaintainState,
                        visible: guestVisible,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 10, right: 20),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10.0,
                                        offset: Offset(0, 6),
                                        color: Colors.black12.withOpacity(0.1)),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Adult",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: "Sofia",
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              //iconSize: 45,
                                              icon: SvgPicture.asset(
                                                'assets/image/icon/minusOutlined.svg',
                                                width: 30,
                                                height: 30,
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  decAdultCounter();
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("$totalAdultCount+"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            IconButton(
                                              //iconSize: 45,
                                              icon: SvgPicture.asset(
                                                'assets/image/icon/plusOutlined.svg',
                                                width: 30,
                                                height: 30,
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                incAdultCounter();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Children",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: "Sofia",
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20)),
                                            SizedBox(height: 5),
                                            Text("Ages 5-12",
                                                style: TextStyle(
                                                    color: Colors.black26,
                                                    fontFamily: "Sofia",
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            30)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: SvgPicture.asset(
                                                'assets/image/icon/minusOutlined.svg',
                                                width: 30,
                                                height: 30,
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                decChildCounter();
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("$totalChildCount+"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            IconButton(
                                              icon: SvgPicture.asset(
                                                'assets/image/icon/plusOutlined.svg',
                                                width: 30,
                                                height: 30,
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                incChildCounter();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          child: Text("Cancel",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontFamily: "Sofia",
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          24)),
                                          onTap: () {
                                            guestVisible = false;
                                            guestMaintainSize = false;
                                            guestMaintainAnimation = false;
                                            guestMaintainState = false;
                                            isSuggestionVisible = false;
                                            guestController =
                                                TextEditingController(text: "");
                                            setState(() {});
                                          },
                                        ),
                                        GestureDetector(
                                          child: Text("Apply",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontFamily: "Sofia",
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          24)),
                                          onTap: () {
                                            guestVisible = false;
                                            guestMaintainSize = false;
                                            guestMaintainAnimation = false;
                                            guestMaintainState = false;
                                            isSuggestionVisible = false;
                                            if (totalAdultCount != 0 &&
                                                totalChildCount == 0) {
                                              guestController =
                                                  TextEditingController(
                                                      text:
                                                          "$totalAdultCount\tAdult");
                                            } else {
                                              guestController =
                                                  TextEditingController(
                                                      text:
                                                          "$totalAdultCount\tAdult ${totalChildCount ?? totalChildCount}\tChild");
                                            }
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 55.0,
                            width: double.infinity,
                            child: Center(
                              child: Text("Search",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.0,
                                      fontFamily: "Sofia")),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF09314F),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(
      //       top: 25.0, right: 20.0, left: 20.0, bottom: 20.0),
      //   child: Container(
      //     height: 50.0,
      //     decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //         boxShadow: [
      //           BoxShadow(
      //               color: Colors.black.withOpacity(0.1),
      //               blurRadius: 15.0,
      //               spreadRadius: 0.0)
      //         ]),
      //     child: Center(
      //       child: Padding(
      //         padding: const EdgeInsets.only(
      //           left: 20.0,
      //           right: 10.0,
      //         ),
      //         child: Theme(
      //           data: ThemeData(hintColor: Colors.transparent),
      //           child: TextFormField(
      //             onChanged: (val) {
      //               // setState(() {
      //               //   if (value.length > 1) {
      //               //     isSuggestionVisible = true;
      //               //   } else {
      //               //     isSuggestionVisible = false;
      //               //   }
      //               //
      //               // });
      //             },
      //             onFieldSubmitted: (val) {
      //               setState(() {
      //                 searchString = val.toLowerCase();
      //                 getSearchResultsFromServer(searchString);
      //                 /*var list = [];
      //                 list.add(val);
      //                 LocalStorage.setListData(LocalStorage.getTag, list);
      //                 isSuggestionVisible = false;*/
      //               });
      //             },
      //             enableSuggestions: true,
      //             textInputAction: TextInputAction.search,
      //             decoration: InputDecoration(
      //                 border: InputBorder.none,
      //                 icon: Icon(
      //                   Icons.search,
      //                   color: Color(0xFF09314F),
      //                   size: 28.0,
      //                 ),
      //                 hintText: "Search",
      //                 hintStyle: TextStyle(
      //                     color: Colors.black38,
      //                     fontFamily: "Sofia",
      //                     fontWeight: FontWeight.w400)),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // Stack(
      //   children: [
      //     StreamBuilder<SearchResponse>(
      //       stream: searchBloc.searchTagDataStream,
      //       builder: (context, snapshot) {
      //         if (snapshot.hasError)
      //           return Text('Error: ${snapshot.error}');
      //         if (searchString == null) {
      //           return StreamBuilder<SearchTagResponse>(
      //               initialData: null,
      //               stream: searchBloc.tagDataStream,
      //               builder: (context, snapshot) {
      //                 if (snapshot.hasData) {
      //                   // tagList = snapshot.data.data;
      //                   // print("tagList ${tagList}");
      //                   return searchBoxEmpty(
      //                     idUser: widget.userId,
      //                     tagList: snapshot.data.data,
      //                   );
      //                 } else
      //                   return Container();
      //               });
      //         }
      //         if (searchString.trim() == "") {
      //           return StreamBuilder<SearchTagResponse>(
      //               initialData: null,
      //               stream: searchBloc.tagDataStream,
      //               builder: (context, snapshot) {
      //                 if (snapshot.hasData) {
      //                   // tagList = snapshot.data.data;
      //                   // print("tagList ${tagList}");
      //                   return searchBoxEmpty(
      //                     idUser: widget.userId,
      //                     tagList: snapshot.data.data,
      //                   );
      //                 } else
      //                   return Container();
      //               });
      //         }
      //         if (isSuggestionVisible) {
      //           return suggestionList();
      //         } else if (snapshot.hasData &&
      //             snapshot.data != null &&
      //             snapshot.data.data != null &&
      //             snapshot.data.data.length > 0) {
      //           return cardList(
      //             dataUser: widget.userId,
      //             list: snapshot.data.data,
      //           );
      //         } else
      //           return noItem();
      //       },
      //     ),
      //     StreamBuilder<bool>(
      //       stream: searchBloc.progressStream,
      //       builder: (context, snapshot) {
      //         return Align(
      //           alignment: Alignment.topCenter,
      //           child: CommmonProgressIndicator(
      //               snapshot.hasData ? snapshot.data : false),
      //         );
      //       },
      //     ),
      //   ],
      //)
      //],
      // ),
      //),
    );
  }

  Widget suggestionList() {
    return ListView.builder(
        itemCount: searchSuggestion != null && searchSuggestion.length > 0
            ? searchSuggestion.length
            : 0,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: Icon(Icons.close),
            title: Text(
              "${searchSuggestion[index]}",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.5,
                  color: Colors.black26.withOpacity(0.3),
                  fontFamily: "Popins"),
            ),
          );
        });
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
