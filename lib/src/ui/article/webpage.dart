import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class WebPage extends StatefulWidget {
  Article itemArticle;
  MediaQueryData mediaQuery;
  WebPage({@required this.itemArticle, @required this.mediaQuery});
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
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
        // hidden:
        //     true, // put it true if you want to show CircularProgressIndicator while waiting for the page to load

        appBar: AppBar(
          title: Text(
            widget.itemArticle.source.name,
            style: TextStyle(
              fontFamily: "NoeDisplay",
              color: Color(0xFF000000),
            ),
          ),
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.red,
              ),
              onPressed: () => Navigator.pop(context)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: Color(0xFFFFFFFF),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share, color: Color(0xFF000000).withOpacity(0.5)),
              onPressed: () {
                Share.share(widget.itemArticle.url,
                    subject: 'Check out this news from Ariel News App.');
                // flutterWebviewPlugin.reloadUrl(); // if you want to reloade another url
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Color(0xFF000000).withOpacity(0.8)),
              onPressed: () {
                flutterWebviewPlugin.goBack(); // for going back
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF000000).withOpacity(0.8)),
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
