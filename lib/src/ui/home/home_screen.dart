import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/bloc/home/home_bloc.dart';
import 'package:flutter_news_app/src/model/category/category.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';
import 'package:flutter_news_app/src/ui/article/article.dart';
import 'package:flutter_news_app/src/ui/carousel/stories.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_news_app/globals.dart' as globals;
import 'package:carousel_slider/carousel_slider.dart';

final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
int selectedCategory = globals.selectedCategory;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(globals.selectedCategory);
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      key: scaffoldState,
      body: BlocProvider<HomeBloc>(
        builder: (context) => HomeBloc(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.only(
                top: mediaQuery.padding.top + 16.0,
                bottom: 16.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WidgetTitle(strToday),
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          print("Settings");
                        },
                      )
                    ],
                  ),
                  /*SizedBox(height: 8.0),
                  buildWidgetSearch(),*/
                  SizedBox(height: 12.0),
                  WidgetCategory(),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            _buildWidgetLabelLatestNews(context),
            _buildWidgetSubtitleLatestNews(context),
            SizedBox(height: 10.0),
            Expanded(
              child: WidgetLatestNews(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetSubtitleLatestNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Top stories at the moment',
        style: Theme.of(context).textTheme.caption.merge(
              TextStyle(
                  color: Color(0xFF000000).withOpacity(0.6),
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
      ),
    );
  }

  Widget _buildWidgetLabelLatestNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Latest News',
        style: Theme.of(context).textTheme.subtitle.merge(
              TextStyle(
                fontSize: 22.0,
                color: Color(0xFF000000).withOpacity(1),
                fontFamily: "PlayfairDisplay",
              ),
            ),
      ),
    );
  }

  Widget buildWidgetSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: EdgeInsets.only(
          left: 12.0,
          top: 8.0,
          right: 12.0,
          bottom: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'What are you looking for?',
                style: TextStyle(
                  color: Colors.black26,
                  fontFamily: "PlayfairDisplay",
                ),
              ),
            ),
            Icon(
              Icons.search,
              size: 16.0,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  String getStrToday() {
    var today = DateFormat().add_yMMMMd().format(DateTime.now());
    var strDay = today.split(" ")[1].replaceFirst(',', '');
    if (strDay == '1') {
      strDay = strDay + "st";
    } else if (strDay == '2') {
      strDay = strDay + "nd";
    } else if (strDay == '3') {
      strDay = strDay + "rd";
    } else {
      strDay = strDay + "th";
    }
    var strMonth = today.split(" ")[0];
    var strYear = today.split(" ")[2];
    return "$strDay $strMonth $strYear";
  }
}

class WidgetTitle extends StatelessWidget {
  final String strToday;
  final Color headingColor = Color(0xFF000000);
  final Color subHeadingColor = Color(0xFF000000);

  WidgetTitle(this.strToday);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Ariel - News for you\n',
                style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                          color: headingColor,
                          fontFamily: "PlayfairDisplay",
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
              ),
              TextSpan(
                text: strToday,
                style: Theme.of(context).textTheme.caption.merge(
                      TextStyle(
                          color: Color(0xFF000000).withOpacity(0.6),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetCategory extends StatefulWidget {
  @override
  _WidgetCategoryState createState() => _WidgetCategoryState();
}

class _WidgetCategoryState extends State<WidgetCategory> {
  final listCategories = [
    Category('', 'All'),
    Category('assets/images/budget.png', 'Business'),
    Category('assets/images/doctors-bag.png', 'Health'),
    Category('assets/images/chemistry-book.png', 'Science'),
    Category('assets/images/sport.png', 'Sport'),
    Category('assets/images/hacking.png', 'Tech'),
    Category('assets/images/music-band.png', 'Entertainment'),
  ];
  int indexSelectedCategory;
  final Color allColor = Color(0xFFFFFFFF);
  final Color selectedColor = Colors.red;
  final Color unSelectedColor = Color(0xFF000000);
  final Color selectedBorderColor = Colors.red;

  @override
  void initState() {
    int indexSelectedCategory = globals.selectedCategory;
    selectedCategory = indexSelectedCategory;
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.dispatch(DataEvent(listCategories[indexSelectedCategory].title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Container(
      height: 78,
      child: ListView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Category itemCategory = listCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: index == listCategories.length - 1 ? 16.0 : 0.0,
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print(index);
                      indexSelectedCategory = index;
                      selectedCategory = index;
                      homeBloc.dispatch(DataEvent(
                          listCategories[indexSelectedCategory].title));
                    });
                  },
                  child: index == 0
                      ? Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: allColor,
                            border: indexSelectedCategory == index
                                ? Border.all(
                                    color: selectedBorderColor,
                                    width: 5.0,
                                  )
                                : null,
                          ),
                          child: Icon(
                            Icons.apps,
                            color: selectedBorderColor,
                          ),
                        )
                      : Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: indexSelectedCategory == index
                                ? DecorationImage(
                                    image: AssetImage(itemCategory.image),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: AssetImage(itemCategory.image),
                                    colorFilter: ColorFilter.mode(
                                        Colors.white, BlendMode.color),
                                    fit: BoxFit.cover,
                                  ),
                            border: indexSelectedCategory == index
                                ? Border.all(
                                    color: selectedBorderColor,
                                    width: 5.0,
                                  )
                                : null,
                          ),
                        ),
                ),
                SizedBox(height: 8.0),
                Text(
                  itemCategory.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily:
                        indexSelectedCategory == index ? "Roboto" : "Roboto",
                    color: indexSelectedCategory == index
                        ? selectedColor
                        : unSelectedColor,
                    fontWeight: indexSelectedCategory == index
                        ? FontWeight.w300
                        : FontWeight.w300,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: listCategories.length,
      ),
    );
  }
}

class WidgetLatestNews extends StatefulWidget {
  WidgetLatestNews();

  @override
  _WidgetLatestNewsState createState() => _WidgetLatestNewsState();
}

class _WidgetLatestNewsState extends State<WidgetLatestNews> {
  final Color newsTitleColor = Color(0xFF000000);

  Completer<void> _refreshCompleter;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 0.0,
        top: 8.0,
        right: 0.0,
        bottom: mediaQuery.padding.bottom,
      ),
      child: BlocListener<HomeBloc, DataState>(
        listener: (context, state) {
          if (state is DataFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: BlocBuilder(
          bloc: homeBloc,
          builder: (BuildContext context, DataState state) {
            return _buildWidgetContentLatestNews(state, mediaQuery);
          },
        ),
      ),
    );
  }

  Widget _buildWidgetContentLatestNews(
      DataState state, MediaQueryData mediaQuery) {
    final listCategories = [
      Category('', 'All'),
      Category('assets/images/budget.png', 'Business'),
      Category('assets/images/doctors-bag.png', 'Health'),
      Category('assets/images/chemistry-book.png', 'Science'),
      Category('assets/images/sport.png', 'Sport'),
      Category('assets/images/hacking.png', 'Tech'),
      Category('assets/images/music-band.png', 'Entertainment'),
    ];
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    if (state is DataLoading) {
      return Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator()
            : CupertinoActivityIndicator(),
      );
    } else if (state is DataSuccess) {
      ResponseTopHeadlinesNews data = state.data;
      _refreshCompleter?.complete();
      _refreshCompleter = Completer();
      return RefreshIndicator(
        onRefresh: () {
          homeBloc.dispatch(
              RefreshData(category: listCategories[selectedCategory].title));
          return _refreshCompleter.future;
        },
        child:
            // return
            Scrollbar(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: data.articles.length,
            // separatorBuilder: (context, index) {
            //   return Divider();
            // },
            itemBuilder: (context, index) {
              Article itemArticle = data.articles[index];
              if (index == 0) {
                return CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      height: 272,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      pauseAutoPlayOnTouch: true),
                  items: [
                    0,
                    1,
                    2,
                    3,
                    4,
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 5),
                                        blurRadius: 10,
                                        color:
                                            Color(0xFF000000).withOpacity(0.1))
                                  ]),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25))),
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: data.articles[i].urlToImage ==
                                            null
                                        ? "https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/img_not_available.jpeg"
                                        : data.articles[i].urlToImage,
                                    height: 242.0,
                                    width: mediaQuery.size.width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Platform
                                            .isAndroid
                                        ? Container(
                                            height: 242,
                                            child: Center(
                                                child: Container(
                                                    child:
                                                        CircularProgressIndicator())))
                                        : CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/img_not_found.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                    // topLeft: Radius.circular(25.0),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(data.articles[i].url)) {
                                    // await launch(data.articles[i].url);
                                    await Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => StoriesViewer(
                                              articles: data.articles, index: i)
                                          // ArticlePage(
                                          //   itemArticle: data.articles[i],
                                          //   mediaQuery: mediaQuery,
                                          // ),
                                          ),
                                    );
                                  } else {
                                    scaffoldState.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('Could not launch news'),
                                    ));
                                  }
                                },
                                child: Container(
                                  width: mediaQuery.size.width,
                                  height: 242.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                      // topLeft: Radius.circular(25.0),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.0),
                                        Color(0xFF000000).withOpacity(0.7),
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
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12.0,
                                    top: 178.0,
                                    right: 12.0,
                                  ),
                                  child: Text(
                                    data.articles[i].title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 18.0,
                                    top: 4.0,
                                    right: 12.0,
                                  ),
                                  child: Wrap(
                                    children: <Widget>[
                                      Icon(
                                        Icons.launch,
                                        color: Colors.white.withOpacity(0.8),
                                        size: 12.0,
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        '${data.articles[i].source.name}',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 11.0,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                );
              } else if (index == 1 || index == 2 || index == 3 || index == 4) {
                return Container();
              } else {
                return GestureDetector(
                  onTap: () async {
                    if (await canLaunch(itemArticle.url)) {
                      // await launch(itemArticle.url);
                      await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ArticlePage(
                            itemArticle: itemArticle,
                            mediaQuery: mediaQuery,
                          ),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 10,
                                color: Color(0xFF000000).withOpacity(0.1))
                          ]),
                      child: Card(
                        color: Color(0xFFFFFFFF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Container(
                          width: mediaQuery.size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    height: 80.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          itemArticle.title,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: newsTitleColor,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Roboto",
                                            fontSize: 15,
                                          ),
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: Icon(
                                                Icons.launch,
                                                size: 12.0,
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            SizedBox(width: 4.0),
                                            Text(
                                              itemArticle.source.name,
                                              style: TextStyle(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.5),
                                                fontSize: 11.0,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 2),
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl: itemArticle.urlToImage == null
                                          ? "https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/img_not_available.jpeg"
                                          : itemArticle.urlToImage,
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          width: 78.0,
                                          height: 78.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                      placeholder: (context, url) => Container(
                                        width: 78.0,
                                        height: 78.0,
                                        child: Center(
                                          child: Platform.isAndroid
                                              ? CircularProgressIndicator()
                                              : CupertinoActivityIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/img_not_found.jpg',
                                        fit: BoxFit.cover,
                                        width: 78.0,
                                        height: 78.0,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
