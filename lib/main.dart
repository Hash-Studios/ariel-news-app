import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/notifications/messageHandler.dart';
import 'package:flutter_news_app/globals.dart' as globals;
// import 'package:flutter_news_app/src/ui/app.dart';
// import 'package:flutter_stetho/flutter_stetho.dart';

void main() {
  // Stetho.initialize();
  globals.selectedCategory = 0;
  runApp(MessageHandler());
}
