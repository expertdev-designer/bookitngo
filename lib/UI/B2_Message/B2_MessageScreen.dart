import 'package:book_it/UI/B2_Message/ChatBot.dart';
import 'package:book_it/UI/Utills/AppStrings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class noMessage extends StatefulWidget {
  String userID;

  noMessage({this.userID});

  @override
  _noMessageState createState() => _noMessageState();
}

class _noMessageState extends State<noMessage> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Chat",
          style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w800,
              fontSize: 29.5,
              wordSpacing: 0.1),
        ),
        actions: <Widget>[],
      ),
      body: Stack(
        children: <Widget>[
          Stack(
            children: [
              Image.asset(
                "assets/image/destinationPopuler/destination1.png",
                height: _height,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 210.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 20.0,
                          color: Colors.black12.withOpacity(0.08))
                    ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Text(
                            "Book It n Go chatbot",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontSize: 21.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            "Our bots will assist you in finding the right solution to your queries.",
                            // "Our bots are very happy to help you through your difficulties if you have any questions, our bots will help you",
                            style: TextStyle(
                                color: Colors.black26,
                                wordSpacing: 2.0,
                                letterSpacing: 2.0,
                                fontFamily: "Sofia"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => chatBot()));
                            // Navigator.of(context).push(PageRouteBuilder(
                            //     pageBuilder: (_, __, ___) => new Chat(
                            //           chatRoomId: widget.userID,
                            //           name: userDocument["name"],
                            //         )));
                          },
                          child: Container(
                            height: 45.0,
                            width: 180.0,
                            color: Color(0xFF09314F),
                            child: Center(
                              child: Text(
                                "Start Chatting",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "Sofia"),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
