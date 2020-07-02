import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/src/ui/animations/seeMore.dart';
import 'package:story_view/story_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = StoryController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: StoryView(
          [
            StoryItem(
              NewsStory(
                author: "Times of India",
                authorImage: NetworkImage("https://picsum.photos/200"),
                headline:
                    "Maharashtra, Mumbai, Pune Coronavirus Live Updates: No community transmission of Covid-19",
                desc:
                    "Maharashtra Mumbai Coronavirus News Live Updates: A senior member of the Maharashtra government’s Covid-19 task force has tested positive for coronavirus, news agency PTI reported on Thursday. He had been admitted to hospital last week. The task force of nine senior doctors was formed on April 13 in view of the increasing number of coronavirus cases and deaths in the state, especially in Mumbai.",
                image: NetworkImage("https://picsum.photos/800"),
                time: "12m",
                controller: controller,
                key: Key("1"),
              ),
            ),
            StoryItem(
              NewsStory(
                author: "The Indian Express",
                authorImage: NetworkImage("https://picsum.photos/201"),
                headline:
                    "Mumbai rain alert live updates: IMD issues orange alert",
                desc:
                    "IMD has predicted heavy to very heavy rainfall at isolated places in Mumbai and adjoining coastal districts, and issued an orange alert for the next two days.",
                image: NetworkImage("https://picsum.photos/801"),
                time: "1h",
                controller: controller,
                key: Key("2"),
              ),
            ),
            StoryItem(
              NewsStory(
                author: "Hindustan Times",
                authorImage: NetworkImage("https://picsum.photos/202"),
                headline:
                    "Coronavirus live updates: Amit Shah meets CMs of UP, Haryana, Delhi; discusses Covid-19 situation",
                desc:
                    "During the last 24 hours, a total of 11,881 Covid-19 patients have been cured, taking the cumulative figure to 3,59,859. This further takes the recovery rate to 59.52%. Presently, there are 2,26,947 active cases and all are under medical supervision: Ministry of health.",
                image: NetworkImage("https://picsum.photos/802"),
                time: "1h",
                controller: controller,
                key: Key("3"),
              ),
            ),
            StoryItem(
              NewsStory(
                author: "The Deccan Chronicle",
                authorImage: NetworkImage("https://picsum.photos/203"),
                headline:
                    "Myanmar calls out China for arming terror groups, asks world to help",
                desc:
                    "Myanmar, China’s closest ally in southeast Asia, has pointed fingers at Beijing for arming insurgent groups with sophisticated weapons and sought international cooperation to suppress rebel groups. In a recent interview to Russian state-run TV channel Zvezda, Myanmar’s Senior General Min Aung Hlaing said terrorist organisations active in Myanmar are backed by ‘strong forces’ and sought international cooperation to suppress rebel groups.",
                image: NetworkImage("https://picsum.photos/803"),
                time: "3h",
                controller: controller,
                key: Key("4"),
              ),
            ),
          ],
          controller: controller,
        ),
      ),
    );
  }
}

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
  final ImageProvider image;
  final String author;
  final String time;
  final ImageProvider authorImage;

  @override
  _NewsStoryState createState() => _NewsStoryState();
}

class _NewsStoryState extends State<NewsStory> {
  bool _isOpen = false;
  PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
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
                  widget.headline,
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
              child: Image(
                image: widget.image,
                height: double.infinity,
                width: double.infinity,
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
                        backgroundImage: widget.authorImage,
                        radius: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.author,
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
                        widget.time,
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
                      widget.desc,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
