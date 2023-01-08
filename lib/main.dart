import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake_animations/books_models.dart';
import 'package:shake_animations/bookview_controller.dart';

import 'book_details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);
  final BooksViewController _con = Get.put(BooksViewController());
  @override
  Widget build(BuildContext context) {
    // final imageheight = MediaQuery.of(context).size.height * 0.75;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              bgimage,
              fit: BoxFit.fill,
            )),
            ValueListenableBuilder(
                valueListenable: _con.notifier,
                builder: (context, value, _) {
                  return PageView.builder(
                      itemCount: books.length,
                      controller: _con.pgcontroller,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        final percentage = index - value;
                        final rotation = percentage.clamp(0.0, 1.0);
                        print((1 - rotation).toString());
                        if (percentage == 1) {}
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 1600),
                                      pageBuilder: (_, __, ___) =>
                                          BookDetailsScreen(
                                            title: book.title,
                                          )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Stack(
                                  children: [
                                    Center(
                                        child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Demo text ' * 1000,
                                            style:
                                                const TextStyle(fontSize: 7)),
                                      ),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(5.0, 5.0),
                                                spreadRadius: 10,
                                                blurRadius: 20,
                                                color: Colors.black26)
                                          ]),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                    )),
                                    Transform(
                                      alignment: Alignment.centerLeft,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(1.8 * rotation)
                                        ..translate(-rotation *
                                            MediaQuery.of(context).size.width *
                                            0.8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Center(
                                          child: Image.asset(book.image,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.45),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                Opacity(
                                  opacity: 1 - rotation,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: 'title',
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            book.title,
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        book.author,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
            SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Bookie',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  static RectTween _createRectTween(Rect begin, Rect end) {
    return CustomRectTween(begin: begin, end: end);
  }
}
