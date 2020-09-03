import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ariel/src/model/topheadlinesnews/response_top_headlinews_news.dart';
import 'package:ariel/src/ui/story/story.dart';
import 'package:ariel/src/ui/story_view/story_controller.dart';
import 'package:ariel/src/ui/story_view/story_view.dart';

class StoriesViewer extends StatefulWidget {
  List<Article> articles;
  int index;
  StoriesViewer({this.articles, this.index});
  @override
  _StoriesViewerState createState() => _StoriesViewerState();
}

class _StoriesViewerState extends State<StoriesViewer> {
  final storyController = StoryController();
  List<int> i;
  List<StoryItem> stories = [];
  @override
  void dispose() {
    storyController.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  void initState() {
    i = rotate(
        List<int>.generate(widget.articles.length, (s) => s), widget.index);
    for (int p = 0; p < widget.articles.length; p++) {
      stories.add(StoryItem(
        NewsStory(
          article: widget.articles[i[p]],
          controller: storyController,
          key: Key('$p'),
        ),
      ));
    }
    super.initState();
  }

  List<Object> rotate(List<Object> list, int v) {
    if (list == null || list.isEmpty) return list;
    var i = v % list.length;
    return list.sublist(i)..addAll(list.sublist(0, i));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: StoryView(
        stories,
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          Navigator.pop(context);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
        onSwipeUp: () {
          if (panelController.isPanelClosed) panelController.open();
        },
        onSwipeDown: () {
          if (panelController.isPanelOpen) panelController.close();
        },
        onTap: () {
          if (panelController.isPanelOpen) panelController.close();
        },
      ),
    );
  }
}
