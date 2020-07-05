import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';
import 'package:flutter_news_app/src/ui/story/story.dart';
import 'package:story_view/story_view.dart';

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
  @override
  void dispose() {
    storyController.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    if (widget.index == 0) {
      i = [0, 1, 2, 3, 4];
    } else if (widget.index == 1) {
      i = [1, 2, 3, 4, 0];
    } else if (widget.index == 2) {
      i = [2, 3, 4, 0, 1];
    } else if (widget.index == 3) {
      i = [3, 4, 0, 1, 2];
    } else if (widget.index == 4) {
      i = [4, 0, 1, 2, 3];
    }
    return Scaffold(
      body: StoryView(
        [
          StoryItem(
            NewsStory(
              article: widget.articles[i[0]],
              controller: storyController,
              key: Key('0'),
            ),
          ),
          StoryItem(
            NewsStory(
              article: widget.articles[i[1]],
              controller: storyController,
              key: Key('1'),
            ),
          ),
          StoryItem(
            NewsStory(
              article: widget.articles[i[2]],
              controller: storyController,
              key: Key('2'),
            ),
          ),
          StoryItem(
            NewsStory(
              article: widget.articles[i[3]],
              controller: storyController,
              key: Key('3'),
            ),
          ),
          StoryItem(
            NewsStory(
              article: widget.articles[i[4]],
              controller: storyController,
              key: Key('4'),
            ),
          ),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          Navigator.pop(context);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}
