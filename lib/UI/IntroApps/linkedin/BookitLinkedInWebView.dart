import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_linkedin/data_model/auth_error_response.dart';
import 'package:flutter_linkedin/data_model/auth_success_response.dart';
import 'package:flutter_linkedin/helpers/authorization_helper.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BootitLinkedInWebView extends StatefulWidget {
  final String clientId, clientSecret, redirectUri;
  final bool destroySession;
  final PreferredSizeWidget appBar;

  BootitLinkedInWebView(
      {@required this.clientId,
      @required this.clientSecret,
      @required this.redirectUri,
      this.destroySession = true,
      this.appBar});

  @override
  _LinkedInWebViewState createState() => _LinkedInWebViewState();
}

class _LinkedInWebViewState extends State<BootitLinkedInWebView> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  @override
  void initState() {
    _onUrlChanged = _flutterWebviewPlugin.onUrlChanged.listen((url) {
      if (url.startsWith(widget.redirectUri)) {
        Uri uri = Uri.parse(url);
        if (uri.queryParameters.containsKey('code')) {
          Navigator.pop(context,
              AuthorizationSuccessResponse.fromJson(uri.queryParameters));
        } else if (uri.queryParameters.containsKey('error')) {
          Navigator.pop(context,
              AuthorizationErrorResponse.fromJson(uri.queryParameters));
        } else {
          Navigator.pop(context);
        }
      }
    });
    print(getAuthorizationUrl(
        clientId: widget.clientId,
        clientSecret: widget.clientSecret,
        redirectUri: widget.redirectUri));
    super.initState();
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    print(widget.destroySession);
    return WebviewScaffold(
      url: getAuthorizationUrl(
        clientId: widget.clientId,
        clientSecret: widget.clientSecret,
        redirectUri: widget.redirectUri,
      ),
      appBar: widget.appBar,
      clearCookies: widget.destroySession,
      scrollBar: true,
      hidden: true,
    );
  }
}