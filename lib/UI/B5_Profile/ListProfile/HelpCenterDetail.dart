import 'package:book_it/UI/B5_Profile/ListProfile/HelpCenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HelpCenterDetail extends StatefulWidget {

   String heading;
   String detail;

   HelpCenterDetail({this.heading, this.detail});

  @override
  _HelpCenterDetailState createState() => _HelpCenterDetailState();
}

class _HelpCenterDetailState extends State<HelpCenterDetail> {




  @override

  void initState() {
    super.initState();
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
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/image/images/doc.svg",width: MediaQuery.of(context).size.width/22,height: MediaQuery.of(context).size.height/22,),
                    SizedBox(width: 10,),
                    Expanded(child: Text(widget.heading,style: TextStyle(fontSize: MediaQuery.of(context).size.width/20),)),
                  ],
                ),
                SizedBox(height: 20,),
                Text("${widget.detail}",style: TextStyle(fontSize: MediaQuery.of(context).size.width/32,wordSpacing: 2.0,height: 1.5),)
              ],
            ),
          ),
        ),
    );
  }
}
