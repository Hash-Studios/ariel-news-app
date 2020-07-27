import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/notifications/messageHandler.dart';

int selectedCategory;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  selectedCategory = 0;

  runApp(MessageHandler());
}
