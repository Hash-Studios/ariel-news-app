import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/notifications/messageHandler.dart';
import 'package:flutter_news_app/globals.dart' as globals;

// import 'package:flutter_news_app/src/ui/app.dart';
// import 'package:flutter_stetho/flutter_stetho.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Stetho.initialize();
  globals.selectedCategory = 0;

  runApp(RestartWidget(
    child: MessageHandler(),
  ));
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    // router.currentRoute = "Home";
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
