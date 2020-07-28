import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';
import 'package:flutter_news_app/src/ui/animations/seeMore.dart';
import 'package:flutter_news_app/src/ui/article/webpage.dart';
import 'package:flutter_news_app/src/ui/story_view/story_controller.dart';
import 'package:flutter_news_app/theme/jam_icons_icons.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

PanelController panelController;

class NewsStory extends StatefulWidget {
  const NewsStory({
    @required this.article,
    Key key,
    @required this.controller,
  }) : super(key: key);

  final StoryController controller;
  final Article article;

  @override
  _NewsStoryState createState() => _NewsStoryState();
}

class _NewsStoryState extends State<NewsStory> {
  bool _isOpen = false;
  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;
  int c = 0;
  String headline;
  String desc;
  String link;
  String image;
  String author;
  String time;
  String authorImage;

  @override
  void initState() {
    super.initState();
    panelController = PanelController();
    headline = widget.article.title;
    desc = widget.article.description;
    link = widget.article.url;
    image = widget.article.urlToImage;
    author = widget.article.source.name;
    time = widget.article.publishedAt;
    authorImage = widget.article.urlToImage;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Screenshot(
      controller: screenshotController,
      child: SlidingUpPanel(
        controller: panelController,
        backdropTapClosesPanel: true,
        color: Colors.transparent,
        boxShadow: [],
        defaultPanelState: PanelState.CLOSED,
        maxHeight: 500,
        minHeight: 100,
        onPanelOpened: () {
          setState(() {
            _isOpen = true;
          });
          widget.controller.pause();
        },
        onPanelClosed: () {
          setState(() {
            _isOpen = false;
          });
          widget.controller.play();
        },
        collapsed: Stack(
          children: <Widget>[
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    bottom: 40,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Text(
                    headline ?? "News Headline",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SeeMore(),
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Center(
                child: CachedNetworkImage(
                  imageBuilder: (context, image) {
                    if (c == 0) {
                      widget.controller.play();
                      c++;
                    }

                    return Image(
                      image: image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                  imageUrl: image,
                  placeholder: (context, text) {
                    widget.controller.pause();
                    return Center(child: CircularProgressIndicator());
                  },
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x55000000),
                        Color(0x00000000),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x88000000),
                        Color(0x00000000),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 25, 18, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage:
                              CachedNetworkImageProvider(authorImage),
                          radius: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              author ?? "Ariel",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              DateTime.now()
                                          .difference(DateTime.tryParse(time))
                                          .inHours
                                          .toString() +
                                      "h" +
                                      " ago" ??
                                  "1h" + " ago",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        // FloatingActionButton(
                        //     child: Icon(JamIcons.share), onPressed: () {})
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        panel: Container(
          margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 12.0,
                sigmaY: 12.0,
              ),
              child: AnimatedContainer(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                color: _isOpen
                    ? Colors.white.withOpacity(.5)
                    : Colors.white.withOpacity(.2),
                padding: EdgeInsets.all(24),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 280,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            child: Text(
                              headline,
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 20,
                            ),
                            child: Text(
                              desc ?? "Swipe up to read more.",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Ariel",
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "PlayfairDisplay",
                              fontSize: 20),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  screenshotController
                                      .capture(
                                    pixelRatio: 1.5,
                                    delay: Duration(milliseconds: 10),
                                  )
                                      .then(
                                    (File image) async {
                                      setState(
                                        () {
                                          _imageFile = image;
                                        },
                                      );
                                      ShareExtend.share(image.path, "image");
                                    },
                                  ).catchError(
                                    (onError) {
                                      print(onError);
                                    },
                                  );
                                },
                              ),
                            ),
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.launch,
                                  color: Colors.black54,
                                ),
                                onPressed: () async {
                                  HapticFeedback.mediumImpact();
                                  if (await canLaunch(link)) {
                                    SystemChrome.setEnabledSystemUIOverlays([
                                      SystemUiOverlay.top,
                                      SystemUiOverlay.bottom
                                    ]);
                                    // await launch(itemArticle.url);
                                    await Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => WebPage(
                                          itemArticle: widget.article,
                                          mediaQuery: MediaQuery.of(context),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
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
}
