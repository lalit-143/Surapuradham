import 'package:flutter/material.dart';
import 'package:surapuradham/widgets/language_widgets.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 225, 211, 189),
            Color.fromARGB(255, 229, 203, 196),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              "Select Language",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.deepOrange.shade200,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                    LngBtn(language: "English", language_img: 'english',),
                    LngBtn(language: "हिंदी", language_img: 'hindi',),
                    LngBtn(language: "ગુજરાતી", language_img: 'gujarati',),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
