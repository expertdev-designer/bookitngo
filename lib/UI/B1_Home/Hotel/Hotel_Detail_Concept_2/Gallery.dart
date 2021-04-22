import 'package:flutter/material.dart';

class gallery extends StatefulWidget {
  List<String> image;
  gallery({this.image});

  @override
  _galleryState createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: PageView(
          controller: PageController(
            initialPage: 0,
          ),
          scrollDirection: Axis.horizontal,

          ///Enable physics property to provide your PageView with a
          ///custom scroll behaviour
          ///Here BouncingScrollPhysics will pull back the boundary
          ///item (first or last) if the user tries to scroll further.
          //physics: BouncingScrollPhysics(),
          pageSnapping: true,
          children: widget.image
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(item), fit: BoxFit.cover),
                    ),
                  ),
                ),
              )
              .toList()),
      // children: <Widget>[
      //   Padding(
      //     padding: const EdgeInsets.only(
      //         top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
      //     child: Container(
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage("assets/image/gallery1.png"),
      //             fit: BoxFit.cover),
      //       ),
      //     ),
      //   ),
      //   Padding(
      //     padding: const EdgeInsets.only(
      //         top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
      //     child: Container(
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage("assets/image/gallery2.png"),
      //             fit: BoxFit.cover),
      //       ),
      //     ),
      //   ),
      //   Padding(
      //     padding: const EdgeInsets.only(
      //         top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
      //     child: Container(
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage("assets/image/gallery3.png"),
      //             fit: BoxFit.cover),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
