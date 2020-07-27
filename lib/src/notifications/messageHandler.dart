import 'dart:async';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_news_app/src/ui/app.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_news_app/main.dart' as main;

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        if (message['data']['tab'] == 'tech') {
          print('changed global');
          main.selectedCategory = 5;
        }
        _showFlutterToast(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        if (message['data']['tab'] == 'tech') {
          print('changed global');
          main.selectedCategory = 5;
        }
        _showFlutterToast(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        if (message['data']['tab'] == 'tech') {
          print('changed global');
          main.selectedCategory = 5;
        }
        _showFlutterToast(message);
      },
    );
    _fcm.subscribeToTopic('all');
    _fcm.subscribeToTopic('business');
    _fcm.subscribeToTopic('health');
    _fcm.subscribeToTopic('science');
    _fcm.subscribeToTopic('sport');
    _fcm.subscribeToTopic('tech');
    _fcm.subscribeToTopic('entertainment');
    super.initState();
  }

  // Widget _buildDialog(BuildContext context, message) {
  //   return AlertDialog(
  //     content: Text(message['notification']['body']),
  //     actions: <Widget>[
  //       FlatButton(
  //         child: const Text('CLOSE'),
  //         onPressed: () {
  //           Navigator.pop(context, false);
  //         },
  //       ),
  //       FlatButton(
  //         child: const Text('SHOW'),
  //         onPressed: () {
  //           Navigator.pop(context, true);
  //         },
  //       ),
  //     ],
  //   );
  // }

  // void _showItemDialog(Map<String, dynamic> message) {
  //   showDialog<bool>(
  //     context: context,
  //     builder: (_) => _buildDialog(context, message),
  //   ).then((bool shouldNavigate) {
  //     if (shouldNavigate == true) {
  //       _navigateToItemDetail(message);
  //     }
  //   });
  // }

  void _showFlutterToast(Map<String, dynamic> message) {
    Fluttertoast.showToast(msg: message['notification']['body']);
    print('shown toast!');
  }

  // void _navigateToItemDetail(Map<String, dynamic> message) {
  //   // Navigator.push(context, item.route);
  // }

  @override
  Widget build(BuildContext context) {
    return App();
  }
}
