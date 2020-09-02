import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/notifications/messageHandler.dart';

int selectedCategory;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance
      .initialize(appId: "ca-app-pub-4649644680694757~4732656234");
  selectedCategory = 0;

  runApp(MessageHandler());
}
