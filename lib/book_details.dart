import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  final String title;
  const BookDetailsScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 140, 61),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Hero(
                      tag: "title",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          )),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static RectTween _createRectTween(Rect begin, Rect end) {
    return CustomRectTween(begin: begin, end: end);
  }
}

class CustomRectTween extends RectTween {
  CustomRectTween({Rect begin, Rect end}) : super(begin: begin, end: end) {}

  @override
  Rect lerp(double t) {
    double height = end.top - begin.top;
    double width = end.left - begin.left;

    double animatedX = begin.left + (t * width);
    double animatedY = begin.top + (t * height);

    return Rect.fromLTWH(animatedX, animatedY, 1, 1);
  }
}
