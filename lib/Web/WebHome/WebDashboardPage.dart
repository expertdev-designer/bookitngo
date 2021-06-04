import 'package:book_it/UI/Utills/WebAppStrings.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WebDashBoardPage extends StatefulWidget {
  @override
  _WebDashBoardPageState createState() => _WebDashBoardPageState();
}

class _WebDashBoardPageState extends State<WebDashBoardPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            menuBar(width),
            _searchView(height, width),
            _footerWidget(height, width)
          ],
        ),
      ),
    )
        /*Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 23.0,
            flexibleSpace:  FlexibleSpaceBar(
              title: _headerWidget(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 80,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    )*/
        ;
  }

  Widget menuBar(width) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  height: 80,
                  child: Image.asset("assets/image/logo/fullLogo.png"),
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              WebAppStrings.home,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              WebAppStrings.message,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              WebAppStrings.reservations,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              WebAppStrings.settings,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  _footerWidget(height, width) {
    return Container(
      width: width,
      height: 200,
      margin: EdgeInsets.only(top: 50),
      color: Color(0xFF000000),
      child: Center(
        child: Text(
          WebAppStrings.copy_right,
          style: TextStyle(
              fontFamily: "Gotik",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF474747),
              letterSpacing: 1.5),
        ),
      ),
    );
  }

  _searchView(height, width) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
            image:
                AssetImage("assets/image/destinationPopuler/destination1.png"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Container(
          color: Colors.black.withOpacity(0.1),
          margin: EdgeInsets.symmetric(horizontal: width*0.25),
          child: Container(
            margin: EdgeInsets.all(6),
            color: Colors.white,
            height: 50,


          ),
        ),
      ),
    );
  }
}
