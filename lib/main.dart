import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:js' as js;
final isCanvasKit = js.context['flutterCanvasKit'] != null;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isCanvasKit? 'CanvasKit' : 'HTML', style: TextStyle(
                color: Colors.white
              ),),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.yellow, width: 8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 300,
                      height: 300,
                      child: RepaintBoundary(
                        child: CustomPaint(
                          painter: NestPainter(),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}

class NestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    final r = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.save();
    canvas.clipRect(r);
    canvas.drawRect(
        r,
        p
          ..color = Colors.red
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20));
    canvas.restore();

    canvas.save();
    canvas.clipRect(r);
    canvas.drawRect(
        r.translate(0, 50),
        p
          ..color = Colors.blue
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20));
    // canvas.saveLayer(null, p);
    canvas.restore();
    // canvas.drawRect(
    //     r.translate(50, 50),
    //     p
    //       ..color = Colors.blue
    //       ..maskFilter = MaskFilter.blur(BlurStyle.inner, 0));
    // canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
