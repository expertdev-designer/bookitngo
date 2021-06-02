import 'package:book_it/UI/Utills/WebAppStrings.dart';
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
      body: Column(
        children: [
          _headerWidget(),
          Expanded(
            child: Container(),
          ),
          _footerWidget(height, width)


        ],
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

  Widget _headerWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(
                    10,
                  ),
                  height: 80,
                  child: Image.asset("assets/image/logo/fullLogo.png"),
                )
              ],
            ),
          ),
          Text(
            WebAppStrings.sign_in,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 1.5),
          ),
          Text(
            WebAppStrings.sign_in,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 1.5),
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
}
