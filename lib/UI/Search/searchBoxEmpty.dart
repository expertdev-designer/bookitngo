import 'package:flutter/material.dart';

import 'SearchTagResult.dart';

class searchBoxEmpty extends StatefulWidget {
  String idUser;

  searchBoxEmpty({Key key, this.idUser}) : super(key: key);

  _searchBoxEmptyState createState() => _searchBoxEmptyState();
}

class _searchBoxEmptyState extends State<searchBoxEmpty>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 145.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Text(
              "Tag Keywords",
              style: TextStyle(
                  fontFamily: "Gotik",
                  color: Colors.black87,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20.0)),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "Anaheim",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Anaheim",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54, fontFamily: "Sans"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "beaches",
                                type: "vacations",
                                userID: widget.idUser,
                              )));
                    },
                    child: Container(
                      height: 29.5,
                      width: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Beaches",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 9.0,
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "mountains",
                                type: "vacations",
                                userID: widget.idUser,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Mountains",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54, fontFamily: "Sans"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "sun",
                                type: "vacations",
                                userID: widget.idUser,
                              )));
                    },
                    child: Container(
                      height: 29.5,
                      width: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Sun",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 9.0,
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "Los Angeles",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Los Angeles",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54, fontFamily: "Sans"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "Florida",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Container(
                      height: 29.5,
                      width: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Florida",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 9.0,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "Tropical",
                                  type: "vacations",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Tropical",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54, fontFamily: "Sans"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "San Francisco",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Container(
                      height: 29.5,
                      width: 106.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "San Francisco",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 9.0,
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "Las Vegas",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Las Vegas",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54, fontFamily: "Sans"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "New York",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Container(
                      height: 29.5,
                      width: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "New York",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 9.0,
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "Park",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Park",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54, fontFamily: "Sans"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "Museum",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Container(
                      height: 29.5,
                      width: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Museum",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 9.0,
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "Hotel",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Hotel",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54, fontFamily: "Sans"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SearchTagResult(
                                data: "Experience",
                                type: "location",
                                userID: widget.idUser,
                              )));
                    },
                    child: Container(
                      height: 29.5,
                      width: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Experience",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 9.0,
              ),
            ],
          )),

        ],
      ),
    );
  }
}

class cardCountry extends StatelessWidget {
  Color colorTop, colorBottom;
  String image, title;

  cardCountry({this.colorTop, this.colorBottom, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
      child: Container(
        height: 200.0,
        width: 130.0,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
              colors: [colorTop, colorBottom],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Sofia", fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    image,
                    height: 90,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
