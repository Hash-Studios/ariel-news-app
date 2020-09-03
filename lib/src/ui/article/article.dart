// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ariel/src/model/topheadlinesnews/response_top_headlinews_news.dart';
// import 'package:ariel/src/ui/article/photoViewer.dart';
// import 'dart:io';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:async';
// import 'package:url_launcher/url_launcher.dart';
// import './webpage.dart';

// final GlobalKey<ScaffoldState> scaffoldState2 = GlobalKey<ScaffoldState>();

// class ArticlePage extends StatefulWidget {
//   Article itemArticle;
//   MediaQueryData mediaQuery;

//   ArticlePage({@required this.itemArticle, @required this.mediaQuery});

//   @override
//   _ArticlePageState createState() => _ArticlePageState();
// }

// class _ArticlePageState extends State<ArticlePage> {
//   bool _pinned = false;
//   bool _snap = false;
//   bool _floating = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFFFF),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             leading: Stack(
//               children: [
//                 Center(
//                     child: Icon(
//                   Icons.arrow_back,
//                   color: Color(0xFFFFFFFF),
//                   size: 25,
//                 )),
//                 Center(
//                   child: IconButton(
//                       icon: Icon(
//                         Icons.arrow_back,
//                         color: Colors.red,
//                       ),
//                       onPressed: () => Navigator.pop(context)),
//                 ),
//               ],
//             ),
//             elevation: 0,
//             stretchTriggerOffset: 400,
//             shape: RoundedRectangleBorder(
//                 borderRadius:
//                     BorderRadius.only(bottomLeft: Radius.circular(25))),
//             backgroundColor: Color(0xFFFFFFFF),
//             pinned: this._pinned,
//             snap: this._snap,
//             floating: this._floating,
//             expandedHeight: 262.0,
//             centerTitle: true,
//             // actions: [
//             //   NavigationControls(_controller.future),
//             // ],
//             flexibleSpace: FlexibleSpaceBar(
// //               title: Text(
// //                 widget.itemArticle.source.name,
// //                 style: TextStyle(
// //                   fontFamily: "NoeDisplay",
// //                   color: Color(0xFF34234d),
// //                 ),
// //               ),
//               background: InkWell(
//                 onTap: () {
//                   showImage();
//                 },
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(25.0),
//                       ),
//                       child: Hero(
//                         tag: "image",
//                         child: CachedNetworkImage(
//                           imageUrl: widget.itemArticle.urlToImage == null
//                               ? "https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/img_not_available.jpeg"
//                               : widget.itemArticle.urlToImage,
//                           height: 292.0,
//                           width: widget.mediaQuery.size.width,
//                           fit: BoxFit.fill,
//                           placeholder: (context, url) => Platform.isAndroid
//                               ? Container(
//                                   height: 292,
//                                   child: Center(
//                                       child: Container(
//                                           child: CircularProgressIndicator())))
//                               : CupertinoActivityIndicator(),
//                           errorWidget: (context, url, error) => Image.asset(
//                             'assets/images/img_not_found.jpg',
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: widget.mediaQuery.size.width,
//                       height: 292.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(25.0),
//                           // topLeft: Radius.circular(25.0),
//                         ),
//                         // gradient: LinearGradient(
//                         //   colors: [
//                         //     Colors.white.withOpacity(0.0),
//                         //     Color(0xFFAAAAAA).withOpacity(0.8),
//                         //   ],
//                         //   begin: Alignment.topCenter,
//                         //   end: Alignment.bottomCenter,
//                         //   stops: [
//                         //     0.5,
//                         //     1.0,
//                         //   ],
//                         // ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverFixedExtentList(
//             itemExtent: MediaQuery.of(context).size.height - 292,
//             delegate: SliverChildListDelegate.fixed(
//               [
//                 Container(
//                   color: Color(0xFFFFFFFF),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         boxShadow: [
//                           BoxShadow(
//                               offset: Offset(0, 5),
//                               blurRadius: 10,
//                               color: Color(0xFF000000).withOpacity(0.1))
//                         ]),
//                     child: Card(
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       color: Color(0xFFFFFFFF),
//                       margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 24.0, left: 24, right: 24, bottom: 20),
//                             child: Text(
//                               widget.itemArticle.title == null
//                                   ? "News"
//                                   : widget.itemArticle.title,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: "Roboto",
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
//                             child: Text(
//                               widget.itemArticle.description == null
//                                   ? "News"
//                                   : widget.itemArticle.description,
//                               style: TextStyle(
//                                   fontFamily: "Roboto",
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w300),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 24, vertical: 0),
//                             child: Container(
//                               child: Text(
//                                 widget.itemArticle.author == null
//                                     ? " "
//                                     : "By " + widget.itemArticle.author,
//                                 style: TextStyle(
//                                     color: Colors.black87,
//                                     fontFamily: "Roboto",
//                                     fontWeight: FontWeight.w300,
//                                     fontSize: 18),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 24, vertical: 0),
//                             child: Container(
//                               child: Text(
//                                 widget.itemArticle.publishedAt == null
//                                     ? " "
//                                     : widget.itemArticle.publishedAt
//                                         .split('T')[0],
//                                 style: TextStyle(
//                                     color: Colors.black87,
//                                     fontFamily: "Roboto",
//                                     fontWeight: FontWeight.w300,
//                                     fontSize: 14),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // SizedBox(height: 40)
//               ],
//             ),
//           ),
//           // SliverFillRemaining(
//           //   child:
//           // ),
//         ],
//       ),
//       floatingActionButton: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(100)),
//             boxShadow: [
//               BoxShadow(
//                   offset: Offset(0, 5),
//                   blurRadius: 10,
//                   color: Colors.red.withOpacity(1))
//             ]),
//         child: FloatingActionButton(
//           elevation: 0,
//           onPressed: () async {
//             if (await canLaunch(widget.itemArticle.url)) {
//               // await launch(itemArticle.url);
//               await Navigator.push(
//                 context,
//                 CupertinoPageRoute(
//                   builder: (context) => WebPage(
//                     itemArticle: widget.itemArticle,
//                     mediaQuery: widget.mediaQuery,
//                   ),
//                 ),
//               );
//             } else {
//               scaffoldState2.currentState.showSnackBar(SnackBar(
//                 content: Text('Could not launch news'),
//               ));
//             }
//           },
//           child: Icon(Icons.launch),
//         ),
//       ),
//       // bottomNavigationBar: this._getBottomAppBar(),
//     );
//   }

//   // Widget _getBottomAppBar() {
//   //   return BottomAppBar(
//   //     elevation: 10,
//   //     // color: Colors.transparent,
//   //     child: Container(
//   //       // decoration: BoxDecoration(
//   //       //   color: Colors.transparent,
//   //       //     borderRadius: BorderRadius.all(Radius.circular(10)),
//   //       //     boxShadow: [
//   //       //       BoxShadow(
//   //       //           offset: Offset(0, 5),
//   //       //           blurRadius: 10,
//   //       //           color: Color(0xFF000000).withOpacity(0.1))
//   //       //     ]),
//   //       child: Card(
//   //         margin: EdgeInsets.all(16),
//   //         color: Color(0xFFFFFFFF),
//   //         elevation: 0,
//   //         shape: RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.all(Radius.circular(10))),
//   //         child: GestureDetector(
//   // onTap: () async {
//   //   if (await canLaunch(widget.itemArticle.url)) {
//   //     // await launch(itemArticle.url);
//   //     await Navigator.push(
//   //       context,
//   //       CupertinoPageRoute(
//   //         builder: (context) => WebPage(
//   //           itemArticle: widget.itemArticle,
//   //           mediaQuery: widget.mediaQuery,
//   //         ),
//   //       ),
//   //     );
//   //   } else {
//   //     scaffoldState2.currentState.showSnackBar(SnackBar(
//   //       content: Text('Could not launch news'),
//   //     ));
//   //   }
//   // },
//   //           child: Container(
//   //             width: widget.mediaQuery.size.width,
//   //             height: 50.0,
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.only(
//   //                 bottomLeft: Radius.circular(25.0),
//   //                 // topLeft: Radius.circular(25.0)
//   //               ),
//   //             ),
//   //             child: Column(
//   //               children: [
//   //                 Padding(
//   //                   padding: const EdgeInsets.all(8.0),
//   //                   child: Wrap(
//   //                     crossAxisAlignment: WrapCrossAlignment.center,
//   //                     children: <Widget>[
//   //                       Padding(
//   //                         padding: const EdgeInsets.only(left: 8.0),
//   //                         child: Icon(
//   //                           Icons.launch,
//   //                           size: 24.0,
//   //                           color: Color(0xFF34234d),
//   //                         ),
//   //                       ),
//   //                       SizedBox(width: 4.0),
//   //                       Text(
//   //                         widget.itemArticle.source.name,
//   //                         style: TextStyle(
//   //                           color: Color(0xFF34234d),
//   //                           fontSize: 24.0,
//   //                           fontFamily: "Caslon",
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   showImage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => PhotoViewer(
//                 url: widget.itemArticle.urlToImage == null
//                     ? "https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/img_not_available.jpeg"
//                     : widget.itemArticle.urlToImage,
//               )
//           // CustomImageView(
//           // url: widget.itemArticle.urlToImage == null
//           //     ? "https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/img_not_available.jpeg"
//           //     : widget.itemArticle.urlToImage,
//           //     title: widget.itemArticle.title.length > 35
//           //         ? widget.itemArticle.title.substring(0, 35) + "..."
//           //         : widget.itemArticle.title),
//           ),
//     );
//   }
// }

// class NavigationControls extends StatelessWidget {
//   const NavigationControls(this._webViewControllerFuture)
//       : assert(_webViewControllerFuture != null);

//   final Future<WebViewController> _webViewControllerFuture;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<WebViewController>(
//       future: _webViewControllerFuture,
//       builder:
//           (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
//         final bool webViewReady =
//             snapshot.connectionState == ConnectionState.done;
//         final WebViewController controller = snapshot.data;
//         return Row(
//           children: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.arrow_back_ios),
//               onPressed: !webViewReady
//                   ? null
//                   : () => navigate(context, controller, goBack: true),
//             ),
//             IconButton(
//               icon: const Icon(Icons.arrow_forward_ios),
//               onPressed: !webViewReady
//                   ? null
//                   : () => navigate(context, controller, goBack: false),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   navigate(BuildContext context, WebViewController controller,
//       {bool goBack: false}) async {
//     bool canNavigate =
//         goBack ? await controller.canGoBack() : await controller.canGoForward();
//     if (canNavigate) {
//       goBack ? controller.goBack() : controller.goForward();
//     } else {
//       Scaffold.of(context).showSnackBar(
//         SnackBar(
//             content: Text("No ${goBack ? 'back' : 'forward'} history item")),
//       );
//     }
//   }
// }
