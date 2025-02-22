import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final blogUrl;
  ArticleView({required this.blogUrl});
  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _initializeWebView();
  }

  void _initializeWebView() async {
    await _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await _controller.loadRequest(Uri.parse(widget.blogUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daily',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              'News',
              style: TextStyle(
                color: Color.fromARGB(255, 196, 2, 230),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
