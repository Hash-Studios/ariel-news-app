import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';

class ArticlePage extends StatefulWidget {
  Article itemArticle;
  ArticlePage({@required this.itemArticle});
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
