import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {
  Article itemArticle;
  MediaQueryData mediaQuery;
  WebPage({@required this.itemArticle, @required this.mediaQuery});
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onchanged;
  @override
  void initState() {
    super.initState();
    _onchanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if (state.type == WebViewState.finishLoad) {
          // if the full website page loaded
          print("loaded...");
        } else if (state.type == WebViewState.abortLoad) {
          // if there is a problem with loading the url
          print("there is a problem...");
        } else if (state.type == WebViewState.startLoad) {
          // if the url started loading
          print("start loading...");
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose(); // disposing the webview widget
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: WebviewScaffold(
        url: widget.itemArticle.url == null
            ? 'https://www.incrediblelab.com/wp-content/uploads/2015/06/2015-05-13_21581000.jpg'
            : widget.itemArticle.url,
        withJavascript: true, // run javascript
        withZoom: true, // if you want the user zoom-in and zoom-out
        hidden:
            true, // put it true if you want to show CircularProgressIndicator while waiting for the page to load

        appBar: AppBar(
          title: Text(
            widget.itemArticle.source.name,
            style: TextStyle(
              fontFamily: "Helvetica",
              color: Color(0xFF34234d),
            ),
          ),
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFF34234d),
              ),
              onPressed: () => Navigator.pop(context)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25))),
          backgroundColor: Color(0xFFB8BEDD),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh, color: Color(0xFF34234d)),
              onPressed: () {
                flutterWebviewPlugin.reload();
                // flutterWebviewPlugin.reloadUrl(); // if you want to reloade another url
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Color(0xFF34234d)),
              onPressed: () {
                flutterWebviewPlugin.goBack(); // for going back
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF34234d)),
              onPressed: () {
                flutterWebviewPlugin.goForward(); // for going forward
              },
            ),
          ],
        ),
      ),
    );
  }
}
