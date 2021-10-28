import 'dart:async';

import 'package:ariel/main.dart' as main;
import 'package:ariel/payments/upgrade.dart';
import 'package:ariel/src/ui/app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseMessaging f;
Future<dynamic> myBackgroundMessageHandler(RemoteMessage remessage) {
  // if (message.containsKey('data')) {
  if (remessage.data['tab'] == 'all') {
    main.selectedCategory = 0;
  } else if (remessage.data['tab'] == 'business') {
    main.selectedCategory = 1;
  } else if (remessage.data['tab'] == 'health') {
    main.selectedCategory = 2;
  } else if (remessage.data['tab'] == 'science') {
    main.selectedCategory = 3;
  } else if (remessage.data['tab'] == 'sport') {
    main.selectedCategory = 4;
  } else if (remessage.data['tab'] == 'tech') {
    main.selectedCategory = 5;
  } else if (remessage.data['tab'] == 'entertainment') {
    main.selectedCategory = 6;
  }
  // }
}

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  @override
  void initState() {
    checkPremium();
    FirebaseMessaging f = FirebaseMessaging.instance;
    // f.requestNotificationPermissions();
    FirebaseMessaging.onMessage.listen((RemoteMessage remessage) async {
      print("onMessage: ${remessage.data}");
      if (remessage.data['tab'] == 'all') {
        main.selectedCategory = 0;
      } else if (remessage.data['tab'] == 'business') {
        main.selectedCategory = 1;
      } else if (remessage.data['tab'] == 'health') {
        main.selectedCategory = 2;
      } else if (remessage.data['tab'] == 'science') {
        main.selectedCategory = 3;
      } else if (remessage.data['tab'] == 'sport') {
        main.selectedCategory = 4;
      } else if (remessage.data['tab'] == 'tech') {
        main.selectedCategory = 5;
      } else if (remessage.data['tab'] == 'entertainment') {
        main.selectedCategory = 6;
      }
      _showFlutterToast(remessage.data['title']);
      // _showItemDialog(message);
    });
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    // f.configure(
    //   onMessage: ,
    //   onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     if (message['data']['tab'] == 'all') {
    //       main.selectedCategory = 0;
    //     } else if (message['data']['tab'] == 'business') {
    //       main.selectedCategory = 1;
    //     } else if (message['data']['tab'] == 'health') {
    //       main.selectedCategory = 2;
    //     } else if (message['data']['tab'] == 'science') {
    //       main.selectedCategory = 3;
    //     } else if (message['data']['tab'] == 'sport') {
    //       main.selectedCategory = 4;
    //     } else if (message['data']['tab'] == 'tech') {
    //       main.selectedCategory = 5;
    //     } else if (message['data']['tab'] == 'entertainment') {
    //       main.selectedCategory = 6;
    //     }
    //     _showFlutterToast(message);
    //     // _navigateToItemDetail(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     if (message['data']['tab'] == 'all') {
    //       main.selectedCategory = 0;
    //     } else if (message['data']['tab'] == 'business') {
    //       main.selectedCategory = 1;
    //     } else if (message['data']['tab'] == 'health') {
    //       main.selectedCategory = 2;
    //     } else if (message['data']['tab'] == 'science') {
    //       main.selectedCategory = 3;
    //     } else if (message['data']['tab'] == 'sport') {
    //       main.selectedCategory = 4;
    //     } else if (message['data']['tab'] == 'tech') {
    //       main.selectedCategory = 5;
    //     } else if (message['data']['tab'] == 'entertainment') {
    //       main.selectedCategory = 6;
    //     }
    //     _showFlutterToast(message);
    //     // _navigateToItemDetail(message);
    //   },
    // );

    f.getToken().then((value) {
      f.getToken().then((value) {
        print(value);
      });
    });
    super.initState();
  }

  void _showFlutterToast(Map<String, dynamic> message) {
    Fluttertoast.showToast(msg: message['notification']['body']);
    print('shown toast!');
  }

  @override
  Widget build(BuildContext context) {
    return App();
  }
}
