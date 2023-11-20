import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import './webview_flutter_web/shims/dart_ui.dart' as web_ui;
import 'dart:ui' as ui;
import 'dart:js' as js;

import 'package:flutter/services.dart';

final isCanvasKit = js.context['flutterCanvasKit'] != null;
ui.Image? screenshotImage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory('test', (int viewId) {
    final div = ImageElement(src: "assets/test1.jpg");
    div.style.cssText = 'background-color: white; width: 400px; height: 250px;';
    div.innerText = "我是垫在图片底下的字，看到我你就输了";
    return div;
  }, onEmbedderNullCallback: (int viewId) {
    return screenshotImage!;
  });
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory('test-no-fallback', (int viewId) {
    final div = ImageElement(src: "assets/test2.jpeg");
    div.style.cssText = 'background-color: white; width: 400px; height: 250px;';
    div.innerText = "我是垫在图片底下的字，看到我你就输了";
    return div;
  });

  final buf = await rootBundle.load('test3.png');
  final codec = await ui.instantiateImageCodec(Uint8List.view(buf.buffer),
      targetHeight: 250, targetWidth: 400);
  screenshotImage = (await codec.getNextFrame()).image;
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
  final GlobalKey key = GlobalKey();
  final GlobalKey keyNoFallback = GlobalKey();
  ByteData? screenshot;
  ByteData? screenshotNoFallback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withAlpha(200),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              isCanvasKit ? 'CanvasKit' : 'HTML',
              style: const TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  'has screenshot image fallback',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RepaintBoundary(
                    key: key,
                    child: Container(
                      width: 400,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                      child: const HtmlElementView(viewType: 'test'),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    children: [
                      Text('screenshot shows here',
                          style: TextStyle(color: Colors.white)),
                      if (screenshot != null)
                        Image.memory(
                          Uint8List.view(screenshot!.buffer),
                          width: 400,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'no screenshot image fallback',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Row(
              children: [
                RepaintBoundary(
                  key: keyNoFallback,
                  child: Container(
                    width: 400,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.black
                      ),
                    child: const HtmlElementView(viewType: 'test-no-fallback'),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Column(
                  children: [
                    Text('screenshot image shows here',
                        style: TextStyle(color: Colors.white)),
                    if (screenshotNoFallback != null)
                      Image.memory(
                        Uint8List.view(screenshotNoFallback!.buffer),
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                  ],
                )
              ],
            ),
            TextButton.icon(
                onPressed: () {
                  takeScreenShot();
                },
                icon: Icon(Icons.screenshot),
                label: Text('screenshot'))
          ],
        ));
  }

  takeScreenShot() async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    screenshot = await image.toByteData(format: ui.ImageByteFormat.png);

    RenderRepaintBoundary boundary2 = keyNoFallback.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image2 = await boundary2.toImage();
    screenshotNoFallback =
        await image2.toByteData(format: ui.ImageByteFormat.png);

    setState(() {});
  }
}
