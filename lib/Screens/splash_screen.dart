import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surapuradham/Screens/language_screen.dart';
import 'package:surapuradham/Screens/main_base.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _selectedLanguage = 'null';
  bool _isInternet = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _checkNetwork();
    _timer = Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      if (_isInternet) {
        timer.cancel();
        nextPage();
      }
      _checkNetwork();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'null';
    });
  }

  Future<void> _checkNetwork() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }

    setState(() {
      _isInternet = isConnected;
    });
  }

  void nextPage() {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 1200),
        type: PageTransitionType.leftToRightWithFade,
        alignment: Alignment.topCenter,
        child: (_selectedLanguage == 'null')
            ? const LanguageScreen()
            : HomeScreenBase(selected_language: _selectedLanguage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 186, 215, 194),
                Color.fromARGB(255, 215, 217, 187)
              ],
            )),
            child: Animate(
              effects: const [
                ShimmerEffect(duration: Duration(milliseconds: 1000)),
              ],
              autoPlay: true,
              child: Container(
                width: 250,
                height: 250,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Image.asset('assets/images/stlogo.png'),
              ),
            ),
          ),
          if(!_isInternet) Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15)
              ),
              child: const Center(
                child: Text(
                  "No Internet Connection",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
