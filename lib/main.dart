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
    var innerBox = SizedBox(
      width: 100,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
                color: Colors.blue.withAlpha(230)
            ),
              ),
        ),
      ),
    );
    var outerBox = SizedBox(
      width: 200,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            color: Colors.red.withAlpha(10),
            child: Stack(
              children: [
                innerBox,
              ],
            ),
          ),
        ),
      ),
    );
    return Stack(
      children: [
        Image.network('https://cataas.com/cat'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: outerBox,
        ),
      ],
    );
  }
}
