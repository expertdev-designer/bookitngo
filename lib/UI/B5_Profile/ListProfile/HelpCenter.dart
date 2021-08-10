import 'package:book_it/UI/B5_Profile/bloc/CallCenterBloc.dart';
import 'package:book_it/UI/B5_Profile/bloc/HelpCenterBloc.dart';
import 'package:book_it/UI/B5_Profile/model/HelpCenterResponse.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
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

  HelpCenterBloc _helpCenterBloc;

  @override
  void initState() {
    super.initState();

    _helpCenterBloc = HelpCenterBloc();
    _tabController = TabController(length: 5, vsync: this);
    print(travellingSub.length);

    fetchHelpCenterData();
  }

  fetchHelpCenterData() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _helpCenterBloc.callHelpCenterApi();
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
      body: Stack(
        children: [
          StreamBuilder<List<HelpData>>(
              stream: _helpCenterBloc.helpDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data.length > 0) {
                  return Column(
                    children: [
                      searchBarViewWidget(),
                      tabBarWidget(snapshot.data),
                      tabBarViewWidget(context, snapshot.data),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
          StreamBuilder<bool>(
            stream: _helpCenterBloc.progressStream,
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

  tabBarWidget(List<HelpData> helpDataList) {
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
                ),
                Tab(
                  child: Text('Review',
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

  tabBarViewWidget(BuildContext tabbarcontext, List<HelpData> helpDataList) {
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: TabBarView(
            controller: _tabController,
            children: helpDataList
                .map((helpDataList) =>
                    tabBarDataWidget(context: context, helpData: helpDataList))
                .toList(),
          )),
    );
  }

  Widget tabBarDataWidget({BuildContext context, HelpData helpData}) {
    return helpData.questions != null && helpData.questions.length > 0
        ? questionsWidget(helpData.questions)
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount:
                helpData.subCategory != null && helpData.subCategory.length > 0
                    ? helpData.subCategory.length
                    : 0,
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
                title: Text(helpData.subCategory[index].name),
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                        questionsWidget(helpData.subCategory[index].questions),
                  ),
                ],
              );
            });
  }

  questionsWidget(List<Questions> questions) {
    return Container(
      padding: const EdgeInsets.only(top: 3),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpCenterDetail(
                      heading: questions[index].question,
                      detail: questions[index].answer,
                    ),
                  ),
                );
              },
              leading: SvgPicture.asset("assets/image/images/doc.svg",
                  width: 30, height: 30),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: Text(questions[index].question),
              ),
            );
          }),
    );
  }
}
