import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/src/ui/animations/seeMore.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';
import 'package:story_view/story_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NewsStory extends StatefulWidget {
  const NewsStory({
    @required this.headline,
    @required this.desc,
    @required this.image,
    @required this.author,
    @required this.time,
    @required this.authorImage,
    Key key,
    @required this.controller,
  }) : super(key: key);

  final StoryController controller;
  final String headline;
  final String desc;
  final String image;
  final String author;
  final String time;
  final String authorImage;

  @override
  _NewsStoryState createState() => _NewsStoryState();
}

class _NewsStoryState extends State<NewsStory> {
  bool _isOpen = false;
  PanelController panelController = PanelController();
  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;
  int c = 0;
  @override
  Widget build(BuildContext context) {
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
                    widget.headline ?? "News Headline",
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
                  imageUrl: widget.image,
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
                              CachedNetworkImageProvider(widget.authorImage),
                          radius: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.author ?? "Ariel",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          DateTime.now()
                                      .difference(
                                          DateTime.tryParse(widget.time))
                                      .inHours
                                      .toString() +
                                  "h" ??
                              "1h",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Text(
                        widget.headline,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 20,
                      ),
                      child: Text(
                        widget.desc ?? "Swipe up to read more.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Spacer(),
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
                        GestureDetector(
                          child: Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.black54,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          onLongPressStart: (details) {
                            print("Start");
                          },
                          onLongPressEnd: (details) {
                            print("End");
                          },
                          onLongPress: () {
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
