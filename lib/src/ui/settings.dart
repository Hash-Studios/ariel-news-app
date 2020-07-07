import 'package:flutter_news_app/theme/jam_icons_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_news_app/main.dart' as main;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int favCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Color(0xFFE57697),
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
            background: Stack(),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Personalisation',
              style: TextStyle(
                fontSize: 14,
                // color: Theme.of(context).accentColor,
              ),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Provider.of<ThemeModel>(context, listen: false).toggleTheme();
          //     main.RestartWidget.restartApp(context);
          //   },
          //   leading: main.prefs.getBool("darkMode") == null
          //       ? Icon(JamIcons.moon_f)
          //       : main.prefs.getBool("darkMode")
          //           ? Icon(JamIcons.sun_f)
          //           : Icon(JamIcons.moon_f),
          //   title: Text(
          //     main.prefs.getBool("darkMode") == null
          //         ? "Dark Mode"
          //         : main.prefs.getBool("darkMode")
          //             ? "Light Mode"
          //             : "Dark Mode",
          //     style: TextStyle(
          //         color: Theme.of(context).accentColor,
          //         fontWeight: FontWeight.w500,
          //         fontFamily: "Proxima Nova"),
          //   ),
          //   subtitle: Text(
          //     "Toggle app theme",
          //     style: TextStyle(fontSize: 12),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'General',
              style: TextStyle(
                fontSize: 14,
                // color: Theme.of(context).accentColor,
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
                        // color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Clear locally cached images",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    DefaultCacheManager().emptyCache();
                    // toasts.clearCache();
                  }),
              ListTile(
                onTap: () {
                  main.RestartWidget.restartApp(context);
                },
                leading: Icon(JamIcons.refresh),
                title: Text(
                  "Restart App",
                  style: TextStyle(
                      // color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Proxima Nova"),
                ),
                subtitle: Text(
                  "Force the application to restart",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     'User',
          //     style: TextStyle(
          //       fontSize: 14,
          //       color: Theme.of(context).accentColor,
          //     ),
          //   ),
          // ),
          // main.prefs.getBool("isLoggedin") == false
          //     ? ListTile(
          //         onTap: () {
          //           if (!main.prefs.getBool("isLoggedin")) {
          //             googleSignInPopUp(context, () {
          //               main.RestartWidget.restartApp(context);
          //             });
          //           } else {
          //             main.RestartWidget.restartApp(context);
          //           }
          //         },
          //         leading: Icon(JamIcons.log_in),
          //         title: Text(
          //           "Log in",
          //           style: TextStyle(
          //               color: Theme.of(context).accentColor,
          //               fontWeight: FontWeight.w500,
          //               fontFamily: "Proxima Nova"),
          //         ),
          //         subtitle: Text(
          //           "Log in to sync data across devices",
          //           style: TextStyle(fontSize: 12),
          //         ),
          //       )
          //     : Container(),
          // main.prefs.getBool("isLoggedin")
          //     ? Column(
          //         children: [
          //           ListTile(
          //               leading: Icon(
          //                 JamIcons.heart,
          //               ),
          //               title: new Text(
          //                 "Clear favourites",
          //                 style: TextStyle(
          //                     color: Theme.of(context).accentColor,
          //                     fontWeight: FontWeight.w500,
          //                     fontFamily: "Proxima Nova"),
          //               ),
          //               subtitle: Text(
          //                 "Remove all favourites",
          //                 style: TextStyle(fontSize: 12),
          //               ),
          //               onTap: () {
          //                 toasts.clearFav();
          //                 Provider.of<FavouriteProvider>(context,
          //                         listen: false)
          //                     .deleteData();
          //               }),
          // ListTile(
          //     leading: Icon(
          //       JamIcons.log_out,
          //     ),
          //     title: new Text(
          //       "Logout",
          //       style: TextStyle(
          //           color: Theme.of(context).accentColor,
          //           fontWeight: FontWeight.w500,
          //           fontFamily: "Proxima Nova"),
          //     ),
          //     subtitle: Text(
          //       "Sign out from your account",
          //       style: TextStyle(fontSize: 12),
          //     ),
          //     onTap: () {
          //       globals.gAuth.signOutGoogle();
          //       toasts.successLogOut();
          //       main.RestartWidget.restartApp(context);
          //     }),
          //     ],
          //   )
          // : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Prism',
              style: TextStyle(
                fontSize: 14,
                // color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                  leading: Icon(
                    JamIcons.info,
                  ),
                  title: new Text(
                    "What's new?",
                    style: TextStyle(
                        // color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Check out the changelog",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {}),
              ListTile(
                  leading: Icon(
                    JamIcons.share_alt,
                  ),
                  title: new Text(
                    "Share Ariel!",
                    style: TextStyle(
                        // color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Quick link to pass on to your friends and enemies",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Share.share(
                        'Hey check out this amazing news app Ariel https://play.google.com/store/apps/details?id=com.hash.prism');
                  }),
              ListTile(
                  leading: Icon(
                    JamIcons.github,
                  ),
                  title: new Text(
                    "View Ariel on GitHub!",
                    style: TextStyle(
                        // color: Theme.of(context).accentColor,
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
                    JamIcons.picture,
                  ),
                  title: new Text(
                    "API",
                    style: TextStyle(
                        // color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "unknow",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () async {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        content: Container(
                          height: 150,
                          width: 250,
                          child: Center(
                            child: ListView.builder(
                                itemCount: 2,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(
                                      index == 0
                                          ? JamIcons.picture
                                          : JamIcons.camera,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    title: Text(
                                      index == 0 ? " API" : "API",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    onTap: index == 0
                                        ? () async {
                                            HapticFeedback.vibrate();
                                            Navigator.of(context).pop();
                                            launch("");
                                          }
                                        : () async {
                                            HapticFeedback.vibrate();
                                            Navigator.of(context).pop();
                                            launch("");
                                          },
                                  );
                                }),
                          ),
                        ),
                      ),
                    );
                  }),
              ListTile(
                  leading: Icon(
                    JamIcons.computer_alt,
                  ),
                  title: new Text(
                    "Version",
                    style: TextStyle(
                        // color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "unknow",
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
                        // color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Tell us if you found out a bug",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    launch(
                        "https://github.com/Hash-Studios/ariel-news-app/issues");
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hash Studios',
              style: TextStyle(
                fontSize: 14,
                // color: Theme.of(context).accentColor,
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
                      // color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Proxima Nova"),
                ),
                subtitle: Text(
                  "We are recruiting Flutter developers",
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () {
                  launch("https://forms.gle/nSt4QtiQVVaZvhdA8");
                }),
            // ListTile(
            //     leading: Icon(
            //       JamIcons.coffee,
            //     ),
            //     title: new Text(
            //       "Buy us a cup of tea",
            //       style: TextStyle(
            //           color: Theme.of(context).accentColor,
            //           fontWeight: FontWeight.w500,
            //           fontFamily: "Proxima Nova"),
            //     ),
            //     subtitle: Text(
            //       "Support us if you like what we do",
            //       style: TextStyle(fontSize: 12),
            //     ),
            //     onTap: () {
            //       launch("https://buymeacoff.ee/HashStudios");
            //     }),
            ExpansionTile(
              backgroundColor: Colors.white,
              leading: Icon(
                JamIcons.users,
              ),
              title: new Text(
                "Meet the awesome team",
                style: TextStyle(
                    color: Colors.black,
                    // color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Proxima Nova"),
              ),
              subtitle: Text(
                "Check out the cool devs!",
                style: TextStyle(fontSize: 12),
              ),
              children: [
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/hashstudio.PNG"),
                    ),
                    title: new Text(
                      "Hash Studios Inc",
                      style: TextStyle(
                          //color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Proxima Nova"),
                    ),
                    subtitle: Text(
                      "hash.studios.inc@gmail.com",
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      launch("https://github.com/orgs/Hash-Studios/people");
                    }),
              ],
            ),
          ])
        ])),
      ]),
    );
  }
}
