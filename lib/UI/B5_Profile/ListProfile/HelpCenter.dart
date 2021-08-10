import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'ExpansionTileWidget.dart';
import 'HelpCenterDetail.dart';

class helpCenter extends StatefulWidget {
  @override
  _helpCenterState createState() => _helpCenterState();
}

class _helpCenterState extends State<helpCenter>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<String> gettingStartedSub = ["How it Works"];

  List<String> travellingSub = ["How to Travel", "How to Host"];

  List<String> gettingStarted = [
    "How to Create an account",
    "What are the requirement to book on Bookit N Go",
    "How do I submit reservation request",
    "Who can host on Bookit N Go?"
  ];
  List<String> accountProfile = [
    "Accessing the account profile",
    "Owner account profile - Basic (free)",
    " Owner account profile - Pro (paid)",
    "Admin account profile",
    "Member account profile",
  ];
  List<String> hosting = [
    "What happens if my guest cancels?",
    "How do I refund my guest?",
    "How do I cancel a reservation as a host of a place to stay?",
    "As a host, what penalties apply if I cancel a reservation for a stay?",
    "When you’ll get your payout",
  ];
  List<String> travelling = [
    " Searching and booking",
    "Search tips",
    "Booking places to stay",
    "  Booking Airbnb Experiences",
    " Booking business travel and events",
    " Booking Airbnb.org stays",
    "Messaging",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    print(travellingSub.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Help Center",
          style: TextStyle(fontFamily: "Sofia"),
        ),
      ),
      body: Column(
        children: [
          searchBarViewWidget(),
          tabBarWidget(),
          tabBarViewWidget(context),
        ],
      ),
    );
  }

  searchBarViewWidget() {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/images/help_image.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text("Welcome! How can we help?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontFamily: "Sofia",
                    color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0, color: Colors.black12.withOpacity(0.1)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            alignment: Alignment.center,
            child: TextField(
                decoration: InputDecoration(
              hintText:
                  'Search for anything(booking a place,getting paid,reviews)',
              hintStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 39,
                color: Colors.grey,
                fontFamily: "Sofia",
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.black),
            )),
          ),
        ],
      ),
    );
  }

  tabBarWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: Text(
            "Suggested Helps List",
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Sofia",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              isScrollable: true,
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('Getting Started',
                      style: TextStyle(
                        fontFamily: 'Sofia',
                        fontSize: MediaQuery.of(context).size.width / 32,
                      )),
                ),
                Tab(
                  child: Text('Account & Profile',
                      style: TextStyle(
                        fontFamily: 'Sofia',
                        fontSize: MediaQuery.of(context).size.width / 32,
                      )),
                ),
                Tab(
                  child: Text('Hosting',
                      style: TextStyle(
                        fontFamily: 'Sofia',
                        fontSize: MediaQuery.of(context).size.width / 32,
                      )),
                ),
                Tab(
                  child: Text('Travelling',
                      style: TextStyle(
                        fontFamily: 'Sofia',
                        fontSize: MediaQuery.of(context).size.width / 32,
                      )),
                )
              ]),
        ),
      ],
    );
  }

  tabBarViewWidget(BuildContext tabbarcontext) {
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: TabBarView(controller: _tabController, children: [
            tabBarDataWidget(context, gettingStarted, gettingStartedSub,
                gettingStartedSub.length),
            tabBarDataWidget(context, accountProfile, gettingStartedSub,
                gettingStartedSub.length),
            tabBarDataWidget(
                context, hosting, gettingStartedSub, gettingStartedSub.length),
            tabBarDataWidget(
                context, travelling, travellingSub, travellingSub.length),
          ])),
    );
  }

  Widget tabBarDataWidget(
      BuildContext context, var gettingStarted, var heading, int length) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTileWidget(
              // key: cardA,
              shadowColor: Colors.white,
              elevation: 0.0,
              initialElevation: 0.0,
              expandedTextColor: Colors.black,
              leading: CircleAvatar(
                  child: Icon(
                Icons.circle,
                size: 10,
              )),
              title: Text(heading[0]),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: gettingStartedTabBarWidget(gettingStarted),
                ),
              ],
            );
          }),
    );
  }

  gettingStartedTabBarWidget(var data) {
    return Container(
      padding: const EdgeInsets.only(top: 3),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpCenterDetail(
                      heading: data[index].toString(),
                    ),
                  ),
                );
              },
              leading: SvgPicture.asset("assets/image/images/doc.svg",
                  width: 30, height: 30),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: Text(data[index]),
              ),
            );
          }),
    );
  }
}
