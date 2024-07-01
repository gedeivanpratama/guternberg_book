import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({
    super.key,
    required this.bookUrl,
  });
  final String bookUrl;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late WebViewController controller;
  final _isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _isLoading.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.bookUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("gutendex.com")),
      body: ValueListenableBuilder(
          valueListenable: _isLoading,
          builder: (context, loading, _) {
            if (loading) return Center(child: CircularProgressIndicator());
            return WebViewWidget(controller: controller);
          }),
    );
  }
}
