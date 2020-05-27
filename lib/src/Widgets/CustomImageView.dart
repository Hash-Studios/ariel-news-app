import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ZoomableImageView.dart';

class CustomImageView extends StatelessWidget {
  final String url;
  final String title;

  CustomImageView({this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: InkWell(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  ImageView.zoomableImageView(url, context),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            }));
  }
}
