// import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/BookItNow.dart';
// import 'package:carousel_pro/carousel_pro.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// class RoomDetail extends StatefulWidget {
//   String imageD,
//       titleD,
//       locationD,
//       idD,
//       typeD,
//       userId,
//       nameD,
//       photoProfileD,
//       emailD,
//       titleR,
//       informationR,
//       roomR,
//       idR,
//       descriptionD;
//
//   // DocumentSnapshot listItem;
//   List<String> photoD, serviceD, imageR;
//   num ratingD, priceD, latLang1D, latLang2D, priceR;
//
//   RoomDetail({
//     this.imageD,
//     this.titleD,
//     this.priceD,
//     this.locationD,
//     // this.listItem,
//     this.idD,
//     this.photoD,
//     this.serviceD,
//     this.descriptionD,
//     this.userId,
//     this.typeD,
//     this.emailD,
//     this.nameD,
//     this.photoProfileD,
//     this.latLang1D,
//     this.latLang2D,
//     this.ratingD,
//     this.idR,
//     this.imageR,
//     this.informationR,
//     this.priceR,
//     this.roomR,
//     this.titleR,
//   });
//
//   @override
//   _RoomDetailState createState() => _RoomDetailState();
// }
//
// class _RoomDetailState extends State<RoomDetail> {
//   @override
//   Widget build(BuildContext context) {
//     String _nama, _photoProfile, _email;
//
//
//
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         centerTitle: true,
//         title: Text(
//           widget.titleD,
//           style: TextStyle(
//             fontFamily: "Sofia",
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 300.0,
//               child: Material(
//                 child: new Carousel(
//                   dotColor: Colors.black26,
//                   dotIncreaseSize: 1.7,
//                   dotBgColor: Colors.transparent,
//                   autoplay: false,
//                   boxFit: BoxFit.cover,
//                   images: [
//                     NetworkImage(widget.imageR[0]),
//                     NetworkImage(widget.imageR[1]),
//                     NetworkImage(widget.imageR[2]),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15.0, left: 15.0),
//               child: Text(
//                 widget.roomR,
//                 style: TextStyle(
//                     fontFamily: "Sofia",
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700),
//               ),
//             ),
//
//             Padding(
//               padding:
//                   const EdgeInsets.only(top: 5.0, left: 15.0, bottom: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Icon(
//                     Icons.star,
//                     size: 18.0,
//                     color: Colors.yellow,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 3.0, left: 15.0),
//                     child: Text(
//                       widget.ratingD.toString(),
//                       style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black45,
//                           fontFamily: "Sofia",
//                           fontSize: 19.0),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 35.0,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 0.0, left: 20.0),
//               child: Text(
//                 "Location :",
//                 style: TextStyle(
//                     fontFamily: "Sofia",
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700),
//                 textAlign: TextAlign.justify,
//               ),
//             ),
//             Padding(
//               padding:
//               const EdgeInsets.only(top: 5.0, left: 20.0, bottom: 20.0),
//               child: Text(
//                 widget.locationD,
//                 style: TextStyle(
//                     fontFamily: "Sofia", color: Colors.black54, fontSize: 18.0),
//               ),
//             ),
//             Container(
//               height: 0.5,
//               width: double.infinity,
//               color: Colors.black12.withOpacity(0.2),
//             ),
//            /* Padding(
//               padding: const EdgeInsets.only(top: 20.0, left: 20.0),
//               child: Text(
//                 "Information :",
//                 style: TextStyle(
//                     fontFamily: "Sofia",
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700),
//                 textAlign: TextAlign.justify,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 5.0, left: 20.0),
//               child: Text(
//                 widget.informationR,
//                 style: TextStyle(
//                     fontFamily: "Sofia", color: Colors.black54, fontSize: 18.0),
//               ),
//             ),*/
//            /* Padding(
//               padding: const EdgeInsets.only(top: 20.0, left: 20.0),
//               child: Text(
//                 "Location :",
//                 style: TextStyle(
//                     fontFamily: "Sofia",
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700),
//                 textAlign: TextAlign.justify,
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.only(top: 5.0, left: 20.0, bottom: 20.0),
//               child: Text(
//                 widget.locationD,
//                 style: TextStyle(
//                     fontFamily: "Sofia", color: Colors.black54, fontSize: 18.0),
//               ),
//             ),*/
//             // Padding(
//             //   padding: const EdgeInsets.only(
//             //       top: 0.0, left: 20.0, right: 20.0, bottom: 10.0),
//             //   child: Text(
//             //     "Amenities :",
//             //     style: TextStyle(
//             //         fontFamily: "Sofia",
//             //         fontSize: 20.0,
//             //         fontWeight: FontWeight.w700),
//             //     textAlign: TextAlign.justify,
//             //   ),
//             // ),
//
//             // Padding(
//             //   padding: const EdgeInsets.only(
//             //       top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
//             //   child: Column(
//             //       mainAxisAlignment: MainAxisAlignment.start,
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       children: widget.serviceD
//             //           .map((item) => Padding(
//             //                 padding: const EdgeInsets.only(
//             //                     top: 10.0, left: 10.0, bottom: 10.0),
//             //                 child: Row(
//             //                   mainAxisAlignment: MainAxisAlignment.start,
//             //                   crossAxisAlignment: CrossAxisAlignment.start,
//             //                   children: [
//             //                     Text(
//             //                       "-   ",
//             //                       style: TextStyle(
//             //                           color: Colors.black, fontSize: 24.0),
//             //                     ),
//             //                     Container(
//             //                       width:
//             //                           MediaQuery.of(context).size.width / 1.3,
//             //                       child: new Text(
//             //                         item,
//             //                         style: TextStyle(
//             //                             fontFamily: "Sofia",
//             //                             color: Colors.black54,
//             //                             fontSize: 18.0),
//             //                         overflow: TextOverflow.clip,
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               ))
//             //           .toList()),
//             // ),
//
//             Container(
//               height: 0.5,
//               width: double.infinity,
//               color: Colors.black12.withOpacity(0.2),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Price",
//                     style: TextStyle(
//                         fontFamily: "Sofia",
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     "\$" + widget.priceR.toString(),
//                     style: TextStyle(
//                         fontFamily: "Sofia",
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),
//             ),
//
//             /// Button
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 15.0, right: 15.0, bottom: 10.0, top: 20.0),
//               child: InkWell(
//                 onTap: () async {
//                   Navigator.of(context).push(PageRouteBuilder(
//                       pageBuilder: (_, __, ___) => new Bookitnow(
//                             userId: widget.userId,
//                             titleD: widget.titleD,
//                             idD: widget.idD,
//                             imageD: widget.imageD,
//                             latLang1D: widget.latLang1D,
//                             latLang2D: widget.latLang2D,
//                             locationD: widget.locationD,
//                             priceD: widget.priceD,
//                             descriptionD: widget.descriptionD,
//                             photoD: widget.photoD,
//                             ratingD: widget.ratingD,
//                             // listItem: widget.listItem,
//                             serviceD: widget.serviceD,
//                             typeD: widget.typeD,
//                             emailD: _email,
//                             nameD: _nama,
//                             photoProfileD: _photoProfile,
//                             idR: widget.idR,
//                             imageR: widget.imageR,
//                             informationR: widget.informationR,
//                             priceR: widget.priceR,
//                             roomR: widget.roomR,
//                           )));
//                 },
//                 child: Container(
//                   height: 55.0,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                       gradient: LinearGradient(
//                           colors: [
//                             const Color(0xFF09314F),
//                             Color(0xFF09314F),
//                           ],
//                           begin: const FractionalOffset(0.0, 0.0),
//                           end: const FractionalOffset(1.0, 0.0),
//                           stops: [0.0, 1.0],
//                           tileMode: TileMode.clamp)),
//                   child: Center(
//                     child: Text(
//                       "Reserve Now",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 19.0,
//                           fontFamily: "Sofia",
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
