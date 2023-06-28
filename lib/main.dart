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
        child: RepaintBoundary(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child:  const SizedBox(),
          ),
        ),
      ),
    );
    var outerBox = SizedBox(
      width: 200,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Colors.red.withAlpha(10),
          child: Stack(
            children: [
              innerBox,
            ],
          ),
        ),
      ),
    );
    return Stack(
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white10,
              Colors.orangeAccent,
              Colors.blue
            ])
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: outerBox,
        // ),
        outerBox
      ],
    );
  }
}
