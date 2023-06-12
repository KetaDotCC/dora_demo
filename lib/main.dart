import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: const [
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
  var rotateX = 0.0;
  var value = 0.5;
  final key = GlobalKey<State>();
  var flipRateScale = 2.0;
  Uint8List? img;

  @override
  Widget build(BuildContext context) {
    var transform = Matrix4.identity();
    // print(transform);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Text("With RepaintBoundary"),
                    Transform(
                      transform: transform.clone()
                        ..rotateX(-value * flipRateScale),
                      child: Container(
                        color: Colors.red,
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        child: RepaintBoundary(
                          key: key,
                          child: Transform(
                            // key: key,
                            transform: transform.clone()
                              ..rotateY(-value * flipRateScale),
                            child: Container(
                              color: Colors.black,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Material(
                    //   child: Container(
                    //     child: Text("${transform}"),
                    //   ),
                    // ),

                    // Material(
                    //   child: Transform(
                    //     transform: Matrix4.skewX(0.1)..rotateX(rotateX),
                    //     child: ColoredBox(
                    //       color: Colors.black,
                    //       child: Transform(
                    //         alignment: Alignment.topRight,
                    //         transform: Matrix4.skewX(0.1)..rotateX(rotateX),
                    //         child: Container(
                    //           padding: const EdgeInsets.all(8.0),
                    //           color: const Color(0xFFE8581C),
                    //           child: const Text('测试！'),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Material(
                      child: SizedBox(
                        width: 100,
                        height: 10,
                        child: Slider(
                            value: value,
                            onChanged: (v) {
                              setState(() {
                                rotateX = 2 * pi * v;
                                value = v;
                              });
                              Future.delayed(Duration.zero, () {
                                final bound =
                                    key.currentContext?.findRenderObject()
                                        as RenderRepaintBoundary;
                                // bound.toImage().then((value) async {
                                //   final img = await value.toByteData(
                                //       format: ui.ImageByteFormat.png);
                                //   setState(() {
                                //     this.img = img?.buffer.asUint8List();
                                //   });
                                // });
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              final bound = key.currentContext
                                  ?.findRenderObject() as RenderRepaintBoundary;
                              // bound.toImage().then((value) async {
                              //   final img = await value.toByteData(
                              //       format: ui.ImageByteFormat.png);
                              //   setState(() {
                              //     this.img = img?.buffer.asUint8List();
                              //   });
                              // });
                            },
                            child: const Text("Catch Images")),
                        img == null
                            ? Text("img")
                            : Image.memory(
                                img!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Text("Without RepaintBoundary"),
                    Transform(
                      transform: transform.clone()
                        ..rotateX(-value * flipRateScale),
                      child: Container(
                        color: Colors.red,
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        child: Transform(
                          // key: key,
                          transform: transform.clone()
                            ..rotateY(-value * flipRateScale),
                          child: Container(
                            color: Colors.black,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                    // Material(
                    //   child: Container(
                    //     child: Text("${transform}"),
                    //   ),
                    // ),

                    // Material(
                    //   child: Transform(
                    //     transform: Matrix4.skewX(0.1)..rotateX(rotateX),
                    //     child: ColoredBox(
                    //       color: Colors.black,
                    //       child: Transform(
                    //         alignment: Alignment.topRight,
                    //         transform: Matrix4.skewX(0.1)..rotateX(rotateX),
                    //         child: Container(
                    //           padding: const EdgeInsets.all(8.0),
                    //           color: const Color(0xFFE8581C),
                    //           child: const Text('测试！'),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Material(
                      child: SizedBox(
                        width: 100,
                        height: 10,
                        child: Slider(
                            value: value,
                            onChanged: (v) {
                              setState(() {
                                rotateX = 2 * pi * v;
                                value = v;
                              });
                              Future.delayed(Duration.zero, () {
                                final bound =
                                    key.currentContext?.findRenderObject()
                                        as RenderRepaintBoundary;
                                // bound.toImage().then((value) async {
                                //   final img = await value.toByteData(
                                //       format: ui.ImageByteFormat.png);
                                //   setState(() {
                                //     this.img = img?.buffer.asUint8List();
                                //   });
                                // });
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              final bound = key.currentContext
                                  ?.findRenderObject() as RenderRepaintBoundary;
                              // bound.toImage().then((value) async {
                              //   final img = await value.toByteData(
                              //       format: ui.ImageByteFormat.png);
                              //   setState(() {
                              //     this.img = img?.buffer.asUint8List();
                              //   });
                              // });
                            },
                            child: const Text("Catch Images")),
                        img == null
                            ? Text("img")
                            : Image.memory(
                                img!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              )
                      ],
                    )
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
