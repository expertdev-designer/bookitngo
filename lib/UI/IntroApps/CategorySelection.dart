import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:book_it/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:book_it/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_bloc/CategoryBloc.dart';
import 'model/CategoriesResponse.dart';

class CategorySelectionPage extends StatefulWidget {
  String userID, isFrom;

  CategorySelectionPage({this.userID, this.isFrom});

  @override
  _CategorySelectionPageState createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
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
        _categoryBloc.getCategory(context: context, token: widget.userID);
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
        _categoryBloc.saveCategory(
            context: context, categories: ids, isFrom: widget.isFrom);
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
                      // "Choose your Desired Destination",
                      "Choose your preferred location",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sofia",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
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
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 10,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          physics: NeverScrollableScrollPhysics(),
                          children:
                              List.generate(snapshot.data.data.length, (index) {
                            return InkWell(
                              onTap: () {
                                if (snapshot.data.data[index].isSelect) {
                                  snapshot.data.data[index].isSelect = false;
                                  ids.remove(snapshot.data.data[index].id);
                                } else {
                                  snapshot.data.data[index].isSelect = true;
                                  ids.add(
                                      snapshot.data.data[index].id.toString());
                                }
                                setState(() {});
                                ids.forEach((element) {
                                  print("Element${element}");
                                });
                              },
                              child: FadeAnimation(
                                  0.9,
                                  itemCard(
                                      image:
                                          "${snapshot.data.data[index].imageUrl}",
                                      title:
                                          "${snapshot.data.data[index].name}",
                                      isSelected:
                                          snapshot.data.data[index].isSelect)),
                            );
                          }),
                        );
                      } else {
                        return Container();
                      }
                    }),
                SizedBox(
                  height: 70.0,
                ),
                FadeAnimation(
                    4.0,
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
                                  "Continue",
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
                                "Continue",
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
                  height: 60.0,
                ),
                Visibility(
                  visible: widget.isFrom == "Home" ? false : true,
                  child: Center(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => bottomNavBar(
                                userID: AppStrings.authToken,
                              ),
                            ));
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new bottomNavBar(
                                  userID: widget.userID,
                                ),
                            transitionDuration: Duration(milliseconds: 600),
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }));
                      },
                      child: FadeAnimation(
                        6.0,
                        Text(
                          "Skip",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 19.5,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
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
  bool isSelected;

  itemCard({this.image, this.title, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 5.0, right: 5.0, top: 16.0, bottom: 4.0),
          child: Container(
            // height: 95.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Material(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover),
                  border: Border.all(
                      width: isSelected ? 2 : 0,
                      color: isSelected ? Color(0xFF7F53AC) : Colors.white),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Color(0xFFABABAB).withOpacity(0.7),
                  //       blurRadius: 6.0,
                  //       offset: Offset(0, 3)),
                  // ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    color: Colors.black12.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        // shadows: [
                        //   BoxShadow(
                        //       color: Colors.black.withOpacity(0.7),
                        //       blurRadius: 10.0,
                        //       spreadRadius: 2.0)
                        // ],
                        color: Colors.white,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isSelected ? true : false,
          child: Positioned(
              right: 0,
              top: 0,
              child: SvgPicture.asset(
                "assets/image/images/tick_b.svg",
                width: 34,
                height: 34,
              )),
        )
      ],
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
                    blurRadius: 6.0,
                    offset: Offset(0, 3)),
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
