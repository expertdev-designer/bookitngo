import 'package:book_it/UI/IntroApps/login_bloc/CategoryBloc.dart';
import 'package:book_it/UI/IntroApps/model/CategoriesResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:book_it/UI/Utills/WebAppStrings.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WebCategorySelectionPage extends StatefulWidget {
  var token;
  var isFrom;

  WebCategorySelectionPage({this.token, this.isFrom});

  @override
  _WebCategorySelectionPageState createState() =>
      _WebCategorySelectionPageState();
}

class _WebCategorySelectionPageState extends State<WebCategorySelectionPage> {
  bool isSkip = true;
  bool isForgotSelected = false;
  bool isContinue = false;

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
    _categoryBloc.getCategory(context: context, token: widget.token);
  }

  void saveCategoryList() {
    _categoryBloc.saveCategory(
        context: context, categories: ids, isFrom: widget.isFrom);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              _headerWidget(height, width),
              Container(
                width: width,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xFF6774E7),
                  Color(0xFF7D55B6),
                ], tileMode: TileMode.mirror)),
                child: Text(
                  WebAppStrings.choose_destination,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.5),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<CategoriesResponse>(
                  initialData: null,
                  stream: _categoryBloc.categoryDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data.data != null &&
                        snapshot.data.data.length > 0) {
                      return Expanded(
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: width > 650 ? 4 : 2,
                                    crossAxisSpacing: 25,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.8),
                            padding: EdgeInsets.only(
                                left: width * 0.18,
                                right: width * 0.18,
                                bottom: 100),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (BuildContext context, int index) {
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
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage("${AppStrings.imagePAth+snapshot
                                                    .data.data[index].image}"),
                                                fit: BoxFit.cover)),
                                        child: Center(
                                            child: Text(
                                          '${snapshot
                                              .data.data[index].name}',
                                          style: TextStyle(
                                              fontSize: 26,
                                              // fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: "Amira",
                                              letterSpacing: 1.5),
                                        )),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          snapshot.data.data[index].isSelect,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            gradient: LinearGradient(colors: [
                                              Color(0xFF6774E7)
                                                  .withOpacity(0.7),
                                              Color(0xFF7D55B6)
                                                  .withOpacity(0.7),
                                            ], tileMode: TileMode.mirror)),
                                        child: Center(
                                            child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
          _footerWidget(height, width),
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

  _headerWidget(height, width) {
    return Container(
      width: width,
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.all(
                  //   10,
                  // ),
                  padding: EdgeInsets.only(left: width * 0.1),
                  height: 50,
                  child: Image.asset("assets/image/logo/fullLogo.png"),
                )
              ],
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.only(right: 24, left: 24, top: 12, bottom: 12),
            // shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //         width: 1.5,
            //         color: isSkip ? Colors.black : Colors.white),
            //     borderRadius: BorderRadius.circular(4)),
            splashColor: Colors.black12,
            onPressed: () {
              if (!isSkip) {
                isSkip = true;
                isContinue = false;
              }
              /*else {
                isSkip = true;
              }*/
              setState(() {});
            },
            child: Text(
              WebAppStrings.skip,
              style: TextStyle(
                  fontSize: isSkip && !isContinue ? 16.0 : 14,
                  fontWeight:
                      isSkip && !isContinue ? FontWeight.w500 : FontWeight.w500,
                  color: isSkip && !isContinue
                      ? Colors.black87
                      : Colors.black87.withOpacity(0.7),
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: 1,
          ),
          MaterialButton(
            padding: EdgeInsets.only(right: 24, left: 24, top: 12, bottom: 12),
            // shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //         width: 1.5,
            //         color: isSkip ? Colors.white : Colors.black),
            //     borderRadius: BorderRadius.circular(4)),
            splashColor: Colors.black12,
            onPressed: () {
              // if (isSkip) {
              //
              //   isSkip = false;
              // } else {
              //   isSkip = true;
              // }
              if (!isContinue) {
                isContinue = true;
                isSkip = false;
              }
              setState(() {});
            },
            child: Text(
              WebAppStrings.continue_text,
              style: TextStyle(
                  fontSize: isContinue && !isSkip ? 16.0 : 14,
                  fontWeight:
                      isContinue && !isSkip ? FontWeight.w500 : FontWeight.w500,
                  color: isContinue && !isSkip
                      ? Colors.black87
                      : Colors.black87.withOpacity(0.7),
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: width * 0.1,
          )
        ],
      ),
    );
  }

  _footerWidget(height, width) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: width,
        // height: 80,
        padding: EdgeInsets.symmetric(vertical: 14),
        color: Color(0xFF000000),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      WebAppStrings.about_us,
                      style: TextStyle(
                          fontFamily: "Gotik",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFFFF),
                          letterSpacing: 1.5),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Flexible(
                    child: Text(
                      WebAppStrings.contact_us,
                      style: TextStyle(
                          fontFamily: "Gotik",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFFFF),
                          letterSpacing: 1.5),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Flexible(
                    child: Text(
                      WebAppStrings.privacy_Policy,
                      style: TextStyle(
                          fontFamily: "Gotik",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFFFF),
                          letterSpacing: 1.5),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Flexible(
                    child: Text(
                      WebAppStrings.term_Conditions,
                      style: TextStyle(
                          fontFamily: "Gotik",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFFFF),
                          letterSpacing: 1.5),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                WebAppStrings.copy_right,
                style: TextStyle(
                    fontFamily: "Gotik",
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
