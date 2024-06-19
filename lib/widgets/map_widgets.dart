import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String initialContent = '''
    <html>
      <body>
        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d14749.191278858969!2d72.276125!3d22.45544!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395ede8cf29cd10d%3A0xc9658624b13b7b6f!2sShree%20Surapura%20Dham%20Bholad%20Bhal!5e0!3m2!1sen!2sus!4v1718690562306!5m2!1sen!2sus" width="100%" height="320" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
      </body>
    </html>
  ''';
  late WebViewXController webviewController;
  bool _mapError = true;
  Timer? _retryTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    webviewController.dispose();
    _retryTimer?.cancel();
    super.dispose();
  }

  void _retryLoading() {
    if (_mapError) {
      webviewController.loadContent(initialContent,
          sourceType: SourceType.html);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          margin: const EdgeInsets.all(8.4),
          child: WebViewX(
            height: double.maxFinite,
            width: double.maxFinite,
            initialContent: initialContent,
            initialSourceType: SourceType.html,
            onWebViewCreated: (controller) {
              webviewController = controller;
              _retryTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
                _retryLoading();
              });
            },
            javascriptMode: JavascriptMode.unrestricted,
            mobileSpecificParams: const MobileSpecificParams(
              androidEnableHybridComposition: true,
              gestureNavigationEnabled: true,
            ),
            navigationDelegate: (navigation) {
              googleMapsIntent();
              return NavigationDecision.prevent;
            },
            onWebResourceError: (error) {
              setState(() {
                _mapError = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                _mapError = false;
              });
            },
          ),
        ),
        Positioned(
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: const Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 234, 223, 209),
                    width: 17,
                  ),
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 234, 223, 209),
                    width: 17,
                  ),
                  left: BorderSide(
                    color: Color.fromARGB(255, 234, 223, 209),
                    width: 17,
                  ),
                  right: BorderSide(
                    color: Color.fromARGB(255, 234, 223, 209),
                    width: 17,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_mapError)
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }

  void googleMapsIntent() async {
    const fallbackUrl =
        'https://www.google.com/maps/dir//22.45544,72.276125/@22.4555432,72.2753879,17z';
    final googleMapsUri = Uri.parse('geo:22.45544,72.276125');
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      final fallbackUri = Uri.parse(fallbackUrl);
      if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri);
      } else {
        debugPrint('Fallback URL is not available.');
      }
    }
  }
}
