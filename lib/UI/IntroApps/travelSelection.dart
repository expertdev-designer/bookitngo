import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:book_it/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:book_it/UI/Bottom_Nav_Bar/bottomNavBar.dart';

import 'login_bloc/CategoryBloc.dart';
import 'model/CategoriesResponse.dart';

class mainSelection extends StatefulWidget {
  String userID;

  mainSelection({this.userID});

  @override
  _mainSelectionState createState() => _mainSelectionState();
}

class _mainSelectionState extends State<mainSelection> {
  @override

  ///
  ///
  /// Bool to set true or false color button
  ///
  ///
  bool button1 = true;
  bool button2 = true;
  bool button3 = true;
  bool button4 = true;
  bool button5 = true;
  bool button6 = true;

  CategoryBloc _categoryBloc;
  AppConstantHelper _appConstantHelper;

  List<String> ids;

  @override
  void initState() {
    _categoryBloc = CategoryBloc();
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    getCategoryList();
    ids = [];
    super.initState();
  }

  void getCategoryList() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _categoryBloc.getCategory(context: context);
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

  void saveCategoryList() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _categoryBloc.saveCategory(context: context, categories: ids);
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                FadeAnimation(
                  0.1,
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Choose your Desired Destination",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sofia",
                      ),
                    ),
                  ),
                ),
                StreamBuilder<CategoriesResponse>(
                    initialData: null,
                    stream: _categoryBloc.categoryDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data.data != null &&
                          snapshot.data.data.length > 0) {
                        return GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          childAspectRatio: 1.6,
                          crossAxisSpacing: 10,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          physics: NeverScrollableScrollPhysics(),
                          children:
                              List.generate(snapshot.data.data.length, (index) {
                            return InkWell(
                              onTap: () {
                                if (snapshot.data.data[index].isSelect) {
                                  snapshot.data.data[index].isSelect = false;
                                  ids.remove(snapshot.data.data[index].sId);
                                } else {
                                  snapshot.data.data[index].isSelect = true;
                                  ids.add(snapshot.data.data[index].sId);
                                }

                                setState(() {});
                                ids.forEach((element) {
                                  print("Element${element}");
                                });
                              },
                              child: FadeAnimation(
                                0.9,
                                !snapshot.data.data[index].isSelect
                                    ? itemCard(
                                        image:
                                            "${AppStrings.imagePAth + snapshot.data.data[index].image}",
                                        title:
                                            "${snapshot.data.data[index].name}",
                                      )
                                    : itemCardSelected(
                                        image:
                                            "${AppStrings.imagePAth + snapshot.data.data[index].image}",
                                        title:
                                            "${snapshot.data.data[index].name}",
                                        sizeFont: 25.0,
                                      ),
                              ),
                            );
                          }),
                        );
                      } else {
                        return Container();
                      }
                    }),
                // SizedBox(
                //   height: 50.0,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     InkWell(
                //         onTap: () {
                //           setState(() {
                //             if (button1 == true) {
                //               button1 = false;
                //             } else {
                //               button1 = true;
                //             }
                //           });
                //         },
                //         child: FadeAnimation(
                //           0.9,
                //           button1
                //               ? itemCard(
                //                   image:
                //                       "assets/image/destinationPopuler/destination1.png",
                //                   title: "Museum",
                //                 )
                //               : itemCardSelected(
                //                   image:
                //                       "assets/image/destinationPopuler/destination1.png",
                //                   title: "Museum",
                //                   sizeFont: 25.0,
                //                 ),
                //         )),
                //     InkWell(
                //         onTap: () {
                //           setState(() {
                //             if (button2 == true) {
                //               button2 = false;
                //             } else {
                //               button2 = true;
                //             }
                //           });
                //         },
                //         child: FadeAnimation(
                //           1.7,
                //           button2
                //               ? itemCard(
                //                   image:
                //                       "assets/image/destinationPopuler/destination5.jpg",
                //                   title: "Park",
                //                 )
                //               : itemCardSelected(
                //                   image:
                //                       "assets/image/destinationPopuler/destination5.jpg",
                //                   title: "Park",
                //                   sizeFont: 25.0,
                //                 ),
                //         )),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     InkWell(
                //         onTap: () {
                //           setState(() {
                //             if (button3 == true) {
                //               button3 = false;
                //             } else {
                //               button3 = true;
                //             }
                //           });
                //         },
                //         child: FadeAnimation(
                //           2.4,
                //           button3
                //               ? itemCard(
                //                   image:
                //                       "assets/image/destinationPopuler/populer2.png",
                //                   title: "Beach",
                //                 )
                //               : itemCardSelected(
                //                   image:
                //                       "assets/image/destinationPopuler/populer2.png",
                //                   title: "Beach",
                //                   sizeFont: 22.0,
                //                 ),
                //         )),
                //     InkWell(
                //         onTap: () {
                //           setState(() {
                //             if (button4 == true) {
                //               button4 = false;
                //             } else {
                //               button4 = true;
                //             }
                //           });
                //         },
                //         child: FadeAnimation(
                //           3.2,
                //           button4
                //               ? itemCard(
                //                   image:
                //                       "assets/image/destinationPopuler/destination4.jpg",
                //                   title: "Mountain",
                //                 )
                //               : itemCardSelected(
                //                   image:
                //                       "assets/image/destinationPopuler/destination4.jpg",
                //                   title: "Mountain",
                //                   sizeFont: 25.0,
                //                 ),
                //         )),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     InkWell(
                //         onTap: () {
                //           setState(() {
                //             if (button5 == true) {
                //               button5 = false;
                //             } else {
                //               button5 = true;
                //             }
                //           });
                //         },
                //         child: FadeAnimation(
                //           4.0,
                //           button5
                //               ? itemCard(
                //                   image: "assets/image/homeImage/hotel.png",
                //                   title: "Hotel",
                //                 )
                //               : itemCardSelected(
                //                   image: "assets/image/homeImage/hotel.png",
                //                   title: "Hotel",
                //                   sizeFont: 25.0,
                //                 ),
                //         )),
                //     InkWell(
                //         onTap: () {
                //           setState(() {
                //             if (button6 == true) {
                //               button6 = false;
                //             } else {
                //               button6 = true;
                //             }
                //           });
                //         },
                //         child: FadeAnimation(
                //           4.8,
                //           button6
                //               ? itemCard(
                //                   image:
                //                       "assets/image/homeImage/experience.png",
                //                   title: "Experience",
                //                 )
                //               : itemCardSelected(
                //                   image:
                //                       "assets/image/homeImage/experience.png",
                //                   title: "Experience",
                //                   sizeFont: 25.0,
                //                 ),
                //         )),
                //   ],
                // ),
                SizedBox(
                  height: 70.0,
                ),

                FadeAnimation(
                    5.5,
                    ids != null && ids.length > 0
                        ? InkWell(
                      onTap: () {
                        saveCategoryList();
                      },
                      child: Container(
                        height: 55.0,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 0.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color(0xFF647DEE),
                              Color(0xFF7F53AC)
                            ])),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w500,
                                fontSize: 19.5,
                                letterSpacing: 1.2),
                          ),
                        ),
                      ),
                    )
                        : Container(
                            height: 55.0,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19.5,
                                    letterSpacing: 1.2),
                              ),
                            ),
                          )),
                SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
          StreamBuilder<bool>(
            stream: _categoryBloc.progressStream,
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

///
/// Create item card
///
class itemCard extends StatelessWidget {
  String image, title;

  itemCard({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
      child: Container(
        height: 85.0,
        width: 165.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFABABAB).withOpacity(0.7),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.black12.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 10.0,
                          spreadRadius: 2.0)
                    ],
                    color: Colors.white,
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
/// Create item card
///
class itemCardSelected extends StatelessWidget {
  String image, title;
  double sizeFont;

  itemCardSelected({this.image, this.title, this.sizeFont});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
      child: Container(
        height: 85.0,
        width: 165.0,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF647DEE), Color(0xFF7F53AC)]),
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFABABAB).withOpacity(0.7),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                gradient: LinearGradient(colors: [
                  Color(0xFF647DEE).withOpacity(0.5),
                  Color(0xFF7F53AC).withOpacity(0.5),
                ]),
              ),
              child: Center(
                child: Text(
                  "Selected",
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 10.0,
                          spreadRadius: 2.0)
                    ],
                    color: Colors.white,
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
