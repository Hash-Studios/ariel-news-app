import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/Widgets/CustomImageView.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import './webpage.dart';

final GlobalKey<ScaffoldState> scaffoldState2 = GlobalKey<ScaffoldState>();

class ArticlePage extends StatefulWidget {
  Article itemArticle;
  MediaQueryData mediaQuery;

  ArticlePage({@required this.itemArticle, @required this.mediaQuery});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 228, 242),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF34234d),
                ),
                onPressed: () => Navigator.pop(context)),
            elevation: 0,
            stretchTriggerOffset: 400,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(25))),
            backgroundColor: Color(0xFFB8BEDD),
            pinned: this._pinned,
            snap: this._snap,
            floating: this._floating,
            expandedHeight: 262.0,
            centerTitle: true,
            // actions: [
            //   NavigationControls(_controller.future),
            // ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.itemArticle.source.name,
                style: TextStyle(
                  fontFamily: "Helvetica",
                  color: Color(0xFF34234d),
                ),
              ),
              background: InkWell(
                onTap: () {
                  showImage();
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.itemArticle.urlToImage == null
                            ? "https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/img_not_available.jpeg"
                            : widget.itemArticle.urlToImage,
                        height: 292.0,
                        width: widget.mediaQuery.size.width,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Platform.isAndroid
                            ? CircularProgressIndicator()
                            : CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/img_not_found.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: widget.mediaQuery.size.width,
                      height: 292.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          // topLeft: Radius.circular(25.0),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Color(0xFFAAAAAA).withOpacity(0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            0.5,
                            1.0,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 650.0,
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  color: Color.fromARGB(255, 225, 228, 242),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    color: Color(0xFFB8BEDD),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, right: 10, bottom: 10),
                          child: Text(
                            widget.itemArticle.title == null
                                ? "News"
                                : widget.itemArticle.title,
                            style: TextStyle(
                                color: Color(0xFF34234d),
                                fontFamily: "Helvetica",
                                fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 40),
                          child: Text(
                            widget.itemArticle.description == null
                                ? "News"
                                : widget.itemArticle.description,
                            style: TextStyle(
                                color: Color(0xFF34234d).withOpacity(0.8),
                                fontFamily: "HelveticaL",
                                fontSize: 24),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.itemArticle.author == null
                                    ? " "
                                    : "By " + widget.itemArticle.author,
                                style: TextStyle(
                                    color: Color(0xFF34234d),
                                    fontFamily: "Helvetica",
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.itemArticle.publishedAt == null
                                    ? " "
                                    : widget.itemArticle.publishedAt
                                        .split('T')[0],
                                style: TextStyle(
                                    color: Color(0xFF34234d),
                                    fontFamily: "Helvetica",
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 40)
              ],
            ),
          ),
          // SliverFillRemaining(
          //   child:
          // ),
        ],
      ),
      bottomNavigationBar: this._getBottomAppBar(),
    );
  }

  Widget _getBottomAppBar() {
    return BottomAppBar(
      elevation: 6,
      color: Color.fromARGB(255, 225, 228, 242),
      child: Card(
        margin: EdgeInsets.all(10),
        color: Color(0xFFB8BEDD),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25))),
        child: GestureDetector(
          onTap: () async {
            if (await canLaunch(widget.itemArticle.url)) {
              // await launch(itemArticle.url);
              await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => WebPage(
                    itemArticle: widget.itemArticle,
                    mediaQuery: widget.mediaQuery,
                  ),
                ),
              );
            } else {
              scaffoldState2.currentState.showSnackBar(SnackBar(
                content: Text('Could not launch news'),
              ));
            }
          },
          child: Container(
            width: widget.mediaQuery.size.width,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                // topLeft: Radius.circular(25.0)
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.launch,
                          size: 24.0,
                          color: Color(0xFF34234d),
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        widget.itemArticle.source.name,
                        style: TextStyle(
                          color: Color(0xFF34234d),
                          fontSize: 24.0,
                          fontFamily: "HelveticaL",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showImage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomImageView(
                url: widget.itemArticle.urlToImage == null
                    ? "https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/img_not_available.jpeg"
                    : widget.itemArticle.urlToImage,
                title: widget.itemArticle.title.length > 35
                    ? widget.itemArticle.title.substring(0, 35) + ".."
                    : widget.itemArticle.title)));
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller, goBack: true),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller, goBack: false),
            ),
          ],
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      );
    }
  }
}
