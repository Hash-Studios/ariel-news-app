import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/src/ui/animations/seeMore.dart';
import 'package:story_view/story_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(MyApp());
var caption =
    "Maharashtra, Mumbai, Pune Coronavirus Live Updates: No community transmission of Covid-19";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PanelController panelController = PanelController();
  bool isOpen = false;
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
            new StoryItem(
              SlidingUpPanel(
                controller: panelController,
                backdropTapClosesPanel: true,
                color: Colors.transparent,
                boxShadow: [],
                defaultPanelState: PanelState.CLOSED,
                maxHeight: 1000,
                onPanelOpened: () {
                  setState(() {
                    isOpen = true;
                  });
                },
                onPanelClosed: () {
                  setState(() {
                    isOpen = false;
                  });
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
                            caption,
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
                          image: NetworkImage("https://picsum.photos/806"),
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
                                  backgroundImage: NetworkImage(
                                    "https://picsum.photos/804",
                                  ),
                                  radius: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Times of India",
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
                                  "5h",
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
                  margin: EdgeInsets.fromLTRB(20, 100, 20, 120),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 4.0,
                        sigmaY: 4.0,
                      ),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        color: isOpen
                            ? Colors.white.withOpacity(.5)
                            : Colors.white.withOpacity(.2),
                        child: Text(""),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
