import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  Article itemArticle;
  MediaQueryData mediaQuery;
  ArticlePage({@required this.itemArticle, @required this.mediaQuery});
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.itemArticle.source.name,
                style: TextStyle(
                  fontFamily: "Helvetica",
                  color: Color(0xFF34234d),
                ),
              ),
              background: Stack(
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
                          Colors.black.withOpacity(0.0),
                          Color(0xFF000000).withOpacity(0.2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.3,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: ,
          ),
        ],
      ),
    );
  }
}
