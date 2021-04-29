import 'package:book_it/UI/Utills/AppStrings.dart';
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
          pageSnapping: true,
          children: widget.image
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(AppStrings.imagePAth + item),
                          fit: BoxFit.cover),
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
