import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.index==0){
      i = [0,1,2,3,4];
    }else if(widget.index==1){
      i = [1,2,3,4,0];
    }else if(widget.index==2){
      i = [2,3,4,0,1];
    }else if(widget.index==3){
      i = [3,4,0,1,2];
    }else if(widget.index==4){
      i = [4,0,1,2,3];
    }
    return Scaffold(
      body: StoryView(
        [
          StoryItem.pageImage(
            NetworkImage(widget.articles[i[0]].urlToImage),
            caption: widget.articles[i[0]].title,
          ),
          StoryItem.pageImage(
            NetworkImage(widget.articles[i[1]].urlToImage),
            caption: widget.articles[i[1]].title,
          ),
          StoryItem.pageImage(
            NetworkImage(widget.articles[i[2]].urlToImage),
            caption: widget.articles[i[2]].title,
          ),
          StoryItem.pageImage(
            NetworkImage(widget.articles[i[3]].urlToImage),
            caption: widget.articles[i[3]].title,
          ),
          StoryItem.pageImage(
            NetworkImage(widget.articles[i[4]].urlToImage),
            caption: widget.articles[i[4]].title,
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
