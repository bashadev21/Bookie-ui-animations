import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake_animations/books_models.dart';
import 'package:shake_animations/bookview_controller.dart';

void main() => runApp(MyApp());

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
                        if (percentage == 1) {
                          print(percentage);
                        }
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Stack(
                                children: [
                                  Center(
                                      child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(5.0, 5.0),
                                              spreadRadius: 10,
                                              blurRadius: 20,
                                              color: Colors.black26)
                                        ]),
                                    height: MediaQuery.of(context).size.height *
                                        0.55,
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                  )),
                                  Transform(
                                    alignment: Alignment.centerLeft,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.002)
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
                                                0.55),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
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
}
