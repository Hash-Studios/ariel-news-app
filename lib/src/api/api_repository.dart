import 'dart:async';

import 'package:flutter_news_app/src/api/api_provider.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();

  Future<ResponseTopHeadlinesNews> fetchTopHeadlinesNews() =>
      _apiProvider.getTopHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopBusinessHeadlinesNews() =>
      _apiProvider.getTopBusinessHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopEntertainmentHeadlinesNews() =>
      _apiProvider.getTopEntertainmentHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopHealthHeadlinesNews() =>
      _apiProvider.getTopHealthHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopScienceHeadlinesNews() =>
      _apiProvider.getTopScienceHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopSportHeadlinesNews() =>
      _apiProvider.getTopSportHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopTechnologyHeadlinesNews() =>
      _apiProvider.getTopTechnologyHeadlinesNews();

  // Future<ResponseTopHeadlinesNews> fetchTopHeadline(String text) {
  //   if (text == "all") {
  //     return _apiProvider.getTopHeadlinesNews();
  //   } else if (text == "entertinment") {
  //     return _apiProvider.getTopEntertainmentHeadlinesNews();
  //   }else if (text == "tech") {
  //     return _apiProvider.getTopTechnologyHeadlinesNews();
  //   }else if (text == "sport") {
  //     return _apiProvider.getTopSportHeadlinesNews();
  //   }else if (text == "business") {
  //     return _apiProvider.getTopBusinessHeadlinesNews();
  //   }else if (text == "health") {
  //     return _apiProvider.getTopHealthHeadlinesNews();
  //   }else if (text == "science") {
  //     return _apiProvider.getTopScienceHeadlinesNews();
  //   }else {
  //     return _apiProvider.getTopHeadlinesNews();
  //   }
  // }
}
