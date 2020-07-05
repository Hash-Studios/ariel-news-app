import 'package:flutter/material.dart';

class SeeMore extends StatefulWidget {
  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        new AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: -5.0, end: -15.0)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(controller);
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, animation.value),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
        ),
      ),
    );
  }
}
