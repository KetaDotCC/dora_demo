import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Stack(
        children: [
          Home(),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final colors = [Colors.red, Colors.orange, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return RadialGradient(colors: colors).createShader(rect);
                    },
                    child: Text(
                      "This is the first text which has 400 width, let make them same width.",
                      style: TextStyle(fontSize: 30, color: Colors.grey.shade500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 400,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return RadialGradient(colors: colors).createShader(rect);
                    },
                    child: Text(
                      "This is the first text which has 400 width, let make them same width but different height. place holder  place holder  place holder  place holder  place holder",
                      style: TextStyle(fontSize: 30,color: Colors.grey.shade500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
