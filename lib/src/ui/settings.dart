import 'package:flutter_news_app/src/notifications/messageHandler.dart';
import 'package:flutter_news_app/theme/jam_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_extend/share_extend.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int favCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Color(0xFFF44336),
          leading: IconButton(
              icon: Icon(
                JamIcons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          pinned: true,
          expandedHeight: 280.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image.asset('assets/icon/icon.png')),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'General',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                  leading: Icon(
                    JamIcons.pie_chart_alt,
                  ),
                  title: Text(
                    "Clear Cache",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Clear locally cached images",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    DefaultCacheManager().emptyCache();
                  }),
              ListTile(
                onTap: () {
                  f.unsubscribeFromTopic('all');
                  f.unsubscribeFromTopic('business');
                  f.unsubscribeFromTopic('health');
                  f.unsubscribeFromTopic('science');
                  f.unsubscribeFromTopic('sport');
                  f.unsubscribeFromTopic('tech');
                  f.unsubscribeFromTopic('entertainment');
                },
                leading: Icon(JamIcons.bell_off),
                title: Text(
                  "Unsubscribe Notifications",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontFamily: "Proxima Nova"),
                ),
                subtitle: Text(
                  "Unsubscribe to all the notifications",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Ariel',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                  leading: Icon(
                    JamIcons.share_alt,
                  ),
                  title: new Text(
                    "Share Ariel",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Quick link to pass on to your friends and enemies",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    ShareExtend.share(
                      'Hey check out this amazing news app Ariel https://play.google.com/store/apps/details?id=com.hash.ariel',
                      "text",
                    );
                  }),
              ListTile(
                  leading: Icon(
                    JamIcons.github,
                  ),
                  title: new Text(
                    "View Ariel on GitHub",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Check out the code or contribute yourself",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () async {
                    launch("https://github.com/Hash-Studios/ariel-news-app");
                  }),
              ListTile(
                  leading: Icon(
                    JamIcons.newspaper,
                  ),
                  title: new Text(
                    "API",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "NewsAPI.org ",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () async {
                    HapticFeedback.vibrate();
                    Navigator.of(context).pop();
                    launch("https://newsapi.org/");
                  }),
              ListTile(
                  leading: Icon(
                    JamIcons.computer_alt,
                  ),
                  title: new Text(
                    "Version",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "v1.0.0+1",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {}),
              ListTile(
                  leading: Icon(
                    JamIcons.bug,
                  ),
                  title: new Text(
                    "Report a bug",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Tell us if you found out a bug",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    launch(
                        "https://github.com/Hash-Studios/ariel-news-app/issues/new");
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hash Studios',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Column(children: [
            ListTile(
                leading: Icon(
                  JamIcons.luggage,
                ),
                title: new Text(
                  "Wanna work with us?",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontFamily: "Proxima Nova"),
                ),
                subtitle: Text(
                  "We are recruiting Flutter developers",
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () {
                  launch("https://forms.gle/nSt4QtiQVVaZvhdA8");
                }),
            ExpansionTile(
              leading: Icon(
                JamIcons.users,
              ),
              title: new Text(
                "Meet the awesome team",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: "Proxima Nova"),
              ),
              subtitle: Text(
                "Check out the cool devs!",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              children: [
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/AB.jpg"),
                    ),
                    title: new Text(
                      "LiquidatorCoder",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Proxima Nova"),
                    ),
                    subtitle: Text(
                      "Abhay Maurya",
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      launch("https://github.com/LiquidatorCoder");
                    }),
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/AK.jpg"),
                    ),
                    title: new Text(
                      "CodeNameAkshay",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Proxima Nova"),
                    ),
                    subtitle: Text(
                      "Akshay Maurya",
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      launch("https://github.com/codenameakshay");
                    }),
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/PT.jpg"),
                    ),
                    title: new Text(
                      "1-2-ka-4-4-2-ka-1",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Proxima Nova"),
                    ),
                    subtitle: Text(
                      "Pratyush Tiwari",
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      launch("https://github.com/1-2-ka-4-4-2-ka-1");
                    }),
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/AY.jpeg"),
                    ),
                    title: new Text(
                      "MrHYDRA-6469",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Proxima Nova"),
                    ),
                    subtitle: Text(
                      "Arpit Yadav",
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      launch("https://github.com/MrHYDRA-6469");
                    }),
              ],
            ),
          ])
        ])),
      ]),
    );
  }
}
