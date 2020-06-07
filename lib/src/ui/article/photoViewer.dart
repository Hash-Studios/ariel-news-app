import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class PhotoViewer extends StatelessWidget {
  final String url;
  PhotoViewer({@required this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: NetworkImage(url),
        heroAttributes: PhotoViewHeroAttributes(tag: "image"),
        minScale: .35,
      ),
    );
  }
}
