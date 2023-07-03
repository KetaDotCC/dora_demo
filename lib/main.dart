import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Demo()),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key});
  @override
  Widget build(BuildContext context) {
    var innerBox = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 100,
        height: 100,
        child: ClipPath(
          clipper: CustomClipPath(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child:  ColoredBox(
              color: Colors.blue.withAlpha(200),
              child: Center(child: Text("test")),
            ),
          ),
        ),
      ),
    );
    var outerBox = SizedBox(
      width: 200,
      height: 200,
      child: ClipPath(
        clipper: CustomClipPath(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            color: Colors.yellow.withAlpha(100),
            child: Stack(
              children: [
                innerBox,
              ],
            ),
          ),
        ),
      ),
    );
    return Container(
      margin: EdgeInsets.all(16.0),
      child: RepaintBoundary(
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(image: 
                  NetworkImage("https://t7.baidu.com/it/u=2291349828,4144427007&fm=193&f=GIF")
                )
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: outerBox,
            // ),
            outerBox
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius=5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
