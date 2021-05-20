import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  var text, url;

  WebView({this.text, this.url});

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String selectedUrl = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text(
          "${widget.text}",
          style: TextStyle(fontFamily: "Sofia"),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: WebviewScaffold(
            displayZoomControls: false,
            scrollBar: true,
            url: widget.url,
            withZoom: false,
            withLocalStorage: false,
            hidden: true,
            initialChild: Container(
              child: Center(
                child: Text(
                  'Loading .....',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff131621),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
