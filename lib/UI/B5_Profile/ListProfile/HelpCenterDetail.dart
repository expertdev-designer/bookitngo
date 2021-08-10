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
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.,",style: TextStyle(fontSize: MediaQuery.of(context).size.width/32,wordSpacing: 2.0,height: 1.5),)
              ],
            ),
          ),
        ),
    );
  }
}
